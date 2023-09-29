Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB407B2DF1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjI2Iim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjI2Iih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:38:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E811A5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:38:35 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2cee40de8so90250166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695976714; x=1696581514; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJ7dWwjIApKtRRNvf80hbFpB8p0JqB1tooDJ9n4DaEc=;
        b=TgzOm07j+oG1QdQ6M6etJgUeQYZp+TXhNEwce6SC7NegU1rvUIB8qWIqSre70gvqIl
         MZoLTwZhnSm4GD9A7X5nEcFjM5oklp7VbT6v2YugXw9sAAVaRZKFefkHoVYLwtQPQqmA
         kwLGp3DeDUejD6/DoBtKu4NVoQF23G9vRfrPyPHWSFuCBwpVq2JqnteNoGkCboByweNL
         rW7vkuPdNX+G8+XZjZ0EYIFQSrZIN9tIaanqwXw4ghxwvG+XB10HbW9hYVpN433PmAm8
         RxdVY393/oodVrOK4Cp5rIRsjrBeNtzJXY45LiiHcVFwVhGvLxwbKznFsmVG2+9g9t0x
         zOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695976714; x=1696581514;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJ7dWwjIApKtRRNvf80hbFpB8p0JqB1tooDJ9n4DaEc=;
        b=rnrEmWja58ArI3f9Oc2SjqYTkneLYYtx9Os5jOkXWTdZv6k6R5PTLOM4EebNlYUf17
         V/OarOCLagxqQizSNC6Ohw5z+0xqs6tAeliFFrwF4r8YMnhQPQiEHBujk06MYmLpsRFz
         6NZL7oujqQm9KBsZg3NUfzcYmWu/dKDORMMtVFlj+jIjtaalOI7q+I4rqrdRjH2GkWwK
         v0GgCQFcK8eZGFSPHX+Y7PbifXJ6kO+88halmYgPBMVxrYnxq9jRX+8+JxtW26A4Qb6I
         d4HraE+JpWlzgsvuiMw3uZdrc8h9VKG8d+X/tPeWip+zVPsF5ixrTAh4wcesczXjBWFT
         u6Vg==
X-Gm-Message-State: AOJu0YyOmAzVYPyWodLImbr1CYNNRd8GNbTeMtbokAFQ+bBvdNVcOoTx
        S1BwIo8vIzb9mUnJbwWtZAu3kQ==
X-Google-Smtp-Source: AGHT+IEhBGY5oEalRjg4MOYzaPZSrg/MxpppdFL+uwcBakrAbyblbQv0sSsQVIzDZ1igXxgYsQTD2A==
X-Received: by 2002:a17:906:8a73:b0:9a1:b528:d0f6 with SMTP id hy19-20020a1709068a7300b009a1b528d0f6mr3157220ejc.27.1695976713867;
        Fri, 29 Sep 2023 01:38:33 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b009ad89697c86sm12208965ejb.144.2023.09.29.01.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 01:38:33 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 29 Sep 2023 10:38:21 +0200
Subject: [PATCH 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable venus
 node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-sc7280-venus-pas-v1-3-9c6738cf157a@fairphone.com>
References: <20230929-sc7280-venus-pas-v1-0-9c6738cf157a@fairphone.com>
In-Reply-To: <20230929-sc7280-venus-pas-v1-0-9c6738cf157a@fairphone.com>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the venus node so that the video encoder/decoder will start
working.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 2de0b8c26c35..d29f10f822c9 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -665,3 +665,8 @@ &usb_1_qmpphy {
 
 	status = "okay";
 };
+
+&venus {
+	firmware-name = "qcom/qcm6490/fairphone5/venus.mbn";
+	status = "okay";
+};

-- 
2.42.0

