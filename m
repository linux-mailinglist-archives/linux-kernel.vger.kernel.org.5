Return-Path: <linux-kernel+bounces-16944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D924824657
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D654E1F22E7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D93B286BF;
	Thu,  4 Jan 2024 16:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="GKJP9GJg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2060.outbound.protection.outlook.com [40.92.23.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF6E24B5C;
	Thu,  4 Jan 2024 16:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Atl+IBk7PgEBIXzHdxFheehYbrC2hf0CaR0dJ5W+xKtbruphbA/A70H+GiAvd/D7ceelyRcBzjeItzyS+GJhkxDDNU1Zt3zkqsSG26Pyx6yjETgqIvc9vKG/2j65S3qWbNtKwOzmXYDMF+9qHG1alnsK+blHJ/Q/0AlGOsd3NHDv6cqOjac2WwdgbK0U8n4enn7LfIAEexbE6nrq+tqR/90NBL2OJG3qjgRtvYNvHXbecTZEqbyTM5ZTaDtY2wJGVRukXKx5kS6Yy3tL6x+jqJL6ru0fIQB+NFDPdfGM464Ep4K8frgMF4fH0xSdxIHNXhtx0rKgqjwbX4kTPi6/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=m6tcqHbKmxnw3vqsQVXwAf10zluMKPwz/BFsQ9lDio8TMzoIcm63pEgegqzLLhpEe6IfCcX07Y2LFvmcqkmyv4UQ7RoLz5XlMfp1JO/+od3R8EOH8T6qoxdjYom89nRGpJ/dqXaN73awFKT1qCU8j6sZ8CDk2ykm3KHyR0ejhc3uP0t5mzJtTgfDyJgE6vPlmnYq3/OU62EbMaZlb7tvO2rBT2QNwphJIDsWbgyI1566EbGe6I0zd856x+svkiVAXcdiVy0aF+tUxPNH/sY+PAPMg1WLQQSeA/zhD+WoxAhOubuiStys9y89apQ26KQyMFPM/nvAC11a5GNQD9cBeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGPPzyxW99d6Lw7ezMhtXHhJX44cjofP8jGdKVcHmig=;
 b=GKJP9GJgETBsp73KphCt8/hQS3m9gAG3M20QmiTudbIdzSvknIKeORQEihCcmPKIFpFkr75nh3HaLef3z9LOft+V6q4JBBXkW2iHuKdxzFOhLGoqyh+SMGiW5aN68YDjNt2eGXLN5Lt/92JmsxrScqEKwg12wr+HYNLI/jFcKAlSAy7VSqsBBhWTmt3L+7qFnXAMDdbnEphvXdOtcJmB2Jvd2wIlrla3vYRN7hvZgymaMyHa9L48bVDeWqw3kzW6ndlFT6Dytwt5Ey4OBGlTpBKUJRBMoEkfFnnyNvx2AqPAaOWlfxpsKysZZLq59kueO2xk6Mh3zhWo9T72xMC4Tw==
Received: from PH7PR03MB7064.namprd03.prod.outlook.com (2603:10b6:510:2a5::8)
 by CO1PR03MB5906.namprd03.prod.outlook.com (2603:10b6:303:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 16:36:58 +0000
Received: from PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8]) by PH7PR03MB7064.namprd03.prod.outlook.com
 ([fe80::9ca4:4c22:a89:9a8%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 16:36:58 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 2/5] ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
Date: Thu,  4 Jan 2024 11:36:38 -0500
Message-ID:
 <PH7PR03MB7064B38BDED195B1E6239AACA0672@PH7PR03MB7064.namprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240104163641.15893-1-lnimi@hotmail.com>
References: <20240104163641.15893-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [feSnRVPsTNFnmU0A0FJNRnMJIU3CnqXIkLB9qezCpZ4=]
X-ClientProxiedBy: YQZPR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:84::7) To PH7PR03MB7064.namprd03.prod.outlook.com
 (2603:10b6:510:2a5::8)
X-Microsoft-Original-Message-ID: <20240104163641.15893-2-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7064:EE_|CO1PR03MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: bdebb9fa-cc91-4795-9a3c-08dc0d435e6a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wawvOxvP/eR8VV2gGLFaj28pLcMPn051qWNSefaP0RNT9iws/+/gBibVMjptao+xqai2DIxcItDciBWWiJsv28Mp5c7iNbaRjy34j6n6AO/fOFwk1b3QpQbe+sBfz1K2OUqtuk1LDcMfSdAG9SsBEuJTLD3bgfF0P2pF29cNw5m9ouL+A4q9Pqp7yR0YE+t5Q1LlA9EJgUDcSkPOEif91ULIwVoprb6Aidirwm67/OaoSfuBMdndG2hofwnnfSz9ovR/VeUWoAML1Wpc+DPfgA1KXF4nNtcqOFG9qPm1JCsN/snFDCLSYUk6kt+sP6fRPB2XPMm6kB6yAGBFX/0ROq3fnMfzjNGG0+z8cQfOAPtfFlcceTlEcK7i6sHTzuha1Ur28sIW/c4uDTW17whjqr/rrc5CQwGJHkxTa/cpWg5yiKUuM07qazQBZihNeVDR6HH7jNM5MkDo6NQlalUScbLBHN+WIXwxDUupo2pxzbsGtZ2+r9yrK04/v8hM37bRaKWoATxhLB1Fd8T5lI7CfnUzFRiqXfMCSkBc/WsAiuQqRKq2HoFhM1WkUwUMG3mK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dSb7pfBpMsMnBsdyiWn30TMgQqiwp4rTqfi1oMo1wql8tUMmf2juN3ydlpl1?=
 =?us-ascii?Q?a9nfuOoHtPTEGcAOE1OIufmGIBKQusYO56vg+CPQ4AN4OWPrfZazcdKr20SP?=
 =?us-ascii?Q?YTkcIFNS2E24uXFjRv1FDQjo3sWNBZ2fXs4MEVux2fFXluuKUCSLHHJ0ZEnx?=
 =?us-ascii?Q?7+ZKl8gLTo2pMnwFtlRFHbJzRSTiX7DZF0SD56RU/5OyIzJckzlZkK72QTiO?=
 =?us-ascii?Q?8e3qagLBpfhGKiNph1Sg6y+b2p850fYtJwd/QFxWvrHnlHVJlcpfLQ6eNRyg?=
 =?us-ascii?Q?ID8Dk7zrWx814Jb1o/3LM75GdjI/oeZPYs/Qr+UsZPrKIy7D9WHS1fnrURRC?=
 =?us-ascii?Q?0SCiqdqa9utXkMmUhCz2M0NJOPn05PPLDDPZkGvtXey83Li7GV7Z/lBA5k0b?=
 =?us-ascii?Q?Bh+SE3fAGa6fgjOB8JFtgJ77neWo6Ew6Cl26uO7u5OGetSO3KJUTCgvOSczV?=
 =?us-ascii?Q?dHQLNjlx1dVat3dmRbzsSA28CyC0v2Zn4Y1HMBRYvCDFeXA2qvM0NDr4BfF9?=
 =?us-ascii?Q?lf5zp1s6HiEEakDB81uR4C/SSfPcbTWEuNTXmj520/fuJVPHnNLkVjXx1hls?=
 =?us-ascii?Q?fIVXZbWrRzKdlY67BqhfA3gAMvN4eEhwugJSgvzzSR0wwDImf0E3C2y9Se0Z?=
 =?us-ascii?Q?bqu4+e9s56GbZ9KfrOp23tRsO8A28LGZVyjcgvx8Jpq9efbCgyPzslFYmF74?=
 =?us-ascii?Q?nGLQkzZJrbbKPVytpIdfawUNIeSPLANRUC/e2PJi5TIyY4oSlGqGdh/AZJbb?=
 =?us-ascii?Q?PjU0BX/BCm8ikyfhAK111u80GgD/MlLiQ2eOygT+n3DLefIIEhvVhiPhmpiJ?=
 =?us-ascii?Q?FpPr4RQeBfPl2rmzkIUJ4blylyOJ1HghN5CF58a8iqjpMAAiEdt7qUVdgUme?=
 =?us-ascii?Q?+1hfIIFq6lopqv6a3h5NoQ3qaDkiynOKwS7RqjPCPcE50AC5LdV+BV6l1oxA?=
 =?us-ascii?Q?FrkY8KHe9lpv8lm1KX/0Ou8A4CmlPFjsMYEKYd1MaKi5X6gRLhBc9HBB0jW/?=
 =?us-ascii?Q?R1chOFFvu4rn8SbhCnzr4Qa+q4OmidMLLHHqpCiq09b0t1SBaALWQoN3+tj2?=
 =?us-ascii?Q?rGcXHXL4iBRtVgOkKMvVrwz95JX5Li/taiNSCGtnSOdWybKfBuoIrK8XYoJQ?=
 =?us-ascii?Q?0l8PwPRembQLJYWtOVYe+11TvXk2eKbGNYoOCuhO9LAgIQj18EGEMCA2JznZ?=
 =?us-ascii?Q?WpdC03OF2UthDNo1KxuilwtRPUqP9Bk2oyB8qQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-839f4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: bdebb9fa-cc91-4795-9a3c-08dc0d435e6a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7064.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 16:36:58.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5906

From: Min Li <min.li.xe@renesas.com>

In order for phase pull-in to work, write phase timer shall be 0
when not in write phase mode. Also Fix u8 -> u16, DPLL_WF_TIMER
and DPLL_WP_TIMER are 2-byte registers

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index f8556627befa..d069b6e451ef 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1396,6 +1396,20 @@ static int idtcm_set_pll_mode(struct idtcm_channel *channel,
 	struct idtcm *idtcm = channel->idtcm;
 	int err;
 	u8 dpll_mode;
+	u8 buf[2] = {0};
+
+	/* Setup WF/WP timer for phase pull-in to work correctly */
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WF_TIMER,
+			  buf, sizeof(buf));
+	if (err)
+		return err;
+
+	if (mode == PLL_MODE_WRITE_PHASE)
+		buf[0] = 160;
+	err = idtcm_write(idtcm, channel->dpll_n, DPLL_WP_TIMER,
+			  buf, sizeof(buf));
+	if (err)
+		return err;
 
 	err = idtcm_read(idtcm, channel->dpll_n,
 			 IDTCM_FW_REG(idtcm->fw_ver, V520, DPLL_MODE),
-- 
2.39.2


