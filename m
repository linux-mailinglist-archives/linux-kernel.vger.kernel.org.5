Return-Path: <linux-kernel+bounces-6834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DF5819E42
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A21141F21693
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96199219F0;
	Wed, 20 Dec 2023 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ITq2s04I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA02137C;
	Wed, 20 Dec 2023 11:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw9x+//+UwCnet1eRwXlq27PIKdgHyaPmcEUtJTbQssg9zWUxeRCuI1BClgM8dCmBcMNjeyi5rzIG7+Dj9iW1sHG32WxRPymS4zxAmAhv1UeRpVKO3vq1eKaUwA+wak46LhbOLWSa5Nxkari1d2XN9QXDRXUn1DKHfv0LoAG6T8y4eeFYxSz0fog6CydBzEMlM4Llhr0VnRLRnjezeMltZkGV+4yJ9IFplLWLDxwXuhPu5aSnc3xBPwvRAT6Yvksm0K1HA/jbgE8zc2e/Y7gynCYbxXLwiEHUJU7+3O30WFxDaZ3t8rfh5LgmUYSptK6sftfKcybAC9MK0kLstRdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5aWSz2We8CVnEwAds0U9W1er5zbjZNFJbv0x4kmGv0c=;
 b=M+WoYcvdbFYoajGkYcl+g6fLNmj7CSIixU88qRDJByjjfddKs3i8NendpwaEQtSBAjlmuoMDhPXIPT+TV3wRCWvSkdKvTYVSw7+gbDLNxpe9FpdRpFVaXrGZfIhz7vsdLFCXp3ZjqePIZS2wl3VaKSrMV6PH0DEYlBEITrusaeEgdeTvu+UO4eBsEvMs++kX7ubNMbSgB665NDFGcVFKZPIBINYmtJINTjiG4FMaOKu3tCcClu/sGE5Zgs87U/qA7JsZMEvpiXyKxlUFWhiOUau/kC85Za/+rTG4PiBG5wNJ9heLlHaiAoi/zmiuYM19va1lTwF2PuKdMQX60k4tUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5aWSz2We8CVnEwAds0U9W1er5zbjZNFJbv0x4kmGv0c=;
 b=ITq2s04IXhGRLLixKcWOlkG/pAEpwB18AxxXmmsZGgvW6bckUfDNVmjeTCmYb/exo4b2hVzPj1PCn4uzEkiuLj+BpTEtzLtQm7SvnhnLEkvuwVmeWFcNICNSUA+2v/DEXelrodfY0+4PTOdGRl91nN5zNW+DTwa+uW7myB11EMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB6PR04MB3190.eurprd04.prod.outlook.com (2603:10a6:6:5::31) by
 PAXPR04MB9470.eurprd04.prod.outlook.com (2603:10a6:102:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Wed, 20 Dec
 2023 11:39:27 +0000
Received: from DB6PR04MB3190.eurprd04.prod.outlook.com
 ([fe80::bc7b:3b03:445:9827]) by DB6PR04MB3190.eurprd04.prod.outlook.com
 ([fe80::bc7b:3b03:445:9827%7]) with mapi id 15.20.7091.034; Wed, 20 Dec 2023
 11:39:27 +0000
From: Kshitiz Varshney <kshitiz.varshney@nxp.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Varun Sethi <V.Sethi@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Sahil Malhotra <sahil.malhotra@nxp.com>,
	Vabhav Sharma <vabhav.sharma@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Rahul Kumar Yadav <rahulkumar.yadav@nxp.com>,
	Nikhil Singla <nikhil.singla@nxp.com>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kshitiz Varshney <kshitiz.varshney@nxp.com>
Subject: [PATCH v1] imx_v6_v7_defconfig: Enable sm3, sm4, polyval, xctr cipher test support
Date: Wed, 20 Dec 2023 12:38:57 +0100
Message-Id: <20231220113857.1127598-1-kshitiz.varshney@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:208:69::32) To DB6PR04MB3190.eurprd04.prod.outlook.com
 (2603:10a6:6:5::31)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR04MB3190:EE_|PAXPR04MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 23606984-f143-4805-2b17-08dc0150524a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ax2SpJE+TJmrA9qM6rE8aAOMYbJGBnaIJrl4InkZP2l0q1jwjtjq9yarzRWEdNsqH0OgANb30OZ3sPq94yK7oMLQjmM4wQfdbxtfvts+RazK08vm1N56MrC63pZeQ65hnH7qgE6OLJ3noDXScFqTQWpTVWi6g5F9cIIinZE1XXpheSqCCSNCkrRkEFqVZHJe6UBhUCAFZ/KEp82B8zn08onCR7VwswyTONe63l1nPANZ0lPSurHNbgk78pTrB9uFGhdSveUMgeS1X85IJHZQysTwQYzOhmYvoOGG8kt94v0iYFzJp66mVl28lgf/o9gVBQJuepGd+jRlyRTq58prP+ckEL1N6ibgqs+O4Dy13WZAJF2eKp62XTaKuEAZRXL79Xu3l4uYLUKR5XTpNf7UkHtTgd40asrzN9lDFRp7/VwrqIg/dOYkPsk6smsqjuw5q9XhA/e/CEK1D/kg5Rnh1vkO0DaCxukaQ63RyjfDgv2WDT/EckrvSu8o9kEXS+4J6PWmM2q4+t3ISHv0co6jpcdbNUxCtfDIvlJOOXZdvAVvRllgE40nTfC8th0+YpayeUStjBsy+ivZnIYCJsQFLLEsvPoMvLc3HeznpmkwZV5hZ21LIg3CWDDxSbS6MVb0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR04MB3190.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(6486002)(478600001)(5660300002)(6506007)(52116002)(921008)(38350700005)(2616005)(1076003)(36756003)(6512007)(26005)(86362001)(2906002)(6666004)(44832011)(66946007)(8676002)(4326008)(110136005)(66556008)(41300700001)(66476007)(8936002)(316002)(6636002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K2cCu9b/q0fOiTTXL+WAnwgINRSVdsQ6yW1DtKXjpCHzx4ONxFLGzHuhbHxw?=
 =?us-ascii?Q?r0/UGZxZqp144yPifFL/4rnuUxJDl/3KxNBcmwN8YfrB75GPnoMpzsvvYwVL?=
 =?us-ascii?Q?yyqRHkUNmSwJ6opIivYHv/SiBNkEX4kK0IzQgy2qYm7CMa8P5TyMaImtsI11?=
 =?us-ascii?Q?3opl+h1xqbTXhNm6bEeiYnWV7kpzI4oliBbR9Ev17bL0esWDLSrkNdwiDtfe?=
 =?us-ascii?Q?jOhcJQ4bfx3adINlbQOL3ihggSkQ9fCbujk/Xh4A+0EqNA0onFjLg8l7meOo?=
 =?us-ascii?Q?yA1QYchsVUQ9CDuHbGBU/PsQ9ti2Js+fMESjxEA3+HyvW87GyPM2qqq4p9AB?=
 =?us-ascii?Q?3HvLFGyM3L7j27E4QRVQ5VZuBAKMrAgz+SwDW6edQKq9i4QoCewk6Gl75c+C?=
 =?us-ascii?Q?R0CzNn3cBwwjCLcYP1hC7jAY6eK7FbOKtZQ5Nxi2HV+AXjG3FHdVQuDlcOP6?=
 =?us-ascii?Q?nHHRZv0B4syjJHH9n2xowGBHphAe7gtO93cr2U21tUTSs0Hp3jqLfrxHu3N4?=
 =?us-ascii?Q?zcY0B/BjpKGkSJ77Jy+iiCSdTfYQx5cCMrLk78b9q64GzTMCPi9R3w3LzxjM?=
 =?us-ascii?Q?donHuP/ti/rQZQo9xSVv7zKPN2es/iCs+XZ89KFmKqRbNQ8SIK11O5I20fvy?=
 =?us-ascii?Q?BqUlqd5GSE2JF47CRM/8Yq9MUT3b32TpzJlzaQ88HwMfooV4rc7/SL1CBbzc?=
 =?us-ascii?Q?cKWBMB4RYy77n/tfx5Gh8SX7DiTIdycPOFLNSPxbTdycAW36FpssKBzdBYdu?=
 =?us-ascii?Q?uXRf2sdvM/tBrSbj72EvQqQEv9WztFPmMQXDymRn6Bl+LkoTd1Yu7+ctwPdZ?=
 =?us-ascii?Q?hcrPFpkUhF8ThVdS6JMVTK9eHLn3Bf2YMz5FNsA/5CDMTmMY1guN6X4unn+d?=
 =?us-ascii?Q?bMEi8lS7qqa4z9PLJwKiKVwz0hbcOHMlDDHn7MoMdWrNXsy5IvoIV1K7y8IT?=
 =?us-ascii?Q?7jA9zI7UmscFU6sAEYKwQ1x7BO0aUMSpXC3FIrBh+J79tjNM3Dk00+Us48NJ?=
 =?us-ascii?Q?I0eg0OUF6FPU3F75qhS2Bmr9ejnQXh9IsP7KVVWJwraKF/sYTZwTCKhwX6Sk?=
 =?us-ascii?Q?y/S8jh6VdC7XUqKhiL2lqJozpxmwToLhu56N0rFzmMVpjrqJoWmBytUsU+rO?=
 =?us-ascii?Q?dS9fttGiHzHBTqeeie8yEzKZs9nnEi6Rv6zXSxUInlUO8tsiorzdH8xRMjgo?=
 =?us-ascii?Q?kzGMHwcUzg53kFh/R+KyrLRds3Wop2COhhVsiEs39uApllbzGSrX/D+6xw3S?=
 =?us-ascii?Q?c25cyePxwp9/KtXIFfv+Qbpmkxor97RmJFFl/NTmj5AMr5CHSYOSKu2Jwdln?=
 =?us-ascii?Q?vZaZNzsMeJNx2CQiJm3oPBC/cIac8pCljBpkjox9yV/H4UuaLmDfJnlRCPPd?=
 =?us-ascii?Q?Vs84FD2TcjrlkNzm97K/bSxuMCspV52wiUByqXIA0hsrp7OKP9ffb8aAfG38?=
 =?us-ascii?Q?eLLOl8sGUsRCXAlbbnuS5PRhiecnWi+RKetwIjGCk0p7iIsq7cWMLOal4zmy?=
 =?us-ascii?Q?R67JjKaE8XYPRBE7RENfqxk/NDISBn6gLTexK8PGcj3wATMPwY5bQ/PhwBl4?=
 =?us-ascii?Q?yeKk06X5g85GUIEHuOHEywHCqYd0DoCoXq/uqifs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23606984-f143-4805-2b17-08dc0150524a
X-MS-Exchange-CrossTenant-AuthSource: DB6PR04MB3190.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 11:39:27.1275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OrxfZxr1KLrAXs9sY1Zqj4Js9cFMXXRkULqFtDd42zVzwa8HpnC25laDd2MiiXYWDHuBei8BAvFVMENHBwrD0W0pZ0akmdnCxS0xVJzOgjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9470

    Enable config for sm3, sm4, polyval, xctr cipher test as built in module.

    Issue:-
    Multiple crypto tests like sm3, sm4 xctr and polyval failing.

    skcipher: failed to allocate transform for xctr(aes): -2
    alg: self-tests for xctr(aes) using xctr(aes) failed (rc=-2)
    alg: self-tests for sm3 using sm3 failed (rc=-2)
    tcrypt: failed to load transform for sm3: -2
    alg: hash: failed to allocate transform for polyval: -2
    alg: self-tests for polyval using polyval failed (rc=-2)

    Resolution:-
    Enabling CONFIG_CRYPTO_SM3_GENERIC, CONFIG_CRYPTO_SM4_GENERIC,
    CONFIG_CRYPTO_HCTR2, CONFIG_CRYPTO_ARIA as module enables support of
    sm3, sm4, aria, polyval & xctr.

    Signed-off-by: Kshitiz Varshney <kshitiz.varshney@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0a90583f9f01..627f57da9d5b 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -484,3 +484,7 @@ CONFIG_DEBUG_FS=y
 # CONFIG_SLUB_DEBUG is not set
 # CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
+CONFIG_CRYPTO_HCTR2=m
+CONFIG_CRYPTO_SM3_GENERIC=m
+CONFIG_CRYPTO_SM4_GENERIC=m
+CONFIG_CRYPTO_ARIA=m
-- 
2.25.1


