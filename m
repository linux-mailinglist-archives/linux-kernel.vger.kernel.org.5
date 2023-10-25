Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374EC7D6390
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 09:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjJYHiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjJYHhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 03:37:39 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727B530F1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:39 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c5249d55so7710598e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 00:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698219276; x=1698824076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtjaGI0OyZ0EdBdBaBOQ95CjdQNQsAj7+ZgWxWLoVvg=;
        b=aZV3UrC2rVRCUh0Pt9asJRDBZYMnzNs9pzDbH9/miQ8tjLJPlC5k7Rak2NJAcaLGbX
         gQCT6uoRuWwEoPQ6A6kCAYH3A9T+VqamLYymYBaaxAlv0iagKfk3nfWmVD5mBcqAblMt
         IfwBWNkzZaeM1yYCZbBxD/GSHtx88hKgUFb6UKwJlyry+IkuZpdHztXEDzYWYrHEGQ8l
         SaDD5DJvNVXDy2bYAkxBHK1fq+oKxj/6I2HAqdikVh3PUs0JPxc9DGBeNsFNjFVCJr7B
         LmBcklnDCTocki9IfW+mm41lqbRyxMoP2tKoGkJloiBcBqXyrnmhAHRzq/WzVvDEKbyp
         yTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698219276; x=1698824076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AtjaGI0OyZ0EdBdBaBOQ95CjdQNQsAj7+ZgWxWLoVvg=;
        b=BpqXZMF6T7pNuS20KtzTpko7hrkf442lnItcu/1bSU7WMdQ85MzoJchn3sTJmVk2Rj
         kotrRmQnnE8igvBZhtWwZraN46SJJJKaEuTZwW7MSNTnSTPovQom1HPZT24eqrcB15kP
         8Ik60UycbgQ3mZ/vfy1IutdarjBu6QAm/9hz6GBO+jbITqGrt6zRIYyU4oBJ+GYYbXSX
         +1nCqfUsSImoCTTNoK367A4r/Uo+RT8+gCPnmZjbiGSxWUPjGX7+5muyDLqUfDNXQXBq
         SV9daV9EZMBhCkYiQXnyc+yCW+UP3bwa2CgWZfP3r7xX9+fFyiNtsc2AL9J2rfQPQ83m
         ZvlQ==
X-Gm-Message-State: AOJu0Yxmp0vCTLnTx3xIjd5Q5kmuLlcKqewRFQzk5D4zKyTwXgWtjaL8
        jBPn/Ze96ZGvB2BYd5syWF7r6g==
X-Google-Smtp-Source: AGHT+IFQsTBGCIGYdIut4TnKmQ7+1s7MRU+V9MiBwh5l0roqJyWvvI7W3PZkHF29aPNrYRNBhuIeig==
X-Received: by 2002:a05:6512:230b:b0:504:4165:54ab with SMTP id o11-20020a056512230b00b00504416554abmr8851305lfu.56.1698219276654;
        Wed, 25 Oct 2023 00:34:36 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b0032dde679398sm11431392wrs.8.2023.10.25.00.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 00:34:36 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 25 Oct 2023 09:34:29 +0200
Subject: [PATCH 7/7] phy: qcom: qmp-combo: add QMP USB3/DP PHY tables for
 SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231025-topic-sm8650-upstream-phy-v1-7-6137101520c4@linaro.org>
References: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-phy-v1-0-6137101520c4@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=807;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=lzyoKSoE9NysNHXkw5ojcFxOZnDU8btJV0S4+yaPrc4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlOMUE6/wWF47zAPcf5y0QfZFn3laEFazck+MdQEkn
 D8z70yqJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZTjFBAAKCRB33NvayMhJ0TyBD/
 4x3g+f80Xi5iM5qDvn+GND3eMDlSKsxpYY4HC4yXI+oLNDgDl+kFY+J5uNEUTA1l3DxUkXMD5R1S8C
 KnemxaDns3r7sbVLYjf7gb6ziAVY0qGwa1Va5Nxb36gCH6E2lfJeYmCYQFfdrg2gg57T5N86lWBwuJ
 mCtTj/4i5ArczZ/W8vPJXl/mp4eF0WA5vVcB3LjmkIbYXEePSDP42mYU2C6b1lB53ZQbbjl6UHtXuA
 tiOJ3lX97M7pbhHIMvEGV1w1Ag/6xm02gA0u0O0qbPrvg+Di9VwcA48pshHEaLWgv2QcMAVui03BeF
 jvOwcZqouKlHzik+czRaI9w0R1/dAp79jJfwMtwsAVJESsp5J3wGYTD4cGqoa5q4d/ejgDNtsULITF
 PMeYLtQCFE7wYnxRz9Z+y///qh8IaIXIQECNtT2cB2Q0NKNgvpia9MwJgwOChs/HvJLvPZ74Bn2ELX
 RYJRDSYe4N06MWqYJBpSkmvx1rWrsMglXcT83fiz8WTIeiMJdqSZ8mnLreNfwMig+9tkK8rA2QeVK0
 x67dcgzgGg0ltdvlAK0oLpKdCCMs5iUj1spGzyyF7UNxcQrlgHh1Obw6A93aBldFyoDmJ1DRGnC3Bv
 yPwdWtfDTRoR4r4IdGx+MUdaDsCsn8p2oOeUr5z+IhcBP39LuqTO9CKB1USQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add QMP USB3/DP Combo PHY support for the SM8650 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index 9c87845c78ec..0417856b8e7b 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -3558,6 +3558,10 @@ static const struct of_device_id qmp_combo_of_match_table[] = {
 		.compatible = "qcom,sm8550-qmp-usb3-dp-phy",
 		.data = &sm8550_usb3dpphy_cfg,
 	},
+	{
+		.compatible = "qcom,sm8650-qmp-usb3-dp-phy",
+		.data = &sm8550_usb3dpphy_cfg,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qmp_combo_of_match_table);

-- 
2.34.1

