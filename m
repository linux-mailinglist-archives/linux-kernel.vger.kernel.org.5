Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C0F7FAFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 03:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjK1CLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:11:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjK1CLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:11:02 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2074.outbound.protection.outlook.com [40.107.255.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC1BC3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:11:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCexnPgN0VJmmms3ObrZSVZgNKY2kBzX7W3ngxHdw3SABzx2gi+ZgAXzolBAM7V18EBDNCiaxNngA6GoI5WqzaA+69QJLe3mQsHfbdlyajATiLtHx0Dm31bNQa9IwFaUHGQaBW+IjEv6SojhR3lMbBxRYjB85HXYMbaZZh+8Yc9s4xizccHB4vFHkHVfVsffOeBb3T0wKBcH6BIFLRRmweZWc71PdYWUCDS6M0zhwGWWTve6zBV9oq6+PHnxfNeo52fYsUrGyoayjgNd9OloNdhJThQSnKVPoOIRFAt1p6ZgcgvxhH8ieSqIcyQCboqsI/jVIA5CAvE5UR6JLyeGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCBQ8W8KP2ESxU0P5o8t6hgVTVcuKmdNHBa+5tNwWgU=;
 b=WoCHu22mBNir/ceUAmOjF2EtfBkefqqcO9Doc1qCBellEKqCscI5/sUQaEMoQ7S9XWFt3IQEwkNE7qK0UyW67vol0Z9ODGNJd+NkrkP3KaTtJ2gf5LPTXvn8XnytaThoi7hZFO7LccbOarrEthWwiFeUnwUG8Hk17a8crTX3bAeo6C+S/M5xYUo6nJY3bgdZ32x92QhEnUw7ZdwXqWo1NEfxkPj+sJ2b0kP3T9lx0vqHHmLCeX7LAp4bNWuFywEf8SJf1Og2CtAZXkvwP0c/gl1f1NM7P5igf3ui/axRQjIa89HyVTFv3XIj8OESYtyEGcL1jQ/Mni+PNjQEktAiag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCBQ8W8KP2ESxU0P5o8t6hgVTVcuKmdNHBa+5tNwWgU=;
 b=GIk+ezKpydH94IwfMzLME3Uuuxjcc3ytWcbnT+g4Zy3zhtSlVpIkkLW4bLwgJxI5md0gSfVVLuSN8Mn+CM8bzvbXtDft9Bhg/Q4BuOZ/OcgKiQ+4aLOAZs0wQalRFOmtotrzlQGh2g9dO36cn4H6uM18u/r7D4eyDUog4LMjlNbezebk1FQgV2FSfiGCqfoiLzqcUBYVYcInY9d6on3+3m3WxvFMkWsrX2VMMaTplWfxZtBjduTzZm05SGIoLnoJTAdG8ezFuI9nbgAOMGdsq7chXbS1EMzQFmWzz+8RtQYXcB4qh0wOEi3T6EvA77W6NjqiX7jJbQB3RnSho2ToZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com (2603:1096:404:104::19)
 by PUZPR06MB5954.apcprd06.prod.outlook.com (2603:1096:301:119::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 02:11:03 +0000
Received: from TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::e2bc:f679:f52d:9c8f]) by TY2PR06MB3424.apcprd06.prod.outlook.com
 ([fe80::e2bc:f679:f52d:9c8f%5]) with mapi id 15.20.7025.021; Tue, 28 Nov 2023
 02:11:03 +0000
From:   Angus Chen <angus.chen@jaguarmicro.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org,
        Angus Chen <angus.chen@jaguarmicro.com>
Subject: [PATCH] genirq: Fix irqs_unhandled in note_interrupt
Date:   Tue, 28 Nov 2023 10:10:43 +0800
Message-Id: <20231128021043.2099-1-angus.chen@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To TY2PR06MB3424.apcprd06.prod.outlook.com
 (2603:1096:404:104::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PR06MB3424:EE_|PUZPR06MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: a58b3d4f-b9ab-42fb-14cd-08dbefb745af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XY5zkjkjyxz/dw93DwjKcIYPUAdEZGuzJKOrK3WiHUAHiQnbdWoasezZFva7Qf3qnG8lulJWd6oVCO7T71nbbVyF0vBDvlviduyzRSfM3tbaXroifLvztObcrEJZhXPS+g63BtmA3jB/fdyBukcsO8ssM1mwn2SqmdqlytzHowMpMrZLxokw8qxPfAshfFsZOniawl1uQuhdWxdjwNhEWj1RDVn5lH/SPIRGZr0RglOLTHO8frsq+PaHLeqiTyurUZr5Ucb99WPwum7pZRN6LXi+aHIeWFekSiEB6Avrfh7yYkJ45Z0K5CZQJXsZQHJz7M4+p/zmLRNj0Wa3GlXKGjdUKPBSmVONF8nvUKtDngiE7DVWRYYjn0C3IXJy6txA7zNdnxgtwlAjque1ILc+FmKxvCwXMCI9BpNWRAq+5ctDWu7qS+oJt/o7z58QvZaFb3GXnuvZ0SrqZe3I33lmiJCkLgKplB72oB75FRzy7HZPdeATAAPU/76uoN92aECg4C2o4MUOCSOQz7XhwUpBPRhZ/MXxt1a0b3D2TDFJ5h259i7WKg+BDNVODTx8pL9tKRqcGOlNk4r83+Dvts+Syf2zX7md0J+bhksp6usONERznd6lkNZqTPG5ikuhDX6I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3424.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(107886003)(2616005)(26005)(1076003)(6666004)(6512007)(6506007)(52116002)(8676002)(8936002)(4326008)(6486002)(5660300002)(44832011)(478600001)(6916009)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(83380400001)(38350700005)(41300700001)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LkbBUi7m0EpgCoiN9cZSKL0YAWiwdxEHmc4qROS0lmega7n0GTITP9SxDaGb?=
 =?us-ascii?Q?H7PBIBJV39ACdQkEPydwmAUJIwcPXt/0UtNKgAxVJbKYhky/ZgHR3+nBhWkb?=
 =?us-ascii?Q?5ht/3Wnm105H672QUSRAMSvEx2aXJVMknbce3PlhN7wxk6MJH+Vb6LWFkSVv?=
 =?us-ascii?Q?UFAxHUO10IqS0d7W/OrFYvtg+J88SplYGyU0k9SGXRYE5KmQU9RozPGbHoZI?=
 =?us-ascii?Q?4qjTzqe+mQ61qPSZuF7D01F+G68UiBBVlJzcDNdrpLHrBxOAvewfsZfCZNMO?=
 =?us-ascii?Q?ALVibJwSyqLH1i8uNbw2/iNh2OOeMaU9pwgHb5adXpixU6Z3ho9oZBIwp/yr?=
 =?us-ascii?Q?RKaY0DN1NJuefgGTvzAGUs8oyX3XTX1mfpdg/Io+L8FKsO/pb8+j0d79Co91?=
 =?us-ascii?Q?TZU7/lUahCWsl1pLhz2A4nvacAD5jDd/mZBABEBqAWKgyRIpw8uRnSLwvv5J?=
 =?us-ascii?Q?2j6z65a+w5WkwAZt/Q4njf701CTBzRX1y3CvsRMmsIX2MXaHnHzQ95Z136P1?=
 =?us-ascii?Q?v03NNofsh1ekzX3kdBMQSKZp4TJN65Ym5hVH1F2s3pC5U25xx8JcMkZ6Px7H?=
 =?us-ascii?Q?8pKV8X61Xq6nXawoGM0+cNbpaCS4sW7v4tTjWGx44mbRhm+CKeO6QaaK9FVa?=
 =?us-ascii?Q?8J9AvCSouV4fPRkFCpoqqETqKhwz6CqKQlF/JSYosEFpGtu+yhitOALjJz1K?=
 =?us-ascii?Q?y5/tgjRj7npDFfOtqG+T7M/sRS5hYgXP6pQd9qFN4dbYK/7/DKsm/rVCKuDF?=
 =?us-ascii?Q?W+tPq9mmO5HOzyqKy/LdY+YqmpFzWZWtz1pNj/Xz++s6x3VCQ+T4RGes/kTA?=
 =?us-ascii?Q?bicJlgAhBiIndOl+wXnl7uO4N2C/KC7PXp8ojzVfCZLnyluAAvRhTqu3ChlT?=
 =?us-ascii?Q?x78yYCxda/+QAgXGxUb50HZD7yzHsFOZBqyxDcWpdP2uerSO+IeMYINUxUVd?=
 =?us-ascii?Q?Ho95fV3qIvUqveICd+dw1PfAIgoJUcxPiOX9yMXt+/3G9VGjCDUWdcxuZg+1?=
 =?us-ascii?Q?PPPY9x82gxl25mxaqQGU5eO4gEU92P808fMcsb2+AG34mViUmK7hM/RFrCMz?=
 =?us-ascii?Q?r52JEvkZaKimOCXzW+jPw1PUwCpMBNCo7IZYoqaVhA95xHZGKP8O3hMlp0of?=
 =?us-ascii?Q?XKFmFAsb9IwNJKoFE4NBWvC7toaX++07dZMzNx3xMQKb0SrBzkPizbsW6KOr?=
 =?us-ascii?Q?m1sXXkGJAGoZedgI06Tr/FGm6dUQIcqddZ+PeyayDA2bxV8hwqUJ2Xx+WAAX?=
 =?us-ascii?Q?m1R0dSKwnThAdxT+pnisAGWWrS9UlwKvF02amWRg320kP+VCGgRSvxl0A9lj?=
 =?us-ascii?Q?+IDGiHwwVQOzZ1KXWmLryMpt9tTcUeCQZN2IR1nfTu0ZxwNj1JQIkixYvX5H?=
 =?us-ascii?Q?+d4P3F3r3Z6TkDGH8ulVFVflwpTUwVE4nIu2Rqizim6RFaKBfMmBygkh03RT?=
 =?us-ascii?Q?EGPhbVLLsuoTlF0vVOW8d+rO7rUNWoDb5XjheuWcyJIVv3DCaUvE9H3l9Zz8?=
 =?us-ascii?Q?mY91Nag6yKUu4yM0LCLZiBPVW4XiMcnMWgdZtYwtSx6TYHKw2tIj10A2MgCj?=
 =?us-ascii?Q?WWTVzmp8rwqTH8SRsOGDXZwJkjwBm//SbaHTnowc8y+/cmSySCjX4Vh16NIo?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a58b3d4f-b9ab-42fb-14cd-08dbefb745af
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3424.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 02:11:03.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5QzsZBZ1tNgj4pwYMKSdP0gap4x24711VLmv9ElUlS1pwUtAqUmsRXKpFy7eGWRuNfpZ+1RlOrUv8KYgjDjRWhCZUIrtWOURQEHoG495DTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5954
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4f27c00bf80f ("Improve behaviour of spurious IRQ detect")
introduced a age of last_unhandled,after irq_count reached 100000,
we set irqs_unhandled = 0,but we didn't clear last_unhandled.
So we can see the print of irq_spurious_proc_show is not consistent.
Like below:
root@jmkernel:~# cat /proc/irq/138/spurious
count 99998
unhandled 1
last_unhandled 1543930240 ms

root@jmkernel:~# cat /proc/irq/138/spurious
count 0
unhandled 0
last_unhandled 1548915240 ms

we can set last_unhandled=1 as a prompting message.

Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>
---
 kernel/irq/spurious.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index 02b2daf07441..e883df04bdf1 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -428,7 +428,7 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 		mod_timer(&poll_spurious_irq_timer,
 			  jiffies + POLL_SPURIOUS_IRQ_INTERVAL);
 	}
-	desc->irqs_unhandled = 0;
+	desc->irqs_unhandled = 1;
 }
 
 bool noirqdebug __read_mostly;
-- 
2.34.1

