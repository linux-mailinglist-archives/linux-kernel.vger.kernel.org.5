Return-Path: <linux-kernel+bounces-73164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7585BE78
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B17E4B267CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C126D1B4;
	Tue, 20 Feb 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hj2iu2OI"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3A66A8D4
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708438575; cv=none; b=gX6M+baBASQqFr1sE5HSIZOdjAp7leM17y3eQwCpQVEs1CqJOhThuPKX91T/XYddFonKL/dzyrTzc4Gdi9kfuSP1gmHuoUEaubMH1fNhIrrZIR4yM5/jrsdelTvbwicCMqy1tzJvCayKm0W82u4YOgD9r1OCy0tKFXAZC2BM0LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708438575; c=relaxed/simple;
	bh=XYlYR8OxpeVvmXC1saF7WHBLyL9BLQ+hAMkfLosneSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D2enBQ59LRe0dDC7aOy2gI2Iwk4l54gw2k9ZRIM3NJdA/J3aKomuK1tkP13bi1qM7zfEPJztxereh1N0pI0CmguuA1eAdxdHkWrFAjooLeFLkOg5vOHgqXuu5asEcZUEUyGas8MKeLkW3cbOWPvl4UvOfZFOQOmeLlZkmcrTDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hj2iu2OI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7390890a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708438572; x=1709043372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbQj3mp7H4OoQYFV5k9dEyhOUiy+Klvn+UhkFhJKrBs=;
        b=Hj2iu2OIduSG+Ol1eB85Wz/LdLR16YTWByWt+PNwSF3ObWaKJ8U2saQBE+Uqq6rT5S
         8mnaGWBUn87fRbD8+hdpY7gI78NStrjG0cKfJSDg4UmmroLlsoRZpx14MHa0t1Kpwgax
         RQIUznVYwFZG5XUIkJVoSbbQk/x61IF6d/Ic+IAKuXPSAF51MAoRUn8ApCxvWn6ApS8v
         tvxCjBMvn8Z8IvnOpM2Trn6S9PW8nUR2rO7LsPv6LQRHMvTAxUarKy39mkoPpBmV7s/S
         SA14tHKfbA9pdEbvMgJn8/EUpWDtSe2CeYqZLAjEb5bB6IxLJdwSdvxNe2kBouBW+w0h
         PwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708438572; x=1709043372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RbQj3mp7H4OoQYFV5k9dEyhOUiy+Klvn+UhkFhJKrBs=;
        b=hCeHPEVQ15PPe2k48hJJwgaIlFiI1UTKtdabwKtAJ0d54Cf2+Cl/oaGg3KInvai7Yf
         RSKFW9aZF3OfZfbdoHgYUvMxjS+cZIcrhVjrPd/eWM4jKUwHlyVer/0cN5YezCf9XBl1
         bLJVJinAfkW6x62p8PobZNdfLuXgncGSYd9ixTnATQbMSo022WBH3nnAycKdpsBj/SN6
         m96aVhhNqBO0Ma4yZpo+2bramVAhq7e9efQVJIovoHAkemEPs+gsgIkL1643ABPSM4iW
         mcEdkkejLCxzqlVtzN6F23TD9Zb8pQqY76MX5rkqJezePmbyglk0WMWyxbgC/pA1g8XI
         kwBw==
X-Forwarded-Encrypted: i=1; AJvYcCU66dDEuD23llbF2XQCC0z//h9syvuzUgylJwgOuLk6ZVypFn8Qr8jJi6E5r6iI0Yv8YRVEkPJjAnK/zj/71PxKmwc51sQoPf+KErDx
X-Gm-Message-State: AOJu0Yze1ikU/iDa8m3hiH8B+uz+1WK33ISYyChR1n4KfC/SK1uOFziC
	4b729Z3k4Pe9qtIz9RTZGflpdN6VdVkA6z2+/bDi+1yCxtzibQTWlmod/zinsCo=
X-Google-Smtp-Source: AGHT+IHeaYqromQKXV63x2GOq8Xdo0svk0QhphX45LfqQuOwsD+jkKSct2kq2scOmWt8xpsXazi0/A==
X-Received: by 2002:a17:906:c786:b0:a3e:58df:fb08 with SMTP id cw6-20020a170906c78600b00a3e58dffb08mr4446053ejb.44.1708438571830;
        Tue, 20 Feb 2024 06:16:11 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id s8-20020a170906500800b00a3de4c7bf00sm3998534ejj.79.2024.02.20.06.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 06:16:11 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 20 Feb 2024 16:15:56 +0200
Subject: [PATCH v4 1/4] dt-bindings: display/msm: Document the DPU for
 X1E80100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-x1e80100-display-v4-1-971afd9de861@linaro.org>
References: <20240220-x1e80100-display-v4-0-971afd9de861@linaro.org>
In-Reply-To: <20240220-x1e80100-display-v4-0-971afd9de861@linaro.org>
To: Rob Clark <robdclark@gmail.com>, 
 Abhinav Kumar <quic_abhinavk@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=915; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=XYlYR8OxpeVvmXC1saF7WHBLyL9BLQ+hAMkfLosneSU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl1LQk1ZxmTIC+nLc576zOYOqSTbjmHVkcJucIE
 Np/wdtyjx6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZdS0JAAKCRAbX0TJAJUV
 VqITD/93oKXwgnE9me64LzCiFkoiYSArvAyT3TMEmLe8Z6uIdjglhQRBvW2mFA+o7YqYNZpmrvd
 MwIPbFFjM7h7Guj9l3SWYfH8oSrGSXhn2a057889KRm5dzXXpwkRpQoNGBINBCe4OXdwjsc7dfn
 buPYkH4ozhc4d6Gv7rm8XKCh7r/JlgK7Ulaako1hytqxER4nN2wi4HcLgm7MikUNDtBY7X05QtY
 bn4royGDRB0VopB0R+etVyig85SY6SxuAiFLQ36tNQepdsEDBhFJOFBzEYi6U1fouwsw1Kih3+O
 e9q90M1PvF1lILaIdRR0Ph6wDr2dNRpY2k9XnKW9XOikimp88wKkshCKc7Hks2kj3nMzCDoyZGs
 U7ib17+L5uB1cvplJ4Jpb/a9XDT2d9nbvLm3/ZVar2d8g8gwhaeUAbVgcT4/UzGfxkwvy9FFIKD
 FgHIuAvvHfyXKiMlsDxK8yz7KQFKE27fYbXCeqZP/Fo7LYh5711mjhfa8/oA9bfjVGWsNlHWc2Y
 zvs9mtTHDc36uWHwGcfmmyRnM/61a40hFfrkrQ+5Q+EOlovSrZnxl1xr5L4zz2zzhCXIyY3jGre
 Hamf0/55fGdQnveT6bmxRnfNzYe6s8mnjuydNWbePer7futL+ssjc/MzLVpg3AThEgi8ZKdg0xM
 cm6TYl7lFEk+i8Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the DPU for Qualcomm X1E80100 platform in the SM8650 schema, as
they are similar.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index a01d15a03317..c4087cc5abbd 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -13,7 +13,9 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    const: qcom,sm8650-dpu
+    enum:
+      - qcom,sm8650-dpu
+      - qcom,x1e80100-dpu
 
   reg:
     items:

-- 
2.34.1


