Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA7B7DB6D3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 10:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjJ3J4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjJ3Jz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 05:55:59 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E60110F2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:55:26 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso59223351fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 02:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698659724; x=1699264524; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r02XzfMz7t5m8e/QRtdWGgeVrD98wGj55swdSf9w36Y=;
        b=pkMhWuN83g9LGzhb/dYl95jAnZhqj0p8mRmJ2euwrCYydNTSLMhFt12n2cq7MJsqxH
         kNfqRCEpWehBEiD8iee7ggGYME9LRRU3BpyTwLslPzR/SErLAQFbjo+yE6IhRK8ZC0hB
         1pF7zJVpoKUnkMSZPFtGyTIR34s7gl1ziTrzaZ3R4YZO9MJhb3Qd45DCaw/Zxkcoduow
         myyiD4GNo2uwiZsFMmTM/ljNNre7FdZr1MAjBC4AEe0sNZnpkbLDF/5GUYoHdmU0IxxQ
         pOThf6mIy+ZeZyeZy/WZC3xnAE43Wt08GFBy0PlUVByBASSx4HbfekINa1hhnW14bcsz
         sbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698659724; x=1699264524;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r02XzfMz7t5m8e/QRtdWGgeVrD98wGj55swdSf9w36Y=;
        b=dQks3a17pFu0XvB5HZ4OxLrNw0YWqBbudpaJyAup1SbebcqQXgQjOgEwpC3erqPWIw
         aV0QtpIkQ0hAV5j0JLfzvHtDbrZfb9XOtsH0h29ERj7/Z/Xl4nBQJKUMlWDLKbl+v024
         bWCj4mldvVsbuSRRxG+CN4JFl82xbgEQfQs6KsZxCfCe7ALXDmrRpQiPNV1sAhdCmFWf
         +h42T8aacEuJfb8SFXT/Zj6svbSxza/3vAjLVNswvBRrbHM+9vThaMPCy36foip/+Nty
         zmzUjmTtG6Wfx3NgFKy6kq+7GtEch5+KJH+dKlDtfqTAktJ69tcAD1gkGlnnRjzi4TZK
         I3WQ==
X-Gm-Message-State: AOJu0Yy3vuI7Uv4QgBdWGauyaEXrhOubS2sK/eWXvVPJmqE6UD65RKZ6
        fiqe7lJIT0ztyCqrZMhLYMsknQ==
X-Google-Smtp-Source: AGHT+IEkEpDmYJs6Z8Wt0rHwSJrdFdEaJDmZTHR7XwDAdZ6Ce1flzbaMZjxTyrIGw3eeVeKucltswA==
X-Received: by 2002:a05:651c:1a28:b0:2bf:fd6c:ddfc with SMTP id by40-20020a05651c1a2800b002bffd6cddfcmr8610897ljb.45.1698659724296;
        Mon, 30 Oct 2023 02:55:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id m11-20020a05600c4f4b00b0040651505684sm8783759wmq.29.2023.10.30.02.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:55:23 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 30 Oct 2023 10:55:19 +0100
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom,ids: Add SoC ID for SM8650
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-topic-sm8650-upstream-socinfo-v2-1-4751e7391dc9@linaro.org>
References: <20231030-topic-sm8650-upstream-socinfo-v2-0-4751e7391dc9@linaro.org>
In-Reply-To: <20231030-topic-sm8650-upstream-socinfo-v2-0-4751e7391dc9@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=654;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=fnpn3bO+mHDBdWe7hBx2DnPQoU2QixJH3axFkhU5t/I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlP32J0cgFvT5edU1gGd2Vb4t8Rs0PsEeniABZ72O/
 8hwG1xGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZT99iQAKCRB33NvayMhJ0ZyLD/
 9KUgAgxRAi4MiaVjbWGHC/PfhHxaGxkHuLGSYMtIHilvS8wR14lRCRWxXXkSsJcoL/5y8un4BVtBF/
 Y2ThpMoELJQB6YJGLb5AuieBRLPzwpArcHlhy7c2ZdN+Lg5+JPY+SSeim9537vQyN6B7I8D+huhKC2
 Icgb4o2I3CUMgdTDxjtFxQ2Rd7iG6Qg/paJ2F4mU5+SBPBPANgakpBbqfkee334rcoPQxc/EUFD3uz
 Z2R42t54cDxKM03rOUQpRaU5nczo46kPstDocteOcmtftukcQrpSD3MKVwvVQr9Qhgj1jjZ1ilPvzU
 71o6N6h/6WNcWU9nH7iDQpTxdUh+qGME4SJZWtHY8beJjWiqLaA9VVAd5V8ax0iobMQxmfM9HG+CMu
 Q0HSUupm509bePddWgWbBs7NiwqJ+nfHate+vaCCmr2fsZJlbllhWXHfZjqFX0v4KBWx4b9ejNIJRt
 VRvVv4JkltQJ7rfDMUZqftgkHqEE+eogqlakMBmfz/Q1WYOoF6DpJkk7ji0MC5uKegSDPH8fjYl1iO
 gZ7WpsFkuelhN1pnWj25nDmq9Q8VxeKmHxxxgs9mjCf2dw25QZOlFinMGWMq2J2bAkdd2FzdSlbpSX
 zFMxPH4NNCxSiZr+bru93mjm1xKtzikoCBCgszKonZIdnErng/d/Ofxndw/A==
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

Add the ID for the Qualcomm SM8650 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index f7248348a459..51e0f6059410 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -255,6 +255,7 @@
 #define QCOM_ID_SA8775P			534
 #define QCOM_ID_QRU1000			539
 #define QCOM_ID_QDU1000			545
+#define QCOM_ID_SM8650			557
 #define QCOM_ID_SM4450			568
 #define QCOM_ID_QDU1010			587
 #define QCOM_ID_QRU1032			588

-- 
2.34.1

