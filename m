Return-Path: <linux-kernel+bounces-14050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 275FB821763
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DB61F21C09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFE1111E;
	Tue,  2 Jan 2024 05:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="f/RdV6sS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2057.outbound.protection.outlook.com [40.107.117.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF4310E1;
	Tue,  2 Jan 2024 05:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esQf0wxnpqqfWq3xCEwgjyhnexl/kilkLB2aryUEIyXCktppTqxv6i4k9oJND5XzpG4+Mx/ZJxLArmHL+luIOFH5FwU0YTkg5fPW+HjH9lmDm3V4AVNrF6dHMO86tQmVfv4cbJr/80wHkZo1VPy2n3E4Fxe1bh91n07Qop100JSLhtV1tt9nyfq8MB7sYvTaj0UnmikQm89JLS/sesmKN6t4NVGHLyNfUzM8NJr00ZtH+jwZRkgI+kxxdr1HyD+LHZGrrbqW+Zn80cYGhzxKCS53CyqLjt1V4JFXlVi5iVdf4IOUjtJLLYqNSwKRN4gDPtA5EV569QjzsdJKT/wJZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVabQsMq5V3nbSVJMY+zDD6yHUidUIOIb0s34QMjpRM=;
 b=OzFaYSRDGSaBwpo48DkszUj1ZqqkR3MnoxOL2Sj1Rc9zQu12JgKs7g/SWxSl4DT6VzJokpZVbZFRISwHRLx6pcTO6TWJLmovmeAJU6nKl7eCY7DpH8DGAsB2FsD/bf2M1lZW0Wrd0Gu4L9uHJ+LXXgXd1R20GMeiDkupEgR3Q0YLUzikHzREgQQ0SRFddxPteabY4fPlI0peI6KuCLf4f+mkebxC3++9mSoITGE44e1dzdNo19VfJJlYgjl9L37yHwB5KxpalErFB67ETHSSPJeYVHH4YD9DpNgqpGUNRqzVlNb70utjTkhX26XVV/5ZJbFBXS4RfgNd9EAFvON6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVabQsMq5V3nbSVJMY+zDD6yHUidUIOIb0s34QMjpRM=;
 b=f/RdV6sSIiCw1UGzm1+uMtAYPmywzRb5cx89vgPFhmLbRc6dIMM3IyiLKg7e3biHh15IDiVfrjgn7FVYknwnsKbOnPCuxc/BKUtzMHqrAMKRzTc2Z3aAR9tZq5ynXIldOINejs8aMq7Ni4Xpv6w4TCT3QLLfw0hRFj2ZfaxjcrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB3806.apcprd01.prod.exchangelabs.com
 (2603:1096:400:3f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 05:31:55 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b%2]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:31:55 +0000
From: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH] tty: serial: 8250: Set RS232 as default for Moxa PCIe board initialization
Date: Tue,  2 Jan 2024 13:31:33 +0800
Message-Id: <20240102053133.9795-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::6) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB3806:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d6d7644-68f7-4bee-c149-08dc0b5421f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	F+GtFYhIj+OoBSc5F9EwSditsEHT7SSxtN8HolU2vHux0lRf0pJgHAQv543bIdQMmZ0Z6BrucObOT/oxYwn1bgLgS4avzGr4YNsoXJ4Vl+BPb1/2BUHbEzhebl/x7FBcprYcncCuSe74fRsn57zx0svV+4kK/Bd61qsweWxAAGpeerhsXNEug8hfGtKRVX2GKLN0ZyzITmYV6+dMcZ891i89Wi0XNizPQzJmsZJoIqECi+rxbWXwCEh5FmYpZIXzvCrHQdV6aeKepi415OQfifM0jcvnEtMkYaLlv+oO0eeGcG/3YlMufmEO+msW/Hc/0vU1A0/KFO1GyslEzIen24YP8vQ4UvKZEutAbijNUnzxX69ps/QwscXeJ33yjEIcusHKMQ5K7WQGMQHn2FePL+wChpI2CNYZtL8hqe51JqGoFWf6+Sd/etk6daMzwhmfbfjyjx0CPn5j9Hchv4iCW2i8X1Bji4pv7vTqiJ8EqPsdfiqyncNM6G7KTtroJckbHLkHhOCXAAihixxVKDGsMejfc7WTLOz8E1S+pe+okawIrqUYZIE8B7V+Nwr3CLm9+HFlbAcguaagPAQfQ1yMsYbcIVwzZ/7gLUeufJi0iUtGxjKxNkMp+oiOwKAr+res
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39850400004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(107886003)(26005)(1076003)(83380400001)(38100700002)(41300700001)(8676002)(5660300002)(8936002)(316002)(110136005)(4326008)(2906002)(6666004)(6506007)(6512007)(52116002)(66476007)(66946007)(6486002)(478600001)(66556008)(38350700005)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Y8UvGIADKRfdco8ZNmiR2wYmFyAFweyzwUKfZpIVWMH1nH1HKEqC+fkBq/t?=
 =?us-ascii?Q?sv9Jeyw13FFiHw71W9BbKslj5cHaWlWaCHY16qeSPvCJio1TFZr3TjUG0ijH?=
 =?us-ascii?Q?VfjM+Fkhvt8EULqMBZJxb3upTxb8w5SNXIBSH0MnAf+YQM3FBdFSZ1HA1bpD?=
 =?us-ascii?Q?bPumkpVnVOKtwGARPtzyQTj+QqeK8NeojM2JJ2bGz8ZGz6U0ApHr8ekr1XMj?=
 =?us-ascii?Q?p2TzZU2Y/tSbHztcrSwpDxrjH7TbMgL+j/cJP9NFx3MRiRmf7UUJmEr9Hogm?=
 =?us-ascii?Q?WhegIAK84qjyhHObw+73yVE6bBSBlqAiRneJpM4xvygmAkA9rA+ZX7c+uglE?=
 =?us-ascii?Q?UECMIujccUIDJKCIyRNHqyM51xaqQEdYRsGvniero44VGj5Wh8JjJnC3AL0E?=
 =?us-ascii?Q?2XIwHSLOlmkwnugvh9Wpy1UIqEWbjy5wXigxcpTkNEXcqCSCqW6ZELlscd6A?=
 =?us-ascii?Q?T0+2IMSkCiIOLfQ/V05YI9oeX6ivAklVSucy0tJA1kvufVsQxZ16NuihKp0W?=
 =?us-ascii?Q?/aLHWtzHWskAHB3INPGQ0xhlr2XKJfhF2wsO1WP9vEhpcfaTCX5BVDw+BUGZ?=
 =?us-ascii?Q?6uFxbgbxBPZ82xK4cqQ9Zngq0cUxfKrRrdmjo9VlQVZprR7cSiEZumXhnsDT?=
 =?us-ascii?Q?IWRDYamYZ1JNZcUv1sg9alUm7FFTeJheq6VDUxfMvtYLLe+Z43VHNS6WRtKt?=
 =?us-ascii?Q?yi+MH/9+2HeQzrDw0YE8wasJEbu7HfnYQKgw7TvnOE4Eshn38EKSHJ6yRx+x?=
 =?us-ascii?Q?VFVf5PM+5JDJlRBtpBoYcItgo2gTmwA65JfRJYOu+9y0bW5EuaZoriNz03hm?=
 =?us-ascii?Q?+W5i4HkpH2GxmDnjK3Wpzd6+brRLd1MFkt8Vjk57nPTyN40Qg758ZJ7LzAyA?=
 =?us-ascii?Q?1UY7VSOcCzxX2fzH09Ackqo0uqsYQkIQsOL3fPguGIZfuQUVAA63g97Mucrp?=
 =?us-ascii?Q?qCdzloUBZ3mDQk2NPqavx+d2Oc/4twIIOrBHG3fVx3ZtWkzhnMCVOMbIVWNB?=
 =?us-ascii?Q?lDV7i8JCBJkaQicTnquHZZ36zCbyriPsKXbq8wWaoAOisOf61YWhnDO8jHz5?=
 =?us-ascii?Q?PSjsJGVDtwiIhBg2zREjtKwJcrTNKYTF9oF4jdVpS0vmqIRnR5xDIoljNIeA?=
 =?us-ascii?Q?7u9g75NWOQ2Y/VtRslhgZ1qRd6SUfLckkK/jJNVXqU60fAg0v2R3NeY8Odse?=
 =?us-ascii?Q?sWWjFUJ5T5uZEeg4rUMvNTp2G3V+sEEByCLmymtfXFyKjIMyaDR97LnRJw4l?=
 =?us-ascii?Q?JDSWBfqwu905y9EdWa05A6MPjrt+KfaIxpubW4Ri/2IwaatBWpFqQ9fzNt/j?=
 =?us-ascii?Q?JI+4WSxfoCn/l/5z7NZ1xJHfu0KdTLJFu5sxTpRy6yJ4iebbMLoyT9cvmaEo?=
 =?us-ascii?Q?eFCOvtyazvOQvfGHrfXcK/wklCraQju+UO+BQ7I6YAX3dKLF/G6CMoPpAk+P?=
 =?us-ascii?Q?BRzMDrg0y4Hr2BHx37tt4egclWIt7Lrp8NmzFGpwx3beF3Ohy1jstrjqY+EO?=
 =?us-ascii?Q?29TTq1cMDaaoOGuaFNfWEDx0D8jhFsy+7FKaZ8NfMcUpHOGkXOgvnI6Q12wA?=
 =?us-ascii?Q?c6XkALpebTjwCKGwIcEzuFflIgxPbaBocnJMUY11/ncyerFi1aM2lIAXw8eT?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6d7644-68f7-4bee-c149-08dc0b5421f2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2024 05:31:55.6556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZhTZJq2b4LbJExI7RwCL46Kq1XZONc1uOYzNlEaUVn1PCOKDS/lk8/sRUwB3U/ZumgyWiEkQXLOuie/qWO6huCqvuLgxkxdvrn80Nv3LdJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB3806

After switching the serial interface of the Moxa RS232 PCIe boards, it
fails to reset to RS232 when attempting to reload 8250_pci driver.

This patch set RS232 as the default setting during the initialization of
Moxa PCIe board.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
index 8ccf691935b7..0d35c77fad9e 100644
--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -2039,12 +2039,13 @@ static int pci_moxa_init(struct pci_dev *dev)
 	unsigned short device = dev->device;
 	resource_size_t iobar_addr = pci_resource_start(dev, 2);
 	unsigned int num_ports = (device & 0x00F0) >> 4, i;
-	u8 val;
+	u8 val, init_mode = MOXA_RS232;
 
 	if (!(pci_moxa_supported_rs(dev) & MOXA_SUPP_RS232)) {
-		for (i = 0; i < num_ports; ++i)
-			pci_moxa_set_interface(dev, i, MOXA_RS422);
+		init_mode = MOXA_RS422;
 	}
+	for (i = 0; i < num_ports; ++i)
+		pci_moxa_set_interface(dev, i, init_mode);
 
 	/*
 	 * Enable hardware buffer to prevent break signal output when system boots up.
-- 
2.34.1


