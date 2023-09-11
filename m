Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892D779B108
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346962AbjIKVYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbjIKPKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:10:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89175E50
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31c93d2a24fso4155902f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694445034; x=1695049834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ht2UJ2SrAZEBCW6MQUWYMxu5nJ3shvvrcqqoVglcXI=;
        b=TzZ3f7VlRPGg7/misLMDmmMiGHgCXV0MOieoPxMZNZeG6oPgaQ/cyw4AB9K/9+ybOJ
         49quPh6n7b4ZcAdzjzObrGAMBTLBMIBJZIpUwl/PzpZOwb/Ub0tjHuA+bVCOdKQXGTgW
         bLZZ9XreQQro/fKY3ERiGvYpU45MpbD5aI0qORkm389GDUBbzvSZ9vMvvKLdi0iXZyNZ
         XuEcdxKnFwsZOaDEerfHotGWK0kztBnaFImPiLc4uSDgR6sI8yLo7HQtcng2WR1PBBIa
         LjfEfTy36RFefoN4ltX03Pewa7jE8o6DaRiQB4hjzoRRXJqrbxDpX06mx5Mm3WCXB1h5
         Szeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694445034; x=1695049834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ht2UJ2SrAZEBCW6MQUWYMxu5nJ3shvvrcqqoVglcXI=;
        b=oSLY+SEhwxmgGC2SCnK1qSSmNxWBMJYz3tTyXbfSMgJqFVivRD3PxYqY5iGZFhwakC
         A09mK8fgzYwURndK8auzN2WWQzOitoWpRvtMN9fypCWkX9EtiXAuKJitFCPXWqSyhK8c
         aa9Vj5PYWNthMAWasD5UGJtu5yBdxXWD9U0gKJ+spalLfHI8u5UaQyIUFh9fhyUV/6n9
         khXyZh9P3aadytVN9DyCqpQlXMhP5ne1Jz0fGFDzKfnBwPIbJDd8YCZrd0mpHhGXSHIY
         vRdBT9kj7VbdfnPpBcCCG71F4w6CYW4199nYWBDM6quiGjxKPp8Kah+X7xoSwJKCl6V7
         rPCA==
X-Gm-Message-State: AOJu0Yws6hSFw1vnf/V783IpzEtZdz7sja1YTDKNlhZEbZ2Ddmuy06s8
        0qdmYi2NA3agiscrxFjpOGvE5g==
X-Google-Smtp-Source: AGHT+IE4nKR0UaC4vAJTRWZ8UGSUUnfSj9OlxBtzCtbNOI2rCiLWLB5iH0M/MLPczrSSHlDGkLqR7g==
X-Received: by 2002:adf:ec42:0:b0:31c:6420:ff4 with SMTP id w2-20020adfec42000000b0031c64200ff4mr7695847wrn.36.1694445033966;
        Mon, 11 Sep 2023 08:10:33 -0700 (PDT)
Received: from [10.167.154.1] (178235177061.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.61])
        by smtp.gmail.com with ESMTPSA id n4-20020a056402060400b0052a3ad836basm4681281edv.41.2023.09.11.08.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:10:33 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 11 Sep 2023 17:10:17 +0200
Subject: [PATCH RFT 03/20] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-topic-mars-v1-3-a7d38bf87bdb@linaro.org>
References: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
In-Reply-To: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694445027; l=2105;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Vha5xF+p9BTPxJus7eqd6sGp8qGoiJe2/C4TA/PBKzk=;
 b=f8G7+PSq8vQ8m0fwoFb7lhAeXAZZFKJlZ2K2ok59naEqYbofKKp6JrLJUliGcyJWrNRkL2vPp
 0z5kabW6X0jC391xXkpaCqPIoGArBX9faLYDIv0ZpDgQu4zdI6vQRHx
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it easier to understand the various clock requirements within
this driver, add kerneldoc to venus_clk_get() explaining the fluff.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/media/platform/qcom/venus/pm_helpers.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
index e2aec0b46126..59e3eaad97ed 100644
--- a/drivers/media/platform/qcom/venus/pm_helpers.c
+++ b/drivers/media/platform/qcom/venus/pm_helpers.c
@@ -23,6 +23,34 @@
 
 static bool legacy_binding;
 
+/**
+ * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
+ * @core: A pointer to the venus core resource
+ *
+ * The Venus block (depending on the generation) can be split into a couple
+ * of clock domains: one for "main logic" and one for each video core (0-2pcs).
+ *
+ * MSM8916 (and possibly other HFIv1 users) only feature the "main logic"
+ * domain, so this function is the only kind if clk_get necessary there.
+ *
+ * MSM8996 (and other HFIv3 users) feature two video cores, with core0 being
+ * statically proclaimed a decoder and core1 an encoder, with both having
+ * their own clock domains.
+ *
+ * SDM845 features two video cores, each one of which may or may not be
+ * subdivided into 2 enc/dec threads.
+ *
+ * Other SoCs either feature a single video core (with its own clock domain)
+ * or 1 video core and 1 CVP (Computer Vision Processor) core. In both cases
+ * we treat it the same (CVP only happens to live near-by Venus on the SoC).
+ *
+ * Due to unfortunate developments in the past, we have to support bindings
+ * (MSM8996, SDM660, SDM845) that require specifying the clocks and
+ * power-domains associated with a video core domain in a bogus subnode,
+ * which means that additional fluff is necessary..
+ *
+ * Return: 0 on success, negative errno on failure.
+ */
 static int venus_clks_get(struct venus_core *core)
 {
 	const struct venus_resources *res = core->res;

-- 
2.42.0

