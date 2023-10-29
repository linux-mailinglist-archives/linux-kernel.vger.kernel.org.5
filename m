Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7587DAD64
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjJ2RGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjJ2RGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:06:20 -0400
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2180.outbound.protection.outlook.com [40.92.62.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD869B;
        Sun, 29 Oct 2023 10:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tio6nt1YXkeGI+71a7GKytlsSx9SxOxB7jm890sp6hWEBKeqjR6mIgj4ud8NHY3Hc/GTjTwi1CrUOrtDI79omagYHoqkuI7cgEbtIUXvGHKzZHXnEMTfzbguOfbeMovca2Ey8wRUi9jeipx0vYy/9junw72Ib69sL5HGuRvyOchP8A7qOi037KKtfGPDoxikJFiOazcSu/ldBHX5Fi8jboySEjwq4qsvlvulerExS+hA7z/fs2OW+fKVmbL3gMhPqj7C4Eh7PICqF+fQ4m5dO7ATAWbBsm5O5bHSGQC2/0uUYJ4Ld9kFPPL31plVjw7u3NFX5cxaeaK7RGe3z4bWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiDvTMOTYKxvPVSYElkAiLllbD9f2SUr5oGuEtAXapc=;
 b=EFv+LCbRyEXrRRfBi6IiHlOYrc+wxDfwLStHNaaO3LeWUJq95ZRrqdBx+gzn0ard0METfegriwY08D5T4soB8fTZxZZ2GcelfqEs0uqvNPfQcakGGd1dn2w1R0m2TYMmF2WO+OU5mK+fGWACT+dPOI6xHQnssrgvzT93c+fuCLEBCWloY2Vnbd5FsQEOCcDizQv7yrW5QzBwlPIo/uB+aDwyMaQqRkJ6+5VOfewEHrXXhIE5plsoFyoZ32tQ88+Dbgvwz6IPhg3whgUliKB5dmi3Ab6mUTXHW+P8pEDTTAQ8+V838lYcekMt+YiDVafG/0CSZGOoUxQjiPY5CBj+SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiDvTMOTYKxvPVSYElkAiLllbD9f2SUr5oGuEtAXapc=;
 b=RwACsaFBRGy2F3Aek8G9OKIbbMgUo/xcnceNfg7Ke7utlGuogBXcfv/jHN/KOXOFqOc7v8iVpi+xVduk2qFL/PU+hWiTRiGyimRa4F37GlBk0WnjHh3fgaLrW+8nNSoxKH8Eqw+Wh6suyhKYuWz27qHhpoCcJEW1MzvN/orK52Ny5flwemh29jwlTsSXjiY5xBtp4Y8eIV/Ot2Fgwr0nss252Hzfz0oOe4e7MTHSR4X7uAFEaNDY//xNCd7zkXmLA1K72GKBMIxc0f4E/oPLrw8FqCQJrhUHOnm+j9vh5Fqrf+V241UBrio1x46+R2QwuEnPKrMX6uaI/r4bfMPWUQ==
Received: from SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:dd::7) by
 SY7P282MB4517.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:274::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.26; Sun, 29 Oct 2023 17:06:13 +0000
Received: from SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7b4f:c2f2:e037:7f68]) by SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM
 ([fe80::7b4f:c2f2:e037:7f68%4]) with mapi id 15.20.6933.027; Sun, 29 Oct 2023
 17:06:13 +0000
From:   Yihong Cao <caoyihong4@outlook.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Yihong Cao <caoyihong4@outlook.com>,
        linux-input@vger.kernel.org (open list:HID CORE LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] HID: apple: add Jamesdonkey and A3R to non-apple keyboards list
Date:   Mon, 30 Oct 2023 01:05:38 +0800
Message-ID: <SYYP282MB2110B4E87983EAFEDC8741E49BA2A@SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [591oj4R3DDtFoIqJ3KzKtkgmE+n7KhiA]
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:dd::7)
X-Microsoft-Original-Message-ID: <20231029170539.108529-1-caoyihong4@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYYP282MB2110:EE_|SY7P282MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: 464d0f9b-ce62-4538-ae95-08dbd8a15a87
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eugP1pkXLdr/O1z8afEBD9YfXLqVhAKM3T3nQnycxPhjJPL3CXSR8XW4lz7nb47fhYik7XCs628G4qMq6yPDSTgdifZa63yE8ZZ4n8Nvtt5eaVVet6SursR03K3Tr2cfD7q+O+WxMeDlUb3yI0t0rTxW/zGkX7Fc+GdY6iMlMC/iGm7/1GCuTR2SixHbkUkXHynl3FIcBHQYmrFbGMwOwOuGkqT6mXZL3/JN3lRhkpqcowS9jnJp3zgVUK6sa8WjI0KR9nJj8Qo6x4TIL+FkWHaEwIJT+cMSIM1KeQZA5YiJeS6s5HgVxXEMxLVVS0N29O8+UNcZXVDm9m7GYYp2XdqM9oV4r3QM1JVETA++U9TOXaJwVA+B8nLIZnyZIfEpaXFIJN2pGywDZbLwpVRBRQS+2CPhhsI+/PFTGKaZ4JD9GckZiD+fXFwm6ypjXVMZ9By7kwBTdDa+65hqpj6I/QzobeMTkwOaAlZVkF2qOGfhqnDRu0rzS5HVX3h+tV+DO0a72EKC3qmOi1EMowrRTw2lUvufg0aPWt9ePtFBzzA+xDqz7P1xbDq5x73Faws5kJ/exgzg6bDaP7O1Ly7+g21ZrygWF0HbQeS8VDRFDIebjgHZCGRXhCiPC4MT8ork
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YQvVyRys91IYHAOAhq4kVN34VzKkH2I2i41uZvEuAMBVknn7rfQk77Y/5qp8?=
 =?us-ascii?Q?C70JwYtgcITpu9VuhZiL7ir0DfvUyQ9GSKHpzg29lyk0Y8cMWFY98FuZ+IjF?=
 =?us-ascii?Q?Vxe5YG0zDdomu53csA4eTTxHBezGm0XfIgT7BUdUHFVwoWlNsGfH4FBV9QGE?=
 =?us-ascii?Q?6aDcJfz2ZBWZYxW4d3ZiSrtOL/sSNCjHLHiNRpI5zsfjLIkK6ilEKsdERN0r?=
 =?us-ascii?Q?ij00y07VDVJKTCyU3sJEKS9hCDaPq8RvL8sDihVJJypUFUEUoSPXttKVEhiq?=
 =?us-ascii?Q?zYnKJ67YrBQe7ihk/iWQjv7EwBMbE4kf8rVGafvo4BWVX0E59K3daBSIimq0?=
 =?us-ascii?Q?gyAWF/uSygJR83Sz1G91qegCbCl8I9H2ZYi4Ts1jJXrJdqIm2sz1rYSwk9J/?=
 =?us-ascii?Q?Rn7dXrG+LC9om1GriCa1FYzwkTpKZDVnbQUFi6hi6U2EW/TsDJShdtDWugI2?=
 =?us-ascii?Q?32igngxydHFojHsqLnJvd9f3hBmwyHsuX1oDfhTWJaYH/QFueEyPyXSRbtuQ?=
 =?us-ascii?Q?NA3DwpOIT4Y8EwtNXPD7SGqxVmb31+eH8Af89xINsjCN4QZGqySOxpsVdZD2?=
 =?us-ascii?Q?qGeUTazH6t0+SkulXvX7Z8cB72rERChAPfXNW+Rzvsyqh+AeedYLHtzBdUk7?=
 =?us-ascii?Q?sKjQsA16Cx5doLMAPvOA356aGGsJqwc8UZNAlwWWTlfffnDW5DsBIuYB4MSo?=
 =?us-ascii?Q?c/3Mao7DpiaZ2ZieqVh3LAS+1LoMulwLhz8Cg3bJ7/Q66GI+UNiCG5XDKrdS?=
 =?us-ascii?Q?NfsldImbWu+kqTSb1x4h0j1kqM1PyvtpIVV6MG/R3HmGASKCBK0n7tpXWY+f?=
 =?us-ascii?Q?vhCNqKdcejSGVLL6awwzU8s8WtmGFY6wzM/EcRnDLuOA+9/MPVWomqlWskYk?=
 =?us-ascii?Q?bVNu/Rre1ZjZ13a1e+i6n33vFnfUAP88YupPD0vUh4rybmH31W4e1ABsprbS?=
 =?us-ascii?Q?xer9f1x2/zZccl9+jxFa+/Du6uofsnnHJOSIbcpa29wsY8dR6jSEzDwG0PYA?=
 =?us-ascii?Q?IvVtKmeXL8yc/fcPhGunrajQkByUqkH9EG5OVGg5k0RseZgs6Ae/wiNgGHnt?=
 =?us-ascii?Q?15xkW4GL18TSjRfmVH8osXphEnTZz2ORoOG4Wkh9lyCp+fUd1K9VYqs/7e9U?=
 =?us-ascii?Q?cjJfrJUW7yprP9ShR4X+0opcgQ12T+Em9Npf58fUFaxdox4ewvFixnxrHzsD?=
 =?us-ascii?Q?XFENO+uQ5qlMzwtsL3NDSFOxDxGNTUE1aoOn+Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464d0f9b-ce62-4538-ae95-08dbd8a15a87
X-MS-Exchange-CrossTenant-AuthSource: SYYP282MB2110.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2023 17:06:13.0962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4517
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jamesdonkey A3R keyboard is identified as "Jamesdonkey A3R" in wired
mode, "A3R-U" in wireless mode and "A3R" in bluetooth mode. Adding them
to non-apple keyboards fixes function key.

Signed-off-by: Yihong Cao <caoyihong4@outlook.com>
---
 drivers/hid/hid-apple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-apple.c b/drivers/hid/hid-apple.c
index 3ca45975c686..d9e9829b2200 100644
--- a/drivers/hid/hid-apple.c
+++ b/drivers/hid/hid-apple.c
@@ -345,6 +345,8 @@ static const struct apple_non_apple_keyboard non_apple_keyboards[] = {
 	{ "AONE" },
 	{ "GANSS" },
 	{ "Hailuck" },
+	{ "Jamesdonkey" },
+	{ "A3R" },
 };
 
 static bool apple_is_non_apple_keyboard(struct hid_device *hdev)
-- 
2.42.0

