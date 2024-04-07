Return-Path: <linux-kernel+bounces-134336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45789B074
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6C11F21966
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE942562E;
	Sun,  7 Apr 2024 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aHyMTzj/"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117A521103
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712485745; cv=none; b=bC4bTwQiWoqomiAlrFTRhziyEDyd276ZoiB3HvWM6d5OxmiefVPGUDR5tTYTWj/HT2L+ZCLjM7Fdy5XQtlXKx7OFtZ3xVRb3zVjmO01dL+nNf2vMKMBd0h8AsLLOWiPc47Gw4Ja0X/ofCv/TD6FwzWpU/oznj0DBj95rru4WIDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712485745; c=relaxed/simple;
	bh=l4QhM+IxjSm6mQ2XW24RcVpAKYRrWpvED2zUuzV8TE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hMlWbn4hDugYHgNdoOaE5b84LgBWN8T5RHuKmSlFnELwxuWmeXZJELYf7/jOBkBeUd8DssqXw2RXRDxRlTVdm5wdz+16P323bwYvZzo1AxfxOi86G4kKjvPr7bjEdE5Not2TPmKFPGlM25nTbF8JZBykpvyzdv4afMaecvZZZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aHyMTzj/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4162ad8ddd0so20021185e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 03:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712485742; x=1713090542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w85wUQFFRwhr768wNwa60mAcNSboWTs5qbhFvFElJwo=;
        b=aHyMTzj/SFN/QrpzCqPbLEtLQjD8drHr27GBHAQq4F5bMP0wQQdn+aIIi+iGOzYGP4
         q8gAUEESkmoicwUJRg89IlYPuzJftpKotxKRnsq9umdb1opCxJEC+B47Cr2L8SJJgxir
         30fjpqBxV502zGP1bhexx/oiSF6Qrm2vIFRMk9OKzWOYzlVCh4vwUhbsZUdTqkAwc+il
         Fh6RiIF3yLqieatCu1MSi3y3vkYTh3TC6mwamkKbwMurwk9SCW1575g8AGNfdYdSBQ41
         svd3wKzRZemt9hEHQXzfBKKJ37M/BE55Cq6wIojJduzuYTbOgHDwFj6UQzt6rZ46FT2K
         DK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712485742; x=1713090542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w85wUQFFRwhr768wNwa60mAcNSboWTs5qbhFvFElJwo=;
        b=GbSFPdCuxHM1mMComhSyuWI6TVZfcov6XVqqse1P090eaSHD5OZS17enh0SQSJydRJ
         gkGNaDtNxZfIEkHxeMnV+ddkI40sKPudWGCykKeq9wRvRm9e9I40GLdj1k9Cs3umO4Pz
         7LsDcRiVLTp9XrQj3FXIr3xI2M3E9TI0/Jj7jIkUOjiCzRAFHyQX1ZznhllUD3jGpD0J
         D4KW1iH2dxHFxI0ZBgg5NNxihZJcMeCoe74YVN5MQbhm3nEtRgoAtwuOil7f3Ds2vTvw
         Zj4Xg17S8f/zdTVfXxWqrB8kN7SbqCogvGAaDJVp+PNmnCbQrmqiWmrW3E1l9WThrcvo
         qMXQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9iYDgZqGYMtm7tpsmajQA9o2kc/n/HW+5lBGc2Km9fWlACanZvU2lKmiWmK3wBKAVl6HGV3HCOosDXbykYAksTVrME8MV55zzRdl2
X-Gm-Message-State: AOJu0YyKE3vM1DxJHjapZIHEAcB9JkyKhcehaGNKylEnL+QSHuRG4/lr
	r0tIyjUK8xMSFQ+HHAvpsclyocMASQGBauHw/p4/IWZju7Y8RsGetrve3iNUQqg=
X-Google-Smtp-Source: AGHT+IEQe5/Bsm/TQKB4qX1qxV3uy3cg/WeLuTUZ62g74IaNk/xxpRT2tJ2alsoOZP+5w8I13D0dUA==
X-Received: by 2002:a05:600c:35c3:b0:415:540e:760d with SMTP id r3-20020a05600c35c300b00415540e760dmr4728605wmq.5.1712485742523;
        Sun, 07 Apr 2024 03:29:02 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b00416665d3e09sm675487wms.9.2024.04.07.03.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 03:29:02 -0700 (PDT)
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
Subject: [PATCH 4/4] arm64: dts: rockchip: drop redundant disable-gpios in Lubancat 2
Date: Sun,  7 Apr 2024 12:28:54 +0200
Message-Id: <20240407102854.38672-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240407102854.38672-1-krzysztof.kozlowski@linaro.org>
References: <20240407102854.38672-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no "disable-gpios" property in the PCI bindings or Linux
driver, so assume this was copied from downstream.  This property looks
like some real hardware, just described wrongly.  Rockchip PCIe
controller (DesignWare based) does not define any other GPIO-s property,
except reset-gpios which is already there, so not sure what would be the
real property for this GPIO.

This fixes dtbs_check warning:

  rk3568-lubancat-2.dtb: pcie@fe260000: Unevaluated properties are not allowed ('disable-gpios' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts b/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
index a8a4cc190eb3..a3112d5df200 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-lubancat-2.dts
@@ -523,7 +523,6 @@ &pcie3x2 {
 
 &pcie2x1 {
 	reset-gpios = <&gpio3 RK_PC1 GPIO_ACTIVE_HIGH>;
-	disable-gpios = <&gpio3 RK_PC2 GPIO_ACTIVE_HIGH>;
 	vpcie3v3-supply = <&vcc3v3_mini_pcie>;
 	status = "okay";
 };
-- 
2.34.1


