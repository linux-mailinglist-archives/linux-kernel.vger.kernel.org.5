Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951FE7ADBE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233191AbjIYPmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjIYPlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:41:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2D16115
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:20 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4060b623e64so632365e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695656479; x=1696261279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5xDdHYwLfg0JHODBOnX5/PYY4PGuDuMNIjsuATRv640=;
        b=DKmaV5K0OdPdPd+V+L8BFKr5kKiqHYrCd77ijCnMNhUshH1ZuuUHKBxj8xq+TZis99
         u7TgPL41Ty2vurWShsZGpu+30k5ufdGYL+dbjheMiT7binRlVBYSfAbTerVbWKlk7zPD
         5a5Tt2I7H8F81vnWyXn6CpAjq0qVhukZr+2qD68TWrrpvV3NnfK3LuebgzkujdX8gpRO
         Lcranl09kF7M6YTLagOGz4DFB75HtrbRsouEWocS8BQqTwiVm59H6mlw9JJ/7BFJFzzo
         EEp8hmZsBSaHQFFhJc1u7jCcnGKC9O/IB68tyTQ8Wxi/58/51cbSpfbvnjp+5DbU8iR2
         Uddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695656479; x=1696261279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5xDdHYwLfg0JHODBOnX5/PYY4PGuDuMNIjsuATRv640=;
        b=a5mhZVMHbIDjM1s1q+vPxhQBsWkishteo9BBD3K6lRBIumFetreGi6ZWVTIWo7XoBW
         XSgaXEa8vycQxG769LrlyjEvOAnR3dDU/ezTEhsfM8xRkyNAGhwDT2hpvU8oqNhOdAUd
         qtl6A2pRBBifqS1/BLFj++GaFWJ6vz4/EZDR3HlxNRh626r5h8lPnOXvm08gVVrEY1hv
         d9UW1HnGYC66zngnaL15e4AFkHXOcMD7DQy1wiB+/ZcKKOyN6hAILqNoYZTEZtWOB03g
         SgQ+7QH4WHTSCSB1aot4uFoHbtenx0ESosOuUNcnSa2+7rLCKuQp0c4OVfK5uKTTu0RD
         5Efg==
X-Gm-Message-State: AOJu0Ywak874imD8n97oBF+U79aLkupjxVeH2aWS4BipL99M59p197wb
        BVR5S/+n5jE1EzpV20feSAkNsA==
X-Google-Smtp-Source: AGHT+IEmXCMcmZ9IN+MzhG/I0CE2OFRAroFblh36HMUsurrTYSHR7FXHQgUXJAxsAXuGDbumqmRIrg==
X-Received: by 2002:a05:600c:b9b:b0:405:3f06:d2ef with SMTP id fl27-20020a05600c0b9b00b004053f06d2efmr36244wmb.4.1695656479339;
        Mon, 25 Sep 2023 08:41:19 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m15-20020a7bca4f000000b003fe4548188bsm15206155wml.48.2023.09.25.08.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:41:19 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
        hverkuil@xs4all.nl, laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, todor.too@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        sakari.ailus@linux.intel.com, andrey.konovalov@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v6 13/17] media: qcom: camss: Fix support for setting CSIPHY clock name csiphyX
Date:   Mon, 25 Sep 2023 16:40:55 +0100
Message-ID: <20230925154059.837152-14-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
References: <20230925154059.837152-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several of our upstream and soon-to-be upstream SoC CAMSS dtsi declare
csiphyX as opposed to the older clock name csiX_phy.

Right now the CAMSS code will fail to set the csiphyX clock even if we have
declared it in our list of clocks. For sdm845 and sm8250 we appear to "get
away" with this error, however on sc8280xp we don't.

The right approach here is to set the clock when it is declared. If a SoC
doesn't require or a SoC driver implementer doesn't think we need, then the
clock ought to simply be omitted from the clock list.

Include csiphyX in the set of permissible strings which will subsequently
lead to the csiphyX clock being set during csiphy_set_clock_rates() phase.

sdm845 and sm8250 will work with the code as-is so I've omitted this from a
suggested Fixes list.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-csiphy.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 20bb361e9ad05..edd573606a6ae 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -677,6 +677,10 @@ int msm_csiphy_subdev_init(struct camss *camss,
 				if (csiphy->rate_set[i])
 					break;
 			}
+
+			csiphy->rate_set[i] = csiphy_match_clock_name(clock->name, "csiphy%d", k);
+			if (csiphy->rate_set[i])
+				break;
 		}
 	}
 
-- 
2.42.0

