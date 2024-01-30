Return-Path: <linux-kernel+bounces-45284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81368842E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12831B222CE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C2271B58;
	Tue, 30 Jan 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="FC4OJL2W"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC38F55E57
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647272; cv=none; b=o/8eCKZ0BigNfSkM7CKrf6wgSW6x3rlCJ39ZZWHYvbp3oZIAIpK7UWzrM39lxGWMWCx9IisSZv0O8mVTCRHT/oPtYMssDp2+PT9XsCU6KJR1ALVaQH8bzuYklxpekIXxOYyHzbrSjOXtGhzpcZLowOkqp6V8vTDILZdu8AwlpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647272; c=relaxed/simple;
	bh=8PzOVgfO3wYB39pdWO/JXBhwi39Pfy0F/N4Vo5QOofk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ura6shSA3SkilyAiXQoT30rUoNUCBuM4rOwa0EKtsuLDDX4Tbtr/REQhpFEiTgAp/DgFSBPzQj0XGG1ZweKOkJdPrwUJ+vdYyAZ1k/+QbmBaZeDV2UfD3figKupF+iUwCPGxthKya2g5NNCS7SHUQZGdguVQHVCPJNqrWSQdu8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=FC4OJL2W; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1706647267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zM7gBsHINXnI27rsymf8P8R4h9e6Mdp280o+IUjJVAg=;
	b=FC4OJL2W0OlB6UiFqqT/dU9xmaeZLBVHl8nvuR4+KSY/yhn4lljmeD7pb2OYqd3UdP3a4x
	Rw3m+6jTHovIgY5gi2+I69E+6MPEUhpaZqpRQzXhKw0rg67kzGdq8M613ia6QmKNy+g5ij
	c4GfNeac//l8QGhTOTeUunE7r+TwqsY=
From: Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 0/3] ARM: dts: samsung: enable wifi and cleanup
 exynos5420-galaxy-tab dts'es
Date: Tue, 30 Jan 2024 21:40:38 +0100
Message-Id: <20240130-galaxy-tab-s-cleanup-v1-0-d4e17857241d@grimler.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMZeuWUC/x3MQQ5AMBBA0avIrE3SlgiuIhZDB5NISYsQ6d01l
 m/x/wuBvXCANnvB8yVBNpeg8wzGhdzMKDYZjDKFNlrhTCvdDx40YMBxZXLnjrq01NSDKSpVQUp
 3z5Pc/7brY/wAAioH+WYAAAA=
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht
X-Developer-Signature: v=1; a=openpgp-sha256; l=801; i=henrik@grimler.se;
 h=from:subject:message-id; bh=8PzOVgfO3wYB39pdWO/JXBhwi39Pfy0F/N4Vo5QOofk=;
 b=owEBbQGS/pANAwAKAbAHbkkLcWFrAcsmYgBluV7Xk4LCCoPprjBcTUUwoIzGMRjLWqm7OFuFo
 OjZ9CvfbG2JATMEAAEKAB0WIQQsfymul4kfZBmp4s2wB25JC3FhawUCZble1wAKCRCwB25JC3Fh
 a+4PB/sEz0E2++WHDYxoieAhRX4HhGfXaJqxdUkx6PZIv5HwcgGLq4pWzPzHO8kNITDuy2UEOM0
 KOFtASUcssb5KH1iwpCxAln4xADwEp8aF/THd3YT/KQVAV15Q1NWzKXPGrPKuf218LQazraFtH9
 zGIYVlehy16XXpolm2CrR/BQ/Ypj//2KwKjfRztCyVsV5LAqk2k/MP/bFAb1Lg4VV868iHwGg/3
 9dmf25g+NdIHZIWwUNgbCuki3GxwlNRHX8cefFi/QeRkUhNyww6gO33EiaZDC0ZDkNHwsm3UpOT
 k5b+J+CEeKUfYxcrCvgkY2b2cJK9tXYlikpu+tm1WhNGBjGK
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT

Describe wifi node for exynos5420-chagall-wifi and
exynos5420-klimt-wifi, and cleanup their dtsi to accurately describe
available memory and adhere to the DTS Coding Style document.

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Henrik Grimler (3):
      ARM: dts: samsung: exynos5420-galaxy-tab-common: sort node properties
      ARM: dts: samsung: exynos5420-galaxy-tab-common: add wifi node
      ARM: dts: samsung: exynos5420-galaxy-tab-common: decrease available memory

 .../dts/samsung/exynos5420-galaxy-tab-common.dtsi  | 57 +++++++++++++++++-----
 1 file changed, 44 insertions(+), 13 deletions(-)
---
base-commit: 497b447cf89b87c8fb0d0b27994258ed18ac355e
change-id: 20231210-galaxy-tab-s-cleanup-14da98b23606

Best regards,
-- 
Henrik Grimler <henrik@grimler.se>


