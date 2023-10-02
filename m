Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8DE7B5520
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbjJBOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237745AbjJBOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:20:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E59AE0
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:20:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53627feca49so7311526a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1696256432; x=1696861232; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q5zIgA66kGCbchY/Ojg8H7iySCE0A8qr1NX3eo7f44c=;
        b=1lWWqahTP3gORKGiaZ8FZz7o2kLTESUJjkAIci0gU12uDu/IFMeMlaQLXmeAABy3X+
         Cxo7KXg+aaBZlGGZWjpYvAotclV+xpXuECjAx0bgmlnQFMVb3Sh4jeKjK56c1s6G2W1M
         k4M89kG68EG98Td4xVF39xAOg9ceT3i52CNw6PqcXGs5DX0vOMInmXcZPftADSiTNtqM
         L0Ri8NMboj4J4RtM0EsKAD8skPqGxjgWi0qImLljKBVDsLQ2786l8xiI+T++oYX3ePdm
         v6U8MAr79HPkmIVJLmVxTqZTivCjFBfNG/lNzKrXyrTpP7E2c2UYCTwc17VQ5wZ1uu32
         VbCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696256432; x=1696861232;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5zIgA66kGCbchY/Ojg8H7iySCE0A8qr1NX3eo7f44c=;
        b=TP8qn7xr+0lyrDmQ0mpRyJXOFBoo9OaEc2gJPX4xdyEQa5o0H5YP9n0U/OKpLVDgCE
         SpB50PWAkuHoE0lIPLDlfwVYkMAJpOqF3P1RFezxgtuUjs/IrWOuVRwkuObLEVxc6L8V
         29qwCwjcodjWxUa8IFCI+N92chse3oeHO/GSLVh1bDSPVNK6z7KSQ8159QZw2dGAZpI1
         v6SYhcU9ZWPoLErEbitVrUBkzvFxyXEiWcxsYAYh480yf/YY2FGm/X2p9y0c1IMGlEnx
         ejLUkVEVt51f7weyV3P66f4hyJe3fkM0uDSvLLC6kSN8ZCTTmKZ6nE3Wo2ENpZrifOVp
         3QLA==
X-Gm-Message-State: AOJu0YyQPWoc31pwRGSeQZuigEl1Orxy8A6CBbNOSEGQUuJkyV5Fn1jY
        YGzYTmrBTJB5Sdr4WY4I80jxdA==
X-Google-Smtp-Source: AGHT+IH/w7klNPEPn1wR9ywDnQbRqtXeMxEtpPTO2LVbdWvlh6Z4nUdXEHcA+EM+SbMdTweqx3hP2Q==
X-Received: by 2002:aa7:c24d:0:b0:530:9b94:96e with SMTP id y13-20020aa7c24d000000b005309b94096emr9420553edo.41.1696256432713;
        Mon, 02 Oct 2023 07:20:32 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id w10-20020aa7dcca000000b005309eb7544fsm15583356edu.45.2023.10.02.07.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:20:32 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 02 Oct 2023 16:20:31 +0200
Subject: [PATCH v2 3/3] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable
 venus node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-sc7280-venus-pas-v2-3-bd2408891317@fairphone.com>
References: <20231002-sc7280-venus-pas-v2-0-bd2408891317@fairphone.com>
In-Reply-To: <20231002-sc7280-venus-pas-v2-0-bd2408891317@fairphone.com>
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
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

