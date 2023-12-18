Return-Path: <linux-kernel+bounces-3838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220438173A7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25CA1C242D7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD03A1CF;
	Mon, 18 Dec 2023 14:33:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2084.outbound.protection.outlook.com [40.107.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCD101DB;
	Mon, 18 Dec 2023 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Juo+ipXeTkPzuf3tAZTST02YjHGk0ystHshWHdpk36I5j27CqZb1EOoCO80FWSqBFETdWyAuEMo8qsSQxnkb1Lf2Ephqz4f8AZkgwRryS6grDqPViwlE0FGvHAMEh8atzJf2ZqKs6X1d6wzERpqKCSO+NiblJVH6t7H3iDdO4fI5OT/1JWCcx+HLBNPG/xHjkgqdFjnL0r3o5iVbPSM2hiukDOSefPTcqr1qg7h3GVXPkV0AVihMxCVcLKGhCNSZaNB7q0VOb21rPYOO6ECfmEEy4O2houqTU0n5p5Q6nO2Jgu7ku7AniCGYLP3+MM/6qdqyhAnpwv6JoNmWLaMG3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+E/Aey8vd15TcFxr1WH508X5siJsiqwVgaVbtSVA9iw=;
 b=NSk5lmZJZpEbdcrFKu8Th3EI7RMOJaOhDKn03j/YpOklqTbl+DB3lDNpFxcIKkM+pHIztRh+FoztzwL8ML1+PH2fwMMaKLzTwL0+5e56pLQu1D+IDdbjZi2nkMtvvni5o5BSyfe3Epw9+Qv3giEAP2hRL8ZZjQI7CAk5+7j55JsAca+UD+AecH994+CG0ClafPjnveL7qDYoY5Tl3luxZ3ehfbM0OIU7/Pm9Ozx0cbuV2WuPAwEbjV8Kq1NRs7PBkuCY8Y8PocsclWf9ujCByVgssm6nUiScY9Ma2+8AxxCn7kRNWniX600+IHOCEzAyMgjW9FAx0iVAXcy+RmeC2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b01:b::15)
 by PN3PR01MB7368.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:8e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 14:33:24 +0000
Received: from BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e1e5:c8df:a8b:91a3]) by BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::e1e5:c8df:a8b:91a3%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 14:33:23 +0000
From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
To: perex@perex.cz,
	tiwai@suse.com
Cc: himanshu.bhavani@siliconsignals.io,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Marian Postevca <posteuca@mutex.one>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: acp: Remove redundant ret variable
Date: Mon, 18 Dec 2023 20:02:08 +0530
Message-Id: <20231218143214.939885-1-himanshu.bhavani@siliconsignals.io>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0020.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::23) To BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b01:b::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BM1PR01MB4899:EE_|PN3PR01MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: f31daac9-8186-47ea-6276-08dbffd649bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EPrpUh9JtHlYRT6+diwdfMBo6RlOAIwZX9EfLV0MC7dl+qJYutw6tOQMbZ8NWShAWe6xTZn2V7Fz72XNF9WTR0koa3Sod8+4DD4M3cptUEcvpQ+ATsl6h6sUxOlEDZfRGHHnqi9jGdQoM8vJvU6/4Z4z2dnHUyE/MeDjscfaYjhfOrEqGQpGCoh3yuBQ1fb1JuItbr3Xn/IPu08K7Ct/dq89TRnm64Cg1SiUT2+uiilJxJJcdiC8QbpsmqUWMI/OL4B5yL5s2fijBOPkWIzdFxClA1u/TG9zx9qHEnxL/KOLEa/YXuoVm9yQ3APBMztOc69136zLNSTkHTw42whWt8b1U6S7/u7DgrQGrbIWMkx7yRyYB49qEr/ylukBw3HqS1aB+Gi2Jn1AOwZvdDNZK3CkQWu8wySqFHNubqMu9kPzDCWs+Mhzu55PY1GZXl9ofY9Iw7UpwFKAEPMYLhGfRtyU7S1ntkx33djivLzHfMNVQyTyL5jFeOD+xwFzQ3NVCjREAoSquJ/HT02QcQqbdVUeIdLMWjTZ+mDcDTTdTR+9eIqfViDc3f5LilbbUHl1Gy0bzaH+JADveTyj9t5xwC4kakoS7bEUo17NDSMQ3hYwz5hjjovbONfEql3ctGg8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39830400003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(66476007)(66556008)(38100700002)(36756003)(86362001)(66946007)(1076003)(26005)(2616005)(6512007)(6506007)(52116002)(2906002)(316002)(6666004)(8676002)(8936002)(54906003)(478600001)(6486002)(44832011)(4326008)(4744005)(41300700001)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sp5VNnNY1XP+R32jIco4icAGfkyXUsVWPj39bArasd7sMFkBHMo1bmvq0WSq?=
 =?us-ascii?Q?pEeKd7DwqGYhsMuUpgV//g/bFOpNFmSy7aJwNsMBbyoMudtFALF9QBFJTC8x?=
 =?us-ascii?Q?Kyj8xUrizkjvmDu51y3wjOCPpq6z29X+8vLQxVkcHjBzUuZncL6RYQQkqttk?=
 =?us-ascii?Q?+kJJ1M89equYCKnLAwIEVzDwq8aV6y/PveHP75PkoX4peqWn7y00HoObsUEq?=
 =?us-ascii?Q?Y2IgIWcbHIeLCqXaGVteKePTDEcdXUoEeoTT0SyPdVSKURfGXVYYxpI8n/JG?=
 =?us-ascii?Q?uVUvjDnPpSPAlgHgYMtFtQEYe8WYKOicl7Ema07r5TxrNsovdm7Q9iZZBzK8?=
 =?us-ascii?Q?RtefXegqaZ20MPugf8WWyIs6bMW9pDFjtKHVaDU8ShEunRmilBkv9KDGO0jH?=
 =?us-ascii?Q?7cbT1FXPlFEQLHzAoEmKgaykYM1TO5ch1COQiLFc9qIDXSa2Ffd36BFuTnUL?=
 =?us-ascii?Q?RJn6JKtMV1sTs6cHbFxwywYMS1Pkd31eSKZetv0Qfrnykit9g/gKT57R+in4?=
 =?us-ascii?Q?wMM/VcSwXWzeldvM70hBidAT1d131hB+DqaxwR/YXjAjdeHOH4yRt8WtncKO?=
 =?us-ascii?Q?HhPKVz7aV6+++1QzFUL2GYENNmLxS3QsbHCu4zv0k8QjATe9mEpx2FScZULs?=
 =?us-ascii?Q?0nNNB69T67daNGc95Uq67T1Lg+gBORq25dajT2gRPWQxsD7arLU1cCsB/nTb?=
 =?us-ascii?Q?1BOmxtp40nvzCpp3FJ7QjTViSjETZEA76HXGsZ6TR5HVP34Neu2YIvrSXpn5?=
 =?us-ascii?Q?7yINPTiqEoaMztc8IYDcyD1ioLRDupYg02NmFNZMfBHbxK+8aulgLIQwU9wd?=
 =?us-ascii?Q?fBbmAv8Fwz3njEE9eqw4V7lUjLv8Wd1lEk1/rF958Sksybd3dVwobYLTZwKK?=
 =?us-ascii?Q?9RYdgynHo6zjtWdBeb3QVO8F+0+khnf+E9trttA+3NhroWpVTH5okiCQ0DcU?=
 =?us-ascii?Q?/Z/oQEIChUt2zhy1VO5DR6lVEC31Uxzb0f2oi2yUXk4yqHP1r/2A68l8NfGE?=
 =?us-ascii?Q?NUFinHE6wZU5r7CZzCrBSawHjfFttUaGn53QrXwo8WIaNyDyAQNIoIZ0LWVm?=
 =?us-ascii?Q?R5Zz3iMuJ/u7w0yD1wRLPZQ4mlGzU4Ny8TxpCEzR9khTVfNr1sI4N8lgFATh?=
 =?us-ascii?Q?m4QxGguZlTiCpya3Z0sxFlENDemZv3rfjiDsqmdOFbzsFQ4V0BR211g5UlQr?=
 =?us-ascii?Q?xEcrfQr6nVKmaYy4quMCF/jEQGZ/KnF6wXx/INy9wBjFwySF4Wd1sL+zr89d?=
 =?us-ascii?Q?XL0MoDuMcna3qx0hSN3kBdUjp3f1ygNFpcUKsWUMQbIyUpn0HtuOsNhMSV12?=
 =?us-ascii?Q?XgyPAX4jKx2Pioc4sJk5+oEt1bMNSoUayrE3Y/hOz2aY0jVfiHltSDr0Z2Kg?=
 =?us-ascii?Q?bj4OHbMdeg2YqUq8fBZdGQRfUAnJqXiecBY5+Wkdbz84+2xdYGwElc4hpguY?=
 =?us-ascii?Q?NnGLMGfmXgWXDm8igRH8ufSieSl/tqu3hl0UuOQeGkiRH9Xj7dM6+7d1Wbgz?=
 =?us-ascii?Q?ptyNMiAG+CSLeK1P/H4eEYBrlqMI5Apm9x/OwoazK4KXnqlFcoMiUYNZtw8H?=
 =?us-ascii?Q?z1BJESEB79DbVPLUzbcWRcMkdL6ePujG8o3JpOhl42GamXtELWHdnuYieYhs?=
 =?us-ascii?Q?Fg6pyoWnfdLOdz5MlYnAQFc=3D?=
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-Network-Message-Id: f31daac9-8186-47ea-6276-08dbffd649bc
X-MS-Exchange-CrossTenant-AuthSource: BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 14:33:23.8814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0btiTbW+n3mwHigvi3O3nXnaS7xW6a0AjJA9hi3DRn5dGIX8FfmR13TSfhmLxccCo2BEVr/chKUCKhoI4v19RfLTNNLUWG8meN76JDNpm5MS/Sb6gTl4gTyuKbGi/Dt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7368

Removed Unneeded variable: "ret"

Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>

diff --git a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
index 6cd3352dc38d..f85b85ea4be9 100644
--- a/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
+++ b/sound/soc/amd/acp/acp3x-es83xx/acp3x-es83xx.c
@@ -222,7 +222,6 @@ static int acp3x_es83xx_resume_post(struct snd_soc_card *card)
 
 static int acp3x_es83xx_configure_gpios(struct acp3x_es83xx_private *priv)
 {
-	int ret = 0;
 
 	priv->enable_spk_gpio.crs_entry_index = 0;
 	priv->enable_hp_gpio.crs_entry_index = 1;
@@ -245,7 +244,7 @@ static int acp3x_es83xx_configure_gpios(struct acp3x_es83xx_private *priv)
 		 priv->enable_spk_gpio.active_low ? "low" : "high",
 		 priv->enable_hp_gpio.crs_entry_index,
 		 priv->enable_hp_gpio.active_low ? "low" : "high");
-	return ret;
+	return 0;
 }
 
 static int acp3x_es83xx_configure_mics(struct acp3x_es83xx_private *priv)
-- 
2.25.1


