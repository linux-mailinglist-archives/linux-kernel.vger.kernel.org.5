Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572A1769564
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjGaL7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjGaL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:59:40 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E11119;
        Mon, 31 Jul 2023 04:59:39 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1bbb4bddd5bso2974150fac.2;
        Mon, 31 Jul 2023 04:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690804779; x=1691409579;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jrnCzJ9Uk8XHCF3A0ESdVfEJBz/p5J2LPDvMeQ7uQnM=;
        b=MstqOIcavTXASvjjD8SlUwnfgq7+jzoWHJvakFxl/FJJPfbfKxU9NR77wiqvG0QXBX
         LN6xXBvOMB17NyBP/OYscd/si3AqkaQuyjqLFE3ImdF3HQqmnqyG7cM5TJjpr2ZCDKkQ
         BEwZNfs3NPzjaGgYnzNvi1Bcjg4koiwLu2GoZPivyJEfEmOREAIJybD+OlIjPlOtbFRd
         4HnCTMp6+An3sQvwyUBhxRGZngmr1Yi4XzZBG2ERexT09HMUVYB9y3JybDhg57ALBjtc
         O9yW/ZVgsYMVnvyp4CpET53hcRzopkUh3EFBq7RYWicoDpVbR6Uos+/HCKrraGnJSaqk
         qhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690804779; x=1691409579;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jrnCzJ9Uk8XHCF3A0ESdVfEJBz/p5J2LPDvMeQ7uQnM=;
        b=PbF9Kct1eCW11yO5jOSRaFZHwzzLJYXC3rV8kqx+vfMETM0HRrzY+F0O/NPpBn03e3
         F326y/329zZ9MzlwjIyylmYvg4v14I52e9VyVrHlSGIR4Sr2MXALP3rw1hy25ZsU0Ztr
         DDU7aH/Wd8yaEvs1J+s+bfoalv/UK/GCbnXAxU05GLQFzQ1QtvCgbmkGOomS9yGEzeoy
         cRm9Kd35KlswvuLps0jyniwXKvXzBtEqO2WPSo2Dbn6aMQnSUMbLqX3OvmB126PRTKoK
         UGB6cZRmDQkpHnaXYSHUpdgAtm/qo2T7aHOy5E6Xa1XMYr3rWbmoE5CncWOuVFYGQOHD
         tmuA==
X-Gm-Message-State: ABy/qLbdsHM1lhWPXpl/YEOqKD4+RatWTgdkfcYmFLe2yTBy0GALubEJ
        zPIdp7tGiWatRvtA7V8pupE=
X-Google-Smtp-Source: APBJJlG+y/ibdw8Mm0H8nalhBTDE6G3GilRjqns3LDw8oUU8HM9ueMCzQulNIX6CMsPFajgw4pe17w==
X-Received: by 2002:a05:6870:40c3:b0:1be:ca9e:a65 with SMTP id l3-20020a05687040c300b001beca9e0a65mr5073810oal.58.1690804779004;
        Mon, 31 Jul 2023 04:59:39 -0700 (PDT)
Received: from localhost ([2804:30c:927:dd00:76d4:c2a9:4431:27fe])
        by smtp.gmail.com with ESMTPSA id 125-20020a4a1483000000b005660b585a00sm4233002ood.22.2023.07.31.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 04:59:38 -0700 (PDT)
Date:   Mon, 31 Jul 2023 08:59:35 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
        jic23@kernel.org, lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: ad3552r: Correct device IDs
Message-ID: <38b71b347f9c75e926dec55d7ecfa078aedd70c6.1690804520.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device IDs for AD3542R and AD3552R were swapped.
Change device ID values so they are correct for each DAC chip.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/iio/dac/ad3552r.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
index d5ea1a1be122..a492e8f2fc0f 100644
--- a/drivers/iio/dac/ad3552r.c
+++ b/drivers/iio/dac/ad3552r.c
@@ -140,8 +140,8 @@ enum ad3552r_ch_vref_select {
 };
 
 enum ad3542r_id {
-	AD3542R_ID = 0x4008,
-	AD3552R_ID = 0x4009,
+	AD3542R_ID = 0x4009,
+	AD3552R_ID = 0x4008,
 };
 
 enum ad3552r_ch_output_range {
-- 
2.40.1

