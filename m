Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50823803339
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbjLDMmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDMmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:42:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8959DA7
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:42:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c09ba723eso13221275e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701693731; x=1702298531; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8x1dwoG6L6bxEjQMrtyUOBz/l2kp09gC7Z8V8HJ6Bn8=;
        b=YeJdh5ninM2QKZaPuVPWZQmau+UpYLchO5pRNMvWiqah6VlX8oIkPhEmnYGu+lB2Cl
         NEAXs2rQgLxS8nZf7dlAI2ZRbK1P68ikmj3ENClssaG4eFh23I0jgUtNkLp5yCqtIZ3B
         QxQpBab32f5e3YX946VrLRInUmkOgzktWhAvlF+FOOgyGWxn6zYlXGRsh7tcKlrRvj/t
         bQ3Ec6dqYSEmbNTFtavFTN5079EbMRvJl52WYyOW6H5OW3oLUcmsBhFgNbibFgVJnjyo
         zZMYlLvomHgKZgx09JUHaIyA2Wfu1b8WgSZ5up6uqgweSZMWRT60g7V3r0wGwtwvfspR
         1xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693731; x=1702298531;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8x1dwoG6L6bxEjQMrtyUOBz/l2kp09gC7Z8V8HJ6Bn8=;
        b=N+CnQu2+seiAIPVs9SInd0lY1HvjUwHOe5d3lY6jAAlnkJehiEySEKBA8+gPDHG/Vv
         y+niPW2K/PUYLRbKoY1De8SEHtkXeQl94fBh+J971948QfsC19IeLS3Ujb4MTg1kDZMP
         d5Npqvf2EIcjPpJMdVNBpMtEhCaecLmtKO6cL5nWDeXRWKwYu3Pmi29ly37mUxNItHWO
         0T9HbfMCFgF4CC032Y2SacHUxP1cL3DS5qJQKZJC1a/4S61n2ogNTyRA56CM7Tw61I0f
         h06tfCL8MAh4zD+ANEnJj6FD1IVwnh8iMRWXhcJswEuFHibmGWqeho9F75r3KnYSPlEe
         HisA==
X-Gm-Message-State: AOJu0YwJxCs/e3xIq0pPEK+4+5V86lvv6XeZ2Oe52IT6vP9Yjd9asXAg
        tUlf1/+ThkSdknC7z0ZyvvSfpg==
X-Google-Smtp-Source: AGHT+IGJz3N4/IoxBaz0NjZihjCP4keqQKfmadAcfgA7ZWA07jRl1+KY0bF/rDdOkf8aj+mgEiOyHQ==
X-Received: by 2002:a05:600c:450f:b0:40a:5c71:2c3e with SMTP id t15-20020a05600c450f00b0040a5c712c3emr2172252wmo.19.1701693731047;
        Mon, 04 Dec 2023 04:42:11 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b004094d4292aesm14959419wmg.18.2023.12.04.04.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:42:10 -0800 (PST)
Date:   Mon, 4 Dec 2023 15:42:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] ASoC: audio-graph-card2: fix off by one in
 graph_parse_node_multi_nm()
Message-ID: <1032216f-902f-48f9-aa49-9d5ece8e87f2@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The > comparison should be >= to avoid writing one element beyond the end
of the dai_link->ch_maps[] array.  The dai_link->ch_maps[] array is
allocated in graph_parse_node_multi() and it has "nm_max" elements.

Fixes: e2de6808df4a ("ASoC: audio-graph-card2: add CPU:Codec = N:M support")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
In this same function I was also concerned about these conditions:

if (cpu_idx > dai_link->num_cpus)
if (codec_idx > dai_link->num_codecs)

But I wasn't able to see out how those idx variables are actually
used.

 sound/soc/generic/audio-graph-card2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card2.c b/sound/soc/generic/audio-graph-card2.c
index d9e10308a508..78d9679decda 100644
--- a/sound/soc/generic/audio-graph-card2.c
+++ b/sound/soc/generic/audio-graph-card2.c
@@ -557,7 +557,7 @@ static int graph_parse_node_multi_nm(struct snd_soc_dai_link *dai_link,
 		struct device_node *mcodec_port;
 		int codec_idx;
 
-		if (*nm_idx > nm_max)
+		if (*nm_idx >= nm_max)
 			break;
 
 		mcpu_ep_n = of_get_next_child(mcpu_port, mcpu_ep_n);
-- 
2.42.0

