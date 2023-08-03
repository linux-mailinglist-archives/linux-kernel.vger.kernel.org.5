Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9924676F3B4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 21:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbjHCT4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 15:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjHCT41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 15:56:27 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A3DC1706;
        Thu,  3 Aug 2023 12:56:27 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1bf7eb259d5so598507fac.0;
        Thu, 03 Aug 2023 12:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691092586; x=1691697386;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FA21cdF3ub2w1qPV3MyZWOJAJ8z0WCJcF7ZXUjUMPYw=;
        b=Ixygbdk9dAWXPPgsaH5duaOFAPejcKPOehOpKovKOspLOlwQc2QFqDs7h3yMAFuSgr
         nDGt7bf1zxdC6cRt5qXX9bByWv2QvC06tmlWdoBg9E+W+PiXHe+swHO8zGAgZ0J5wnWm
         dm+EkczTPhzpO47/xxxQvQRqC5cT9BXsvNXw+z2LDiGWK1hGLrg1TDvkCf+kKrmfxtVn
         8SkR9BjQsAqiZy7kgIU4P2EF+xyjEP24Na5LsRtU4GxIsmPGUPL0fltOsr6D7L0ruehq
         P/xdBvl19Rq6RqGdZ/GSLKPHPvxmEpEAiIw2m6N3Kh5dRCTvjBFfgsHn/j1BA/53XmIu
         lk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691092586; x=1691697386;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FA21cdF3ub2w1qPV3MyZWOJAJ8z0WCJcF7ZXUjUMPYw=;
        b=f7KpabNwL8hpRkNQyHa/VMcYiwYunqYnUz278V91zIAM0k+cDR7a2N/aXqHFjXP5Xw
         hQDzZfft6mxXoU+DraZPgZdra2IvahIt35wCf0jbp+EUI+oe5+3UXmDnyyleXu++/7Aj
         Ly5MWtUr7ZgRKUHZEY+EZ0RrA0bSi38YdyZ1dcqyro4AI+3hMg5YDa/J4MNoJgz+2lhN
         st4liPSQ8ICheoa7Yb1pKSq/XXGT/21/rSQ3wwvUbC0YSSra2vxkQsbtWWXIS72GJaY7
         kQ0WrB7POEmURmNBFwiPAO9Q6YeHHFXAFmy+t3io9parhUq/haP3Vb4vvKC5IT9wsW6G
         ozZA==
X-Gm-Message-State: ABy/qLZhLfy667CARcqIiqhEBBZBM5BQpsUx/rtp5GDenqHdYPlVLjEE
        nmw19YLwcjnSGmyczqHxN0I=
X-Google-Smtp-Source: APBJJlG6VcN8dQbEB6JbHAxHDmeZsOBLfZ9UdvEXJ0dum+BPbm3XOOYyopVIemX2wSQ5WsH8GBH4qA==
X-Received: by 2002:a05:6870:c111:b0:1a6:8911:61a9 with SMTP id f17-20020a056870c11100b001a6891161a9mr17496810oad.29.1691092586249;
        Thu, 03 Aug 2023 12:56:26 -0700 (PDT)
Received: from localhost ([2804:30c:927:dd00:76d4:c2a9:4431:27fe])
        by smtp.gmail.com with ESMTPSA id dw23-20020a056870771700b001a9911765efsm330787oab.40.2023.08.03.12.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 12:56:25 -0700 (PDT)
Date:   Thu, 3 Aug 2023 16:56:23 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     nuno.sa@analog.com, lars@metafoo.de, Michael.Hennerich@analog.com,
        jic23@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        Chandrakant.Minajigi@analog.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: dac: ad3552r: Correct device IDs
Message-ID: <011f480220799fbfabdd53896f8a2f251ad995ad.1691091324.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device IDs for AD3542R and AD3552R were swapped leading to unintended
collection of DAC output ranges being used for each design.
Change device ID values so they are correct for each DAC chip.

Fixes: 8f2b54824b28 ("drivers:iio:dac: Add AD3552R driver support")
Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Reported-by: Chandrakant Minajigi <Chandrakant.Minajigi@analog.com>
---
A user has reported that the IDs were wrong and the output ranges were not ok.
Also, the dt-doc and the driver require the adi,output-range-microvolt property
for ad3542r but not for ad3552r, which could cause actual ad3552r probing to
fail if the device node did not have that property.
It's not clear from datasheet if setting the output range is really required for
ad3542r.

Was once better at sending patches. Hope I get used to it again :)

Thanks

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

