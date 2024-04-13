Return-Path: <linux-kernel+bounces-143783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A41E8A3D72
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 17:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9621F216ED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD7547A53;
	Sat, 13 Apr 2024 15:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbcgSJpW"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E5E1E526;
	Sat, 13 Apr 2024 15:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713022638; cv=none; b=QdacUHQ/s0IUUWlEue/dhUg/bdIXK39CIRU7llq1MdLwD31wGuTnfyLct+WWbZIpXkx5Au5KvY7H5sG2cYrDUDrQPaDZETyq6XGir/zwOeZ7aK0JScmgq6iETnjmCCfLRCmVGMQBuHRyXDNbCRvT5c22vzoDJonCf+8Uh9ELF7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713022638; c=relaxed/simple;
	bh=gphTeguO7+9lP5wPL18Kcvbic4BlXq/rvH1Fpiu/BKM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Z4sRK3391HNIzjX7vIAj7XOUhJPMaYtgFl7rC/aqqhO3/wFXNKEyh4uCaYZ1SsURtXtmqur5gI63Hs3Nos8V2jPQtpJw+95laj++Cd0FJ9JWXg/oqIZiy6BPsPQ8UmICWV6680liJ22T/vk1z1Q5moh/4krvah36XyXIfxpu6e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbcgSJpW; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso1472675a12.3;
        Sat, 13 Apr 2024 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713022636; x=1713627436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WDMegry8y71WXCoBHyMXqPj5dhdkTwYasbiwY9nWgTQ=;
        b=nbcgSJpWrMKGPdoJgJ8wvncBsyIAhHg9BUn+UZO7PpgzRoJnKekN55NwnJcH2RFa65
         voIkTA5tJz7EygooyxQRPs3SG3nHbYjFnLbRMmWMw9Ps8WXNc2MEf94HqC/dY93sou1z
         Y5LrmPvKUmg56UNOPJQw1IkQOv54ze5wGQU0p5X7thoTCUwDOek/dlghsSlVXbwO5RSc
         d7kLD14OjFB2oIFe6VKe+78b2Rp/Iy1KBiUgQVoL36kxTMCRMmWX03UWi2zuomTkG9hJ
         KHO6xYpb+KLL2ey+szvtzOjpoIYPnxoU05FCLWuqzN905tbg4i8W7PZjr1D2Vu+94Hnr
         BEgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713022636; x=1713627436;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WDMegry8y71WXCoBHyMXqPj5dhdkTwYasbiwY9nWgTQ=;
        b=HW3SWgPb7WyFr1T+Vq9SNNg6L2zGDCTyxYDL3OM7s0alijmmsBig/ABaiKVp2tTCnX
         +zJvC2zVD5EyfzyFAeceZp+j+MZFcPJTBDTJ9JMSHyET2IQ/tVKkEtWYHeZs6BQIwjFF
         +Uc+9EJ3ypJWSWvFIEGjJWJIBh+xlJ6pOTRtmv31f25dU80GM+r7xnXdNUHHT2bYO5iC
         9hbOONDcAs9oBHXuNXs4C+B73YAgOfE8zXrjaA+6OsiXDT5LzZz3DwR/Lu/3tMh2cTK8
         LcqFP2oa5FDT6w6phUW2SlAbPjdB40Ffi8xHVVvM2yU8IhrnehmPCVE6NviBRErOtQim
         cJUg==
X-Forwarded-Encrypted: i=1; AJvYcCV/dfwtyfLR3GtETEF8qsBMSTe9tPzW7ndbe21BYWD+orGkxgrdHQlGnlhLPmAh6OUjmEv80IMMgQAqnXFJBrGq5si+EdDSBbhEEFP6
X-Gm-Message-State: AOJu0YzHFGI3FfW+uTMJoztsM/OYQATZApoz2uBKarCALxkcuLe0OcKP
	UG4aKtth1dHpA4zCCWO/uT2KnK/GzqQ6/oIGgVllG17lke2v0jsNGr07Y7j4AUo=
X-Google-Smtp-Source: AGHT+IHgIme6c43tta8vDZSKEjWp+eR2iHRi6sxYPQSmCZyDxsIfCBzU3n7Md/IZNGSzhBLEYjlK6Q==
X-Received: by 2002:a17:90a:f605:b0:2a2:5860:dea8 with SMTP id bw5-20020a17090af60500b002a25860dea8mr4979129pjb.7.1713022636201;
        Sat, 13 Apr 2024 08:37:16 -0700 (PDT)
Received: from localhost.localdomain ([221.220.133.103])
        by smtp.gmail.com with ESMTPSA id d13-20020a17090ac24d00b002a706910b05sm2609606pjx.9.2024.04.13.08.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 08:37:15 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	weizhao.ouyang@arm.com
Subject: [PATCH v2 0/3] Add ArmSom Sige7 board
Date: Sat, 13 Apr 2024 23:36:30 +0800
Message-Id: <20240413153633.801759-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Add ArmSoM to vendor-prefixes
 - Commit dt-bindings change first
 - Fix commit message for dt-bindings
 - Fix wrong devicetree node name "led_rgb_g" and "led_rgb_r"
 - Link to v1: https://lore.kernel.org/all/20240413032328.784142-1-liujianfeng1994@gmail.com/

Jianfeng Liu (3):
  dt-bindings: vendor-prefixes: add ArmSoM
  dt-bindings: arm: rockchip: Add ArmSoM Sige7
  arm64: dts: rockchip: Add ArmSom Sige7 board

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 725 ++++++++++++++++++
 4 files changed, 733 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts

-- 
2.34.1


