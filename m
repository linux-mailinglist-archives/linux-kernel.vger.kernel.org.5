Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAF47C9351
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjJNHqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjJNHqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:46:16 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2109.outbound.protection.outlook.com [40.107.113.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933D6A9;
        Sat, 14 Oct 2023 00:46:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvZ+CgoosIoeJknyplqXdjsqj6WQ+milO3WamkczQfwfEPKE5N69ITNIy2Ylt/irACfrNnlleNpQ8ixLfHWOHfqad52uo4hKMl7c/X6AkQErB99UWkms9MW4EjK8K9hnewSVEnNeluHxpOUISm2pG9aJ3xrhtgLywiofAfjcZUwN0HXom1spzAAJ9LmmBH+owV5vpTMX6sF/NLmLC5t8I0BknIKQOHjYCS26v5j0Ndd5jI/C5X5eu9RVWMqP1p03D0fz9GbnwzTgZtg3biftndI+O3kunWk9EEtlSJTulTls/mjEl4NRUIBG12GtHffCvvXUNA7sp+ULOGI3JB9d8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOCfgqLGWmZuuPPvOJN6jJSwoA75Y7iR0jJ0oemxbxg=;
 b=YfIiccl9E1RrUTf/8YRqjfLk5zq53/Z74LIycLLfxhVQVaaa9BN0wqT66Cx7SDr8smvROBL9QFMQkW+70jj/wJNMFZlRIRs/yhd5vIlvW3yJZut3NxoCSSa6eDrL7iEm1zJVe05tK0JM5/2K8vTwha53OY/K5l+KIAdVJrzQ2ZkXj/3PfmtfgvxooBklOOVrDnIXY6fybGrxf0DVHtXr+f5Xi5uIgk26VFYeZcYw7aj1DuvdiE05bnFu/tZBnFbEZjQYL+oC/XCjJmwXbpEyNGUlue48lzOHMfMDFH+NVlhQ5nnsfxqmqAT3xW9KOkPzyLUPs6pIGLM3Je0msLa+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOCfgqLGWmZuuPPvOJN6jJSwoA75Y7iR0jJ0oemxbxg=;
 b=VkUWEQuWFugmqKbrV4RoHcaeVL7XcaK2p3G2QhD0g2fV/2XRTj/VXi/Bhl5fiN2dvLJueJYJOTrgD9rCJlkTVnGlLSPDwQKkq73RzzkcX5B8cBn4+5+2HYGiiFtXGWQb4mEGe0v1sAQK9rLdaNYJS9i7NVON2+xOUzorLuMC6uE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:de::5) by
 OSZP286MB1984.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:181::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.31; Sat, 14 Oct 2023 07:46:11 +0000
Received: from TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc]) by TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 ([fe80::54a2:c3cf:4f5:91cc%7]) with mapi id 15.20.6886.030; Sat, 14 Oct 2023
 07:46:11 +0000
Date:   Sat, 14 Oct 2023 15:46:04 +0800
From:   Hongren Zheng <i@zenithal.me>
To:     Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: [PATCH v2 -next] usb/usbip: fix wrong data added to platform device
Message-ID: <ZSpHPCaQ5DDA9Ysl@Sun>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Linux Sun 5.15.67
X-Mailer: Mutt 2.2.7 (2022-08-07)
X-ClientProxiedBy: SJ0PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::33) To TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:de::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYYP286MB1406:EE_|OSZP286MB1984:EE_
X-MS-Office365-Filtering-Correlation-Id: 25082b6e-421d-42b6-c729-08dbcc89a231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4n2R6HbkpYqmVwNGgvjvjbRFEcw/CV6q4lYRHtjLPaaDb27/7pDG1khEaPjs0Ol9aQlhl6qC8tqw3JCMld55jmRwSySbnYfJ+5QPjGjIISgdu2NH5EI3q2qn7USRkCe3HlVVB2ChWrzX90QIx/TeZ9XFWVWIToWBljMUj5snLi6A1OK7E2OLruUVIaderposbtgyNpmoUS1IH8CSj6jBoLppbMCkL7Ipufr/Tob6xPwze2K+EjBjGoSZuJ6yU+aeEyM2QKYlIXI95FExzOdjyFJqThgYSHDQAqq5FiKm+7obF8N1zW4Rj7s/QYH3DeEId4iKdI4wc9ZDpjxdQmMoHvOAggqCrxIePId46jCUzWdinmZlfuI6kvziONKvfCYWuDpMIRTrAGnrpKCtmd62GObfTyPE4QSOHAw393QwY9Fy6oSth6ecWOS7xBR9/9br6eHds4ZXUlya1WCWcpEZJ97pqpTrCY1cf3wH6plvzC2hsoswiSZ4mP2diFYHesf+z1nMEFm/YTdUVgMY+iqxajocQ2keIj+ozGB22Ovdx3lpUtiid221ciluwYKrQz2IZkAb0NCnjEniCrazECxqd6SeIemJlQ6LG4nGKbxS48=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(136003)(366004)(39830400003)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6666004)(9686003)(6512007)(6506007)(38100700002)(41320700001)(86362001)(83380400001)(33716001)(110136005)(66946007)(8936002)(786003)(66556008)(316002)(66476007)(2906002)(8676002)(5660300002)(4326008)(478600001)(41300700001)(6486002)(966005)(49092004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?us6ncWYZodJsLKezwgVvD8fbBl3M1fQPH99h2A9ruIBdYm1k71rlmYxILTdh?=
 =?us-ascii?Q?0h89DOPy0un2+m4LazR0m/hcGQfl0vshju7yZemESSodY1TwHUD/g56Ovr6/?=
 =?us-ascii?Q?Q2k0BFgn0iCkM/3TrBBcCqAhY9Q49jW1dRzVUdDgs35ubeRhTSNXctppgrFO?=
 =?us-ascii?Q?bEGPqoFVbpcDQdbAoSh7oiK6f3fia2/oPV8QTFs6UW8ZOXz/j53yRHBztGUC?=
 =?us-ascii?Q?gn36bksmhg1Jg7lZfLQQzqlXhDyuqqCb83OE5Zm8QqNRzSDYg9y9vMYRSbwG?=
 =?us-ascii?Q?zzMBrpquf+eK81wjubMoiuRM0O2gjhqqGMAEzhdHZ/2bjGpnR5J8t2UgaS1X?=
 =?us-ascii?Q?aYAHLStmm7KnN6HKrtnBRMXFfTyBkF5HTNNoBIxY/tb+AfgmDaBAozUc8cW0?=
 =?us-ascii?Q?YOH3nDdaN2pTtSUkc3ZQCLXq3S0fuLXogKaTp5liCe1c117uEZEynOPEDByS?=
 =?us-ascii?Q?svL+M5lHMH6RTrWyKa6sqViGQ6OHL2la70CgJ/0ibuQNBcMhsY4RMiPER+sE?=
 =?us-ascii?Q?0sy85KHHJojhprBkdFnNnMQZ/pDG265HKMlxDC5eDDOljEyXIH/QIPS1w3dd?=
 =?us-ascii?Q?ij/x39XH73h/kY7cfeyuMhRF/DfvV5uAJ7EkQDIB9rZCW61LTnJpgfVwAvgb?=
 =?us-ascii?Q?y13ZOcbq9ByQKd1v8TlNdbvnvGIR8U+oElp5kknh/OlbzK2AYSnbVBktWsKV?=
 =?us-ascii?Q?QgIABFBifOoRMXVpuzNy+EU0a5eyEJfT8KCEDg+qWN85VYJsuLiR+Mv7F71l?=
 =?us-ascii?Q?kgY4j9eEyh44Y+qZXy/oDQcFgjb/ry44OAgR1aQSm5NkGXJo/8Y070q/mgrK?=
 =?us-ascii?Q?pMt2l0aNrBCn9iYMTdzFbu3uwIHUvrTbUoJWIwJkgrSHW5JLxK7I0SYf7RcY?=
 =?us-ascii?Q?uDZb7rUzoDNzwWcZfFPdfTRKG4g9ndA9fCgcrGcusUnbBRM3RB3tnQ/KzUUn?=
 =?us-ascii?Q?FN5dhRgN4fO/nVJ9/1qWWLaoauJlkQlf2V5UCM0HaJAdEYEzBm+rt0oUADDi?=
 =?us-ascii?Q?j/VxwFfaFSeNVizXI0Cj4MpIQ+3g3AIehyMYFxpYKC6gJNRAkz/xbVSHFuF3?=
 =?us-ascii?Q?yYrVeadBBBpS0FsYvVHvOFjKgfIW2FLjhX+FhGYGbZ485pYXQxs3H7t0c+Vg?=
 =?us-ascii?Q?qx6Yian/CwicMo10BIpejwLi/I1JlIxPyJm9Y03B6nhxvdnLBhQ9pJr/pgpC?=
 =?us-ascii?Q?FKqBRzT5J6Rssgt1K6E4cYFt0JFiuvhzNoRnI7XGa/EC+ABUpJ14VcpRL3u5?=
 =?us-ascii?Q?XgraF2PYRHDXl92TPy/wTDkGy6zGmf6ysplK+AZarcXqYIzGIxVGKIG2o1V3?=
 =?us-ascii?Q?1kzhb1+1Nq81BPa76FfdVyeCOfhFcEg7SBJhhpvgJoY9ZjE2hZUnYAfNxY7R?=
 =?us-ascii?Q?KztVlyWCFEmJltES1ckjGfEROWfPjltY2vBmeEOYP8/3h4uaSi8vNilgnNQY?=
 =?us-ascii?Q?1S5r3ll1U59anjFydILQxh6E3gVfk/OdDUTRvpoLzUhMOzRZGnpyE3tAt3/p?=
 =?us-ascii?Q?M569c3zKgf7Qc41jBAGxiLIvClGbeXLXnGRnRE+tjvWgSk0hB40lTudK0nvX?=
 =?us-ascii?Q?OiQOhdLgLjfuw4XqZ07xfSBRZkeUtMWl/7PrNkga?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: 25082b6e-421d-42b6-c729-08dbcc89a231
X-MS-Exchange-CrossTenant-AuthSource: TYYP286MB1406.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2023 07:46:10.9849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lc8CYSYsn0zP7m8HdcpCpaOQ8f7AKE6OTsm3ldiClSkVvaGt7CdOzCba6TNtM3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1984
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
Closes: https://lore.kernel.org/r/00000000000029242706077f3145@google.com/
Reported-by: syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/0000000000007634c1060793197c@google.com/
Fixes: b8aaf639b403 ("usbip: Use platform_device_register_full()")
Tested-by: syzbot+6867a9777f4b8dc4e256@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/0000000000007ac87d0607979b6b@google.com/
Signed-off-by: Hongren Zheng <i@zenithal.me>
---
 drivers/usb/usbip/vhci_hcd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

v2:
code style change suggested by Andy Shevchenko

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index f845b91848b9..82650c11e451 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -1139,7 +1139,7 @@ static int hcd_name_to_id(const char *name)
 
 static int vhci_setup(struct usb_hcd *hcd)
 {
-	struct vhci *vhci = dev_get_platdata(hcd->self.controller);
+	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
 
 	if (usb_hcd_is_primary_hcd(hcd)) {
 		vhci->vhci_hcd_hs = hcd_to_vhci_hcd(hcd);
@@ -1257,7 +1257,7 @@ static int vhci_get_frame_number(struct usb_hcd *hcd)
 /* FIXME: suspend/resume */
 static int vhci_bus_suspend(struct usb_hcd *hcd)
 {
-	struct vhci *vhci = dev_get_platdata(hcd->self.controller);
+	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
 	unsigned long flags;
 
 	dev_dbg(&hcd->self.root_hub->dev, "%s\n", __func__);
@@ -1271,7 +1271,7 @@ static int vhci_bus_suspend(struct usb_hcd *hcd)
 
 static int vhci_bus_resume(struct usb_hcd *hcd)
 {
-	struct vhci *vhci = dev_get_platdata(hcd->self.controller);
+	struct vhci *vhci = *((void **)dev_get_platdata(hcd->self.controller));
 	int rc = 0;
 	unsigned long flags;
 
@@ -1338,7 +1338,7 @@ static const struct hc_driver vhci_hc_driver = {
 
 static int vhci_hcd_probe(struct platform_device *pdev)
 {
-	struct vhci             *vhci = dev_get_platdata(&pdev->dev);
+	struct vhci             *vhci = *((void **)dev_get_platdata(&pdev->dev));
 	struct usb_hcd		*hcd_hs;
 	struct usb_hcd		*hcd_ss;
 	int			ret;
@@ -1396,7 +1396,7 @@ static int vhci_hcd_probe(struct platform_device *pdev)
 
 static void vhci_hcd_remove(struct platform_device *pdev)
 {
-	struct vhci *vhci = dev_get_platdata(&pdev->dev);
+	struct vhci *vhci = *((void **)dev_get_platdata(&pdev->dev));
 
 	/*
 	 * Disconnects the root hub,
@@ -1431,7 +1431,7 @@ static int vhci_hcd_suspend(struct platform_device *pdev, pm_message_t state)
 	if (!hcd)
 		return 0;
 
-	vhci = dev_get_platdata(hcd->self.controller);
+	vhci = *((void **)dev_get_platdata(hcd->self.controller));
 
 	spin_lock_irqsave(&vhci->lock, flags);
 
@@ -1522,10 +1522,11 @@ static int __init vhci_hcd_init(void)
 		goto err_driver_register;
 
 	for (i = 0; i < vhci_num_controllers; i++) {
+		void *vhci = &vhcis[i];
 		struct platform_device_info pdevinfo = {
 			.name = driver_name,
 			.id = i,
-			.data = &vhcis[i],
+			.data = &vhci,
 			.size_data = sizeof(void *),
 		};
 
-- 
2.37.2

