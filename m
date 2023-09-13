Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6323779ECE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjIMP3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjIMP2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:28:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2B1FF7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:28:49 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso78971635e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694618928; x=1695223728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWXo5chhD5Q8zfXo4/pVSr8fA6rgWTQ7OZCsmmyvZ+U=;
        b=beZoMnKS0MSopOSGjY5SkpDxz/1aMOYtMP8TIqV8c8uhmPazmJWgs7/EDlNcDP9ZDx
         dNUpNfQ6kLQSkieErjLj8ph6H8rzYqwxshxA8idDLhuTc7TCaXZTwWPGAxUCOJfnh3LT
         Ksim/krJodXEE2Ao8BydKvOJEP+Nhz8SV1H7/oYvOXEcdJSduaTo9yqE0ziEiyhTob/g
         QrYYeJfMb/fBnNR1CmPKUfVo9Usc7ceGmtlfBgIwQuZ/9j5WABQmBoHLgp8GfKWNkyoj
         QGr5PuauNjSFd7MQxqkoJxTRP7eiw/gItlHwiDv3ZW/AumYVIn32TxsmjIlD4yhRjctL
         a89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694618928; x=1695223728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWXo5chhD5Q8zfXo4/pVSr8fA6rgWTQ7OZCsmmyvZ+U=;
        b=qAv8FlK6/5ffbvOFd1e2Fbpruxu7PhPpDwDcVEpQRXkjO104caWAdxlfjMHopw3Nlw
         RZ6BwmkxViP0fEGflr/Qrcq9FAaCgX3c/1XzkiBzxXDXoWcuc5UkY1lgiZ6Ftys6UNgK
         H5pPkbXlQlynjJAl0I73R3ibcrNCHtjexrt/5ocrXau/5udJWt8QQcacDG1wXMM068Wz
         BW52k3HgM8bCCcpmRCQ7LzxrcC/ECk3OmgIr6RfmMi0G8GpAhZs1G/GjyhGQk7yRiMkU
         L9ASkPMK3PbbrM+wvSYAhxFgH7IB3HlC/4SCHNVMdxbnSmIdH8AAeUDXzGeHW0U55tL3
         47uQ==
X-Gm-Message-State: AOJu0YynL2eVe7O0wIqVFNjKRWJ0tyUbsWBKOZFdVbqxqyxAam8EJ6PU
        s/1fMA/j1jB2tLmc357yGU0yXmPsIRmgdRqqphZG1g==
X-Google-Smtp-Source: AGHT+IEl11EKMfk5wSAmJ6oOzj+vGlYX5Osa7YOjrMlFE/PamB93QQH5/Vm/y33QO0yOFWOVhVzI0A==
X-Received: by 2002:a05:6000:12d2:b0:31f:bdfd:5d30 with SMTP id l18-20020a05600012d200b0031fbdfd5d30mr2476573wrx.57.1694618928027;
        Wed, 13 Sep 2023 08:28:48 -0700 (PDT)
Received: from [10.167.154.1] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id a11-20020aa7d74b000000b0052a404e5929sm7391979eds.66.2023.09.13.08.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 08:28:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 13 Sep 2023 17:28:43 +0200
Subject: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Mitsumi Electric
 Co., Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v3-1-781da361ec60@linaro.org>
References: <20230621-topic-mm8013-v3-0-781da361ec60@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v3-0-781da361ec60@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694618924; l=1125;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=A4edAPC9JkBqokj8iLNvPGCrxmBfeXMUhLTyoYd19k8=;
 b=MZZTMWp/pnsC9RA4uTSiS1T0IUZR1TpSBUDNNCUmPeUI6H5w6C5cNgBUVRXJ4pU1lcLSfsIto
 Z3ye7OWXVQODysPmLFA45rchPF7iT0WsBI92FZxSYXNlcIoY/vYh/Vz
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mitsumi was [1] a Japanese company making various electronics devices
and components. They've merged into a new entity, MinebeaMitsumi in 2017.

Their current main page is available at [2]

[1] https://en.wikipedia.org/wiki/Mitsumi_Electric
[2] https://product.minebeamitsumi.com/en/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 573578db9509..565b13fb429d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -871,6 +871,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mitsumi,.*":
+    description: Mitsumi Electric Co., Ltd.
   "^mixel,.*":
     description: Mixel, Inc.
   "^miyoo,.*":

-- 
2.42.0

