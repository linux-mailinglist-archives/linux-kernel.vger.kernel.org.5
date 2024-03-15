Return-Path: <linux-kernel+bounces-104489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBBA87CEA2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26DD41F21C26
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C164376F3;
	Fri, 15 Mar 2024 14:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQpRUXFw"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D075D374F0;
	Fri, 15 Mar 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710512588; cv=none; b=Ydm0IAphKe5/Wz2gTF29TqdawosgHqVHz0d7JALZ/IMHbGyI/S42lEbO1XFLraSYdiMjCIdMzYwkdoqElzVnDBg/WqTgnc/hv443hQGGcHuCdg58VBzJvoDzpWZQLU1mrYk0Y5ftIgNHDQqPzn1XZvL+38ecVG3IRcJ+eq/xJRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710512588; c=relaxed/simple;
	bh=Xo4YADlXEc1eDwsDHU74Y4WywxJGX+E4bGP4PmAE/v0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHSav3CEh/BNHJeD7Ry02ytW+6t9XzvxbT924Np49aMz+YVl2XCcgwHa2g5G1c6QFVEELVnXsx/hcanrfOkkFSUMD6qz23Jsxm8EcKSu4I7aYF8V2v+DLkkCTYwYzRnedy+8NmQGeVW0dFBWllPw/CjYz8BrM0zpO80oe0S5W+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQpRUXFw; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-513c982a619so2949100e87.2;
        Fri, 15 Mar 2024 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710512585; x=1711117385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tZkgmYX7j1RNnBUU71HzMr25jaCAVqRVAu1+HZuDA+o=;
        b=HQpRUXFwb8ffB8FkhSq6EhvtlR+CWQzHXUlMAnAU2h6P+GKXkXVFH+gPPzzBRTfmFp
         kNQMdivsk1RlmJHT0Pt0QF54qque4BOjpEQ+XrYkjESLLAsN8Oxeh5k1zCifm7Dm295z
         BZ4pd9mD0jml4jdbdu0Ye4QPOcsCiBpMf8cLMsyUy/Bg7ngEcrgFCumAb8OIR98zo0uw
         VWS92HpwW6aIQHdD/gxgnI8khY4abc7BTz+sElgOJt4w1jcSxKsfqgFAVm6C0qk2mYGS
         EgS2kd0yRhLPQBiIpGxH6KdEqRl6niacAxlUgFuY4WjC/l0NIoIgi+KgQda3gUMqMfgm
         TdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710512585; x=1711117385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tZkgmYX7j1RNnBUU71HzMr25jaCAVqRVAu1+HZuDA+o=;
        b=tA6fD0MQpdCb2SPGlRs/dTUrb9Ei6f2iofstMph2l7Uq7SUDGnfKbWmx28RMrH5k9L
         tpmRch9SCVAwnf9BmwBY3SS0QI7vkW176ruwvpUviG34EAvG4zVDf/QFi3EhMTluLKxw
         ygarXQkpA2JXRQUYCbQgu+E7yakzVW1SW6PkWEYUWashu6BdtkUWKXOEe64bvAZp77C9
         RcbyKyBK2trr6wfZomjUIjmBmbf+2jRdXzPsF9LVlPZ9XkdIKLIafu4jzb3odWMfraF6
         b07YGH2p+xQ37Dd1DicGOGbL05rxNN9LjKatF4ZmWJ5pK5TFX5NqCnmYkBn2LmUZFycT
         mEcA==
X-Forwarded-Encrypted: i=1; AJvYcCV83La9KNcClhDEdF0g3KXlh3iNVvTVRsuYOWondhyWeOUlt4RSWnjAOaneHjAm8ujqFvkGPk9DPQypW/tj2dqSbUQcVxWFFTVEAWtE
X-Gm-Message-State: AOJu0YzuGbAiqDoPm1U5j9BrOa5rmIjZSW7sFMHw0r7+yf2ezJK8Q1OK
	mXIMu4lnFlHqprmUXVYak1oEm+NBApnk14UbvYFXEHccvL7kmEHN
X-Google-Smtp-Source: AGHT+IE98tjIGzyWQqcMwbVhKi5T8nsnQAHn+YgCdP9ysNFO06+/mc50znq9PUxyQhj6LNePnjMhCw==
X-Received: by 2002:ac2:4890:0:b0:513:33ac:fe61 with SMTP id x16-20020ac24890000000b0051333acfe61mr3209679lfc.60.1710512584938;
        Fri, 15 Mar 2024 07:23:04 -0700 (PDT)
Received: from yoga-710.tas.nnz-ipc.net ([178.218.200.115])
        by smtp.gmail.com with ESMTPSA id r18-20020ac25f92000000b00513c82518fasm649651lfe.223.2024.03.15.07.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 07:23:04 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dmitry Yashin <dmt.yashin@gmail.com>
Subject: [PATCH 0/3] Add Forlinx OK3588-C
Date: Fri, 15 Mar 2024 19:18:04 +0500
Message-ID: <cover.1710506373.git.dmt.yashin@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add support for Forlinx RK3588 based SoM and carrier board.
Devicetree split into .dtsi (FET3588-C SoM) and .dts (OK3588-C Board).

Dmitry Yashin (3):
  dt-bindings: arm: rockchip: add Forlinx FET3588-C
  arm64: dts: rockchip: add Forlinx FET3588-C
  arm64: dts: rockchip: add Forlinx OK3588-C

 .../devicetree/bindings/arm/rockchip.yaml     |   7 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../rockchip/rk3588-forlinx-fet3588-c.dtsi    | 556 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588-ok3588-c.dts     | 390 ++++++++++++
 4 files changed, 954 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-forlinx-fet3588-c.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588-ok3588-c.dts

-- 
2.44.0


