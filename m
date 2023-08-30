Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5800378D22C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 04:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbjH3Ckd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 22:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241742AbjH3Ck0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 22:40:26 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787BCCD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:40:23 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4ff8cf11b90so8158984e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 19:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693363222; x=1693968022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u79yO0iAhOgHSkdtiLEgJV1fUj3/h29d83dbFcGVhBU=;
        b=BrBqBKL77X0uemEsLAHm/YcDZNOl+bVb4Eam0RM3uwKqNEsxYiAhfrBrs2bun0P2s2
         PLrEvJFgY3gGxeYuWcJWNOMoESggXsfLAcyaYjH3LSjnBnIpaoB7jOYA1JfOpMYG8PuC
         7XbjHovhDgbRzTKd2TCTPf9GID5/1xrLMtX06zbc0iPZDf+L8ypoIYys1H3WQiQIHNnS
         AA4gjAlbORXmlxR3wYoS0qWkV+2wdlITIZ+0PaSssYzIGJgflz3nmZcfxDx4QQrSYhmv
         aqPXDqLcT1N4Y2aWXqSzwNdHOPOzrtQ1E5QN/MGWBMSW6Qko8ywh7U7PMr8KnfYtbsgO
         Ev9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693363222; x=1693968022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u79yO0iAhOgHSkdtiLEgJV1fUj3/h29d83dbFcGVhBU=;
        b=Tgr5b0NXJySH3QKD2aijXyfSIeT/+AsY0uNhCMJP6IblOTzuVMm8pmL1KEDFMMNGH+
         tME2OGaKD68z3CrlsQ10of6MAeYoyPeRafJ0RLIERSZikd/qzK2vAaXg7lciMAXA0oEh
         NVVMB+w+G4SAmEDE6fJ9WAACMi+qeLCSL3VtOw2QILj1EtC5SZbdu5hQnoWvf5xuh/EE
         eovMc3n/ChK1E4AkQtFL1huT48YFlhuJ7JPhEYZXjHG4g8QfGZISJvz3AUAEkUSbQdUT
         MV7aovEZ/mxUoxuzBHpZkVVQO7UeFc70nSqckI3pVlycvm7ZrGYbLeLn2Yp8MGQMXyH0
         H/3w==
X-Gm-Message-State: AOJu0YzV7Pkl35YyV6NGDd/8Y5HpAsU4lic4HFYoXNQNwZ0AKKQDkqDh
        uEyNCFR7HF4KSKX83UKHo3LgKA==
X-Google-Smtp-Source: AGHT+IEB+Pvy4SQ9xZVdKt+EmXsnpVvha1l5vFdek6iZ3eZULbMZNYOs++suiQW5lY4y3P0QFRWZaQ==
X-Received: by 2002:a05:6512:312b:b0:500:a0a3:80ff with SMTP id p11-20020a056512312b00b00500a0a380ffmr445095lfd.58.1693363221890;
        Tue, 29 Aug 2023 19:40:21 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b004fb99da37e3sm2183878lfk.220.2023.08.29.19.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 19:40:21 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 30 Aug 2023 04:40:18 +0200
Subject: [PATCH 4/4] phy: qualcomm: phy-qcom-eusb2-repeater: Add tuning
 overrides
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230830-topic-eusb2_override-v1-4-ab23825385a8@linaro.org>
References: <20230830-topic-eusb2_override-v1-0-ab23825385a8@linaro.org>
In-Reply-To: <20230830-topic-eusb2_override-v1-0-ab23825385a8@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693363215; l=1714;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NiPnqK52QKHkd/CcD5h/xTEyUsqIlLXa328usvhRCnU=;
 b=VOEa0hyyG8UbttF1hLRne2t5QpVGEd7PBgEJAs3wp6uAI0TP1KnT9BEe4A+kAXPL1NCFnQmTd
 /cC2j3wCQ5fA7z1vShBb/7d6X7rOXpxgi457n+zuW2LVAKcm2t95ufT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are devices in the wild, like the Sony Xperia 1 V that *require*
different tuning than the base design for USB to work.

Add support for overriding the necessary tuning values.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index 645f0e95703a..53e10feb16a1 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -141,7 +141,9 @@ static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
 static int eusb2_repeater_init(struct phy *phy)
 {
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
-	const u32 *init_tbl = rptr->cfg->init_tbl;
+	struct device_node *np = rptr->dev->of_node;
+	u32 init_tbl[F_NUM_TUNE_FIELDS] = { 0 };
+	u8 override;
 	u32 val;
 	int ret;
 	int i;
@@ -152,6 +154,17 @@ static int eusb2_repeater_init(struct phy *phy)
 
 	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
 
+	memcpy(init_tbl, rptr->cfg->init_tbl, sizeof(init_tbl));
+
+	if (!of_property_read_u8(np, "qcom,tune-iusb2-value", &override))
+		init_tbl[F_TUNE_IUSB2] = override;
+
+	if (!of_property_read_u8(np, "qcom,tune-hsdisc-value", &override))
+		init_tbl[F_TUNE_HSDISC] = override;
+
+	if (!of_property_read_u8(np, "qcom,tune-usb2-preem-value", &override))
+		init_tbl[F_TUNE_USB2_PREEM] = override;
+
 	for (i = 0; i < F_NUM_TUNE_FIELDS; i++)
 		regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
 

-- 
2.42.0

