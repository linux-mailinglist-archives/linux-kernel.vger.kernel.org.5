Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3585B7A8885
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjITPgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbjITPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:36:51 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD38A3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:36:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BO5afJrjc2f/m8JlI8GgnGR8dYRBOeESFHG2xH/NHfdogB+RIQmZcKEnZcDythTI+cj0rVeAWmVnv6iNuNhmen1rzyVWJFhrNM4TBCAajgw/GUb3Sz3VgPbEVwBi7pFp0i/gWPFpQqb8ae0mScaANvD50unI3IT6qcGwrlzLW6UFzpFKjkNntVTQdtQif4gC+CoUl5hWgFkkRdl6jFv4kDuxzkD863gUCXetkeB56JTPjxnPcrP4zF4WK3naKmyhVarpGKDWpsnLjxtfMqAQhj6xES01fb1dtPhSVnrJ1VnZGrmCF8uYLzh3YR+gU4EI0qHkLI4JQ191MgWm3Jb+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1p3DtpI6COQt/4oHI9e0pD2r6uqixpQQm+2XLnkcfog=;
 b=LN+aV5fGM1fsZNCiipQb251/PB4QknrIx89QfGCBxt/x7e/gtXOrKbmlQ5a77/Ilt6w7GK+rH/Ldz1oZ40zrUBdeZUV0r3kAoXOH4O/Ljd/VeNklmGfVLf4uqhS5VkikiFYJeeY3HuwUueffEafMeumFqJcrPw5J3AaGzXTZbiwsroQhkyTseF91Oy0FRfAfHhLPNy7ePFjK2lcE7MpapGG3ixp51QQTPgOg7llYy4/0ZzMf1CVSd95Qa1WSAgNcBO4tVLKoT+7y9Y7hgPHZIYCw3c9a4fhwueD0TtXGIrqz3NnA/XqhM2u9HZNuD9WWszEPOHzHQ+c55j20tJvl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1p3DtpI6COQt/4oHI9e0pD2r6uqixpQQm+2XLnkcfog=;
 b=j4zNa5NirNFdZNkGftJr7B5tTOvGy84TUNKBDojXU3cYaJcU7YAr/cYCw8JBLKNbyBgUxi46YSHlkzZQ7t4q5tepZyIpPSOzidIIePk8xZdaoXua1fANHHym9+/FQVS7hwg5WIOEdQ1xuMhIHGhKMHvdh1vJJv6S7QE3JHc6br8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DUZPR04MB9748.eurprd04.prod.outlook.com (2603:10a6:10:4e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 15:36:42 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 15:36:42 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 1/1] ASoC: soc-pcm.c: Make sure DAI parameters cleared if the DAI becomes inactive
Date:   Wed, 20 Sep 2023 23:36:21 +0800
Message-Id: <20230920153621.711373-2-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230920153621.711373-1-chancel.liu@nxp.com>
References: <20230920153621.711373-1-chancel.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|DUZPR04MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: bd3ebdf7-b97a-4cc5-c650-08dbb9ef63a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iekk4sAQ/PM/pyT1diqvkD5cdXp0p2AdqwKHsO9tTL/QwMlmazl3Yjf55f8BDoJrR7FaLznSJ8mWxzfTfjUmGii0SF9X2+2o4RKiqHWk27ao19vyCMySRXSfGAX0Y78CdLDv0a3bSkBqJ72PEzdrNx4RyW3G+EWGvQbCzL162mFb8wdWsQpPSgVh/wDHEfltfRRrIaaES1Ii1ftRBu637NiQhfKIJxc27ubimwYSfk32HrfAXhqBoD4YG3URf3+h+ft7LcOqkWfFQLHZm5CsPve2IuIClWPYNY+f2Fk0DwgHWpJ9AUo6DH7KFL/zCKVuErpT0SPdofq3rW5YiRuc0RJt0Di/fMl679EyVr8QfIsp2+bMEzK7HEvudbHyk3tWZAcdmkhDsGNKUJjPiHxDzrcLF0m797UJlQBUwUKfuvGnU0TG91xNqpcBCcXD7BrTCFw39ZgT+0Ea5nq0xwvg6+U0xpnzcgbjz4i3aWfQNuFXS8meeRvI2ITg/R71dN8uJeZZiVrZ66bPjGclW5u1DJVqEsBpHX+Q4qzSto02nvM+lXFcjRhqTtvFcjbvSuSmPCRxvDJmbaqrmxJkufbVFdO7mWF5hJvVJIbAGRgeSND6fGMNAK5E6IKeXz9Gsnr2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(186009)(451199024)(1800799009)(6666004)(6512007)(52116002)(6506007)(6486002)(36756003)(86362001)(66476007)(66556008)(41300700001)(38100700002)(66946007)(316002)(478600001)(38350700002)(1076003)(8936002)(4326008)(8676002)(26005)(44832011)(5660300002)(83380400001)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7KHSRA+zbTm37vf5UzBno6DNY3ox+hyoqFK9JCgdKy1z6f8ESF6Gfv3L3MjU?=
 =?us-ascii?Q?E4d7ovvlSYiGqj88TVZuus0PAdxbcDZzeedhuZ6SsF1y2P9ZdzSmwXwfFH1Z?=
 =?us-ascii?Q?dCdfVGbdsmvs8Ci+yT9q3hKs1uGL8ePgfKZKvrkiB74BpLFHB9Kipeb0kZ95?=
 =?us-ascii?Q?+7i/6EW1ODFIofJMbEcCdvfY80rGC4B8B0msIU0QmBeyYzxGY29NkuuFrN/Y?=
 =?us-ascii?Q?yLLgiFHpbZvzpUGGG4eqETDHmWK5I8Qz4ASkFVPYzzEQkhv11/BpwFucnfHr?=
 =?us-ascii?Q?OqILpHFZGSIpOLw9DATFzgiybhnW084uICpRThNhOHKY70SLzBArsjsKgkyK?=
 =?us-ascii?Q?QWIlIdSyo9cfst7It8D+m1hWXP/inafkxl+v38lMjMzhLEit9N4pHy6cWf/b?=
 =?us-ascii?Q?Vi9v7ferPTJp1muwgj5fEvUbdI0Kuz9RaxLIuvj97vKPkbfbYLXl/ei4bKml?=
 =?us-ascii?Q?VQD5mbyOveXgiiN1F7FEMFZs67JDvdT0mmGjwIC5GIxgUMEn+nLd1KjhyBNd?=
 =?us-ascii?Q?nK/PqrtUADJhFAGvKe/j8qFNVHFYcBJr05Ou0fwtsYVlb3C4ZSyUYrMKmCRy?=
 =?us-ascii?Q?BqRR5vfe+2nV/FMKbJ2TTtBjdkXro1v8M6xcA1HudHB5SIXMgBI1J7z4c0Mx?=
 =?us-ascii?Q?DFiDIPBKkpHtu7G2ry7gMpx/0o//NG6tQZrfPClo0Ytca2/YNkOo6Bj0wZbf?=
 =?us-ascii?Q?kzIJD4COAtfeaKa/1DFJr8EkXsxRMXP7RHpsE2dXCY6iB5ylGe/XrkrzNxZ/?=
 =?us-ascii?Q?1hYfD1DoGBPlh2EgpL+L0xsnYftQJqTBM3fQLFyNTnmozogJ77KjgIJaPcpX?=
 =?us-ascii?Q?MxRqtUWvBdgWacNHt178KK1O+wevZDbZJpU+bOD9QRZYL5N2I50ackTH4/lD?=
 =?us-ascii?Q?DIDEnXrTtAi8hurwhiD25rzBqJj7PxofuNooHMF7GLXEF3uqnVTGWZ9dUAhF?=
 =?us-ascii?Q?9zhZc12yOmTBF0pGVYg954KpGj3Ux0Fut4yUcvcVYJ5VscXiE7L8NB+fZNIy?=
 =?us-ascii?Q?YxEIjkzt0CmnqsKvtL2glX2/TohGe4wVChClvKsnNEPCXtNI7xG2qsYUi20y?=
 =?us-ascii?Q?G5KqNgY6CVkQNgL0Lr8uLBS4S7SVkl4wN+vOdHhh7DJS8nV/YjNtDpnUZyRT?=
 =?us-ascii?Q?W1zf/gwdBb0NDUbqvvz/0VAc8OMw1ViTMkZzDu5+/3oBaJ7FubWKmsGca3sx?=
 =?us-ascii?Q?TUGmtft+4kTptmPMjYPwQ61HohmZdoAiRtsC8/n9mFKCmkGxyXCJpZFmKkKg?=
 =?us-ascii?Q?pPpOong8hmN8XS2YjhYWW/pf8aZ71zudeQhgFtdhTtchJ7T1ulJ93ARQsTNW?=
 =?us-ascii?Q?m5zF5W9kl64m8Y9rPOrALFHYGNzgw2hVX4cigMctRqARPshslF5nTvUao5Lw?=
 =?us-ascii?Q?US/isUPNV7CeKM1nJK/+s0CXni/TCQElCc5SoL9dgnKNXVQ4ZYdH2aYX9s5h?=
 =?us-ascii?Q?iA66Tu8cJr97r1Cexnahfm5esSTmbcC6OnA/ZiWbV8CYpfjT+c+lmBpS2HM4?=
 =?us-ascii?Q?W+2ePuknBVYvh5HDzsP42J129TtKzX+Bu6BE6Q8untJP1Y5JlsKaQKdEFNlA?=
 =?us-ascii?Q?p4L75DwO4yDH/U12kD3d5KHxUooPAOW7O+iAC6Hf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd3ebdf7-b97a-4cc5-c650-08dbb9ef63a2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 15:36:42.4686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlSZf+ln78Jt6Q/QV7RpV69oLCK3G7ufM7xwAaIv06kB0OX7TpMDvpBPtGWP4HkV5VoLbE8cuUm25wxqgn1kEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs parameters after
stream_active is updated") tries to make sure DAI parameters can be
cleared properly through moving the cleanup to the place where stream
active status is updated. However, it will cause the cleanup only
happening in soc_pcm_close().

Suppose a case: aplay -Dhw:0 44100.wav 48000.wav. The case calls
soc_pcm_open()->soc_pcm_hw_params()->soc_pcm_hw_free()->
soc_pcm_hw_params()->soc_pcm_hw_free()->soc_pcm_close() in order. The
parameters would be remained in the system even if the playback of
44100.wav is finished.

The case requires us clearing parameters in phase of soc_pcm_hw_free().
However, moving the DAI parameters cleanup back to soc_pcm_hw_free()
has the risk that DAIs parameters never be cleared if there're more
than one stream, see commit 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs
parameters after stream_active is updated") for more details.

To meet all these requirements, in addition to do DAI parameters
cleanup in soc_pcm_hw_free(), also check it in soc_pcm_close() to make
sure DAI parameters cleared if the DAI becomes inactive.

Fixes: 1da681e52853 ("ASoC: soc-pcm.c: Clear DAIs parameters after stream_active is updated")
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/soc-pcm.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3aa6b988cb4b..6cf4cd667d03 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -698,14 +698,12 @@ static int soc_pcm_clean(struct snd_soc_pcm_runtime *rtd,
 
 	if (!rollback) {
 		snd_soc_runtime_deactivate(rtd, substream->stream);
-		/* clear the corresponding DAIs parameters when going to be inactive */
-		for_each_rtd_dais(rtd, i, dai) {
-			if (snd_soc_dai_active(dai) == 0)
-				soc_pcm_set_dai_params(dai, NULL);
 
-			if (snd_soc_dai_stream_active(dai, substream->stream) == 0)
-				snd_soc_dai_digital_mute(dai, 1, substream->stream);
-		}
+		/* Make sure DAI parameters cleared if the DAI becomes inactive */
+		for_each_rtd_dais(rtd, i, dai)
+			if (snd_soc_dai_active(dai) == 0 &&
+			    (dai->rate || dai->channels || dai->sample_bits))
+				soc_pcm_set_dai_params(dai, NULL);
 	}
 
 	for_each_rtd_dais(rtd, i, dai)
@@ -936,6 +934,15 @@ static int soc_pcm_hw_clean(struct snd_soc_pcm_runtime *rtd,
 
 	snd_soc_dpcm_mutex_assert_held(rtd);
 
+	/* clear the corresponding DAIs parameters when going to be inactive */
+	for_each_rtd_dais(rtd, i, dai) {
+		if (snd_soc_dai_active(dai) == 1)
+			soc_pcm_set_dai_params(dai, NULL);
+
+		if (snd_soc_dai_stream_active(dai, substream->stream) == 1)
+			snd_soc_dai_digital_mute(dai, 1, substream->stream);
+	}
+
 	/* run the stream event */
 	snd_soc_dapm_stream_stop(rtd, substream->stream);
 
-- 
2.25.1

