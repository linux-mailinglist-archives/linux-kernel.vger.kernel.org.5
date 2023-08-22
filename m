Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E6F783D7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjHVKDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjHVKDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:03:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C922ACC9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:03:47 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31c615eb6feso403392f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692698626; x=1693303426;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9oWcWBxrLZ6QRQDomCUBwC94tz1/w32xrnxOpTFoa0=;
        b=F3psM64G5WcmAmJGTd53InmPq+ZFOhviOs7P8nuzUSBjU5OEjLQb1XdDD7v+ACFibr
         J199FR8+flJextfo67efIqr7j2P/q4My/kQHT63/GRUhNHqfC/0EgbC/Io1KyJTh6Z1D
         QMMw2qRTRfDgPlr0VDYx6AehC+jJxtKngakHNOcErbiwUupzfRBP65nBXfS+qSyESQAw
         MBrV48QKHBWjWNiqrlFdpXI4CCmfwTixCX4Lslb4DkElMUI6DiH1CDZir9bM+QOrPvUT
         NAJw+T/0n6ibrck2e4sEIfFpOS9IKNEwYx2L8Hs49rG9r1MnGLpzstCYTXBBmtyUba2Z
         rvXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692698626; x=1693303426;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9oWcWBxrLZ6QRQDomCUBwC94tz1/w32xrnxOpTFoa0=;
        b=cfIfNFzusYfl4buttWArd/Qv8d3ULBIS7kwgBIFtzDtEiTesofxsbbLRUAw68R2eKm
         mzdp0Q5bPsG592xC7FW1TwlNPmmdCy4FXS+oUmhIrayVEaomQUTGQPM/OHPBsZlzCX4e
         rqYZxfVaSskVg9+cHDs5fHExe70mEoO8Hi1UpVS2ya8OPvhMPkmeLo7AUT9Cb/1IXRmg
         08+517XlbqhzDBIN1/6X6RAfDj03jFUw/7o2ESDA0hnTSv/ESO5SLyTBFtmFleZInJE1
         +IIoAKk8BBHrkrMeNvArpKTjqvd3ajMPKDSEyymsEuuFbYLNsP9obUmVXul3dLoiscyF
         /mXw==
X-Gm-Message-State: AOJu0Yxq+Df/AJ9sLG5CaaiJIKEgtfVK+jSEs/kKSkfMXrsjYlf8mCGn
        g/05vA5EwwO+yAl0FxTvgcbVgQ==
X-Google-Smtp-Source: AGHT+IHZimcGq1dwshaSdwbG9u3MCjx8Kkwnl9v2EnHQYP71rOGbCVWTIl2A/r+h1Im9RaQAdYj77g==
X-Received: by 2002:a05:6000:118c:b0:31a:d450:c513 with SMTP id g12-20020a056000118c00b0031ad450c513mr6580461wrx.26.1692698626123;
        Tue, 22 Aug 2023 03:03:46 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id h1-20020adffa81000000b0031980294e9fsm15242250wrr.116.2023.08.22.03.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 03:03:45 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 22 Aug 2023 12:03:43 +0200
Subject: [PATCH v2] dt-bindings: regulator: qcom,rpmh-regulator: allow i,
 j, l, m & n as RPMh resource name suffix
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-v2-1-136b315085a4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAP6H5GQC/52NQQqDMBBFryJZd4oZEbWr3qO4SDXRATVhJopFv
 HtTj9Dle3z+O5RYJivqkR2K7UZCfkmAt0x1o1kGC9QnVphjkdeIEH2gDmSu9zKHNUhka2bgMI/
 AdlgnEz2DrM7RDtg4bBBd+S47lR4D26Sv2qtNPJKk9eeKb/pn/+tsGjRg4XqjK1drVz0nWgz7u
 +dBted5fgE+09UC5wAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1465;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=sHD0CoBdjOt8T7P0X9DuvTDVsWVRM3vbyLemEfe2fRo=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBk5IgAXacuuTfEmY8oyjuVZ4vAe0RbnRuFuKt4Fitb
 LiJFAdiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZOSIAAAKCRB33NvayMhJ0TVhD/
 oCHPHpyZHi90fgsVR3okCviCzF4fWfmM/M//htdHAoF55vjeo+ZukyHPSus519zXZgyddnkLLhiRNj
 OB6VhwitRqH2NBNWjTe995YlAcfuJkxrBhEY7DPebVKKixxaOrfLqVRAh0HA1OB+MjmS4ON2xy96Ch
 Nx5JG5ELx37M2l8OiZGvhOZxXy9R9sX4UWvbuzPxDUKVnlSNY2BekyXyTxrfWiKcO79cbq/JGro9o4
 e5A784IPqmQOK+E+BSgxA7m4NBGIOq5vLC9gv2suavQGJwdhwdd3FNZKNApNTDfvCnt5DewvHEqfIX
 fnB+jI8DFYvWqxoMaQtdPyxeP0zbm25uazmplGmonV4FuErIgHu7TpS2PUuCnbHM9Qy5v2tvxD5n75
 gTWrg37p6knTbxW5+PAv8s+mNjaxgymwHCd63EL499sNM/Ckn8Q0fwjCPLMKdqzHN8uZZGw6Er7DMM
 UDTDPitTGdREmpcnOCYmNbumq5oyMqHwMm2TQ3EaVweDdTalJmV9AYzgnKd+KFmZFNRWZ2xRYRQzoF
 dZweP6lYudCcM31X1aopZmMuwbyZNNFIJQebbszIgpJMi7DlzFj/1dwzOrCQ7h+iD9w3DDweIfQLVJ
 IcFEYKAKK3VRDv5AyqDxEDAzGx0YA9jHWZXzwx+BUg5cMgtUM1L2P7+FMTgg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "i", "j", "l", "m" and "n" to the allowed subffix list as they can be
used as RPMh resource name suffixes on new platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Add m & n as konriad reported, confirmed used on sm8550-qrd
- Also add l since it's also an used suffix on sm8550-qrd
- Link to v1: https://lore.kernel.org/r/20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-v1-1-23fda17f81f7@linaro.org
---
 Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
index e758093365bc..127a6f39b7f0 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
@@ -92,7 +92,7 @@ properties:
         RPMh resource name suffix used for the regulators found
         on this PMIC.
     $ref: /schemas/types.yaml#/definitions/string
-    enum: [a, b, c, d, e, f, g, h, k]
+    enum: [a, b, c, d, e, f, g, h, i, j, k, l, m, n]
 
   qcom,always-wait-for-ack:
     description: |

---
base-commit: 28c736b0e92e11bfe2b9997688213dc43cb22182
change-id: 20230822-topic-sm8x50-upstream-rpmh-regulator-suffix-29f2922f5b5c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

