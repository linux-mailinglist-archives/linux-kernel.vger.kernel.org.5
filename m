Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280DE75E36F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 18:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjGWQKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 12:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjGWQKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 12:10:21 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7C19AB;
        Sun, 23 Jul 2023 09:09:49 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-991ef0b464cso987235766b.0;
        Sun, 23 Jul 2023 09:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690128564; x=1690733364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2veQxu8CUO6P1XePRFBe/UBdEyNGLJM/Toogbx/KiU=;
        b=rCRWyphLVpv5BaBfJbMtK/Kq7hN6XWTg+54WvIitnZAGyK8aoqbq261/U8/aZclp8R
         cQCLWoi6C/llJ4InbyYLi6MgiXbbbzZJGYFNPawL5PVYE26x9oFjvhDkEw+suongj+ZQ
         blLfT6bWK8WAuJhM9jB1DgjdEaXh6vR4mCc1uhW03fRdEZ3iG5VTQU1O/IqExRxfldrx
         BdDipNnZXba0J3QW34kQCDCeMU6dWAd8LhOGabN91xks0mbsopCjv2ViLLWPx2/t87M9
         tDrqmA+bkivmTvEhPhuwWwh9FgO/QdFfcZwZKw3yGkJePuT8MqmttfNbRKuZ8bQXSu9Y
         XxPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690128564; x=1690733364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2veQxu8CUO6P1XePRFBe/UBdEyNGLJM/Toogbx/KiU=;
        b=W7uZLZdjFTAL5HTZ14DnCEYa2s6gNhmH1CTDcye7ZHndbHCjyuTPOPYcdCgQT36jk/
         Xvbi0+5I3pbqKQIz4O8CsCT3eu91PzrkaCCkfp58W3eRmjmaLIdHpp0ZtZPAN+mDyKNy
         l7XQiy8zh0jcrthPoWx2AA+t7JYPE53PsKVR8PY6tPTXUKmLvW5FW91Mg6r9Pa1ZHii1
         b6todX/yWiQHKfnsAtMpil2IApGhAL6udC9mGlNIMnpw4WVKBhpU0r1uN438QHrAbRwI
         e3W5T/7wSSQCRhqkifSIl03CgmGdBXvEftgGxznTcfm4hRfCi7tmIG4i6d/IIZhWyhsr
         6U4w==
X-Gm-Message-State: ABy/qLYa4HYiEKhGzgtDzOM8+rQ7Ns/ACdy79wDbq4ez2xpC5XXXxt0o
        czr2F8bImUxq7aBsHp4DOvryhGJbot8=
X-Google-Smtp-Source: APBJJlFwIsIQryk9Q0z6iRZ5GHRdFGTKryrN46bOO1De3xg5QU5uQTyAdbGBs0nS/IgWahibdbzRVg==
X-Received: by 2002:a17:906:2d4:b0:988:b61e:4219 with SMTP id 20-20020a17090602d400b00988b61e4219mr8155209ejk.29.1690128564696;
        Sun, 23 Jul 2023 09:09:24 -0700 (PDT)
Received: from localhost.localdomain (ccx116.neoplus.adsl.tpnet.pl. [83.30.147.116])
        by smtp.gmail.com with ESMTPSA id u16-20020a170906951000b0099b4d86fbccsm5425039ejx.141.2023.07.23.09.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jul 2023 09:09:24 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] clk: qcom: clk-hfpll: Configure l_val in init when required
Date:   Sun, 23 Jul 2023 18:08:21 +0200
Message-Id: <20230723160827.22660-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230723160827.22660-1-a39.skl@gmail.com>
References: <20230723160827.22660-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pre-configuring default frequency multiplier,
this appears to be required on some platforms like MSM8976.
Without configuring L_VAL device reboots when trying to bring PLL up.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/clk-hfpll.c | 4 ++++
 drivers/clk/qcom/clk-hfpll.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index 86f728dc69e5..705352aff067 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -44,6 +44,10 @@ static void __clk_hfpll_init_once(struct clk_hw *hw)
 		regmap_write(regmap, hd->user_reg, regval);
 	}
 
+	/* Write L_VAL from conf if it exist */
+	if (hd->l_val)
+		regmap_write(regmap, hd->l_reg, hd->l_val);
+
 	if (hd->droop_reg)
 		regmap_write(regmap, hd->droop_reg, hd->droop_val);
 
diff --git a/drivers/clk/qcom/clk-hfpll.h b/drivers/clk/qcom/clk-hfpll.h
index 2a57b2fb2f2f..27b9effcb3fd 100644
--- a/drivers/clk/qcom/clk-hfpll.h
+++ b/drivers/clk/qcom/clk-hfpll.h
@@ -18,6 +18,7 @@ struct hfpll_data {
 	u32 status_reg;
 	u8  lock_bit;
 
+	u32 l_val;
 	u32 droop_val;
 	u32 config_val;
 	u32 user_val;
-- 
2.25.1

