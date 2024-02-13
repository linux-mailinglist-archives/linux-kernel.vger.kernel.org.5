Return-Path: <linux-kernel+bounces-64387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF93853DB9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A541F2C299
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD4F6281C;
	Tue, 13 Feb 2024 21:54:34 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2055.outbound.protection.outlook.com [40.92.48.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65006280F;
	Tue, 13 Feb 2024 21:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707861273; cv=fail; b=pjiAW8qRciAnhx8qXHFjOdJk75K2xImECZjrj9wtkPcC4UHeoJUxrlNcJN1G0jtpBaItxqQKHrdFl49tt/hkrDvLNLSpAJhzw4sp/Q86BWlkpezc6KWAVuCx+HLTmVA3ppGuHUTCKaF7N0wtLJDI+a/rI8BUzElEjHuxZiB8zZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707861273; c=relaxed/simple;
	bh=U+Ke6YQ2CH57ecVsPCfgQMxnQIrWzyh1vUwb1rbL3QI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kRlHvqKrByiQY5Y1mA/hsSV8oqejKFmokoDNDjW5k2GUliaQ0TFvmOhz3IcGDG9VusOSzpqX6jE5PR5MTj8jaupm0dFpJrZW0EnV8lPx3b10QjBvM3gcXlxnIrluCHgWdIeJoFMEdkZyaTMnMkkRZftZmwD8BpupTlXhGBCFzq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; arc=fail smtp.client-ip=40.92.48.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OokSdNjH1Ot/FQlpJt/hJuFfRoTvUC8ymvC7TurbPFh8l2fGsHu9prwfuj75wPxCG0CSFYlCvvMJ9eWimAOlsdxsZA6tyjZzJqW0sr7tXE5TBE32fEFVXWgTwTp1rHHj6P3UVDlLPeISmBTSzfls2maR0CvLH6o3WG5Y/6hy43Y+WmZCcTFNW/35fx4O36c8WeqnxsAoqcgzINVnhb8bi2UQvE2vVd/SycCWedVILlS5GGG+de2qlZEl+exZoffB40Uscsr3InwiV5a+SJP8koIGql2FoZd6dKCx9yyDaO7FsaSTNSXxCXNH0BILJ6AJtLTQWF9fCIal7BUdIZtrHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyyEMqc8UtLmunplqVFG7L1yK2gkbZO99TtUQExK4Oo=;
 b=Xqjc8TClqGALptenGO6ddsWMQuXVQCUmhy8nYzplzmVU0JGOfsY6TjCvTlYpI8hDrG2BU1q5Li3r76vB7Kmj456N9UWrI9j7wCfATqa5WOtyM0PyJrHZ+3bZka0LQA0/4E7nRwiNS3cMefyJmQ2ZvhKJEl4NDb6jK05m9xlomjWuohe/RoGJTMfRtZq0SxUp7D3egiS4SK3S/3dU/Fmpdl3U6ekZdo68jap2KujHUDbqsWg9S7fxBBQgnQokpkh/hDvJ2D8PrWKw/qPo8y/E+MYFsXvJ+/WSOjU24vzXiyUApCHPQ8XKVSPRr1X8l2paecq7MurAcw8sOEX/Gnmg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com (2603:10a6:10:347::11)
 by DB3PR0202MB9201.eurprd02.prod.outlook.com (2603:10a6:10:43f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 21:54:29 +0000
Received: from DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::d9bc:2ca3:7e77:9b47]) by DU0PR02MB7899.eurprd02.prod.outlook.com
 ([fe80::d9bc:2ca3:7e77:9b47%7]) with mapi id 15.20.7270.036; Tue, 13 Feb 2024
 21:54:28 +0000
From: Cameron Williams <cang1@live.co.uk>
To: johan@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: Cameron Williams <cang1@live.co.uk>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: serial: Add device ID for cp210x
Date: Tue, 13 Feb 2024 21:53:29 +0000
Message-ID:
 <DU0PR02MB7899B4A2A35EFE1B350E6F97C44F2@DU0PR02MB7899.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.43.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IcQugbF7hp8bVnlelUVHmFodLzpS5lFy]
X-ClientProxiedBy: LO4P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::23) To DU0PR02MB7899.eurprd02.prod.outlook.com
 (2603:10a6:10:347::11)
X-Microsoft-Original-Message-ID: <20240213215347.3798-2-cang1@live.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB7899:EE_|DB3PR0202MB9201:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dc3c89d-fc60-48fa-db83-08dc2cde597f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K56UO4QUZO/qPviFomVyldOLFDv1n+f5/COjiJsRHw/CLUYBaloxVfuGpTA2HGI8qbYia+fKAJiKv+UuOFYXJJEwEO3jCKPL+IBgd1ylivIH+IGt4VdCf7FY788pNCK8+pRKXK7q8Q1jVue4N3RGP67fO+D40Vv+lA707jCS82XcVhmwhwnskUUkSlQRRZ1zjDUPPvLCQN3qsklt0TLoJVb6lsCvj5UUC6Rfhr9T0O/b8W6+iCuJpzKsAvvY/rGvV8r7XbxoAV9FZZ/y6hDYMU/c3W+rgvjCV4cSx0wNnBve+lkHw3Xj9BVZahOiyvhEWW8NDw7X6BunFxBKihqe/StdcqhGcw/l/jesvNoIvQ5fnE1hiM7NLjn5+m0X9dpmoRPQuMysZ1SxcTVHjsuDPQTdohfx9UH0h4DeoOtoEr1+sDP+Co6TC3oO07pk4X1fJSJOTtRUWevA+U8yidZ2FKFEE+MssENtoQgtrbz+pRd02GKVAmsTu9j9OCh+eXyHRNB7fNYBqDOgBhciiPo24LHuDDPUB5oUm7YTyLlwov8vEW4KfHLaMEAwthbjfWNf96MK7hfhtN5U4KpRUxwrgcFda28BNdQGmA+pX61OePi5lOXSmC5/hkqeJyvx7WNN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?es1wSSQHu9uhWVL3KY+Tip84l/Aj2Rw0tZA+GUFb6zjvxafBhZ2WTcI6Q7gK?=
 =?us-ascii?Q?Kc4lQI8xppPRkJoSW8DyruAyPshmVEA/wtVioEdnqIO+yJm5mRYfQnwgk8fi?=
 =?us-ascii?Q?8bx+th/YKbzeyLfdR/YLPDsqw5k55eCWINJwzqnhzfYggJkUAOl1uDCc5h1e?=
 =?us-ascii?Q?SPQka+0gs92Q2vWD8tT4AbaojumEc4U5oZQGYZVXWFyPIhbXxBNV9p2hlx2I?=
 =?us-ascii?Q?P2Ug1zbPgCI6JwnVaJ/erBTnyc21Jy3X/PBMtl6N+YmHuwbAspZnhoroaNeG?=
 =?us-ascii?Q?7K2Rooeu7AtCtsVSmoEeiasZ1/LkNZr0dG6SQk/gUY/eoiC+DUPjB1CQm0JS?=
 =?us-ascii?Q?22s7rws/KiH/vh1ievQ0MRcEnge4CKJu1NVTaMop/hZVN/o1LIFbOqB8yv+P?=
 =?us-ascii?Q?Qj2aLkQuEfCddSXYlW3k0+OOk9KkCMR1idgoo4288nofXbG4m3UxZQpoWWbi?=
 =?us-ascii?Q?iLtzLpikHE3nNrB7rL3wv1wUcuS7WW06GEW2yDMxdb4iG+rKWVk/gk5UlDx5?=
 =?us-ascii?Q?ycuXc1A0jBk/wvRblGSyrBieAu4FYM6DBDjEe4jtn/Wqgg734FrLNPzZ52Dq?=
 =?us-ascii?Q?P2+1HutCKwP63+gD5EmexPOCaYyhO9salTLlwDvNMr+1A7JFqHOZ/Rf7k9qn?=
 =?us-ascii?Q?nqdqKSIWrO4AzGSXyzWVjdGXwCHW0MhU+mFgbZlERNizKT9QURRRHaIsXbIC?=
 =?us-ascii?Q?pIDqKlHSs90xjq2u6NCNKBeeEtKg+Uo8FsBl+E+SqxuQvIwAngxaYfFnT75I?=
 =?us-ascii?Q?bSl3U8jAe7x/RbvyUz+sjk/0SIvoZ1tFzq4FefuUdipzBPGdIpFGOyK9towl?=
 =?us-ascii?Q?3xP6rKnEZJ9SxjtAcf9RocvSQ9LI9sXdiS4Z72SldVsPxiLk+MbbJxqYD9L5?=
 =?us-ascii?Q?XK/PA9xb+jPLaQMRkAU+llkG17M6K9g2ORLZL8rcfa6NUe6GM0LADKbxtPhO?=
 =?us-ascii?Q?7HJrjyiO2uXrBU9pAXO5TGpd4xFPgO6j3Wa53E0P0FbVLwD/BKqJmFV+ijL0?=
 =?us-ascii?Q?37DcXGB/RKWsjBSVexDJHoTLy7xsrD3QQeNWPp/oPEaQ89QV07hVXubNHsY6?=
 =?us-ascii?Q?NK67c0Yq/qdgantV5vNMRz8F3gnwSRcdG7z0q0WoCXak3WMEW4pwD963UJ5N?=
 =?us-ascii?Q?/49+bKt2ARGBmZ1jnlugOen00XnuZeNYCt6NPFZ/lNxxfchtXwaHPC9UP45i?=
 =?us-ascii?Q?ZKY+SS85bF7SiBIlCGcH8e7WV3rsy4u+wqPxzg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc3c89d-fc60-48fa-db83-08dc2cde597f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB7899.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 21:54:27.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB9201

Add device ID for a (probably fake) CP2102 UART device.
lsusb -v output:

Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 [unknown]
  bDeviceSubClass         0 [unknown]
  bDeviceProtocol         0
  bMaxPacketSize0        64
  idVendor           0x11ca VeriFone Inc
  idProduct          0x0212 Verifone USB to Printer
  bcdDevice            1.00
  iManufacturer           1 Silicon Labs
  iProduct                2 Verifone USB to Printer
  iSerial                 3 0001
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0020
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 [unknown]
      bInterfaceProtocol      0
      iInterface              2 Verifone USB to Printer
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
Device Status:     0x0000
  (Bus Powered)

Signed-off-by: Cameron Williams <cang1@live.co.uk>
Cc: stable@vger.kernel.org
Cc: linux-usb@vger.kernel.org
---
 drivers/usb/serial/cp210x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index 923e0ed85..d339d81f6 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -177,6 +177,7 @@ static const struct usb_device_id id_table[] = {
 	{ USB_DEVICE(0x10C4, 0xF004) }, /* Elan Digital Systems USBcount50 */
 	{ USB_DEVICE(0x10C5, 0xEA61) }, /* Silicon Labs MobiData GPRS USB Modem */
 	{ USB_DEVICE(0x10CE, 0xEA6A) }, /* Silicon Labs MobiData GPRS USB Modem 100EU */
+	{ USB_DEVICE(0x11CA, 0x0212) }, /* Verifone USB to Printer (UART, CP2102) */
 	{ USB_DEVICE(0x12B8, 0xEC60) }, /* Link G4 ECU */
 	{ USB_DEVICE(0x12B8, 0xEC62) }, /* Link G4+ ECU */
 	{ USB_DEVICE(0x13AD, 0x9999) }, /* Baltech card reader */
-- 
2.43.1


