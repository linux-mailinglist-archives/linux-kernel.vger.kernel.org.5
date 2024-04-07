Return-Path: <linux-kernel+bounces-134290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E98789AFF6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 11:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA0A31C203DA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 09:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B4324B33;
	Sun,  7 Apr 2024 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGyLIzZX"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3DA25605;
	Sun,  7 Apr 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712480716; cv=none; b=ML8/AqvmZlmCNKUBQ6+lRcbEbjhMPuMCJr8E3SByrXxYuCm08qeP4WDE/tOyvBV1V3BsmigtVj0Y5R8vNsBhDWYSpeuNeutMZly0BkIV4laUOPv3NAaTms3iHbyvgQuLIoxnXNZE9Kn/kJQfzigNRagIu8vjrQHDCy7JygWdfqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712480716; c=relaxed/simple;
	bh=T/t51JGXpD0fuvl8+chSNW3C31fIsTrLP6DTVv85bPY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SHqZ5oVZmQQw5AkVPvWf7sufpp2lls/7B3SQ2sPjxa8whwcmzSMmx+XYfpm8HVqzrmmLk5QwgEN2b0k19uDzKOaf5wSMieU1FvZ2kgVke/lU0+E4Hbw/ApdA92nipZYNMr5J57DId7ASeNyLj17jxrya0TYM+hxYNrK63BqCxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGyLIzZX; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d82713f473so59857981fa.3;
        Sun, 07 Apr 2024 02:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712480712; x=1713085512; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8G+rV0x749m2N6zouKipiE4KRePdWsDRuNApiIyhjU=;
        b=FGyLIzZXSCgN3Crmxnu+DNLZv4EeaJo+ZUNzCMD6petUiijbfLbXgyMH+9RV7g2CYW
         r4U2xFlg17qK25bOlzte9ONo4Tuhm4/sTPrCuVIG5A0w4TidhQH+FdaOmfQOgGuusv6i
         0r5H0P4mwqtVPIv3F6X7dOSYnAvqqsIbQBSjTOPXhmqaN0RMWW6AJ8SdmxJwgp7uc9of
         IxNp8JSVTJRYMof2bKl8Q2UKVSCnonVNKPEsM39eUyWZhEaMUnS5v2WqqQc406AFvdIB
         dR+mDYOX6QSbEIdP7ZQcJrQ+Xsq4AVhyEcwc2cy18OEDpHs75VjsGLFBUoeuYJBEbhEG
         qPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712480712; x=1713085512;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8G+rV0x749m2N6zouKipiE4KRePdWsDRuNApiIyhjU=;
        b=RhFyW/Ka8ypQ9ZHPAPy3TgSPaYjePR7+NfYM/gnPWs8QXeG3qqk74uW3Wc1LeHG+BT
         7QW71cmyucpF8oxwDEyjUIoAO3aD0tSEcpb7rNRYwFchoS56vAPBsL+z//WVYv4SzkdP
         YvZBRQV7YLerDNSkU0iJlXJFdHo3HM92bpTph7H8jqoyjL2pPvJ5/JbzluRSvII3q8lp
         udIw/pXpFWRX/ztboE/eLbpwp3iZ0NccJ+RM9EaReKw53BxWj75huca5Lk+W55LAZysz
         pXYaMxf4QDEuXZzELZxT26bWYYMezwg7DjHdiJ/pxtIEtigeGdOciVlh3jdHRB59HT/1
         nxow==
X-Forwarded-Encrypted: i=1; AJvYcCW07HqqLqVUI/EVuQTUmIULUpMfcpjhJCJHxzshDX2nVmx5Otr4FG1IOVFhyEnMPVBxc7gNamMt7PemzRAXaAYBE6Q8uk87i/JqnZ7lW2YXhj/WDz/0cUXuiDd36FIG9GbDIwYBDdnrgZ7ALD+05DoKtn2Z18v7X8Hw+jlgohFQJEvmRy7a
X-Gm-Message-State: AOJu0YwRfWqMsjveqUjfMfKSSEZXbAFuBoRNFJDRhXKdvnHFaRbK4/xw
	uob+adwynAN8rHGUSou891IOqi9NdRMu2nA0q9Wz10OQPG3ABbjkXB/Ddfo/
X-Google-Smtp-Source: AGHT+IEfkrFmkI3a8ZU8PI/MDIccfCLffQW0RgcK9+kZmYle7tpvm+I9PWStlGfZwx3/2SojeD9itQ==
X-Received: by 2002:a2e:b0ca:0:b0:2d8:6fc4:d0b5 with SMTP id g10-20020a2eb0ca000000b002d86fc4d0b5mr4311433ljl.8.1712480712262;
        Sun, 07 Apr 2024 02:05:12 -0700 (PDT)
Received: from standask-GA-A55M-S2HP (lu-nat-113-247.ehs.sk. [188.123.113.247])
        by smtp.gmail.com with ESMTPSA id el4-20020a170907284400b00a51b3410e46sm1924565ejc.7.2024.04.07.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 02:05:12 -0700 (PDT)
Date: Sun, 7 Apr 2024 11:05:10 +0200
From: Stanislav Jakubek <stano.jakubek@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: arm: qcom: Add Motorola Moto G (2013)
Message-ID: <32c507337ab80c550fb1df08f7014d1e31eb4c32.1712480582.git.stano.jakubek@gmail.com>
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
---
Changes in V3:
  - no changes

Changes in V2:
  - collect Krzysztof's A-b

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


