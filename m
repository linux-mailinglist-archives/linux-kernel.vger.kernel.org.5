Return-Path: <linux-kernel+bounces-134333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBF389B06E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A45191F2118F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737151B7E4;
	Sun,  7 Apr 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tJp0k+yC"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237491EB30
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712485741; cv=none; b=kHo9BdmArhvHE372agslnSEReQ+SWiSkuJ2mTHzTYNNlvsFKzsvsJ/IOFqeD8c7r52muQHrDZ0NM3FZ/v5RjzQa09ZSi5e7Hj50SsdQUik6JjxFVTWoqu4n2bBZq11E1L+0rwJoEijPf9H+AFoAWz1Zj88PImFaVzsmIEgFYYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712485741; c=relaxed/simple;
	bh=I5VfWiu6ZDLhwRBYVmmcKI/4Wf6DyoHtVj8HRjhNeBs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BdgzXNFXLnSVlIpycWUTNxWZcGdpb4eNWnI/BlboKVOIwURIS1fzcQc4PMlmVxN073VtmhR9aFh4n33Q1IilNunMncp3czZp+NSrNurjMMTWzfKKNhULBBENdsKxqbQIMhAK6++fsqaL+rXBJOCRn7BtuufB1AY/ksylZggsqSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tJp0k+yC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41663330f9dso802695e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 03:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712485738; x=1713090538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2qX1t41u1T9MwLzZAGHfGyEjQdDcaTPM4SrGSAT2KI=;
        b=tJp0k+yCJxejA+L/osl24UhWF+5KKBLA9QSHPLA9u0XFgqGs8IoOhIni0n7khc7ePL
         eA3w5e1NU0ca1+rTl5uK00LCYv5bQ6ZeFOk2Xxo9yo0DvaN/zr2PUAGnTQVZfdMv+FaT
         qktoSHUDbMVCYRGs/V9G+iGcLWXGKAUrpP2v3zuT559cAPnJjLgiLueJvXKaurXlqKwa
         G0STorzYph0jzlQgHc2g5qoP0wP3TDCvUK6ekkEtc2lVgSb9h5k58s61eo+EVFuMNLmQ
         Lpzea9o7awfCOYS0wSdxzIgImH9zltjs/sTkZK+RFmrwjseQmApALpBFhot2ZGK77xb6
         avfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712485738; x=1713090538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2qX1t41u1T9MwLzZAGHfGyEjQdDcaTPM4SrGSAT2KI=;
        b=d0fYFkkFq8kBb5TooUFW5OH6klGVjQVEOHmuzIQCxmfPsiVdRZBajsgQB8Snjg5gqe
         6MkGjaDIHWHsQGrNDqKKCBMC1/REwMgSo5PxJm51VsNMkc8dxdz03PB7z+nOW9yQ/p8a
         7ZdXaJRVdgK23qXAS1dGUXnl2g4Ypj/LC5cERpJR5rhwhGxT55+5aWp4JlPthsn2dxah
         yDpNgcey1tfO+BVybhALbe8CGNISBSNjtujCeude0s0kpMEFcRnih0Lv4iY5JfDqk1j4
         dqis8lIP2+AGUdxjM5wG8RWxX9nz8VViJYGLQ7g2TAWQmV4K4RIonEg0oA0RlNu9tckb
         qW+w==
X-Forwarded-Encrypted: i=1; AJvYcCXgRtgcxB6XuNG+RTajfDnoiFP9fIFdPHd+wpzgyagIXkqRVqTB/t8DfBoiGi9nhhd/Y7ByNRVFq/fDFHZLoTfwujsMVmKPp2Mntr+R
X-Gm-Message-State: AOJu0Yw5TzSfcy7pKfKqDH2UEnYk7gg57HSnsTMvP7c5IzrCHZcLGOg2
	lOJAYrKOUQIIOLY8djJoeo3Bz1DsV+YKuC2HZ729M7og1T2QMT33eQyDsd0BZR0=
X-Google-Smtp-Source: AGHT+IFWfjnLtCEkxl1+BnC59PnN9cnn88flTr/8ui7FMcDA60fJXNXAp4TD+Q2z1JbUH9ZGPtfq9A==
X-Received: by 2002:a05:600c:4eca:b0:412:fa5f:7f85 with SMTP id g10-20020a05600c4eca00b00412fa5f7f85mr4058545wmq.19.1712485738513;
        Sun, 07 Apr 2024 03:28:58 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b00416665d3e09sm675487wms.9.2024.04.07.03.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 03:28:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] arm64: dts: rockchip: drop redundant pcie-reset-suspend in Scarlet Dumo
Date: Sun,  7 Apr 2024 12:28:51 +0200
Message-Id: <20240407102854.38672-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no "pcie-reset-suspend" property in the PCI bindings or Linux
driver, so assume this was copied from downstream.  Drop the property,
but leave the comment, because it might be useful for someone.

This fixes dtbs_check warning:

  rk3399-gru-scarlet-dumo.dtb: pcie@f8000000: Unevaluated properties are not allowed ('pcie-reset-suspend' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
index 5846a11f0e84..b9d64048d46c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
@@ -689,7 +689,6 @@ &pcie0 {
 	ep-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
 
 	/* PERST# asserted in S3 */
-	pcie-reset-suspend = <1>;
 
 	vpcie3v3-supply = <&wlan_3v3>;
 	vpcie1v8-supply = <&pp1800_pcie>;
-- 
2.34.1


