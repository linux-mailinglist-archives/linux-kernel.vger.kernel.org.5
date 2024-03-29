Return-Path: <linux-kernel+bounces-124259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD56D89147F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0E51C2334D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5508144364;
	Fri, 29 Mar 2024 07:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="fcPsTL2u"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B540BE4
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698361; cv=none; b=DkTjw4A0wp3ZupyCF8COmlo56pTnVi8DOwSt4Gb1IlZzDw4QNEZGtgpLpOLbLd6JNEdeQaYe4D7GZLO5qYpjyJugsjXHLpUQGOjls8CGYTi+323lcL1Lt5HIKz57dmVNApG9jv9PotDB33dc1Q1GDwoHYctmE6WJ41PVLhbDWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698361; c=relaxed/simple;
	bh=25Qs8m6volBcpFuS55c6sWHasm9Na16Ss/X8GJM+fYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MAXCxEgDQ6qqdS4/puVL8f0sEomyfWZVwST0dBFBr/O3xjIDuUWHhb/QcvEoQBpyzoKOdK8OX+4IDubn2v4ItKpAUVD3SrZN6FbNeOlCGHbtBySKknNs26mkDUfjyYoNd4auk1dqxNTkU78HQt1u+GjczgMtqCDk0rcLdu4/p/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=fcPsTL2u; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513dc9d6938so2099238e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1711698358; x=1712303158; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4McqOYY3UTRJyQ2CjaqCL8nyfMiP9YKrs8lnA2q8yiE=;
        b=fcPsTL2uKOBwHe5Qt1Q3CRLPsaY+jd4DOQC2CZIUK/52r0E78rkCH1FsonjFNj0a8s
         LeTTx9CifDc7ndQRbR8F3Di6st1w3RUYUZzMz3HL7Iaf3cbQNn9KHF3AuZ7bVCCTHa8O
         QeygeGBxeroImGDK9g+YHPLuSMrAcGblmiZeHd5y0I4C5Sp14CRVtFdcZw18c0n32fSX
         CjdQTGBKWZKA78gOLoYnTDA2xCkmn2HF5BQQq1rjd8cQyHOUh73wnoTzHqErD/pzK512
         6BvES/m7wS//9RSsRb0ZxiLz0f+2/D+gmncGPDd/qZLMUx6YIrZGIU9Owv05UHx+STdm
         YjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711698358; x=1712303158;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4McqOYY3UTRJyQ2CjaqCL8nyfMiP9YKrs8lnA2q8yiE=;
        b=fTNjZNhP2LSaPm5GkQLzMSc5nSLUDnop7pHfGKjGWZv+1VDBHDDOGmDjtzyapv0/80
         i+3yhkyNS115XyxmL7vTB4G4juTQhvw1zXB3t4+TkPJO9n3vuO64WmV9Hlqrih1nQdyY
         R8Dr6YOIvU9UTs6jK5xgKGFRuUXwgXMiXTUqcrApPWYFouHlL13sm+mm7j55g64TIaZl
         2Yz7OEMX51EPuPnklY4PBVZKR9vf7io6gqPKGbz3Lb3Q+gvpqmeDxMHPYnoJN8kUiNPF
         4ldUCkb3JJCAvRSphnvS+1N3BcEU7kFi/1NCCrelPJgDrf9L/LksKAiEf3aww8gVCsHo
         +c0A==
X-Forwarded-Encrypted: i=1; AJvYcCUbmSEUVUN7WhFSmhgS7V/SnmrMIZkwhB4vk37G8EhW4sghZBYRuPhd4p00eHQiJO5Xv4UcwHKkKcLgIpaHcar2t+Os3O+k9SPAXJH4
X-Gm-Message-State: AOJu0Yw0x/8BxjzQ9NC3P5Cl9FwhgLdYTCltM5awAZGyiiO+taedzKLY
	MX9RT+y5kNDrqHPbn5ZIf8oav0tkhM6j9rPC50ABs5Dnw4WxLICfTUpMZCgb6Aw=
X-Google-Smtp-Source: AGHT+IGr9SjS2/x9Bg3Cg9sAk0T6zHFzcOeMV4fzLJHUxJzzp46Etz1DP0Mivc1g9nSdBVgZiLJLTg==
X-Received: by 2002:a19:2d06:0:b0:513:d8e3:fe3d with SMTP id k6-20020a192d06000000b00513d8e3fe3dmr976784lfj.26.1711698358274;
        Fri, 29 Mar 2024 00:45:58 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b00a4e24d259edsm1382737ejh.167.2024.03.29.00.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:45:57 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 29 Mar 2024 08:45:55 +0100
Subject: [PATCH v2 2/3] dt-bindings: display: msm: sm6350-mdss: document DP
 controller subnode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-sm6350-dp-v2-2-e46dceb32ef5@fairphone.com>
References: <20240329-sm6350-dp-v2-0-e46dceb32ef5@fairphone.com>
In-Reply-To: <20240329-sm6350-dp-v2-0-e46dceb32ef5@fairphone.com>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0

Document the displayport controller subnode of the SM6350 MDSS.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
index c9ba1fae8042..bba666bdffe5 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6350-mdss.yaml
@@ -53,6 +53,15 @@ patternProperties:
       compatible:
         const: qcom,sm6350-dpu
 
+  "^displayport-controller@[0-9a-f]+$":
+    type: object
+    additionalProperties: true
+
+    properties:
+      compatible:
+        contains:
+          const: qcom,sm6350-dp
+
   "^dsi@[0-9a-f]+$":
     type: object
     additionalProperties: true

-- 
2.44.0


