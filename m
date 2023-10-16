Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F0F7CA0BE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjJPHgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjJPHgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:36:35 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2041.outbound.protection.outlook.com [40.107.255.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A43ED;
        Mon, 16 Oct 2023 00:36:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1Kah9n6hsDrbVHPJe0AXJkSsLxPVH3TKkV0NWVqQHDBBOmAympnSbHRpr9ur5Nim2qv56cw/52mlZ4M8N76gQ4OPdLd6bZvrzq3OudpDSNXYlb2RtxePhA4l2pNQG0eGylv+YyeIkO48/NoLZBaiqNMRFpWnFOcrUs8xVQGmgGbF4Uc2Dj9GmAF1aq82h1a37T6JZ15IWf9AYIdsKKuPlQoYIdKQs+vNqATgnDPlyMNyrmZi01pGTAnGNbYdsIs8W6dtmezz1Jhy/yzYMIc3gh1PMUi9kItQYAikno9XE8yzRjqzwNjNa684XLCoF6sLF/mgEYnXzOOmRPKOYzBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEA9KQPaIyzDdTBjNRPPWlFjBT6+M2Cz89Wi3xEcZ3A=;
 b=lZOCerft9eD90qrrrrTI7Y/9NYUo5HDlslah9g7yWqExFluLgxiLzrm8T36eNFynqCEE0yq3EFtD005ixoKe/MRdCbzB5acZmMD5/C+774LI2F3zzn5nQjoxZ3W5vGMGUjuHr9JcwKpko9AAL8pr2Ng+HwtUd+u5UsDXfELLtVocp9Kng8yqFkXLunV7Xw9ZFNmUSrp3oEtig3mH12CAdCxX5qRjsP6xT+l4QZih+ieb1/8vXHe2fm3NM2YcknFvoA8GCnNuyoNlqnoM7gc0TGq99md77UbPDp9NEI0pNHDq5Pz982rv2iaLII6hM5Mc+iIAzZfzF5r8zTNtStPwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEA9KQPaIyzDdTBjNRPPWlFjBT6+M2Cz89Wi3xEcZ3A=;
 b=F3njckSz9Rrh2YZlreDeivpyTSsw8+rVQSnZF1FKd6MCOuoIIWAiXIChZ3hRdRonF0ENTayqGJUTqNT4B2RP7a3ES3OfIyAVK++VnDkZMIHiiy43Z6bIyi85INQQLvWR16vHD8C74b3VxUcCOhvRLo6yDtpO4FJofkdjN29r88A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com (2603:1096:400:71::13)
 by SEYPR02MB6181.apcprd02.prod.outlook.com (2603:1096:101:c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 07:36:27 +0000
Received: from TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::21da:6305:19cc:e3a2]) by TYZPR02MB5088.apcprd02.prod.outlook.com
 ([fe80::21da:6305:19cc:e3a2%5]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 07:36:27 +0000
From:   =?UTF-8?q?L-=E9=B2=81=E7=92=9E=E4=BA=AE?= <puliang.lu@fibocom.com>
To:     johan@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Puliang Lu <puliang.lu@fibocom.com>
Subject: [PATCH] USB: serial: option: add Fibocom to DELL custom modem FM101R-GL
Date:   Mon, 16 Oct 2023 15:36:16 +0800
Message-Id: <20231016073616.519051-1-puliang.lu@fibocom.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0046.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::18) To TYZPR02MB5088.apcprd02.prod.outlook.com
 (2603:1096:400:71::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5088:EE_|SEYPR02MB6181:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a309ff-934a-4cc1-d379-08dbce1a9b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGAnYokKmL5nK6cs+TbvWimmow+pGKG4mg6MqawQqLTPRFxH7xdzxS0phND00p8s0nARfgdv+8sMvnGnvS/ERhGWdio8iu65Bml13gaNEDLlMt5coRBRZ69h9Ssdt/xcjnR249fKOQEJtE0S8ShcheOtzF+XZrrY3SLVGnj2QxDlPD69hzzd16EIXyMpLlCNSndqh1FAbmtgdcPsOKA9mL69tlL6kXi/LHvDOs+wIK7TvE8M5hauIlvbE+1pDaInqkSNY4FQYo2TrqYE5yyx1dQSn+/B0g8sYygFknRI8vbYmymET5HeQU/52HmdtUsaq5cIvHFnoDkZQA2hFzHb3ttAi3jMX7t83D6YjK2nXHQHNsSx+gDHD+8yz+wcRhaLJrs+fm5LaUBuBBzQBtpJARU0VxjnHbaS8ZuDT3k/t+0+44y4c3e2qBWVXIuv1VFgc16Jzp0cGPHtdjaAHbcbBdE7bF/34N2QRB9rqrX2nLxwUnVHEkT0snLLI494KT1VIPmm+nZqU2pG6df1sFuhDE/sQVgKLlvBchl8UbfridN5lDO3Vs9XfvqkTOClAIwq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5088.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39850400004)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(478600001)(6486002)(6666004)(66946007)(66476007)(66556008)(107886003)(1076003)(6506007)(52116002)(316002)(2616005)(6512007)(4326008)(8676002)(8936002)(2906002)(5660300002)(41300700001)(36756003)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4uDBNEnY0wbpAPyXCfXYMrAPtI7DjyDk+5CTHnmWWiG/BYyf1BA6/EAFs/Zg?=
 =?us-ascii?Q?+CXeOQfhfDJQOedj9iD9IBuZ3k4ZwkCR3z5ohbJmIFYzpXsq14OOsx7L+iJi?=
 =?us-ascii?Q?Y5a2+NJBKCprgawVknmWcQowMaHxVzd3tGmw31BtLALH3x1wfPeAjgJ2hMR7?=
 =?us-ascii?Q?yM21fa1Jh6nqq5MoNQEBMTAWHAO2WDaGZwndAhokJIklz9RiD43loYihD9dT?=
 =?us-ascii?Q?HPyppuFAzWxOiqZuYgDGI0nkHIgejqA86XCXWq8OUrAdfdOiZgW+J6gTFaF3?=
 =?us-ascii?Q?I8j95IYBxUBQ/3b+E8E3Q5MMbuaMXTU5QQik3XgjHAxUKCIj0nbXAWRioHqN?=
 =?us-ascii?Q?SYMYR05NI4ZgyQlgu4404ysqGWFhHYu7RuNZ4Sn+5o12ilMAjiCLKFccSOp4?=
 =?us-ascii?Q?d8HmIDLuU6DgIkgDuVGlpf/W0xkl8sSlIsw+yIHHcvGBDzBan45CkjtXLh84?=
 =?us-ascii?Q?UwwLXiWVL8ZodHdV5ThTMt9VCwAvSUWlNeOnjCq1aUdmVXojTCpTkGm8obv0?=
 =?us-ascii?Q?oFXpxbOeQZh5qonE2lCTWLQYQWzG2/0j+w8e+Vg0nOHSpa7Hgjopge76yR+R?=
 =?us-ascii?Q?jk3EXcFVrWpZDu99wNTrewi3EofQ3Q08W+vw06jMUDh9Y4k4M1RtcMDgS68S?=
 =?us-ascii?Q?fFs92DNbxQqsUN2O/5rSKZIiQhyafopZDmQj1eZtqVu3KPnL1EyYjG2Y213Y?=
 =?us-ascii?Q?y6qiPDApTjQ+DERzZHn4nGfbhzfotq22fejY+Xom3bnqb2Q9uDU13iwJaUKB?=
 =?us-ascii?Q?ItLqzpDdMwueiD1mFhHfC1ribj9hfalf0pkhMXnvZrBxGSOdPldIjZSQuZZe?=
 =?us-ascii?Q?a/yqEhYHuwqRx2Am39YlW7vZO68u8BTHZbzXBLaWqMleKGWAZ9ubz5OXockU?=
 =?us-ascii?Q?FcAw6ZdgaA1nbNrXYpgQObtZQR1fT9j9eWkq4xFwAR8yoge6RBuHI7M0udql?=
 =?us-ascii?Q?yjqc5ynUeFvx+4tnISvbRXxm9GsDkrOcDhQzqieVtj+VVV9PkfRVDKnYJUrR?=
 =?us-ascii?Q?TPp1YFRFn3JNVY4JusKC6JAC2XNqSfHE2pnsSzL1TpApnY0jm6gQoOw4lDgR?=
 =?us-ascii?Q?9tG7d2uBUsUGMb/KU2NWZt2JZJSiL1UTTrwKHu7curQyImsntg3vEHl+WkQ7?=
 =?us-ascii?Q?fLsKfMhbCcN9TIED5kDbg91TW5BPTryUoBtOcNNHSarWDEjn342nR3buUcsG?=
 =?us-ascii?Q?XLmcg+bFSJteklU+LystrKpQCO21Wjk3azUYuJWYr3ew13c268y4rfi/RlF0?=
 =?us-ascii?Q?PoJPK94ebrJ9Nr4Jh58qB7/GCO3CV4pfP/c2S4gjXw/4PS7tb50Lq4THeK1g?=
 =?us-ascii?Q?scuGLap4RIhC1lPWTRETg6lXiz24xdd5qoi+MSqHh+oc+RSqJ44brBPCTStJ?=
 =?us-ascii?Q?TebQC7Oa2BSlJnSF6rI2Jtz1PFX3NDUUhYlYCUoIaxQMgt07djVm1K8Fza7v?=
 =?us-ascii?Q?eB9bs0ZrjppDe+cKlhhB637F3Z53TfgGRb4E9PKVl12FNGyjxj7H2BEQv3/A?=
 =?us-ascii?Q?bpL3LHtgaYSPjK29LPYcF7R+eP3PYDsRMVjtbH+YKIo1LmChv2DuEXMFfBU9?=
 =?us-ascii?Q?Q4fu191tXOKQjpyKle4grwqCpv2eBigKxY7KZOvFFXTVKWoG9rQbGHWvB36F?=
 =?us-ascii?Q?tlH8fewzYl1D3FyeULMjsXQNKop5X7bSLiIiMB8vWfaTMnZLHje5vVIxD8Rn?=
 =?us-ascii?Q?vA10BA=3D=3D?=
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a309ff-934a-4cc1-d379-08dbce1a9b73
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5088.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 07:36:27.8062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obDaWumNeimDv5Npbu51EqnG/4dmMPaul3eMgGR1uniPGSCR7zHHhnbARn1eem2K201fe5pArYu/oum64snX1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB6181
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Puliang Lu <puliang.lu@fibocom.com>

Update the USB serial option driver support for the Fibocom
FM101R-GL
LTE modules as there are actually several different variants.
- VID:PID 413C:8213, FM101R-GL are laptop M.2 cards (with
MBIM interfaces for Linux)
- VID:PID 413C:8215, FM101R-GL ESIM are laptop M.2 cards(with
MBIM interface for Linux)

0x8213: mbim, tty
0x8215: mbim, tty

T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=413c ProdID=8213 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=a3b7cbf0
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms

T:  Bus=04 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=5000 MxCh= 0
D:  Ver= 3.20 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 9 #Cfgs=  1
P:  Vendor=413c ProdID=8215 Rev= 5.04
S:  Manufacturer=Fibocom Wireless Inc.
S:  Product=Fibocom FM101-GL Module
S:  SerialNumber=a3b7cbf0
C:* #Ifs= 3 Cfg#= 1 Atr=a0 MxPwr=896mA
A:  FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=0e Prot=00
I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=0e Prot=00 Driver=cdc_mbim
E:  Ad=81(I) Atr=03(Int.) MxPS=  64 Ivl=32ms
I:  If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=02 Driver=cdc_mbim
E:  Ad=8e(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=0f(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms
I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=40 Driver=(none)
E:  Ad=83(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=1024 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=1024 Ivl=0ms

Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>
---
 drivers/usb/serial/option.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 8ac98e60fff5..1dcd1f068f23 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -203,6 +203,9 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
+#define DELL_PRODUCT_FM101R			0x8213
+#define DELL_PRODUCT_FM101R_ESIM		0x8215
+
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
 #define KYOCERA_PRODUCT_KPC680			0x180a
@@ -1107,6 +1110,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(0) | RSVD(6) },
 	{ USB_DEVICE(DELL_VENDOR_ID, DELL_PRODUCT_5829E_ESIM),
 	  .driver_info = RSVD(0) | RSVD(6) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R, 0xff) },
+	{ USB_DEVICE_INTERFACE_CLASS(DELL_VENDOR_ID, DELL_PRODUCT_FM101R_ESIM, 0xff) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_E100A) },	/* ADU-E100, ADU-310 */
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_500A) },
 	{ USB_DEVICE(ANYDATA_VENDOR_ID, ANYDATA_PRODUCT_ADU_620UW) },
-- 
2.34.1

