Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7337E26A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjKFOYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231671AbjKFOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:24:08 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF86D71
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 06:24:03 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32d81864e3fso2624077f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 06:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699280642; x=1699885442; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y71neDZp28SM9UCppWA9Z9/rY93fXQytngy/ALew8rQ=;
        b=CTSWs4NvP2Z0J9iaWJrKQMnbBLunuexYUHs9aKKuVovhanZc45C/lxjeqEtigepgKI
         PRFSC1+6sb1Y9jm19Gu6i9JALASLhwzGDg8fsQJDc2WOcgswrb15+/B1RKY8o2UPlmrk
         cruXcsEZErBAKS2hcNcsRpB+D0tIUzYuI9jeqFox86UEtWA4VmOQEHZySa+fdsyKOIbf
         Jf46Q5arlHJy+a44XNIJY2+jRdz/+D3PW4n/D1OUYXgByZQFF9dzl50IVFmWrmViwyGF
         xf5jDp4zpvYFlvwzdwP8prF3gCon4+s/PzS7qwaNNw1M+/ZEd3LKP6Bmi3S6hJBRVQfT
         sdjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699280642; x=1699885442;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y71neDZp28SM9UCppWA9Z9/rY93fXQytngy/ALew8rQ=;
        b=IiqymEzcVx2mPYMuBqbIh4AD9u91rWrtjW7vWfeLRs/rx8K67jKIxVTml97Ms2w4H+
         a2EaLpqTzGy5Tk8N/7lQMw2RDaLmMe19dRhYbGfiG+ZGow6Mewl+w+VLu5v/QSNhwTY1
         U4thN0orRq7SSbrhvukUOKo4E95QEnih3WPKZnJVQvmEYnYQ0fe18aCjavcxLPy6+qOL
         8FfzrLIf2Z8fK0FAF4aBAcKNNZGJUoxP3MLUaQ18ha/bSzUW7tqnLc+uDEU9x+HvvMv5
         F7b6FNOTXa5jEwMujB+0w4JfyMOq3FNYUbpStWj6JPJQc7pHGAwmfgL4R5MmlQsiZJD0
         MetQ==
X-Gm-Message-State: AOJu0Yzo8wP1OWQzu6Hqom4hI4Jlt4yuce56i8Ey13nJGjzMXxXb9DuQ
        aqO/lzXioFsb7JpDdtcodOLIBg==
X-Google-Smtp-Source: AGHT+IGmUpoaIF/DPCna5FfP9gHBZdHU+kMvnZHX2AGqLp35+hpvtUb/kJP21jCRPoQlQPgKwAr9VA==
X-Received: by 2002:a5d:6051:0:b0:32d:a4c4:f700 with SMTP id j17-20020a5d6051000000b0032da4c4f700mr20614880wrt.38.1699280642165;
        Mon, 06 Nov 2023 06:24:02 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb0c000000b0032fc5f5abafsm6492025wrr.96.2023.11.06.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 06:24:01 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 06 Nov 2023 15:23:57 +0100
Subject: [PATCH] arm64: dts: qcom: sm8550: fix soundwire controllers node
 name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-topic-sm8550-upstream-soundwire-bindings-fix-v1-1-4ded91c805a1@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPz2SGUC/x2NMQ6DMAwAv4I811JCC0R8pepAEgMeSCIb2kqIv
 zfqeDfcnaAkTApjc4LQm5VzqmBvDYR1Sgshx8rQmvZurelxz4UD6ua6zuBRdBeaNtR8pPhhIfS
 cIqdFceYvuocfog/9PBgHNVmEqv7vnq/r+gHg9mRLfgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2058;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=iaOLj36FAc4olkdSibLasAQpUsIwwHBODZ4KhepQONQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlSPcAlx2cC1kfI53Xmp/i2TEG5TZqy1EKLQeXjF9t
 NRMLQZmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUj3AAAKCRB33NvayMhJ0XpFD/
 wP515JR3mFSm5M6scJ2Oa8mTfdHxAfR5ylNovQ9KSBOBlG7w9dq9KXmG2dKePaWIs8QZCX5pShJNAw
 92FlIuoUdf4BAa36QDNN4MM21PMKV8/kSOXxF7234LHZEQsn6pLCihOV5JObxSHgHYUZyjmhEY90sl
 usb7C6JOq+e9zybY0DJjw5pgva2pupuRxyx5FZv5X/fWvHsFTDyRT9tXvIXld6fgzz0ZH6G+TjlA0G
 tAjZW37T2ZKZeVwiP+FQyfp9sa7V44JWlTomguZPK5avjRXxlsuBEphiI+cQMfWr9Q2Y1m0uQ3LZ/M
 mQ83ub+46DOO7MKOxBx9lsy76WAwxmL6DO91u+v5tED2lqtrlSpihJXoWvvimD9WzeD1m2MVAnLteo
 fh3P3ljvv6VwWQIDywJaajbDTu9wx59Mw0B8r0/2npwEOJjGZw68zAzWgeVNDhv5vKXCyGp20zHyjl
 Wv8dqBqLbauCgO5Jtg46A7VM9LmclWVyltcqID9gP7D6AF+g1SWT9pvqUOYqZOn4OKj10450Ej1wci
 r/WPqJzW2Ctvg8TO9RqsgLSVKK63ZhGM89hV/HRjWaUZu7X+LmmxxAWj+6JCgyckNbEblYHH5HaMcO
 fyCcvbtS8ioWxe0CWPxJKZDgJiIGW08CyNY3+FBC6WkZSLpTTTPrIYydf1+w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following dt bindings check:
arch/arm64/boot/dts/qcom/sm8550-mtp.dtb: soundwire-controller@6ab0000: $nodename:0: 'soundwire-controller@6ab0000' does not match '^soundwire(@.*)?$'
from schema $id: http://devicetree.org/schemas/soundwire/qcom,soundwire.yaml#

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7bafb3d88d69..52e8f4c52426 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2055,7 +2055,7 @@ lpass_wsa2macro: codec@6aa0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr3: soundwire-controller@6ab0000 {
+		swr3: soundwire@6ab0000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06ab0000 0 0x10000>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
@@ -2101,7 +2101,7 @@ lpass_rxmacro: codec@6ac0000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr1: soundwire-controller@6ad0000 {
+		swr1: soundwire@6ad0000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06ad0000 0 0x10000>;
 			interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
@@ -2166,7 +2166,7 @@ lpass_wsamacro: codec@6b00000 {
 			#sound-dai-cells = <1>;
 		};
 
-		swr0: soundwire-controller@6b10000 {
+		swr0: soundwire@6b10000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06b10000 0 0x10000>;
 			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
@@ -2193,7 +2193,7 @@ swr0: soundwire-controller@6b10000 {
 			status = "disabled";
 		};
 
-		swr2: soundwire-controller@6d30000 {
+		swr2: soundwire@6d30000 {
 			compatible = "qcom,soundwire-v2.0.0";
 			reg = <0 0x06d30000 0 0x10000>;
 			interrupts = <GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,

---
base-commit: f21821a1f31f531d9f516ec24323e40ae32e21b5
change-id: 20231106-topic-sm8550-upstream-soundwire-bindings-fix-84b7dbc6f708

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

