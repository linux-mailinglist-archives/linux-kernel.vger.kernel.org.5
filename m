Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6D7768F0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 21:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjHITjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 15:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjHITjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 15:39:18 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C7710DC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 12:39:13 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b962c226ceso2934891fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 12:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691609952; x=1692214752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yYYbomUJVYgsT+0D2+rI323JIj5qrFGSdCe33pVIZs=;
        b=tqnNXFLLqfg0t6tHjegrEctrUV42CI2guavbdlc24Kg1Lu94eGiLVXp5vbUp+lf8RJ
         gtJnAslFI2VXyKE+/KDGNPXn5ngn9WC7PUlvLlHkmEbNOaEVdsYkxZiXreaPEzOFdgS1
         jKe56kNjLHQzN/Nvx+lW0NNUwinIhHH+q8xquYD94jhVWAweDkuAXFHthoW915Qa3UU+
         Hn3r+rqgpJ+YezmkXn7SEwW7R4/6CwEPbyKgbRLq0xvf7KT3HTHDc0hob9PhZw4Lu2ik
         bph6Yu6vmddOLcvEoZyfzZviwyQOIAqUwVDxKf61RSbL4r/BcCol7eAVI6GO51XW0rsg
         kd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691609952; x=1692214752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yYYbomUJVYgsT+0D2+rI323JIj5qrFGSdCe33pVIZs=;
        b=gPkxMlpQb61gKxkFdhvEZqIKgRElRe+Mi9oHRd42E/eArZRjxlM3gMFXRS+OZYjckO
         D0K8cQF7Kf6PojyQrQuoA5DkTnnEs0zyiWQqAKZcxnAW8MGkzFbBKgEmePGNshYGfm7u
         NNWHj4OnLzttVtHB7onUZ7+Lcp1YAVwgL0tiiBcsbEhk0rymJaDomPA64s257PszgZGY
         HrbyfHhETQXXQArMhcpdvZhfgJq4OlwiiMu+og46mr4lkzOsRxDafVyGZwCYmKQ2WeAX
         NnXvxanvrqkcC6IKhdgeVIWa0Y4xRW4m6us9T4zj2X7UhApbabrI0ShkeopwEx8ZZHSN
         1xaw==
X-Gm-Message-State: AOJu0YwuilMalqDfp5zjEu54ARyXhlhCLwp+DMcN85ZQFi5SXAj4J3N0
        UoGI6lGKUE0I213hEmW5vZrmbw==
X-Google-Smtp-Source: AGHT+IHUl1v+fAW73b46poe0EsZeZKCAgbz1VooItCQHjAXRVgpu5we0yITth6++5WZknc0WXmfY8w==
X-Received: by 2002:a2e:8057:0:b0:2b6:efa0:7c36 with SMTP id p23-20020a2e8057000000b002b6efa07c36mr120940ljg.21.1691609952056;
        Wed, 09 Aug 2023 12:39:12 -0700 (PDT)
Received: from [192.168.1.101] (abxi185.neoplus.adsl.tpnet.pl. [83.9.2.185])
        by smtp.gmail.com with ESMTPSA id x6-20020a2e9c86000000b002b9fe77d00dsm2885287lji.93.2023.08.09.12.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 12:39:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 09 Aug 2023 21:38:56 +0200
Subject: [PATCH 3/5] pinctrl: qcom: sm6115: Add MPM pin mappings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-topic-mpm_mappings-v1-3-5e17dd76b3c8@linaro.org>
References: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
In-Reply-To: <20230809-topic-mpm_mappings-v1-0-5e17dd76b3c8@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691609947; l=1748;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=T9v/mfuQb1OwiuFmWNxxzc2HXqjuVkV8vrJqKXZTL10=;
 b=gR9SWreVvqNicNvyIa61OzGWUuYDZRtlOOTQBHFGGKy6KmJn32HLSCWEsfHjrB/HvNLv6yE4S
 zaXUPOwt+4wCIxSkEzzd/HfqJHUBJy8qKOcaP80qsIRfXhgiEIttYUQ
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin <-> wakeirq mappings to allow for waking up the AP from sleep
through MPM-connected pins.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-sm6115.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm6115.c b/drivers/pinctrl/qcom/pinctrl-sm6115.c
index 2a06025f4885..4e91c75ad952 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm6115.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm6115.c
@@ -867,6 +867,16 @@ static const struct msm_pingroup sm6115_groups[] = {
 	[120] = SDC_QDSD_PINGROUP(sdc2_data, SOUTH, 0x73000, 9, 0),
 };
 
+static const struct msm_gpio_wakeirq_map sm6115_mpm_map[] = {
+	{ 0, 84 }, { 3, 75 }, { 4, 16 }, { 6, 59 }, { 8, 63 }, { 11, 17 }, { 13, 18 },
+	{ 14, 51 }, { 17, 20 }, { 18, 52 }, { 19, 53 }, { 24, 6 }, { 25, 71 }, { 27, 73 },
+	{ 28, 41 }, { 31, 27 }, { 32, 54 }, { 33, 55 }, { 34, 56 }, { 35, 57 }, { 36, 58 },
+	{ 39, 28 }, { 46, 29 }, { 62, 60 }, { 63, 61 }, { 64, 62 }, { 65, 30 }, { 66, 31 },
+	{ 67, 32 }, { 69, 33 }, { 70, 34 }, { 72, 72 }, { 75, 35 }, { 79, 36 }, { 80, 21 },
+	{ 81, 38 }, { 83, 9 }, { 84, 39 }, { 85, 40 }, { 86, 19 }, { 87, 42 }, { 88, 43 },
+	{ 89, 45 }, { 91, 74 }, { 93, 46 }, { 94, 47 }, { 95, 48 }, { 96, 49 }, { 97, 50 },
+};
+
 static const struct msm_pinctrl_soc_data sm6115_tlmm = {
 	.pins = sm6115_pins,
 	.npins = ARRAY_SIZE(sm6115_pins),
@@ -877,6 +887,8 @@ static const struct msm_pinctrl_soc_data sm6115_tlmm = {
 	.ngpios = 114,
 	.tiles = sm6115_tiles,
 	.ntiles = ARRAY_SIZE(sm6115_tiles),
+	.wakeirq_map = sm6115_mpm_map,
+	.nwakeirq_map = ARRAY_SIZE(sm6115_mpm_map),
 };
 
 static int sm6115_tlmm_probe(struct platform_device *pdev)

-- 
2.41.0

