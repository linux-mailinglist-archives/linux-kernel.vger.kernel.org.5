Return-Path: <linux-kernel+bounces-149952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C138A9848
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B3BC1C20D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD8415E5C7;
	Thu, 18 Apr 2024 11:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+ffTQUZ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67BE15E218;
	Thu, 18 Apr 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438630; cv=none; b=HysNl0T9y1Jx4FHt/RjD/ERrdqEj30ZiQf6yOiG59C5ol464VaWyeAs9AWOxkidg/q69X8DtqyV5ldwe+sXXJ5PYSFsMziVTftLp7qi9oBJLaT+92S9+GdfA7MmVbha8sDbaUs/0RBV13j2GDlJrUpILF07FaEoZfYyW0D/Uc0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438630; c=relaxed/simple;
	bh=aM709iaBDuiEMYntK7996B1tBFrfkx+MdgWjG9QW6Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GDfOsaJIunCo507GheicFI2m7cnIRipO/KddvyLaf04o+lT4jTa4nMNegUVvtnGCsaYZrzQYyBPTk1ZXJs6xcuPYs36IDzuKRPJAIUxCL1RWpUQ8JL78jlocLMaj16EikCI5x1QpPkOx61He/Uv5rlVtLr05SJ75rtzVXO4654A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+ffTQUZ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e86d56b3bcso6759585ad.1;
        Thu, 18 Apr 2024 04:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713438628; x=1714043428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MEYZdxZ9ZKFOWmTeiAFHDTp2vDfUpWN0o2R7rPWODZc=;
        b=L+ffTQUZsGoQLfmbvUNzf2wWAsLg9FugMeuyZEq7VSw9x0k2r+/++GBSmRrNjCOt4T
         F3wt2IKBwq7VM+Tk+inc7xd0R1VFZiY+H+mH+FjSYBFsmZ0ZvEGj4mKOfsgv1bb00xDW
         q+CXwZqEmrxcg3dybZSAe+mC1MoBqScU15UUfvpDO4xdN+qOWx3tAwSUgjaAL/ICa10i
         VKBF5BwHHV3t2LAC0sJ7YCyrm7LbMIbY3bCP9NBVJcn2kqByKaOGrAUq6IEjvzTx4N+B
         vJkAMFRkkNHRq7+MzKs8s5Chf/RTrebD85hNqKX+jn8mzk2nmuyOMJZW+BrnGFL0k7ng
         7s+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713438628; x=1714043428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MEYZdxZ9ZKFOWmTeiAFHDTp2vDfUpWN0o2R7rPWODZc=;
        b=jsQWceZHIkAw376Ka7owqZb9Z7Pf3Nv6uZjsutz8YhwN/uEYFH9+6cd1Lxc8mBF47B
         TYkK+loRp+/nqOH7Ema+f4Se7qU3rzpqVn97YRQFIUtzaHiv5+e2jdojX81bRCfiuNsl
         SzGWvtR/N0j+IChkbhv5U+Dv+rDSdldrtpdggibsTotx5jmHG0Q182A/CLFWK6U2Y8mV
         woQ2nMSzJWJwly+nsOFmA3k79eg859EIktzCi3iz0kY0DjMzcldjjHFf9uKcryMNKIOi
         ep91gmgPs8VNBuMZXLPUhdWS0fk7RawdrTeRtvzvLHc/uTPeYOvqoNYVpgjqFncFTRsO
         gv+g==
X-Forwarded-Encrypted: i=1; AJvYcCUKBVXVSKp3bMmyr8kqAVcZnHWQWP20aCyqDmkMvsEErO3v+jwTSZZRZhZz3KjYkRxQBef3DKzf7p9XoqxHNszsF/Sod3qOs2L1j1iUWfiUZZdaH0ry/Ky5TmWM3pdVT8+wPPehmT2M7w==
X-Gm-Message-State: AOJu0Yyjm7AOAuiY4bodoZf3QMOJS/7Yf4zCQKdjI2qk7KmvgyO2vIPN
	rnS8g4ma9Hl94Au05EyD8dY57KSY9MDu4raXx8qvUZIZcnDje9jszVacjwiUJfM=
X-Google-Smtp-Source: AGHT+IHW2OefZKApGAQcCcxMIShFsJ9lBRZjH06QsH+lKPPakyQiSSbApOKUwSHn3fD1f8W0RHQLDQ==
X-Received: by 2002:a17:902:b716:b0:1e4:e5fe:ce0 with SMTP id d22-20020a170902b71600b001e4e5fe0ce0mr1999513pls.43.1713438627752;
        Thu, 18 Apr 2024 04:10:27 -0700 (PDT)
Received: from localhost.localdomain ([221.220.135.251])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001e4d22f828fsm1051159plb.33.2024.04.18.04.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:10:27 -0700 (PDT)
From: Jianfeng Liu <liujianfeng1994@gmail.com>
To: linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: ezequiel@vanguardiasur.com.ar,
	p.zabel@pengutronix.de,
	mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	liujianfeng1994@gmail.com,
	sfr@canb.auug.org.au,
	sebastian.reichel@collabora.com,
	sigmaris@gmail.com,
	didi.debian@cknow.org
Subject: [PATCH v6 0/2] Add hantro g1 video decoder support for RK3588
Date: Thu, 18 Apr 2024 19:10:00 +0800
Message-Id: <20240418111002.83015-1-liujianfeng1994@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the v6 version of this series adding hantro g1 video decoder
support for RK3588.

RK3588 has Hantro G1 video decoder known as VDPU121 in TRM of RK3588 which
is capable to decode MPEG2/H.264/VP8 up to 1920x1088. This vpu ip is also
found in RK3568.

Test results from fluster can be found from thread of v3[1].

Changes in v6:
 - Apply dt-bindings first
 - Collect missing commit tags of old versions
 - Specify the base commit suggested by Diederik
 - Link to v5: https://lore.kernel.org/all/20240413064608.788561-1-liujianfeng1994@gmail.com/

Changes in v5:
 - Add missing interrupt-names to devicetree node
 - Rebase devicetree patch based on next-20240412
 - Link to v4: https://lore.kernel.org/all/20240316071100.2419369-1-liujianfeng1994@gmail.com/

Changes in v4:
 - Change compatible string to rockchip,rk3588-vdpu121
 - Link to v3: https://lore.kernel.org/all/20231231151112.3994194-1-liujianfeng1994@gmail.com/

Changes in v3:
 - Drop code in hantro_drv.c because hantro g1 vpu in rk3588 is compatible
with the one in rk3568, only adding devicetree node should work.
 - Change devicetree node name to video-codec@fdb50000 to match the reg
address.
 - Add dt-bindings rockchip,rk3588-vpu compatible with rockchip,rk3568-vpu
 - Link to v2: https://lore.kernel.org/all/20231228131617.3411561-1-liujianfeng1994@gmail.com

Changes in v2:
- Fix alphabetical order in patch1 and patch3
- Sort device tree node by bus-address
- Drop rk3588_vpu_variant fron v1 because that is exactly the same as rk3568_vpu_variant
- Link to v1: https://lore.kernel.org/all/20231227173911.3295410-1-liujianfeng1994@gmail.com

[1]https://lore.kernel.org/all/20240118080602.9028-1-liujianfeng1994@gmail.com/

Jianfeng Liu (2):
  dt-bindings: media: rockchip-vpu: Add rk3588 vdpu121 compatible string
  arm64: dts: rockchip: Add Hantro G1 VPU support for RK3588

 .../bindings/media/rockchip-vpu.yaml          |  3 +++
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi     | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)


base-commit: 7b4f2bc91c15fdcf948bb2d9741a9d7d54303f8d
--
2.34.1


