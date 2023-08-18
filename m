Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1D780AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376365AbjHRLGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376403AbjHRLGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:06:15 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40F92708;
        Fri, 18 Aug 2023 04:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFVYB//qRRTQXnvBrHrEsuIEdM2NkJ6sclen55X0rteV8Urzu392pxT2g0H5mfhTIWA4qEsTHlPkZP84iCzWaYNQuQvIrd+QiWNVZeuG5nyzBjxYDEBn0Vw5dMZLVG3u6r4MFkkB7JDKRVfPbATLQxV+4l5RCS+IP3r/vU6AfbFhHq3fGU0VWxL+8Ws/tBmiC3yBjBHElHkw2IJ7bQ8YGAPDNqQZV7poXyTPbLwnJPd/JXvWbEsaWFK9cjstOwz2erFCm1SYz/d6LWPFB6XYGaF6FiVfuiLEZoutMIStT9+TRguHfcEUjaSH9ryqa9wQTY7EDrXz7Z0aasXc/POKMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yK5nxgNOVMoV2meGzFfEHbAA6Nmr7Bsfa5eh0vArl8o=;
 b=FWn97MPHFluhFOItjmh1ZhIxlN3Dg2UIRBLXFIzjHhGHw7z/ghftETq00XFCwtT/tnr5Nq0GurqLkb88BhQp+ZA1BSCHuy99u0mkYHV/CRtjRLVArc3QcqAT9zAiOBKl0Rwninv7d9/0WRysJgKC4oaoMnZN1mbBVm/7tOgWbLicKSR4yGuVyCB5rEt88+HCQN22OBj/zdCQ/7mQh21enfC5PukWJdLUIGMFr0DYd83i4X5eVgaw1ihnqeDdx0Z3F4GatvpiUuHCF7gl2tTJY15910eQwnfFmhi3m6D5PB1nlInWiWiqRn6KIcUyLYa7Fw4auCbHREWy9oEedWrNYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yK5nxgNOVMoV2meGzFfEHbAA6Nmr7Bsfa5eh0vArl8o=;
 b=W8PiWv/cIlHk+Tn/0ZeRJfNbL2iWjBraymG9iO3ufyqDGCm/6D/DQYe3zPu7NidtmkFhDJH2EuzoHgFH8x174z7DN9RGapQC9Umw9SA5v9hm2/TztgbDkFjzq+fLTphQa4fQ55vq60/dgOcHEWVaei2BWul8dFE1uuzZeZ34ISc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DBAPR04MB7237.eurprd04.prod.outlook.com (2603:10a6:10:1a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 11:06:09 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::c19e:3b5a:c081:ce3b%4]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 11:06:09 +0000
From:   Josua Mayer <josua@solid-run.com>
To:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v3] net: sfp: handle 100G/25G active optical cables in sfp_parse_support
Date:   Fri, 18 Aug 2023 13:05:56 +0200
Message-Id: <20230818110556.10300-1-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0007.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::11) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DBAPR04MB7237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c064130-6e2d-4125-f4cf-08db9fdb2039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+qKVWsDSHaG4DfHB9A40iJzduKRxGgYjww6dOLhM3P2fDyevPcVYL5oMIEa3KR32URJN0LWNySykDGBJ7rU6tdC/Ek26GydlamUXg1Q/HgwN1Q4EtQCCehzHhszbNlGxemwwtVgW7/NahoAWHg8/+gFAh+6yVask+LkZY72Z6Jmkiqd6N4ouW6uTSPIMcZ4kEiP/4IVJNF1GOFuci2pSvsYk7oHdLqxPdJOcUkoXxO6ViSolR5u3jLcd1LnSFfZIJQmom2rTibM8BcpFTyuNbDOWRwOBF1AXv0afU7HNo9t2mQdPxIjeMWFrjmFhe2r3Mu0vx0orlO+ZlCpMju+sK1ANZee5lugdVq6mRe3PYgOpS3s/3YZTQWZONueZw3Yn2HofEP8ePkPvPqr61M5oGkfZH/zxri2PSHT3xnRRoTGq+sR1uirv4LKIQ/U57gHBZoDjfQ3ngk+skYIv5ggiX9ng7hyeVfTHBRVsZ1G+4HEBUJAK5WQeC3pQBFmXvFIDtkuOndoAsE4DCmtXukxWVLA/s3GKKbOtpCWWweYt/YoHDAo04r22nl1IdLugELB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39830400003)(366004)(136003)(376002)(451199024)(1800799009)(186009)(2616005)(1076003)(6666004)(6486002)(52116002)(6506007)(6512007)(83380400001)(4326008)(5660300002)(8936002)(8676002)(2906002)(478600001)(41300700001)(54906003)(316002)(66476007)(66556008)(66946007)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UWnL09v/KOAhHS9P4Z8IhtAB8Pv79DfvMjxH5WYkv1QZSTae+6LMPbva8Zvj?=
 =?us-ascii?Q?wXRELpJe53Fznq9DEkqWOmi9VzlGzbHTQIADS2boZnIXdGCQzJaA5vd7Y8gZ?=
 =?us-ascii?Q?aBTlEIzpPQC/9dJtW/u1kGMy9Au5qI3YiFk3cV02SCmoEpZ1GVxNPg6DC1HO?=
 =?us-ascii?Q?DsG/j2VLK+WHhZCCMibLnOigC+mJ/AWofU1UZz2Y63W9fPKj4Ie49TdX4JO1?=
 =?us-ascii?Q?e/cxGQQfQylJco2GLLlelw+M7VX+9+L0ztH9r8bfXjETkD1XGsDTbtON43/j?=
 =?us-ascii?Q?wwmdYR9NrEay9HpJuG1OIvSy0zeut5+IQldCvXZPqM+hGmsxgSgsi5vR0eGG?=
 =?us-ascii?Q?DIWubXVasL2qbNGTHkhWMKviipEnIfWYpoVim4dDg52eDRTgB0Es2dg/DjpP?=
 =?us-ascii?Q?OO5fNREjQji5JPtN1liwlBcMMbqcl2dp/vnttjrOKUBtGRmsBYRpJpcK4pGS?=
 =?us-ascii?Q?vTwDYE3iCPb6rdwkBQgcTkOqHiFdA/JRcphuF+ITUrawZVj28m5bqzCvwIA6?=
 =?us-ascii?Q?3380xFnJZiFOOQMNRKeoyYq2G+MrCtS0A/qA4S/x1M9AES6aztBlvQLhR5pW?=
 =?us-ascii?Q?Pkh6LfV/tFVt01+eFGJy0pA8tNS7JsOPZOwahbAaAxwi6hjKegpbBymzl+03?=
 =?us-ascii?Q?CwTig/A9dr4PUQiAK+yxwFt9xfSjgQMM3ul1mnAQ2g0/Y3ZsBaSNPZfDv1BC?=
 =?us-ascii?Q?OqlxLT0gPU2kJlupUgHbEdXGJ3+q9Z2Li5gXIXsJVO7X/1vqvXoqdK4N1U83?=
 =?us-ascii?Q?UQ/fBtn6gJC4Bs1U9yMLhV8qh+fTPGLOkMXynldZXvz6ImigQ6lndpXHxCxC?=
 =?us-ascii?Q?R+v5h2TJHsuye8cgPZambmiO6C/zFlIgYqjNQr9zDUVZQTkUuHlbFX+qo+9T?=
 =?us-ascii?Q?TYCVGR8EyHM/5YShejCtHlipFmG/PHgin0F1sL9KIFy/bDHMy2Ut5lJvdsLd?=
 =?us-ascii?Q?UkSfoLZpmhzIrZVUc+1IalKpfiCLyWiVvo+7oriW87cFGWnOqqlZdtSdCllc?=
 =?us-ascii?Q?PKbv4RylwAfLDxROvZ5JN9LjvjnOSyCa0xCtdYvgiIOY/4soOdrXwDVx7dGK?=
 =?us-ascii?Q?ZZ26hiU/F6S3JSGbGxyeR82SKwTDozbtG3dCd/LQcqtq0jWHBF7WLqIGXb7W?=
 =?us-ascii?Q?f+EL2w6AeLawDd0JMmA+OVakUHxR1wfOWQcDnU33CwtcGDsxZXHXINqZLoVk?=
 =?us-ascii?Q?RAKHydxc4ZiQVFctR+B8H3u45WzKdf7aevclaQ1zyL480B2idjMfjt1wJ8bS?=
 =?us-ascii?Q?NJW0CWelFqoE6otQfMUcUrDzV1WDnvPwFfEei87yzlY1ixnVQjRfrn3DjEA6?=
 =?us-ascii?Q?FHMc4obQWPGEy1eNYCp1LD6U8pcmHTgYlO7I7FyeYtrG32R6HIwFGith9ZIX?=
 =?us-ascii?Q?PbvkAvqAHQk4J7UcpkaTPhY4VbjfZLtTg7MbXIkb/8RNiINSFd2qaRfyIsO/?=
 =?us-ascii?Q?HUEz1s0Ai++SfpPQQgp5IwPscWP+R51oOq+s6JmdAC55b1Aye0AWnUN7WWZc?=
 =?us-ascii?Q?7iwcGqK9DkGvnOWBcmGOXYihwmwaOqMbGnOX/d/iJJVWiLyC/PU6aCwDH6go?=
 =?us-ascii?Q?r9zVU2PSS/GuwTPM6gmcxNcR+oOukRV8p+GtIQoayfxGJLNFL0NnAh4EOr2y?=
 =?us-ascii?Q?+/gOAAMmR0p/cnZHWliUKZg=3D?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c064130-6e2d-4125-f4cf-08db9fdb2039
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 11:06:09.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KeNyIH05IdvFXtkXkE4/mNRdc74MK7eU2VzIoea1uYy9H+w8YQLlwV2hLnr8S1mQxO4xPq8xDtP7B+f5tGWPOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7237
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle extended compliance code 0x1 (SFF8024_ECC_100G_25GAUI_C2M_AOC)
for active optical cables supporting 25G and 100G speeds.

Since the specification makes no statement about transmitter range, and
as the specific sfp module that had been tested features only 2m fiber -
short-range (SR) modes are selected.

The 100G speed is irrelevant because it would require multiple fibers /
multiple SFP28 modules combined under one netdev.
sfp-bus.c only handles a single module per netdev, so only 25Gbps modes
are selected.

sfp_parse_support already handles SFF8024_ECC_100GBASE_SR4_25GBASE_SR
with compatible properties, however that entry is a contradiction in
itself since with SFP(28) 100GBASE_SR4 is impossible - that would likely
be a mode for qsfp modules only.

Add a case for SFF8024_ECC_100G_25GAUI_C2M_AOC selecting 25gbase-r
interface mode and 25000baseSR link mode.
Also enforce SFP28 bitrate limits on the values read from sfp eeprom as
requested by Russell King.

Tested with fs.com S28-AO02 AOC SFP28 module.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/net/phy/sfp-bus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)
V1 -> V2: added separate case SFF8024_ECC_100G_25GAUI_C2M_AOC
V1 -> V2: added bitrate check for eeprom values
V2 -> V3: updated multi-line comment style

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index e8dd47bffe43..208a9393c2df 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -258,6 +258,16 @@ void sfp_parse_support(struct sfp_bus *bus, const struct sfp_eeprom_id *id,
 	switch (id->base.extended_cc) {
 	case SFF8024_ECC_UNSPEC:
 		break;
+	case SFF8024_ECC_100G_25GAUI_C2M_AOC:
+		if (br_min <= 28000 && br_max >= 25000) {
+			/* 25GBASE-R, possibly with FEC */
+			__set_bit(PHY_INTERFACE_MODE_25GBASER, interfaces);
+			/* There is currently no link mode for 25000base
+			 * with unspecified range, reuse SR.
+			 */
+			phylink_set(modes, 25000baseSR_Full);
+		}
+		break;
 	case SFF8024_ECC_100GBASE_SR4_25GBASE_SR:
 		phylink_set(modes, 100000baseSR4_Full);
 		phylink_set(modes, 25000baseSR_Full);
-- 
2.35.3

