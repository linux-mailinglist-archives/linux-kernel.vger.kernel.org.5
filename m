Return-Path: <linux-kernel+bounces-146187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDA8A61CF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 05:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CE21F23935
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B06D1BF3F;
	Tue, 16 Apr 2024 03:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCG6FLYY"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B2F17BD9;
	Tue, 16 Apr 2024 03:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713239258; cv=none; b=YT6xlEWoBIHmWIPHIDTw6z6iOazGbIsGq/PmnNSHT6FvP2h/S1oEEIxkatKmnJuU7CzrlPFjokN4b4FDvogxk7PQDGlsGmsSxuSXhxUxUXUbUB/2jsfX1nloOHz5PvfxreGOD4MdYO+v6cxo92kPMojZR8bUFxfRxG8OpE82YFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713239258; c=relaxed/simple;
	bh=3pJqnpHunMgJA9HvWF4LPFNXMMZUBY0f2lHbi7OClg0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jYY4Ds/6EZQnD9oZlxvB+nftCb5BB9TXw2oEZ6FbpzZ8O1Ptx6yxS+NRRfK4b9FoMGYgrVBX2SnUcLHmkmmP2cHetaLnkoF6G4oBd5QtCU21osKX30pkd0mu33QGk9fzecWjQm8lycGtuuYlAjGyWKCtig+8+4/uNLX573xkYAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCG6FLYY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2a559928f46so2238989a91.0;
        Mon, 15 Apr 2024 20:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713239256; x=1713844056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vE9TehhVe5dLLae17iDDbi7HMgNctUCXygXG9Azr2QY=;
        b=MCG6FLYYcyD3+oRlaINZzVEzK3W5tUM/zYcq8Jsn9xIPWl4ycHZJ/RkyYRe4oiM3Ni
         ZiscM8oWiS5uJxQucxf4jBgS/DJ6ADrd5gf06qWFB2/8LJeXxD/jeVYZbxyxTJ5GsoFm
         HIGRH87vqRHJIdSo7rvdmEXJaGwU8HW7vphmrJNKphEn8PoV42/sOxoM+3f8QVa6AqHJ
         3fSc+aBk3muw14vxrEU6dPsU0g2qMjMwwI6RV0wQKALmkgOt7cMxGH6zV/N2ZGIaO8iE
         ZnecFZTZxhfOMfE9q8K6vSlDGN3pzOK+1+OakjeOYyTDKPXuE3pMyjqkkPX0MaU4K0/0
         rg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713239256; x=1713844056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vE9TehhVe5dLLae17iDDbi7HMgNctUCXygXG9Azr2QY=;
        b=dREmzfL08lPo6q+PCv2Zg5bhDSAc5L3SYuS1HRlCJQtAnRNySB429hTniUP9ETX1no
         nOw9SsUSEe9RnlH2/BJ9KMPlcigYLBGC9qjnKzaHCBquMZ23FbObVnOJL4t2a4OaiOC5
         /Pthiy4qpLSmDRhSslfIIrYfLAHDCfhEBhYsTQp42VIFfWa2/3NQtlVkFvVWDCNOzYl6
         xTwZyOmdRezWimTXy9M4yJ+X64+hS0HkEeT55QciHIFS7ZwOGG+B+4dzEjajamWRLWlV
         VoBBp6nvq9veftl1FJCAq7CLOeojCNqy1dqAq5X1bgWUvfK5x6JoXfMP3C1nY28snxf/
         Guaw==
X-Forwarded-Encrypted: i=1; AJvYcCXbzx6+hfrlS3SblHisSTDMvWc41uiBRpIMnMSlXkWD67EclWCjqrr/w7h/Dgr/Jxy6e24qcF75srlR79PXNRBKaaDEazFYjwHkBBJE
X-Gm-Message-State: AOJu0YzlU856gDQd9j9z3m3RYx9i3HkuAk1t6DD0Ln0awSvRvFaATBIs
	h3rtcmIyDmXu5SWtqX7sjNJKp/Nlw06uUQC1BPvDlZ6tDgitPiYuxJJoswI04tw=
X-Google-Smtp-Source: AGHT+IHdEVPnQTq33bviY1bVGMyNJ/KKptNJC1+Zy+9wn58hubkabul9+m1Or3B9SXi3oG6bpmAvrQ==
X-Received: by 2002:a17:90b:164c:b0:2a2:c16:d673 with SMTP id il12-20020a17090b164c00b002a20c16d673mr12161559pjb.36.1713239255888;
        Mon, 15 Apr 2024 20:47:35 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id u6-20020a17090adb4600b002a51dcecc49sm7748815pjx.38.2024.04.15.20.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 20:47:35 -0700 (PDT)
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
Subject: [PATCH v4 0/3] Add ArmSom Sige7 board
Date: Tue, 16 Apr 2024 11:46:23 +0800
Message-Id: <20240416034626.317823-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v4:
 - Fix dtb check error/warning with command
"make CHECK_DTBS=y rockchip/rk3588-armsom-sige7.dtb":
  - Change led lable name to fix duplicate label with pinctrl node.
  - Remove useless property "pinctrl-names" from "&pcie3x4".
  - Change red led trigger to "none".
 - Link to v3: https://lore.kernel.org/all/20240415170737.49350-1-liujianfeng1994@gmail.com/

Changes in v3:
 - Update vendor description in vendor-prefixes
 - Link to v2: https://lore.kernel.org/all/20240413153633.801759-1-liujianfeng1994@gmail.com/

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
 .../boot/dts/rockchip/rk3588-armsom-sige7.dts | 724 ++++++++++++++++++
 4 files changed, 732 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-armsom-sige7.dts

-- 
2.34.1


