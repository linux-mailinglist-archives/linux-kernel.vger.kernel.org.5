Return-Path: <linux-kernel+bounces-122706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBEF88FBDB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F8AEB239B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E6273528;
	Thu, 28 Mar 2024 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="fVJnpFSV"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D5264CE9
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618985; cv=none; b=AtAuKMnrcCdL+xwVCjLVgWX/n5QFbZAD4HnFGHPuUm1KrmXLq0KVFFXJgFVnLto1V3IFx8g5xB4Xpj4sGBkCbnIrHC1Yw9wLKo6H6Mlf+l2nYp4zlxxx+a7sD8VPExnk8brCqNjWpJhcBSslXqz2GEOkvNgT1AVaXWGPswi6VZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618985; c=relaxed/simple;
	bh=DOZ+RwVEHFidaYx+4BjcY1d1DFBraPgTKyKRArfhhss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svg3ZF/XaD+nyhcwR/ls/DV8f8NFsINTnYELSK5NcLmzd5boGETXeh6jV5Vh/PzNtuGmQ9G+mIY9AnCIQCIVMraZnn+KqTboQX9T8l4OdyW9mdBMSs+w4IuMklXppOBhWg54PcDonYAHURzbRA70lbD+oiQziCuMt2mXVLBDooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=fVJnpFSV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56c0a249bacso903325a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1711618982; x=1712223782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pkS0hnNrFDbXHrlcoNspnOJj4NSYX03NbGI5xXPUHvo=;
        b=fVJnpFSVukAgC/kkTfD3FZb1owgk/nUJ67au5y4QwhzZ5CAP3TmUW33U3HPRt872hd
         bqMmMpNHEhuYnh924A5LWiVXOb7aQkK4agYYMjOF82c1smo5J5ncwYu1YTFy+PDO9esy
         7kPoh9zFGPX0VfMhWgmeMn7fzoc6VD37hHetBWEa/QFIf5IIXIl1xFD8rUn1SZQQ3ojc
         PuoEgIVLynUw8lYANLaCaJa2cvZbOoF+jFTg6L7jgGGmV1QrN/LF9M1wxz1j8BTScWYB
         Zr5qyxT2OoGWIZ0rl9LszGpgkZcLp8bPhl1sYz4gU6fi4u5mns+6ags87vjV4tDWx65X
         uchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711618982; x=1712223782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkS0hnNrFDbXHrlcoNspnOJj4NSYX03NbGI5xXPUHvo=;
        b=TCSu8wfhD4u+/LttfuTrLBacVWr9l/vuqKVwGD2SgWGA3ekjwkGBNfwyMsbGO24jTu
         2v2rtHMbTN4hX2/IP27vpnbuiGitD6RYrFVq2Jtf7LoPImN5k+eaMwvUaTlxO0xO8/yU
         jWCiGX6ppeAHpe6+L4/kQpgfA4Rd1uKG0lhPV8Uv/uU0vOFVoXKDi22mRy+mmpDUM6YE
         fUfhf1af8KKi60StjcUqT2FYeOboQaTNraQl4mRL5t915rlBOj0XtYLJNXWflNp8DXmc
         HNdsmVewwpyFlRUr6zH/BiI4qh+SoolUoLiYGk/UX36Fnm1uI9tXNfcoEyIkVu7GIZtf
         BolA==
X-Forwarded-Encrypted: i=1; AJvYcCU2zhL6gN1Fr+YxEXyZtSl3gZUOkwklbDIAtbA+uLbEm0Zfg26CIF1e2g9BJTDF+wSRkza8Ob292RSBkQdeMp7a8CUmE7GTdnytK4XE
X-Gm-Message-State: AOJu0Yxw0j1yXJxjn4Z+duSNks8iRL2zYyJ012CNzQ8vBxz/DrSJGGoq
	sZOmGHPHC0nLz3Nle50PDwX25JXEM2uDTwTDkrNRck93VYiO9YNQ41dFBZEiui0=
X-Google-Smtp-Source: AGHT+IEWpqXuFzJjsC1M/sOHK3zZOE84F5IxzcbN5OkAPk4DTWHSoyiO2rVY9a6j5rj0JVACU4kHSA==
X-Received: by 2002:a50:cdc2:0:b0:566:ab45:e6c5 with SMTP id h2-20020a50cdc2000000b00566ab45e6c5mr1772674edj.28.1711618982129;
        Thu, 28 Mar 2024 02:43:02 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id l2-20020aa7c302000000b005645961ad39sm631362edq.47.2024.03.28.02.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 02:43:01 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 28 Mar 2024 10:42:44 +0100
Subject: [PATCH 1/3] dt-bindings: display: msm: dp-controller: document
 SM8250 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-sm6350-dp-v1-1-215ca2b81c35@fairphone.com>
References: <20240328-sm6350-dp-v1-0-215ca2b81c35@fairphone.com>
In-Reply-To: <20240328-sm6350-dp-v1-0-215ca2b81c35@fairphone.com>
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

Add the compatible string for the DisplayPort controller on SM6350 which
is compatible with the one on SM8350.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index ae53cbfb2193..97993feda193 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,sm8650-dp
       - items:
           - enum:
+              - qcom,sm6350-dp
               - qcom,sm8150-dp
               - qcom,sm8250-dp
               - qcom,sm8450-dp

-- 
2.44.0


