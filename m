Return-Path: <linux-kernel+bounces-112702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32784887D26
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C769B1F21337
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4679618042;
	Sun, 24 Mar 2024 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLkoh3VC"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CDCA64;
	Sun, 24 Mar 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711289044; cv=none; b=faHXeCbQ9nFcFV2DjrlrRqhKLg+0xlvU4NTt6TMgcTK3pkNpWK1xzgJ3VcKuHXiXXvxgXca+Q4XrCcgRdQH3L23D1vrmB8Ooy++VCULMIF+faNtK3khgE2wM0/CG0iqugM37w4dOXcUxmpLf+5P+gHBTOxlhDStbWUiuHDg9c/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711289044; c=relaxed/simple;
	bh=kJRfWCwbgqvjO4Vm2t7TCC4claVvZRzQjDXCa+/fYvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NfQc9ZBtGcfrEnUR2JQANEQcl10fzYZ9xtZzJ/W7VrZ1AgVitpnO+3IIPgR1KtagLmn+wjpP42s4Y5Wds4Cv23qzfdCJRjJaFl5DwoepLUXRbEVxDlf9TbrO1hX2jqx3CDgZScbeO7Uy03QPUxYe1Fsoh9Vzu/Iixhc85ahuALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLkoh3VC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c0521a636so701367a12.0;
        Sun, 24 Mar 2024 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711289041; x=1711893841; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ce9XlLUsIx5Oz+wYKryfp3VqLagYvAPoszk7DGEM1Y=;
        b=iLkoh3VCoejvFy3IuOgwPs5a1qmq5GwHS2rGL4/TzcFGmjN5HRsG7rYypumrET/jKn
         hJ9EDahUQfVGhT/y4t0HeTP0X7Bg/tKO5mCPYSXex7XmhhdkVEcucDiuufCGqD/vS7dW
         NRwtL5dXfYMOdgeMZNWLg1fOFYUCYrAD26EkR1VFnAW+FLZK5T/90tSA3p49y30lhUnz
         d/HfEFn/R7Fe1eBI6fBRGINV2Ie364tiv+XJDJudAA7jmD474PWN0+kQi4XbTNEAjMuG
         wb9uuZ1IaFxwgLxHb9zIopDXR1+pwL07lN8MERobGuMGVE9IZdmGs4cRalZ+jEv0NFcQ
         F4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711289041; x=1711893841;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ce9XlLUsIx5Oz+wYKryfp3VqLagYvAPoszk7DGEM1Y=;
        b=oTYtt/iythGM/pbMinTXjfKGPuUOjMG2KAwQjRveZUj9DOGP9Ikdp21AJR07bhEtie
         JnCcJmcCZLlWm216PVA5qPPWGEvdahUgjbvFStuJikxZSKIldbV6kEgNZkoxJl3ozbT5
         RGt5wT6bKDpLoUrWMP1spE56pjEKDcK0PQXBwVwQg6F+1gxaNSRgYyWOZW/HCn7NI2Ni
         MTWa9DBMWHk9427MhS0qfGgUxl42tKuw04y38tL+1xVF07V74j8UJMw8X9qCEAXfYLuZ
         CgBRR2tYJkb2RzWQsmM0xdrv1e6LCMIWrSdlHsy9G24HLKEn84Ts/F8lfZ0+fYOFJaZ2
         +kOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp1eew6M90p8TUJs0D4XdbTWVGmHYbPa+GYz8wiwd8aMHsyF7VKFpMw3zdWSfHxGJ4Hwbu3piAV4xvlcL7TI6vY+4RZu87oY6vTmj4ECWcs9gbxfc8uyexMssiUD6Kx1Sln48RPK7PSyvjAfJ4DlPzAue16508t/Ae1FFlKf4lozSNydx/
X-Gm-Message-State: AOJu0Yw43T7WW2fxaI6iKeIkOFGLkRzKUgrVWu9tVaEaV2cktLSshq2p
	iv2qiDaOVPRjMFiGug8mr+0hrASX4eIDvkArQhufz/Q8JUYO1VN+
X-Google-Smtp-Source: AGHT+IH+nFMX4APDditc9PHbYG8iUth7ciKyGIvhXdddb+ikkbg3Y4T/kx6knqqBPfAdvUcTUD4Kcg==
X-Received: by 2002:a50:d51b:0:b0:567:29d9:99ae with SMTP id u27-20020a50d51b000000b0056729d999aemr2993359edi.28.1711289041098;
        Sun, 24 Mar 2024 07:04:01 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id s19-20020a056402521300b00568d5e737b0sm1916137edd.57.2024.03.24.07.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 07:04:00 -0700 (PDT)
Date: Sun, 24 Mar 2024 15:03:59 +0100
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: arm: qcom: Add Motorola Moto G (2013)
Message-ID: <f5d4d71cd59f25b80889ef88fa044aa3a4268d46.1711288736.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Document the Motorola Moto G (2013), which is a smartphone based
on the Qualcomm MSM8226 SoC.

Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 66beaac60e1d..d2910982ae86 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -137,6 +137,7 @@ properties:
               - microsoft,dempsey
               - microsoft,makepeace
               - microsoft,moneypenny
+              - motorola,falcon
               - samsung,s3ve3g
           - const: qcom,msm8226
 
-- 
2.34.1


