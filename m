Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42234786E09
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 13:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbjHXLeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 07:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241041AbjHXLdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 07:33:41 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A5D19B2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:38 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so61648525e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692876817; x=1693481617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WpELkDIoFcOBpglC5P3ZWupm38vhsMwP331NwzHDCg=;
        b=sY8ALyLRjJDrsOn1XznUGHJfPgIfmyT3Tg0xOOF4HO37o86q3EqwE1RRaAZyepNNII
         6AVjt45Xjf2TnmyXWQdGCPVs8dzdJFz/zerBQTxHAEaovgUyeqmeZN/vfUKxxPb4JCNp
         RhgB8go+MX3G1C1cqAI0hPW3NoyQj/Y+FAVWNOpic6XpZiHkP4qwgil+v5/SoAgrMT/S
         TRn7F29XL2SahYx6ddzq9G2pHXkH/B8ONHQtZxCvQ8PTjSoey7zo4Qyu1WwujMygbOSk
         ar3dOvEz0nYYEEjYhgoVm/ZbkEF0ShfHWjemNl0Cj6soF7nRtca3qfwfPBCA2Sfax48P
         eiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692876817; x=1693481617;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WpELkDIoFcOBpglC5P3ZWupm38vhsMwP331NwzHDCg=;
        b=MCa8H2cga78rQBrtgvZaN+6lAx3US9ITbrENWGjDy5Lq9RJxQMDXyiT53s/n3vnmqm
         QP47eY1C36yutBfkD5TpaMB6wichgOI+6OBF+w/oYkFLS0mWUAnKsu7Kd7Xx5Pb3QgD+
         FSvrWSkvQgZ83p4R5NvKNGrrNHiUT1D5br6kY892MuQE1VFmZvEXA52uQN/DItDU/kJB
         IRETD8D18gaGX8D30N/Ib5BZ7/VVFJO/DMuewIDJfOPel3GuH6y9X67xXp/oeR/BXobg
         87XAD0cSfNXoN9gsQspukRCwW8HOek34xQMd+3ebeqN0TLudalIb6KKfUYjQ2nsfUplj
         /RXg==
X-Gm-Message-State: AOJu0Yw58ry+pYzHIFGsEsVf3usDpTGoBUVhpGJPBNJm1sKhtji1UzEC
        aLDM+SEZCyDRke6I+fkxnXaOzw==
X-Google-Smtp-Source: AGHT+IGjbctPhhJokdl8EmJDPZ3i+yvO6pNALDMAAqAje9IL5RVindngBZP8hJQWzMaLq33xiHrP+g==
X-Received: by 2002:adf:f184:0:b0:314:35e2:e28d with SMTP id h4-20020adff184000000b0031435e2e28dmr12110907wro.13.1692876817511;
        Thu, 24 Aug 2023 04:33:37 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id e11-20020a5d65cb000000b003179d7ed4f3sm22063938wrw.12.2023.08.24.04.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 04:33:37 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 24 Aug 2023 13:33:25 +0200
Subject: [PATCH v2 6/7] arm64: dts: qcom: sm8550: add TRNG node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230824-topic-sm8550-rng-v2-6-dfcafbb16a3e@linaro.org>
References: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
In-Reply-To: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=756;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LCwZ4KC8gvTuRA6IYwBPb6uZ7MJ47erCdg3FgSczjSk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk50AI/PPcJ1kGTnjICAPRr2U3fYANpHfpQIvkgI/s
 F+2GPeaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOdACAAKCRB33NvayMhJ0cgUD/
 9O/sp8RbQsdhI90sMdLRCcuPxF0rghLROCL/uMxN5I/TvrJ3axijUfEQjNjnaeOgqahQlNbI9hKXls
 57RUBMw+cPaZ7mmJGEjxYNBvmBw92hOTor4Dx+q1+2jWXI7Go0j0U+iziubp3fvc1oHiTHeGpLvejI
 ZRS1jntKG1fJDSCZzb7WMTRystUhvOXizM+o7UkdvvCtiEXxbBsWzKmMv+YVcKYf+GZbk8MwPmjY7r
 KUVMezBYzyRDcxs92cNdVB18OUzPyJlt3L7jHADYf5V7qdcUWE6nLZwpCwUpEISuPSWbVrJdV04ytR
 IEbL0jikGHc15Wz955ySCMN4oQInrxga3CSeYGNa1no2rVkD1ZYR7nWV7SSN23AE/JVxKS8wiq1NIE
 DlBHIqpwnawBbVDvOAOiAHewPyHF0Sq497lFoFHWFczalJBfkD+L6HIQqb1YnKD18Pdzl0XG/DkexN
 r92QJK48RsicPiZNt+D6rFQuQv4xEw75ElKbmR//2nj0OveBZDLM3ZobPGuBUu4iu8ocZ+NI57n11A
 dVfvmZWNEU1cK5ffb7GqGt8hAVHEXSud65tfu6/Tx1C2MC4ybqNu6cKhJ7vUxv9/lMp5cP63yEy+Vi
 GulunAvRr7ppT5HfloBWBV8MsCrnmPnCKiZ4yj+4Rb1BUj/rNt59ltLNYWKg==
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

Add the Qualcomm True Random Number Generator node.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index d115960bdeec..c42c5bd03a37 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1661,6 +1661,11 @@ mmss_noc: interconnect@1780000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		rng: rng@10c3000 {
+			compatible = "qcom,sm8550-trng", "qcom,trng";
+			reg = <0 0x010c3000 0 0x1000>;
+		};
+
 		pcie0: pci@1c00000 {
 			device_type = "pci";
 			compatible = "qcom,pcie-sm8550";

-- 
2.34.1

