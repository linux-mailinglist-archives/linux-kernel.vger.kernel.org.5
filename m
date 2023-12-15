Return-Path: <linux-kernel+bounces-818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F53B81469B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FFECB239A1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67BA2E3F9;
	Fri, 15 Dec 2023 11:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxyGxn9b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AC2C6A9
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3360ae2392eso377311f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702638956; x=1703243756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wj6vTmlRSd1bu8+W9TkZBmaTAnAxkW+/q7AbzNoNfA0=;
        b=cxyGxn9bm8dIS3ozXtUZTyrGNpqbCZkWlhFDEmqAjugAa3Q3BacwRCYRLfkTsdlWmG
         Tz7EzpifCioAqQqEWuStKijgTec1X85WAgi2Igccwco3nux1Znk3iCL9HmVGDD10hZP0
         7jXwgEgAmlUJ8O1S8E+9KXFhXICm7bUjwWL8zUCOUcSWyTgrAU9eedBGRpHH/l54V4dl
         n9kpZ3IsqzzEWijFhNFVn1MPvCdQQT8Qi9+0Wuad/Nq5hls+z9zIFJqK2GAwneKZLeiA
         9bCmhrNtVQm4JqIRMiADw3moiHtUq/eura0Bvk5hM+CnOHsZENHe+rSVf2GnJw44Exd+
         ZhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702638956; x=1703243756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wj6vTmlRSd1bu8+W9TkZBmaTAnAxkW+/q7AbzNoNfA0=;
        b=XJ6pmwY0ymm/c21lkrxVCOQ0F/Zgwmq2ky97YYNzJcKuaJxrCKwr2w9H4sfnz62gXm
         EgDjK1O7DsHnvRa/YKCiIHgTwkWcaal80fRTpXuz7CiEb7yX5kC6firRVPCxLbaA16YK
         yvNgLD463hP/PKnWwF5M1lWcM7s9mPOuzOMYECL5KxnEQEMNxqmkpMCMSB5jgfwdkt3c
         0IQwxsX58jCtFnVraBLHfapTyMooib0Ny1KWttmCtxxLJqB6ztH1I+erA6CAWZ5dl5Lx
         km58GoztgxVIXgCHq4fzI+F31dZEt+VVnG4YWw6//M9fspsR49v9Cw9JCH/ZFXCk4X2w
         ZMlQ==
X-Gm-Message-State: AOJu0YyHagEPJfK3NiBHm9iNVDkd0i5J2Z7V1x4LeK+lZczDwdfB2lam
	Ft4t7ynimTgIJlVJxa19YFFn3A==
X-Google-Smtp-Source: AGHT+IHka+ZRTmAvdw2RUKECCNVsM86VMh14Z2k+zoWvpI2YMUk++gbe6RFNRCCOFsPLwxCbXybJvQ==
X-Received: by 2002:a05:6000:147:b0:333:38bb:f8bc with SMTP id r7-20020a056000014700b0033338bbf8bcmr5884686wrx.102.1702638955879;
        Fri, 15 Dec 2023 03:15:55 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g13-20020a056000118d00b003333d46a9e8sm18511497wrx.56.2023.12.15.03.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:15:54 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Patrick Delaunay <patrick.delaunay@foss.st.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 09/10] dt-bindings: nvmem: add new stm32mp25 compatible for stm32-romem
Date: Fri, 15 Dec 2023 11:15:35 +0000
Message-Id: <20231215111536.316972-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
References: <20231215111536.316972-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=835; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=uFrn3U3yuiQtXighYC3u5r+C5PUPeLGELEDLZIYljOg=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBlfDVYDLx9/HVM7ZtbN6hbLYzrrMgdVZXw67uHK BjRvp4c0OmJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZXw1WAAKCRB6of1ZxzRV N9N4CACOa471I/UZVFYooW+x2TUmGjdN4GFFlg2kWlHgriCC+GbriAX/PqQ3JjZQ2wlJxwngoZT mdhri2sxg7D4UmLFxhAwolvJz0wC4Pty9DyQDo4ceekju8djqZLMuN59H0FDdaP7Lz1ltNOWDSh EUaXsEisVCKI53qA/MFTJZh0r3AViZmY9avxtyqAZRfNpmf86tdrtc6kHMbGYeIHW6zUxcHW+v9 IMfPG1hTAICG4GDpRR3uC3Wnq/W1C5RBNEO/K3GO59C09gXlpDtOnZUIrDruBy+gXboco1ECIEf +wIktzKEv6LAHEtaR/XiyoV1caYw9wpCbCB8MKG6tjJTMvnN
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Patrick Delaunay <patrick.delaunay@foss.st.com>

Add a new compatible for stm32mp25 support.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
index a69de3e92282..92bfe25f0571 100644
--- a/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/st,stm32-romem.yaml
@@ -24,6 +24,7 @@ properties:
       - st,stm32f4-otp
       - st,stm32mp13-bsec
       - st,stm32mp15-bsec
+      - st,stm32mp25-bsec
 
   reg:
     maxItems: 1
-- 
2.25.1


