Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEBB77BB25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjHNOKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232005AbjHNOK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:10:26 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD671711
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe1fc8768aso43972315e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 07:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692022221; x=1692627021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HGhoQh+Cc1QnhiJuF+fRUaLv4iTYPEYMts/sNpzsFg=;
        b=q1/n7+K4ipJ+tYmMshBiWs8UFexzbspwBdc9ZCpYUYLlsNKUPdUE7XnFw6RuBdLqNy
         v18ohU22Co4Wl4pabLqUcgicdRJkgvsmxbdJFjwPpNnj1z+1wqQx1zNg0WCYMUJKVQrA
         Mv2C97gY7qilWDANjiz4ufA83ERqMLcheTbDHadv0qk200LiHUiv2ITjphLMuILd17BR
         /+gvfp0YErQntLe/yWsqZqKpBvnq4RaQ3gBzgcIWZo/j3vQt1JVoDqBK7r6yNeLeIYih
         sqkl7r916TX2NGndd8elM8QBEkUGh9I+KokcQKbOWTP2VDzKk70zng3MU5HsKsfUTB6j
         okvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692022221; x=1692627021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9HGhoQh+Cc1QnhiJuF+fRUaLv4iTYPEYMts/sNpzsFg=;
        b=ecvw27DJGWQgyvWXNcboXHP/OR4rM6/nkUVhTsDtFkHaRQQQFaUsrizx48YJNhn9wi
         VduCJK1jZCS/jJ8z2Qt/LWZsIR8Stz0yvoUtoGwB6HSDUctSISir6GMIWWQ1B+IHL9go
         Aji+z3ke5pwIXnPnjKLE0isksL7rbWzOI8juRgLTPdf8U84QlYzTvJKy4kieWEF7Llt2
         XkknDuZUG0eqnxhv7r1x2uHMbS2JQhLq/aoJE/RxAuPLwIHeznw4fbh4xwoa3GlzmLAd
         D5wQWzVVBtugwmE3wxAEAUILVWt9IvyOBr3tEAB2Vrxwl16wiYfrjnAVPlOr/kK/cv4d
         LNbw==
X-Gm-Message-State: AOJu0Ywy46MnOjKwCA81oIlAWgyp8ddMKezfkeMYKYMB5q4Vnq0e/XWP
        oUURMNB7REmWQocWa3dN9URDtg==
X-Google-Smtp-Source: AGHT+IFD3EH24917DWNuG+tFsT60ozdbcomaexWmGlHGkqMp2ssZOZrDp1HJXZ1mKSZN47v/jZDbKA==
X-Received: by 2002:a1c:7910:0:b0:3fc:f9c:a3ed with SMTP id l16-20020a1c7910000000b003fc0f9ca3edmr8283076wme.22.1692022221036;
        Mon, 14 Aug 2023 07:10:21 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c7405000000b003fe1630a8f0sm17232749wmc.24.2023.08.14.07.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:10:20 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v0 7/9] media: qcom: camss: Fix invalid clock enable bit disjunction
Date:   Mon, 14 Aug 2023 15:10:05 +0100
Message-ID: <20230814141007.3721197-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
References: <20230814141007.3721197-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

define CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE BIT(7)

disjunction for gen2 ? BIT(7) : is a nop we are setting the same bit
either way.

Fixes: 4abb21309fda ("media: camss: csiphy: Move to hardcode CSI Clock Lane number")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index 04baa80494c66..4dba61b8d3f2a 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -476,7 +476,7 @@ static void csiphy_lanes_enable(struct csiphy_device *csiphy,
 
 	settle_cnt = csiphy_settle_cnt_calc(link_freq, csiphy->timer_clk_rate);
 
-	val = is_gen2 ? BIT(7) : CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE;
+	val = CSIPHY_3PH_CMN_CSI_COMMON_CTRL5_CLK_ENABLE;
 	for (i = 0; i < c->num_data; i++)
 		val |= BIT(c->data[i].pos * 2);
 
-- 
2.41.0

