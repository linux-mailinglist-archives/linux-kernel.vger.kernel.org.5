Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A8A7C83C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjJMKwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjJMKwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:52:22 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E33AD;
        Fri, 13 Oct 2023 03:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaXI1KkhMTCg/svf/FeBnrIktF5BMufsZ5M+BseInqyFnI+mM5lY6oOhThh+EXHM5Jxzy8xphoEqFB7plsEkzOGyyJNqRKYdKPi8GNDMhqOYC9BbpbEQfkY5iudJcqwGCcLF2XQjdzrF/o+5flLq5xgqvaJn4ySd5X76b7h6GZOB9oRv/NrGn2xs5df7Fs7zz0Kjnrcn9vNChsfi30xR5J1rPdW77wbWB4hdgeS5bni1yo53Y+ieCF5tQgXvX/i8iJaLuFsNAzJOmpFSNUJlc0VhlpaW/u+TwZUXAsRuThe/XjIvEUOACEaWiBWPUCdtDHWB2mPHo17p9KRv/LawqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaB9/jCNtvAx3Ke+Aa7pIH0sdS4tlzY7Lpxjcd+qR+8=;
 b=ltAGofvz+slE8VLBnYq7yqW8Fb7uhEWWpntJcLUd6Ipal6l/esbrd7n0fTtSjm5dp9exxr+IXaWZor0fGOou8MHj7E5Uyo6awR07CYLYzoFXBFmeK3Z1LxVlfw87igUzdFqBpUK4gDd0/BFnI9zGrjw24+U68rlb8RndJFVl3RYNIt3G2xB3B3aHn58SnoKKIhmHC8vtRq/e4ovs7mGTsgpiq1xUeB1eLpcULZtwEwuRBhY9+HsIa640w5VC/Y7Fh6LPNMH4XclzG6viVGA1l7Sl7A4Kb744I4M+GqRFZ0tJ15p3OtB2wzwU93GFePZ5dt5PyYlL9sDdUgN/QXTg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaB9/jCNtvAx3Ke+Aa7pIH0sdS4tlzY7Lpxjcd+qR+8=;
 b=tUcxouPQ8EkuOsS2l4wEyc236p+vQojxWXFQv9dMJI/IL3xZtexpB/9Tw333ASpkKN2JVqDD4ua7Td9Xg5KLLyeoyStYXIt1IuyYWa6dhZdpNWCQBE/LWXiblPQ+vV3tOWVkNSLR+xln1eBxGIgw06lcUv3SHXgn2O0WccyQj44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 TYWP286MB2478.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:236::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.29; Fri, 13 Oct 2023 10:52:16 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc%7]) with mapi id 15.20.6886.030; Fri, 13 Oct 2023
 10:52:16 +0000
Date:   Fri, 13 Oct 2023 18:52:09 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: [PATCH -next] usb/usbip: fix wrong data added to platform device
Message-ID: <ZSkhWa5wmAGsAdCK@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR13CA0045.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::20) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|TYWP286MB2478:EE_
X-MS-Office365-Filtering-Correlation-Id: f05b149b-d518-4be5-4816-08dbcbda76c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rF7sifoVAzKoWu+LRVZhBHIYmi6dKI/yYqvAvzxr0+be7OD7kMMJPxAkgwRq3MAWPGiUECx9mtisXFAVDo0GF2vT/2d73cxYItj2biyfJGwdSv4XMJ8vYrOadvfrYQTHSDJ0lYKVrCXnmtOElW9Ej4F7KzG4li9L6LvyFPTaOyeq8cg54FOQDoAkVzA+abBS24wR8Nc0Rk9AVStm4wm1fSqChKYEpk0eahsmKgyHMUw1YWasqqhvIGVVFjGLYnZCNfK4+F/2C4OgFVXRezpnJuyEAwFN7b+c/tkXTzy9MUNfgWyIlWFr2ksZ1aQJZ30Ex5S+NVWIrmsirSzwbFADEBTTWW9NRv23UYcsic4Q5s8LLhAfQ1mCeAVRoS4nKdWoAO9hEYAI2r7memz5t3ImpGEYJN/SbX71XSIgvbkWAbXwfl+j4/eSSsmj5h52y4I91kzEm/WsSNsrvatHcVIhUiiJRtXnC7kFJgXFBaU7iJ1sEmU33W1RZYyveGeRskes6IJUrYqDzep1FDr81VOZZCoSf0yuyXW5Dpbthv104Al79cmzHGKpNhwW/qB0m354RbW7mqiII4btMmgZZXOmjQpOqekZ0tcmmtiaJa8aBz0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39830400003)(376002)(366004)(396003)(136003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(316002)(786003)(6666004)(6506007)(9686003)(33716001)(6512007)(83380400001)(5660300002)(4326008)(8936002)(8676002)(2906002)(478600001)(966005)(6486002)(66476007)(66556008)(66946007)(110136005)(41300700001)(38100700002)(41320700001)(86362001)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wAahB1BKOB8NWW+Ok75sSS78zqpiKOumDwYUmyyzNb1BuClUVOp7J4OqLSN3?=
 =?us-ascii?Q?Bv6cLImssNiICjzWgRNIVowfT5Mzc3teVOCXslc9GzFVaZrzM8+qP5b+HwrL?=
 =?us-ascii?Q?gOtCf8dinp/kwNvhKO0Qz9IQmHACkWlIcDlxWsN22V7dwno6XyOZEoRjJ2EY?=
 =?us-ascii?Q?EEe2viJtOeNIZJDUJJpNhHi9auFHFEmhZ8K7r0fStLyjfjyvljOCpx87lyIL?=
 =?us-ascii?Q?re5xAaO3Dn0GvTQPtjNUD+NQ5SuJ13RKCSA5J9Zxga6LZYU0bi91DJFpH8yM?=
 =?us-ascii?Q?EvT0yw8Ub7lMFvgNzDixFW07RV8SUkKQ2ni3HWunFXBXvvzGmXUb5OBZTsBB?=
 =?us-ascii?Q?RzHZL6rK/5GOcK7jO4+cirbGbfnTkQv0LvZ1G9wF7P3ySlmeiPnOrRG364R2?=
 =?us-ascii?Q?H3U/cxARr0+KWpzhzXip2f9G8Q6YgIg/i3Ghg/1JidqMAK4c8P1veTU+mnJB?=
 =?us-ascii?Q?wp5h7VUnXs6fo8Rwov7XkNrmhuJe4oq5v50c5K9bw90D0IXpkfdq1EfBI4zq?=
 =?us-ascii?Q?wk6TaSqqqG0DPsm5nvF2N5bS0w8+B9RAe/cPz7ifurWUXxWPsLsmQn4HRo6O?=
 =?us-ascii?Q?DQhXDWe6QQsqNJsATKL5wFUtsj4sXHoBGvsle04sVNiDkzKqOF9gmUbxbdQk?=
 =?us-ascii?Q?JBkvoEn1WDm7Q9tR/Daq1yuTOjSf1C+LUfs/o7gJqaKqq7XtmaE9VNs8Aemt?=
 =?us-ascii?Q?dIJ66nu216nG8TWPi3Hi72t8BIko7ZQ6/njjVPPAi3uxVA+7Jy5sdTGncJje?=
 =?us-ascii?Q?iAPNEsfzCu2SzHSMi9/6JhXTG7hjV03rUOnmSyJpcPjCRWTgU0bsvPyyp3I8?=
 =?us-ascii?Q?lFgm11S95HvEpG9AFwNU3Xf2K5y25LTVd0P0uax39JCyWHAMN2UqNdPQnMzg?=
 =?us-ascii?Q?Z1q0w2Cs94lmTq1MPYq3tu7gGELfwOLRGlEXuxDSkOG2wr0pXUgsKMCFzY2Q?=
 =?us-ascii?Q?hYW2ghRXenBOfyZmpXigczX1j5ei/t0AtxDO74Qo1/bd+4pyu9Q9V0uY+Iws?=
 =?us-ascii?Q?++0l4TfHtwqr8F9Pdcgh1kFMANM6RSYSIXAZJ53Ukse5L7eZfieHV9ACLgQy?=
 =?us-ascii?Q?x1+J9lCP7wDrQyidPt+NzDa5E4QX4ijYGaTVczZgG1VKBI/nQet2CyaAGB5W?=
 =?us-ascii?Q?EqaMSienT9w6STP0zJCw4toaUrS5ggEB4F2I5FcMF3NPe03CKVn4jUMDFmOB?=
 =?us-ascii?Q?UhN6uzE9blnI1HO7joz3KaLAEgeY2PoH1x2gcm75ToyU9iDgHNabxcNFBMDY?=
 =?us-ascii?Q?ThtKNEsrQ3JWyFj0/EenoqMVoKMnfSHyw88/RXpnBkkO5J0LtGl5FnlOwbPk?=
 =?us-ascii?Q?6/DL4kgif0li4WIbGBdLPmtPDCDwkTvyznrTr1Aldg1DJZUL9J12CnkyHCxC?=
 =?us-ascii?Q?zeHtJuw4J3tW1FTeU1mIZK4KvH+Zhv45MmOsJbesNqBGO8AezU1Bjfp3SDsT?=
 =?us-ascii?Q?8cxh9R66LqXJf4OZV5Y3GSuQNg0S83GXHhx9dCVq9OzsRNAwRFyhLDThKaVv?=
 =?us-ascii?Q?oiQvkjvYEQ6hvHWV65EjGpVh67sLSlPZjJ+6B8rLs7JpBgicAPS9k8RATHg6?=
 =?us-ascii?Q?JE4pGGeZ+FPTekujhTmtTXpgS6srbjolFS+mGEPr?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: f05b149b-d518-4be5-4816-08dbcbda76c6
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 10:52:16.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9eQm4tzfBrmn6RZBrNymiCKAnxfi6TVgSfDjAFAO5VfgVW+ev0M10ihiqpfl0q/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2478
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.data of platform_device_info will be copied into .platform_data of
struct device via platform_device_add_data.

However, vhcis[i] contains a spinlock, is dynamically allocated and
used by other code, so it is not meant to be copied. The workaround
was to use void *vhci as an agent, but it was removed in the commit
suggested below.

This patch adds back the workaround and changes the way of using
platform_data accordingly.

Reported-by: syzbot+e0dbc33630a092ccf033@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/00000000000029242706077f3145@google.com/
Reported-by: syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/0000000000007634c1060793197c@google.com/
Fixes: b8aaf639b403 ("usbip: Use platform_device_register_full()")
Signed-off-by: Hongren Zheng <i@zenithal.me>
---
 drivers/usb/usbip/vhci_hcd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index f845b91848b9..dfbdc77108e5 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1139,8 +1139,7 @@ static int hcd_name_to_id(const char *name)
 
 static int vhci_setup(struct usb_hcd *hcd)
 {
-	struct vhci *vhci = dev_get_platdata(hcd->self.controller);
-
+	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
 	if (usb_hcd_is_primary_hcd(hcd)) {
 		vhci->vhci_hcd_hs = hcd_to_vhci_hcd(hcd);
 		vhci->vhci_hcd_hs->vhci = vhci;
@@ -1257,7 +1256,7 @@ static int vhci_get_frame_number(struct usb_hcd *hcd)
 /* FIXME: suspend/resume */
 static int vhci_bus_suspend(struct usb_hcd *hcd)
 {
-	struct vhci *vhci = dev_get_platdata(hcd->self.controller);
+	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
 	unsigned long flags;
 
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
@@ -1271,7 +1270,7 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
 
 static int vhci_bus_resume(struct usb_hcd *hcd)
 {
-	struct vhci *vhci = dev_get_platdata(hcd->self.controller);
+	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
 	int rc = 0;
 	unsigned long flags;
 
@@ -1338,7 +1337,7 @@ static const struct hc_driver vhci_hc_driver = {
 
 static int vhci_hcd_probe(struct platform_device *pdev)
 {
-	struct vhci             *vhci = dev_get_platdata(&pdev->dev);
+	struct vhci             *vhci = *((void **)dev_get_platdata(&pdev->dev));
 	struct usb_hcd		*hcd_hs;
 	struct usb_hcd		*hcd_ss;
 	int			ret;
@@ -1396,7 +1395,7 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 
 static void vhci_hcd_remove(struct platform_device *pdev)
 {
-	struct vhci *vhci = dev_get_platdata(&pdev->dev);
+	struct vhci *vhci = *((void **)dev_get_platdata(&pdev->dev));
 
 	/*
 	 * Disconnects the root hub,
@@ -1431,7 +1430,7 @@ static int vhci_hcd_suspend(struct platform_device *pdev, pm_message_t state)
 	if (!hcd)
 		return 0;
 
-	vhci = dev_get_platdata(hcd->self.controller);
+	vhci = *((void **)dev_get_platdata(hcd->self.controller));
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
@@ -1506,6 +1505,7 @@ static void del_platform_devices(void)
 static int __init vhci_hcd_init(void)
 {
 	int i, ret;
+	void *vhci;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -1522,10 +1522,11 @@ static int __init vhci_hcd_init(void)
 		goto err_driver_register;
 
 	for (i = 0; i < vhci_num_controllers; i++) {
+		vhci = &vhcis[i];
 		struct platform_device_info pdevinfo = {
 			.name = driver_name,
 			.id = i,
-			.data = &vhcis[i],
+			.data = &vhci,
 			.size_data = sizeof(void *),
 		};
 
-- 
2.37.2

