Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5567B5027
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 12:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbjJBKUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 06:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236473AbjJBKUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:20:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9BEBF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 03:20:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307d20548adso14814081f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696242034; x=1696846834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=toN6r+xeaq1Ts94kNkRkELT8eGStIF+kV6xrpdbRXVs=;
        b=jrdTl3yqhkFh+jKcRlNdVrtN8ry1R6r+XjyybPQidxc608FhgES2AILMR2CV/kDa61
         R1XqQUihJL1RMbZFjLCv9pgbW7y+2yWViRTpFjCam9sSa6l2NZw41qfIUiLnLF1NRu71
         FSD3u4OA8sLOEErW16K3R1nDFXFZ8f4fgfROONXPVOlW+ScGLuXrHzgmqQhkbIRjgHH9
         MrcjYaKH2ywGGvBMXvzoBTD6OILFpTqCIUj8itB589T9Ksq2F0JIQz+Uwe366fOz/mmj
         i/IeW/rePShVuwRAOKRZoAMFuVP8Gxsy+/YgahbKLiCre6s+XvUWclpVRbUehmiirEOl
         f6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696242034; x=1696846834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toN6r+xeaq1Ts94kNkRkELT8eGStIF+kV6xrpdbRXVs=;
        b=DD8T0MdJwS4qvng5emK1L7mg5lHe56M5NlvXnXXjjiwhC8Jk2smPW14OzQP8lXXaIG
         RH/tNyelVL2Owp/C7/st7uE0QggUD5o0U4ZkldhslOlObK1u5zRii+YiZjD2FB902A+7
         LR0VR9DJOywaI29B05qYYQDQeyig6A25JQZW28upbdSNb/lbZkf6hyGeKX/bA9m415fi
         TLRNp64PW+hlJgrDUm1HpA3b4JIrw/Li1Iz86L178trx1+95PxaBAc15lf+a0E/lNAOB
         IC/nCeaI+ImzXxjmHu5QBXd6Z3u+ukqJjv1YO3lyGhzN/CiTdPycGF3+CzjokUSOKEO0
         80kw==
X-Gm-Message-State: AOJu0Yw/qBXwEi6HGUH12YKa+qNIN6pxHkbY6yR39GXZu7NREFV+KiHt
        Jpxwkk5/SMvF0MMUNuZY+bHeDg==
X-Google-Smtp-Source: AGHT+IEa/HpWgFyxZ1gMQsf3eytauR+vrzRmuOkkxvteaxITGvbpX7awG4sLKbqd8siwexJ9yWU5jA==
X-Received: by 2002:adf:cc8c:0:b0:323:117b:9780 with SMTP id p12-20020adfcc8c000000b00323117b9780mr9241476wrj.66.1696242034490;
        Mon, 02 Oct 2023 03:20:34 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id g18-20020a5d5552000000b003196b1bb528sm27822901wrw.64.2023.10.02.03.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 03:20:34 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 02 Oct 2023 12:20:24 +0200
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm8550-qrd: add orientation gpio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-topic-sm8550-upstream-type-c-orientation-v2-4-125410d3ff95@linaro.org>
References: <20231002-topic-sm8550-upstream-type-c-orientation-v2-0-125410d3ff95@linaro.org>
In-Reply-To: <20231002-topic-sm8550-upstream-type-c-orientation-v2-0-125410d3ff95@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=699;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=a52yWfSl6rve1rSnFAPH6wMN+d5/XtEIEhMbM7TvYMs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlGpltnVpQ54f/GOdNOhf0I2L8Ry9vPmPhESsLSJ6G
 flGoj46JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZRqZbQAKCRB33NvayMhJ0cKpD/
 4orn5zrk4N2XcuZGtLwgUAbQjX4vQ67T/777fuyck0dEQqK8000S7A54oZ7rDaAILASdrW7fOB2MGV
 kkfZlnyfBRUxb6tc6HlFkPL+4P6ECcc1JnHw7bTuKxx3vBvLZZPaJdZRULJc027rfRfYAOs8jIT1CD
 1hgsCekgQ1yuThhKs5yL8K7IF8UNoxEPiBpryVEsRiA2DpdW+MjD5Dcq5Bd634mQF1zHLXZ3PTVdfT
 6pLaigxHQxXPq6jfcUjRcrQCJ0FOP1FGX1YJKgvrOGYpa6K9IYLeHnF48jMW+B7jR6LiNI5S1vyy81
 A8eqJ7nQS/H3quqfqZjFrUzcSNPPVak4P1gLGqN8cIOxwtt8h2beQ29Fjss/FiaexxRy3HwCLX566e
 u9Hkn00241kvGBxDD2I/+FhpWLRFcxJ5dQ3mX8wkhpkKqrrKhrG67C533PM38AmEoIAsjIQjag8Tcg
 qcXpaaSaeenUHEcbbw+aFpOX24igjP387JTy1YOXMOuwatsf/CsKL28T8N5OsW9W+ZWZy8EjFuQ/+y
 rNu1WbBT/Xxb6X+qmRkMji/E3ybEQXtj4+mrDVoPRGqD4IntObr+7+cl6R0dMVnA7eIwO2jUdgpjnv
 /OlbV2T2MS0gnkOkipXL0RNSrHrQIi3j30gGOgHAKBD5BkXvTBvj0yQLaKXg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify orientation GPIO to the PMIC GLINK node.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 320662024e89..eef811def39b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -77,6 +77,7 @@ pmic-glink {
 		compatible = "qcom,sm8550-pmic-glink", "qcom,pmic-glink";
 		#address-cells = <1>;
 		#size-cells = <0>;
+		orientation-gpios = <&tlmm 11 GPIO_ACTIVE_HIGH>;
 
 		connector@0 {
 			compatible = "usb-c-connector";

-- 
2.34.1

