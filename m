Return-Path: <linux-kernel+bounces-6618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 625E5819B12
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6EA31F2282D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827751D55C;
	Wed, 20 Dec 2023 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y057Yinq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2089.outbound.protection.outlook.com [40.107.13.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B691D528;
	Wed, 20 Dec 2023 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KC/QkWRgf6jEoxttsA6nx+A+H5Bhd7r6vc5bThFJYbvrkdDB0ZETxULxroaRfCW/GtWo+rRcJJtHY3mMTRlq24afoJQ+oAyxSBuSvnmEAeq29sx7EMhPDHYa2C+DQfO7N6a8ifUXJq2i71XmnXVkoQExS8pthcUonZheQnpikY+EFTwu5ZvGDFe695P/9pH7T5zMAyuzaDMBpLkWYAeBX69Q214cmyc7bYvqe3xmEn83g0pep+UTH6mornJ3yqvDX7IlsENEip5FmekZxtro6uvSETrnN7O8Dfwfs09LBAfScQURSCen5L4r9bARpNcBrhcs658/9cUb5iqpAW3clQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78kJGGURgDJWbrTdA19Wi1v2kCUuJ9964uuoO6QgsIw=;
 b=l/FMO3W+lISL3b+rjNQZMM6X47C3ASt6hGmxbk8ouT5wN59xWLNlSqgHlUm1+5aLoaW2qFzVO2U3T63s6YF1YyAZXBikd/Gkc8jgjRRtW7/uwnRXJJGBJeOfq7wSEHVxapi9byWa8985kC+/kKLbaZpRCTD6rdC4dErCsAkvsuwQCD+dO4t+0o0plwjpRtYnacDnAAd6XBrYQBdY8JTkeBzbmnhr+v+0Uz0P0ykVnm5zWgLKoY+faLlMdX3PlLsA55MNpAeyVlOepDiZfQqKimyjc4iGC8qPJd8Lw9LbQNTN8xljOsydR226Tx2/J8y+Ksa+cakmAOwfPKmP4CdmyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78kJGGURgDJWbrTdA19Wi1v2kCUuJ9964uuoO6QgsIw=;
 b=Y057Yinq0jgHr/1fsWn3rh5bf0Q/gLQjwABXpDdIhHEQRKX8DytqNeHk5MMtn1mbVf1Khn1iUyyaDrxwDz2pmtq3YgRw6wd9se47SeDatxy6oHNKuSTdcEE5aYHZoQkS9sskcr1cbMzoq5akjAVIs8ED0yyDyJpNbSbjft5VyAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by AM0PR04MB6835.eurprd04.prod.outlook.com (2603:10a6:208:180::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 09:02:30 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::ef2d:51b6:463f:846]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::ef2d:51b6:463f:846%4]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 09:02:30 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	briannorris@chromium.org,
	kvalo@kernel.org,
	francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com,
	David Lin <yu-hao.lin@nxp.com>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH] wifi: mwifiex: fix uninitialized firmware_stat
Date: Wed, 20 Dec 2023 17:01:35 +0800
Message-Id: <20231220090135.1028991-1-yu-hao.lin@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0116.apcprd03.prod.outlook.com
 (2603:1096:4:91::20) To PA4PR04MB9638.eurprd04.prod.outlook.com
 (2603:10a6:102:273::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9638:EE_|AM0PR04MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 153ccd5e-7391-49d9-21a5-08dc013a657e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fsDhabPiDTKcG1H6IencTCQAcXU+qAuYWa1oQZip5FUUBumrniU0FtAvW+oEUurB/AQE0rmIz8W1qZxMX/12j70kgVauWseqLuBdX7l5Njx8lpAvXfP0oWEzv9dvD9sHeycbnvlc+uC61ZOkjJOmKNhpenGcJINw97IsbXND2GmJhdj7MvJ7aeLqzw5lJ1QQSPjzBXCoKeJOn2dRwNzo/1zJkEmvQJpZprJxP7urifMs+hD35NnEG5Frljx86/rS5JlDA4kyHb9Xe10N0z/Lya0C1Qv25Swd/u7NoWlIiuljEJazzRrRGU1GsbgE5vS3O7kDbeBPPxpzO9IPSdJ0E28MRWJ1y39ZfUkeHajYm5lLgndWCpQShFZwiDin6Nu6S6imGZZOclj7HBu+fc5KUS54/KXrOGisAz3sZRnmzUD9HiLOFKxRPgKPYdjyblOLGYokxnNcKCjl7OFSCAtfdaTcM0mXT5DSUtEtkUk8YXXFfTpi9UGX8CEaeIWm2gG6qpCyv06zMSZks4kUnwXcl97UNLije6oK9RFQVS0gOnZjIYvA9/axTgu3y717MADWh/UN3OwRRl04Lbr7vRegkUKqPRIjj4eMeOd5fgyRepw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39860400002)(376002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(41300700001)(54906003)(66476007)(66556008)(316002)(66946007)(6916009)(6486002)(966005)(478600001)(52116002)(6512007)(6506007)(36756003)(86362001)(38100700002)(38350700005)(5660300002)(8676002)(8936002)(4326008)(2906002)(1076003)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0xPECtAY1sT5ktav4kO7ET6ORUrsW56LkyEN/95IAzAGtrd+FL4m/QGxQj1T?=
 =?us-ascii?Q?Ie71dCjsHJoTf9yunRqH2AhfjlzFwc4UoOqpmstrTKF95D+YywBtpda0Iajj?=
 =?us-ascii?Q?DRsi2LdMmX2NgtY88VARc7diC527Ze6Cm0+0roSFYDFTOXUJTCUW+hSfxnTv?=
 =?us-ascii?Q?SpnbnK/ef/wTzrAn6rBOP3c8h3ISOTOfCZJ1JS96ArUn/q8U+qbCShTZFy/s?=
 =?us-ascii?Q?bwyFj0A+XQs4rcRvstb0KAZKuP0EuTsFbfU9y0+LarnMaZ9SVLjNSKmiO4Wb?=
 =?us-ascii?Q?SvHBjLGze/7VXC1j8lKN6MC8My8CKlbeLc8qqvQTDnKvNq8/9X9zTdsVZyLg?=
 =?us-ascii?Q?OaJyUZQlNtMyrnLf3E2SjAoo5cYcOgpnnGQ43AaWMaFSFOTsf3bZxX7/Vd3g?=
 =?us-ascii?Q?fUk5jW5NnMG+f/8YbGgDFqqv55dQiZVoZGJGQTRAZSfbId+uk9WPNUOBF/QG?=
 =?us-ascii?Q?adeSn3E/zlUzX462L2NNuWkr87RGjDsHjZQ4oVnCNBdvAeZIuJYX+kOMBrEq?=
 =?us-ascii?Q?v8VnpaFX1J7F3XVLX3H95VlWW21E4/M/6wPT4FKz/qH7xSLlVaa8SbQFBqq+?=
 =?us-ascii?Q?2xSqGPX9q4FtAvUk2cT+6rYGIpSreQR2f1QYpnlwYMzSe12TjgbmKjN4d+F0?=
 =?us-ascii?Q?ifGN4KhRRhOsm4iMB7luoH7Jr4ujN3d6DPpeNbCCMyg9H0WwcHzC6jEtDtvK?=
 =?us-ascii?Q?lXG5YIFgH2M7WvY3hnjYZMD9OYYZETjdvRly3+yQ0f3PUJohf7AJhv8w2xlo?=
 =?us-ascii?Q?8zKdpx5zQBSbokwt6TBrXBGdUbCWvsY+LdsRpx5CU247enJYxBaaZ49dRAZ/?=
 =?us-ascii?Q?5m13MgALslhaQiLd3dMZhYoLuf4e9ZblUKCOf5pspdoUNdX5IBjPgxNnTElg?=
 =?us-ascii?Q?+5Ap8uMGTAyO6gQcmr7EmBJyIojCtS/1ah/gcDeKNrwowiZS5qJT9QvKWijw?=
 =?us-ascii?Q?nabT4pKnYu3JABuws3iu9s0vmBqt8paspYicp8hSscGPi9bNShk0DbjY7Aix?=
 =?us-ascii?Q?oI5OEIuK/TCkSIWiIPkVGet11J+dWOiVegyXsEXj1NKJ+ij5efSJfUNFSzTn?=
 =?us-ascii?Q?UnLRWA31b0Ts7eIuTwXFiayug0eQUZC/OTSzO4i4lVhVH2GjDMCBiyP6ehM7?=
 =?us-ascii?Q?3EJAIfiZltpVdghJi0cUM2axu18XffpL86ufAZSVYFt2rueOHKTXotlwY1yd?=
 =?us-ascii?Q?fOmw1BxzcjSy/opD37NfXlRAGtLwc4+zwQEOudRaK39yUawlRWRyDoOBrIeX?=
 =?us-ascii?Q?as8e4tGn9FnBuGNX8D6ge3rgEHMlmvRF2RoECiFjipn2l0GTl3i6wYKAEZ5v?=
 =?us-ascii?Q?F+RzUeXuXWqjrUQXsYq+68GfQqouDByQ7Pz6j34RVTpRvkGXjM1EidTB2IdJ?=
 =?us-ascii?Q?w8lwu4j6aBQvui8RSevvi/xqj+QTMepNiWdW3DpVxkTku0FZW4nuUQ3N00qG?=
 =?us-ascii?Q?Kyjz/ktJZeefbBnWjbjWvGMCOBD/6ENZTuVjvcy5/s/j1QnDZdpJhiNDQnJx?=
 =?us-ascii?Q?ZEoPPFPZWGLO0DbE01yyJdvmuALP+uXREJ0Hn4icT4zw6vsFB8QH9k9ajAEd?=
 =?us-ascii?Q?2MmkKtDG0uGaMBCnMdVhpUuhYgXH1NSvB54kt4gp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153ccd5e-7391-49d9-21a5-08dc013a657e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 09:02:30.7083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6RUHqq0hoV35jIVUwJpGERcjyqeLVmKojmzWm2Eu6dlnl5rq1/C5B6LT/y4mVJmVvthYQSyHFg9Tqmriii2cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6835

Variable firmware_stat is possilbe to be used without initialization.

Signed-off-by: David Lin <yu-hao.lin@nxp.com>
Fixes: 1c5d463c0770 ("wifi: mwifiex: add extra delay for firmware ready")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202312192236.ZflaWYCw-lkp@intel.com/
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index ef3e68d1059c..75f53c2f1e1f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -779,7 +779,7 @@ static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
 {
 	struct sdio_mmc_card *card = adapter->card;
 	int ret = 0;
-	u16 firmware_stat;
+	u16 firmware_stat = 0;
 	u32 tries;
 
 	for (tries = 0; tries < poll_num; tries++) {

base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
prerequisite-patch-id: ee10b03f813ab1e72d05c59aef4e07a26afdf678
-- 
2.25.1


