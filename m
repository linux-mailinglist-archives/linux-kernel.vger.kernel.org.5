Return-Path: <linux-kernel+bounces-155874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC158AF847
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B487B1F25D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7E1143864;
	Tue, 23 Apr 2024 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aoSFYmNX"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D23142E7A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905415; cv=none; b=kqgoSXcDXaOXpf1kOPIn/K/HbB0pYF4/l957R9jrsPN62BnceSfCjlMj9vMzLJhDl0KuWErsQjobzsEGIYCGG5FBWuJ9SeD4x9iz/gDgIoDknbQzh5mknLe1riMHwqtOTDMvuu9335NVg+Ep9gxr0BgNyU07C1Bxc5thiOG06YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905415; c=relaxed/simple;
	bh=lN0o2tlEgJg9kalVb74fI9+nLCmdUkqOjjcor3skRjw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gu4jz/xLWoTyYB1Z2Ci6lW1uI0v1DREpM4F3Sntq0PT2IUtojh2RgPT+pcmvE4WwCrHjVIw2Gch2Lr9U9AMBsxRubzzOg0n0TvwacLrWhnS3F6AC2iMTOYMFVmPgSjt/swwkL0Kc6UJlnU2jvrHE4oCLkBHbJU5Tdz2xNfoH5pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aoSFYmNX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4155819f710so51003225e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713905411; x=1714510211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iDTk5oDvvrRdQcAB/F+kDJkRJSv6Emu0SrjcMhqOn4I=;
        b=aoSFYmNXC/ou/r57z+3a/IZgIYSX0U2P0m6TyNU3xqDDrzyoDwsR5sGSPumc/MfQGN
         HacIoAIdI4eiBLJpBDaUnV+SpnUc64FAjmtWxom3SsFJqr9+HBdNVrTr9nuljy67noBh
         w0vbUZrLYzM/YVmHKiSV0wvnGrwSH6HILedadpveV51j0NaPcJ/Eb65XL6vAVA5OUKF3
         tRaFCvqL8Y2AYUJY6W6l+kwcDNXcFrbEoTE1jryFOcL9/2KkkVqmEdcbuTFsodesw9Sw
         M8ZRxykmNNuJMPg9SK+j6foy4Cbi1m4YVzxU4x0XgCkuy26wH1q5pvWB2kZY8P1LneCZ
         mH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905411; x=1714510211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDTk5oDvvrRdQcAB/F+kDJkRJSv6Emu0SrjcMhqOn4I=;
        b=U2Mo5eSy6GJSJLeE4WG2mDtKja8UiVa9OwCdjGsFE6IifXrvkCZhVM9d5B9L3SmarL
         ihlghplSdqm7xL4bz9E9zJd5o/nTgWrXaWOE5KhzBfB2vye7GllaxFjo74M9lJKX+b7Y
         pSwn66bzDI4tcJiLn2/O0alv8e9Qc5kn/pi37AqvPUHcBYGHL72gWtwjkpKm8jgazSBJ
         P+lxqhGVsRQX1uXmVmVfhDO2Ztettqd7Pg+ro4dSDlKaSBC9KFcNNg2RCxq52NRmhvFi
         dpv8X/MjzxuiBk5Fo6jfkJl0idQQ1GzUrviBFgPRhPDQ/85IZMDiZOlMTsjMRdxhYUJ6
         FzEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXpv9KHUFUNs9bXIzJuOrkNWH3sUDdjF3gi+4foTwlduIVM1yw2pgpacAAEx+aRHL2NN5I2WQaL0LJR8F6+v6AWWcR8e58pIKc/B/R+
X-Gm-Message-State: AOJu0Yzm3GLAJAevs77XF7LsAlT1nYKaOY8dXR40L1xhHxa9gMxrkN2W
	GW+BLTK8YDPauMw9QmsbOzoZbWIxXs7WKDsecyWDPnlbMTj/qgxfPbnG2ickJF0=
X-Google-Smtp-Source: AGHT+IH9twwrV4GDTD98S7Dg0JzPI6O8DIUuVeYEzvAw6xtx7WWc6EfOFfwcn0BmyTCvX/h+qFPVTQ==
X-Received: by 2002:a05:600c:4f89:b0:41a:408b:dbd4 with SMTP id n9-20020a05600c4f8900b0041a408bdbd4mr257314wmq.7.1713905411055;
        Tue, 23 Apr 2024 13:50:11 -0700 (PDT)
Received: from gpeter-l.lan ([2a0d:3344:2e8:8510:4269:2542:5a09:9ca1])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00419f419236fsm13065443wmb.41.2024.04.23.13.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:50:10 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org,
	alim.akhtar@samsung.com,
	avri.altman@wdc.com,
	bvanassche@acm.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	James.Bottomley@HansenPartnership.com,
	ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	tudor.ambarus@linaro.org,
	andre.draszik@linaro.org,
	saravanak@google.com,
	willmcvicker@google.com,
	Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 00/14] HSI2, UFS & UFS phy support for Tensor GS101
Date: Tue, 23 Apr 2024 21:49:52 +0100
Message-ID: <20240423205006.1785138-1-peter.griffin@linaro.org>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi James, Martin, Alim, Bart, Krzysztof, Vinod, all

Firstly, many thanks to everyone who reviewed and tested v1.

This series adds support for the High Speed Interface (HSI) 2 clock
management unit, UFS controller and UFS phy calibration/tuning for GS101
found in Pixel 6.

With this series applied, UFS is now functional on gs101. The SKhynix
HN8T05BZGKX015 can be enumerated, partitions mounted etc. This allows us to
move away from the initramfs rootfs we have been using for development so far.

Merge Strategy
1) UFS driver/bindings via UFS/SCSI tree (James / Martin / Alim)
2) GS101 DTS/DTSI should go via Krzysztofs Exynos SoC tree
3) Clock driver/bindings via Clock tree (Krzysztof / Stephen)
4) PHY driver/bindings via PHY tree (Vinod)

The v2 series has been rebased on next-20240422, as such all the phy parts
which were already queued by Vinod have been dropped. Two new phy patches
are added to address review feedback received after the patches were queued.

The series is broadly split into the following parts:
1) dt-bindings documentation updates
2) gs101/oriole dts & dtsi updates
3) Prepatory patches for ufs-exynos driver
4) GS101 ufs-exynos support
5) gs101 phy fixes

As well as the v1 review feedback some additional cmu_hsi2 clocks were marked
as CLK_IGNORE_UNUSED in v2 so that all other remaining clocks in cmu_hsi2 can
be disabled and UFS will still be functional.

The sysreg clock was also moved from CLK_IS_CRITICAL in clk-gs101 to ufs node,
as the system is still functional with that clock disabled, however fine grained
clocking just around sysreg register accesses doesn't result in functional UFS.

kind regards,

Peter

Changes since v1:
 - collect up tags
 - google,gs101-clock: alphabetical ordering (Andre)
 - re-order samsung,exynos-ufs.yaml as per Krzysztof review
 - Ensure google,gs101.h dt-bindings is contained with bindings patch (Andre / Krzysztof)
 - fix google,gs101-hsi2-sysreg size (0x10000 not 0x1000) (Andre)
 - drop blank lines in clk-gs101 (Andre)
 - cmu-hsi2 alphabetical ordering (Andre / Krzysztof)
 - use GPIO defines in DT and add TODO pmic comment (Krzysztof)
 - Add sysreg clock to ufs node (Andre)
 - Mark additional cmu_hsi2 clocks with CLK_IGNORE_UNUSED flag (Peter)

lore v1: https://lore.kernel.org/linux-clk/20240404122559.898930-1-peter.griffin@linaro.org/

Peter Griffin (14):
  dt-bindings: clock: google,gs101-clock:  add HSI2 clock management
    unit
  dt-bindings: soc: google: exynos-sysreg: add dedicated hsi2 sysreg
    compatible
  dt-bindings: ufs: exynos-ufs: Add gs101 compatible
  arm64: dts: exynos: gs101: enable cmu-hsi2 clock controller
  arm64: dts: exynos: gs101: Add the hsi2 sysreg node
  arm64: dts: exynos: gs101: Add ufs, ufs-phy and ufs regulator dt nodes
  clk: samsung: gs101: add support for cmu_hsi2
  scsi: ufs: host: ufs-exynos: Add EXYNOS_UFS_OPT_UFSPR_SECURE option
  scsi: ufs: host: ufs-exynos: add EXYNOS_UFS_OPT_TIMER_TICK_SELECT
    option
  scsi: ufs: host: ufs-exynos: allow max frequencies up to 267Mhz
  scsi: ufs: host: ufs-exynos: add some pa_dbg_ register offsets into
    drvdata
  scsi: ufs: host: ufs-exynos: Add support for Tensor gs101 SoC
  phy: samsung-ufs: ufs: remove superfluous mfd/syscon.h header
  phy: samsung-ufs: ufs: exit on first reported error

 .../bindings/clock/google,gs101-clock.yaml    |  30 +-
 .../soc/samsung/samsung,exynos-sysreg.yaml    |   2 +
 .../bindings/ufs/samsung,exynos-ufs.yaml      |  38 +-
 .../boot/dts/exynos/google/gs101-oriole.dts   |  18 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi  |  54 ++
 drivers/clk/samsung/clk-gs101.c               | 508 +++++++++++++++++-
 drivers/phy/samsung/phy-samsung-ufs.c         |  11 +-
 drivers/ufs/host/ufs-exynos.c                 | 197 ++++++-
 drivers/ufs/host/ufs-exynos.h                 |  24 +-
 include/dt-bindings/clock/google,gs101.h      |  63 +++
 10 files changed, 921 insertions(+), 24 deletions(-)

-- 
2.44.0.769.g3c40516874-goog


