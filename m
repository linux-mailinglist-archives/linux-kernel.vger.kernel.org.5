Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC5D7F88C5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjKYHPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:15:07 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2070.outbound.protection.outlook.com [40.107.22.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA59E4;
        Fri, 24 Nov 2023 23:15:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxkSKyLCs2+GeO5DvhkHBITAiuva8h58A69pKuuICbMJpvPTI6tQJUyJIi0ONKezlioMF6d8H+E+Fhclz71yyLSREXpihXqCxytZCGJ3jnW64r+DQZzrAlApvVkY8+VaXLvqo+owh8W162UiIarMFp8y/rKwKDJK5hgEcDK3GoHt/pHcqndV+dq37WCKpWRFI9B8bKO8y+D+4fZbxY5rxL+uaoX8ip2TqFG8Wx/m8LkYL2PRFbVDrqY9yGvxVQwUppoI9xWBACvyFA5StVJ2eoXZZGhE47uVakGqLQ2KoaDN6d9T1qqeFuRcoTZYQbUXsST+Gb7mG1NKvLituooiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjqfbS83s1Nhib4p6FisAUYloz4i3vZh1eE0Ce84tj8=;
 b=mWWfwBg9oty8PizIE0flYkXarM+06uynjjjYvGB6dfXOMQGZC4cUNr4bPStgkqP5Q+JHjXKYh96gvFXJC4eaYkXPz4sZhmxylsD+fpp2FmQVwnB1ARzuVnG0e02ZfO5r1q/dEYcCLnI00Hev9Umoy0+baD0KsGTYQxa5eV2AlgygkSQvCTlDSx6uVM4PtoQWHPkLh0kOrlHzduPG3NawyhJORG8jz12WSSVwLuuhHzMnvoKeDer8fKS8+bnnlIh89SwOFVJRPsNZ5Jxdwmh6EOY3pnDrK/2Dcf0/qaGH8EwsLoueH0iuWixVtpB0t/vhaCfaEpLKq3Py4TkGbZ+Ucw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjqfbS83s1Nhib4p6FisAUYloz4i3vZh1eE0Ce84tj8=;
 b=dUECTterodjV8FnrF8Z5zGI91tGBaLXAlLxmQknr5/Sz8a0gFJezmBIU1zevbvEQ9C/Gngj3WTMeNmlg9tcD7bbhiK8FD1elW1J9n4aqUijcetlx/tmYKmL5LE5tYvncpH08PpYjCFBk4MFrwdEiA1eNol6vaXZclKxvJctBNak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.16; Sat, 25 Nov
 2023 07:15:10 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::dffc:1d:4398:7768%6]) with mapi id 15.20.7046.015; Sat, 25 Nov 2023
 07:15:10 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH] ASoC: imx-rpmsg: SND_SOC_IMX_RPMSG should depend on OF and I2C
Date:   Sat, 25 Nov 2023 14:53:00 +0800
Message-Id: <20231125065300.6385-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0022.eurprd03.prod.outlook.com
 (2603:10a6:208:14::35) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|AM7PR04MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: bd841494-142f-4bcf-20fc-08dbed86428e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bg+G/IUqE8Aao2JcFhCk54UoWAG1EjTMnAseza22gO+ucuj8f50ECr2beNDW7w3Q6139i2gaGDkq8tihVqnaYBfBxU+9kvr9CAnoZ+ro+Kx/8kg7mZHL+05sUuhC/wyzbxAqbXXgc7V7gYkInclo7+ybWGL6LEeTLK5yJIHhcXPOHyawYzg+3nU1z5vjv+J7rRXKfb5z1us6eNeg5KLTpZoOrD1OSYTHykKa1/wKC9e6JV0cDhft5mbbsMg0jNTIWlqKjYZqD6AMBJQEVTdPDQj1dk47OYU1Xo4S3vLoag4va9ZsD4gFmFj8hCKIl9P7R+1eiVDKCyM2FnH0/8uucEeuPrp2RKUfnRrKtltuJde2LQwSazdRH1uIb4pYeRS3cw8Dsf7d4Z9IHOkP9yw0N9a1wbsf+F06BPwNFuLN3gpufh8SPuXCwfk+gibCln7s/Qo3Y/G+71yLqdA0788FMKKuVq67O1LZevbyQsU/n4XTwdQ4tsFDCocL+Re8y7vctA45Heic54LdCtsaWXla1xJ4REqeBgl76eqJOCe+DLqD8zyGn9lcOuSDx/+JbyBqFQF63wySE5UA5vaTKtXnyXG38E/9ujh6b7Fn/YTmk3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6512007)(1076003)(6506007)(2616005)(6486002)(478600001)(6666004)(52116002)(966005)(83380400001)(4744005)(2906002)(44832011)(5660300002)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008)(8936002)(8676002)(38100700002)(38350700005)(86362001)(36756003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bc7QDa9y+zPriS6FmcG3N5kQ3BHNqZZRXizrdKdMKjICLZVvY2pHr86EEL5F?=
 =?us-ascii?Q?yNMHJj0nh5N/sd4BkXUTPTrfQ9xHNgV1bNgjRvUZUP+fM8G2j+bnBKzJCfOe?=
 =?us-ascii?Q?3dBDGe63XLz+82Gnm0kjjuDiFJlAHlm+XQ6tJGAm97atwHo/kWP6mBprHfQO?=
 =?us-ascii?Q?Hn3fPiV+XdHT/445ao7Pd8ZlJwueMTzqRtI8kp7PcWqkawEgh3hT6edQaRkC?=
 =?us-ascii?Q?DclZvA60q/xKFDVAdNGHro9eO/98ng175PPr6y+HVuaL4Ak1DCM/VekxpmLe?=
 =?us-ascii?Q?fc5CqH9cP1hA63ildo1G9kg5gEv6aMTkHFw19R/PsX8DLQrWkpBzGzUpJNGb?=
 =?us-ascii?Q?vWoDJmCJisd8JnaaLMvyZHupWmPdakh7/ZQwcenYR0/rfhxEbru29H6fY0/C?=
 =?us-ascii?Q?jJpekyjqKsgWoxBX9Jf9lQ1nJo5MGtQB15f40MZI4zYvDrWkZ6jzKlG/9BhJ?=
 =?us-ascii?Q?mciXThcv3Pybdgyk+VJgvAKxFADUwBnL28JOVdtzctBpvhhq2XXmcRKhONtK?=
 =?us-ascii?Q?WXeYWJOdRfJZvi+VO3vLyniN36PT0Bz0quVkWwBkujdjAs1cydI5HRi2L5bs?=
 =?us-ascii?Q?hnBXLWaodOwfbntx7e9KvaLmsnGyaDku/K4q6V2zeyCNcLh0df+h4Yrbbs0b?=
 =?us-ascii?Q?umsClP6HY0GMNq2R359O6CxB+KOnGi6moPWQKV9/5vNSjOn0tMGzx9kuOCjm?=
 =?us-ascii?Q?fHfdWcVK8J3a4VaQHJS2Xc0o1o7hY0LYFqYuG/Bpnk0Ur2dS7bv5A/P53Nr2?=
 =?us-ascii?Q?LHGK377aRqBpU/pQXVZwJZDjbCsnv3qDQBF8XhRx6Pix9A1NuxfzPiMSvwXI?=
 =?us-ascii?Q?wGEv3wwK2HKlpKj7PHBFiFuISKvNHCm9xOJVmjOkLi9IQMaHDCutAo6H+5GU?=
 =?us-ascii?Q?hcd8sh619P+KszwxnZ7u1PNHsR+JKswPpy7pENQeiOmDzFm9P25yBYz3Unvl?=
 =?us-ascii?Q?LBnnyORM+401qnpiIul3fn2ZowdkemtquWPOzYZQDRF6mcyqhsL2TPPPWpYz?=
 =?us-ascii?Q?nwj25wYuCmPAys1eIUux8HTCsWEGsS+iB7HKyzCrpp8nTjW6IewDNThdyQqt?=
 =?us-ascii?Q?JP3DSDx3G0cuFP3tmFhhmn/bVOoJBLxrJIbIKJT32Dy4rHoEI2ZDF1KyqdsV?=
 =?us-ascii?Q?zAydqdNPqAG4GnFrNBlCs1wnWjkpmsv+Wq7O6fkn0yc02MW9fjzpC0kGoc6b?=
 =?us-ascii?Q?1P2yImKTMyr8CAYSM1/7DNW8WXWCnhOuP6PjaP9gQ9vbJOE/W7sViy7waS3f?=
 =?us-ascii?Q?CFyO0QV64C3efRO0/Tc6e3DkabtnQtmjPh2JUJ73eoeAvPhhcq2TLw+Wic/S?=
 =?us-ascii?Q?6pXFsrVg8yewdzYDSGekASEDV1/BgDWu1mR9HHaGLzQ1Kdg4JBg5WX9uaJng?=
 =?us-ascii?Q?UJwyeNPfBn5Rzjg6+LPJfXQzPH9Ym9GWIczczso2tJ3psXpoYhEDENSWWCgv?=
 =?us-ascii?Q?anmvREQc6fbDDSg5rCM7e1QpcjqPr+QQrDyowkzHYdNUWX36XGNy5KhcZbDV?=
 =?us-ascii?Q?D47WYP2wKWfJnYfYjwxpWkPoqRKOoyOI78y3HwwE3tGT0VuqCjcsclcff9VP?=
 =?us-ascii?Q?Rg2RDd4J4GUgqUI8pokI3dADHN059fGsvAea16MY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd841494-142f-4bcf-20fc-08dbed86428e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2023 07:15:10.4831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xc4ZwAsVkcCSz4UB9PPuJdDChwNA5KKfepn6PfG+He7LdoOWAgHdsu3cHaZnd2k1/RNl2EqLN+Rd0h56jVLp/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SND_SOC_IMX_RPMSG should depend on OF and I2C. It fixes the following
error reported by kernel test robot:

ld: sound/soc/fsl/imx-rpmsg.o: in function `imx_rpmsg_late_probe':
imx-rpmsg.c:(.text+0x4f): undefined reference to `i2c_find_device_by_fwnode'

Fixes: 5d9f746ca64c ("ASoC: imx-rpmsg: Force codec power on in low power audio mode")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202311230506.DPF9vvYY-lkp@intel.com/
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/fsl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index bec2aa561930..acb518f7ae79 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -347,6 +347,7 @@ config SND_SOC_IMX_HDMI
 config SND_SOC_IMX_RPMSG
 	tristate "SoC Audio support for i.MX boards with rpmsg"
 	depends on RPMSG
+	depends on OF && I2C
 	select SND_SOC_IMX_PCM_RPMSG
 	select SND_SOC_IMX_AUDIO_RPMSG
 	help
-- 
2.42.0

