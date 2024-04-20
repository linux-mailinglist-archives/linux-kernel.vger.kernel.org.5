Return-Path: <linux-kernel+bounces-152108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DE8AB940
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 05:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8C51F21366
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D3AD2F0;
	Sat, 20 Apr 2024 03:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL2rT7El"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EDF8F5D;
	Sat, 20 Apr 2024 03:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713584674; cv=none; b=bR9UC0j1gxy9v0mPTCO0/1yMYylS8KbK1aSFFcPWnIePcOn5q5GLRTQNG49THCgizxqjv+dxzfvv0O/eBEmw5vdjKVivWbWWios5sGYFH9gPU+z3PW6xuqlhR7aH1jkjTGyMjz9Vvq1cBNzgnH82s+xjBsNjXOELg2PIpyPHZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713584674; c=relaxed/simple;
	bh=mWNq/Ho0XfydJc4lwISm+mknMo+KfcKXD8unrHfndmc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LF7Rp74xbDr4Zwshb8T4fzVyow3SCbAE2ooV8ytK9LfjiFkj0zMt67Tg3WMSccSHbKcqvg+082qOlYIpXUh0SPB1Feurk6aeXY/4cayxPDJkG3sT93YOGts8yiBdWmZimNLNko9fB52YJo2Vk4t9bsMJecVwxeHw6UGLztwiOJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RL2rT7El; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6eddff25e4eso2279750b3a.3;
        Fri, 19 Apr 2024 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713584672; x=1714189472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CXpX/g/hvBkXQRFrKFV+1cv3bBK+UaH54WwHfuszeFc=;
        b=RL2rT7ElyOWS0Ktx6/PLB/abaD6kwy+hWpnSx/bDSwmXPK5nc0trQDZOMHyEQ6+F+d
         f8ZHA4hfVrVkekR8GOzHPzF1cL53WNBO5ioNW9t37UVSGapx2bZw2SW2hjtzfzsxCAuD
         hivSLo84oH5St4cVV/qBOAiYWw89AJGzBv43EHJNMBPMJZuKpydPWzH+agQbG17CFCdh
         Z3LsTcsCr0Lc/zOGQhpdA6KvqdRek05SoZ8ZW4fxuXEE8ftkg4Mi8D07R3xErfLSZicT
         dzeDPS0ddt36rLpOGD89269g6nyJP/jvt1S+pUTNNJXcX6OFOuIm8qe17HjxodjvFXZY
         jk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713584672; x=1714189472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CXpX/g/hvBkXQRFrKFV+1cv3bBK+UaH54WwHfuszeFc=;
        b=uihAhCUj+2Aj9PnvE9e6PNwfF4oDpirSedyW7oA5rjEThFILA28xvRQiO/CoNRkcuj
         srQ4VlnE64uq7ji/IxErAKO1NVHLbDiVg8KpqoN6U87kmIZfxVXxTugpPlOUm0RGa7NL
         Fz9MW7pkqr7OCSWSgnaR/4JiejpK7GgRlh80MUW8xyCPk2b7vqiINIpbAhzWear5DOqV
         GDTmgTRgvF9cvKCpWYvkms0ZXhNxsQxdIAQFQkjC5ge0eELk6/n4NjZ7a39eLavJ23dj
         IXoyQy0bDcbYnJlyxH8ZjcrqxuKA6Q7GLFYKlwNKXyUEJ/vIUhhTsuoUXg4DkZbKBE41
         wIhw==
X-Forwarded-Encrypted: i=1; AJvYcCVChvWGhD2Hxtjd1cbGbJ0MfRGSu2TZwzd9h26VjSMWZyxPZSmP49xUmzUA3cDNMkow9hDSKgR98FP8OXHQa1fVh1h7CvfPcxwC/rV/
X-Gm-Message-State: AOJu0YxHwWr8wENFeD60yHWqeTD8Ost2rB0pbT9/MwK4ZbMcGR0eLgdk
	kqvz9SauEvVW55yMlDEu1hzIFkVGk2h8cT5mkdJOgkYghcAodDYQMaQ8oSUd
X-Google-Smtp-Source: AGHT+IHwdx/ijPvHS/ZWZzR2ZCzkPZP/eqQXUMbJcDIyn5nMaDUKKwY5Jd+0Qfvm0+77oiC8+5VWKg==
X-Received: by 2002:a05:6a00:92a7:b0:6ed:4a95:e3ce with SMTP id jw39-20020a056a0092a700b006ed4a95e3cemr5355445pfb.13.1713584671663;
        Fri, 19 Apr 2024 20:44:31 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id b9-20020a056a00114900b006eaaaf5e0a8sm4005633pfm.71.2024.04.19.20.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 20:44:31 -0700 (PDT)
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
Subject: [PATCH v5 0/3] Add ArmSom Sige7 board
Date: Sat, 20 Apr 2024 11:42:57 +0800
Message-Id: <20240420034300.176920-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v5:
 - Rebase to next-20240419.
 - Add missing commit tags.
 - dts: armsom-sige7's led-0 is green, not blue, change "led_blue" to
   "led_green", "led_rgb_b" to "led_rgb_g". And Weizhao's reveiwed
   tag to devicetree is removed.
 - Link to v4: https://lore.kernel.org/all/20240416034626.317823-1-liujianfeng1994@gmail.com/

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


base-commit: a35e92ef04c07bd473404b9b73d489aea19a60a8
--
2.34.1


