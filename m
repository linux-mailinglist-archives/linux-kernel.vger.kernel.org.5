Return-Path: <linux-kernel+bounces-45093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7373E842BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06971F299E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58824157E89;
	Tue, 30 Jan 2024 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+VycGtl"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E07156985;
	Tue, 30 Jan 2024 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638895; cv=none; b=AmqPAmMwSpGr2fF8ZwBnTiJdFgK+6M9XqMcVn62W9MN95h83LwAxeGxAGeZQFdIq07GK0oOo4E83loeiuKvwXUwQ0xYuvbi43PE2Kc6WuBi1HP1DPOmse1Uz0/qSNtQ0I1r/2PxHcBCS4heABmz5I4wucgLg6WSFefgSkJ6UJJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638895; c=relaxed/simple;
	bh=adjuFoy6nt1GW5d4QC6awoBjEu5YFjCdHB0I/DbiuqY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kIauvlu5dlsjwGtK5GgS1HPFeOkWr4Bs06Rgm/KtI5g01+ajMfn+Uvr7+0a5uSXZC3UvIH66djIa3tG0UOBgqmfsqAtGAWqRLNdDUVYJgslQvWSeVTzZvivjjUQWD9E0/1IVmaZU5fpYPXQ/0DBcsFIx8dHlDdTj07fObiWAC38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+VycGtl; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33ae6f4fd78so2033944f8f.1;
        Tue, 30 Jan 2024 10:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706638892; x=1707243692; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e9VubAmaaSRTnW+owpxkezzka6tE/KYNpuT5KbngMRE=;
        b=R+VycGtlDPtEzAMcLYkfkDuB0yDz9wGAhPDX0QmThcyR0pWWpRjnq4bNzEiBX6ZBK+
         /654duvcSlrlZojDmjrk9ebQfYstZ1oQKRJm6EuLLX4Q/BlXOUcsqZjnai7+OJ4iWp/j
         p4nUkl3ujdb/Sjo+XNKCfukzxuvPjXaPtTJCUzgri647dvkIXjaa3/9qQjkzddIdRRmK
         ZZSicxjCAXWRqZWp/LHHDAHyMjtJjpSzOSmfrKSA+t+PtKso4t6OWv0zM8qIGnSmZsgn
         OPhMhEGjSKMdHkGvlqohJTGoKhQ4rixxH23S1SjsvEBp/7zcSHk6u5AqIP1dXj2DkA0z
         iSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706638892; x=1707243692;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9VubAmaaSRTnW+owpxkezzka6tE/KYNpuT5KbngMRE=;
        b=Knwbbak02A9hm20vfISWo0vQHHfrwRi4M+pmnIGRN2yaCvZWN1R6q6kfVFa7Rb7rkV
         KxkpbgxTpXbkYUuDqLV+M1llghwospXiCjRnDfu85ke+5g8zVKtGwEnRKBqJjyxaE6zd
         bmC2MMg0sHokqx8GxDj3zndKDLZWdZsaqv/7kEnBuOx8SIJnb58JDfp1qODXAvcmC7Xp
         9iDyoSDhHpppaWZ1Q7nFR+rFyaiL/22A30vfLX/BAIjJGer5A9cQTNQsenkA4zc+eRHx
         hwVggH1XZ0BAFHukIyVfOxzC/7mIBgqXTCzTqLvDKi8faAyEYYhReZFY1V1yGc8y6O9s
         Cd9A==
X-Gm-Message-State: AOJu0YxoJlciaPS1tYGqVqJN9jBy5qVF9QEh028SEsonp6R2g6ZJucFF
	fkhzYFlXycJLGGrAADwLoyqQGf0O4wE74sKe3sqLznsmBcei34u9
X-Google-Smtp-Source: AGHT+IFLXdhkL2WD30RpdlAbcXXlr0f71XFBz/XOA07FR93Moskp6+X23fkN87H0FoXlMnz2DXfoKw==
X-Received: by 2002:adf:ee0d:0:b0:33a:fe63:77fe with SMTP id y13-20020adfee0d000000b0033afe6377femr872761wrn.15.1706638891801;
        Tue, 30 Jan 2024 10:21:31 -0800 (PST)
Received: from [172.30.32.188] ([2001:8f8:183b:50fb::d35])
        by smtp.gmail.com with ESMTPSA id u18-20020a5d4352000000b003392b1ebf5csm11374254wrr.59.2024.01.30.10.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 10:21:31 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Subject: [PATCH v2 0/4] RK3588 and Rock 5B dts additions: thermal, OPP and
 fan
Date: Tue, 30 Jan 2024 22:21:12 +0400
Message-Id: <20240130-rk-dts-additions-v2-0-c6222c4c78df@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABg+uWUC/2WNQQ6DIBBFr2JmXRqgIuqq92hcgKBOWqUBQtoY7
 l5q0lV3837+f7NDsB5tgL7awduEAd1WgJ8qGBe1zZagKQyc8poyXhN/JyYGoozBWLrlaozUgst
 W6g7K7OnthK9DeRsKLxii8+/jQ2Lf9CcT/7LECCWilR2XwuhLM13nVeHjPLoVhpzzBzTNuUmwA
 AAA
To: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706638888; l=3010;
 i=alchark@gmail.com; s=20240125; h=from:subject:message-id;
 bh=adjuFoy6nt1GW5d4QC6awoBjEu5YFjCdHB0I/DbiuqY=;
 b=vxae3YmuZ0paCU+BN095MkbNCIEuFp5KMEL/tC4laXGc48XyJGHJrugcVTOMqkfmloKgDTgHM
 8W2wls6X7ozBn/vtICz/O2r2axOzmDTAtlpqlg1kYn+osOMDrDCEUBM
X-Developer-Key: i=alchark@gmail.com; a=ed25519;
 pk=xRO8VeD3J5jhwe0za0aHt2LDumQr8cm0Ls7Jz3YGimk=

This is an assortment of device tree additions for RK3588(s) and their
enablement on Radxa Rock 5B.

Thermal zone information and cooling maps is the follow-up to feedback
received on v3 patch version [1] - thanks a lot to Daniel for continued
review of these!
Changes in v4:
 - Set higher 'polling-delay-passive' (100 instead of 20)
 - Name all cooling maps starting from map0 in each respective zone
 - Drop 'contribution' properties from passive cooling maps

Fan control on Rock 5B has been split into two intervals: let it spin
at the minimum cooling state between 55C and 65C, and then accelerate
if the system crosses the 65C mark - thanks to Dragan for suggesting.
This lets some cooling setups with beefier heatsinks and/or larger
fan fins to stay in the quietest non-zero fan state while still
gaining potential benefits from the airflow it generates, and
possibly avoiding noisy speeds altogether for some workloads.

OPPs help actually scale CPU frequencies up and down for both cooling
and performance - tested on Rock 5B under varied loads. I've split
the patch into two parts: the first containing those OPPs that seem
to be no-regret with general consensus during v1 review [2], while
the second contains OPPs that cause frequency reductions without
accompanying decrease in CPU voltage. There seems to be a slight
performance gain in some workload scenarios when using these, but
previous discussion was inconclusive as to whether they should be
included or not. Having them as separate patches enables easier
comparison and partial reversion if people want to test it under
their workloads, and also enables the first 'no-regret' part to be
merged to -next while the jury is still out on the second one.

[1] https://lore.kernel.org/linux-rockchip/1824717.EqSB1tO5pr@bagend/T/#ma2ab949da2235a8e759eab22155fb2bc397d8aea
[2] https://lore.kernel.org/linux-rockchip/CABjd4YxqarUCbZ-a2XLe3TWJ-qjphGkyq=wDnctnEhdoSdPPpw@mail.gmail.com/T/#m49d2b94e773f5b532a0bb5d3d7664799ff28cc2c

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
Changes in v2:
- Dropped the rfkill patch which Heiko has already applied
- Incorporate feedback received on the thermal and OPP code (see above)
- Link to v1: https://lore.kernel.org/r/20240125-rk-dts-additions-v1-0-5879275db36f@gmail.com

---
Alexey Charkov (4):
      arm64: dts: rockchip: enable built-in thermal monitoring on rk3588
      arm64: dts: rockchip: enable temperature driven fan control on Rock 5B
      arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
      arm64: dts: rockchip: Add further granularity in RK3588 CPU OPPs

 arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts |  34 ++-
 arch/arm64/boot/dts/rockchip/rk3588s.dtsi       | 371 ++++++++++++++++++++++++
 2 files changed, 404 insertions(+), 1 deletion(-)
---
base-commit: 8a696a29c6905594e4abf78eaafcb62165ac61f1
change-id: 20240124-rk-dts-additions-a6d7b52787b9

Best regards,
-- 
Alexey Charkov <alchark@gmail.com>


