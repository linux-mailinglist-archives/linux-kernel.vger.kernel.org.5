Return-Path: <linux-kernel+bounces-71700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E217D85A93A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129C81C21B79
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC374121B;
	Mon, 19 Feb 2024 16:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffb8TRna"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99663F9F8;
	Mon, 19 Feb 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708361173; cv=none; b=lIGgtgHdbJJYd68QBu1yEjBoa5D92SFRv3p4mhCZZNm/ipBE94dmOImGcvsDoiDQFSpYfIXkusAPOkSoHhqTc/J3JHpMGY6kiQuqs0H4SzwJgpB2AWeTJZoxQJgYBp350/TNiQcLqBdpOdrXmwrX7SB/3aSPuu0+B8tUkXZrhcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708361173; c=relaxed/simple;
	bh=EEl2gY8IYqh43eRkVKCnR+nEv7c8AQM0pRrgpPbjuZI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jM/JU1Y1ZfBcCVC8imjesdKhiydj8MC5ZsYQMwFEKTF9CDbBQhADmMKI6OYcIct43sKQ7E2kHZbb5dbr51UZ59NdWCvB0UuobpCMHeECj01BJKgUDcrgrQjaTYMa7DxnkcPreJcCLp5zF4gQ9z5jNxCx5t/vi5naL8CyvwvM+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffb8TRna; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a3e7f7b3d95so160374866b.3;
        Mon, 19 Feb 2024 08:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708361170; x=1708965970; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U2fCNWiM3gBWDcPsaPzkwgi85IdpiVc9Yy8EhbZ+rUg=;
        b=ffb8TRnaqWLGpt/qu745qSPZBklYWvumcZUjit7/pDj553xV5rrRc554QMAcc3eSg4
         q8thdMcMSaVOJ7fpwxnJebdUgDbaBk7wcyPsZs2uhFL+1I9Ao3IpZWqjd4sFvwpTtHxT
         dVmuyRTtbYJCdgPIgRXyC3UL8bfH7zi7STyjsoByJHkAcuzgLNSKRc6VQM6G51humL7D
         m7ZlrgxhavpOmwSbl6kxDqi2/tKv9J0UDWYrMA/+NQITItUU6T1kBOAW8STgemO3m0NT
         eaPU4bNvFOmAgZAVvaQIGMTJAFDv+k+26hogG0PanWD2Y9wUsdGOattvlcABIO1ebaXd
         sUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708361170; x=1708965970;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U2fCNWiM3gBWDcPsaPzkwgi85IdpiVc9Yy8EhbZ+rUg=;
        b=uPiG45WeOj5Nj3atzTbHq+Rbj+nRP8EydOTz+VsocHAflplt+BmT7SH8Yu18HGrkPy
         0J/xnG8jffTxn78GOq1uDeFbuMvLrvlCgE7mXdYg2C0arJB5UBX1ZpVgWFV0wJlnDS8+
         9aFOTB1cN6gQnttCb1ES3azWaeTJoRY/3riB7GhUcQZ6pshXguT0p4pNZgWaBXjyOPoY
         TnpDZtZoItzPMbH+Qqhx9Qsi08ZN+61AF1f2NpFDTTP2LJTcu3jqGys8JT4Db8RAMUrh
         6Ru8MHaMHgaaWBJpp1hLHA5nOiyn8YYGyT50WpOjOmxdMB2gh7PYd5p0vgbCBBe3YFXC
         ay0Q==
X-Forwarded-Encrypted: i=1; AJvYcCU48zfFP2Fky347pONQXTuO/d9vnJZoS9Mm5xPjTtdqde2Brg/5sen+q3p+pPqa5UVvhTaq2foICP9FES4I0rQTBaiEQGwIOE1xNheBRmFz3Y+wobeUJqlAJYwHY0AOHsdnjiuUSbAU3/boEZHu5qe/1uXRGgdQ5wyRMR2onmK9GFY=
X-Gm-Message-State: AOJu0YwgJpAIkagCCz5QM4jhTO/MzLah9fGOPjFzuWWvzfoeZVMq0ofi
	fYHZ6DTrgiVj/1CRzMHnIKHP8orCDpM1a+7WyT9Cz7FG/tfflcwD
X-Google-Smtp-Source: AGHT+IHUtbT6N+I5vRkwIChFpp4DaVBQvNMYjkjPPeteBQ6/TCncEmVXPd5Dkwq3bRCdT1mITTsyYw==
X-Received: by 2002:a17:906:a38d:b0:a3e:5c65:9e27 with SMTP id k13-20020a170906a38d00b00a3e5c659e27mr3267359ejz.56.1708361169407;
        Mon, 19 Feb 2024 08:46:09 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id hw12-20020a170907a0cc00b00a3d11908bbcsm3051711ejc.203.2024.02.19.08.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 08:46:09 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH net-next v3 0/3] net: stmmac: Allow driver-specific AXI
 configuration
Date: Mon, 19 Feb 2024 17:46:03 +0100
Message-Id: <20240219-stmmac-axi-config-v3-0-fca7f046e6ee@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMuF02UC/33NQQ7CIBQE0Ks0rMXAtxbrynsYF0A/7V+UGiCkp
 undJaw0MS4nk3mzsYiBMLJrs7GAmSItvoTToWF20n5ETkPJDAS0AoTkMc2ztlyvxO3iHY1cKdT
 ijLpH51jZPQM6Wqt5Zx4T97gm9ijNRDEt4VXPsqz9HzdLLvgFAHtlYIAObz7TQPpol7lyGT4J+
 EVAIboWtQGjjVTmi9j3/Q153SoGAAEAAA==
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semit <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=treding@nvidia.com;
 h=from:subject:message-id; bh=EEl2gY8IYqh43eRkVKCnR+nEv7c8AQM0pRrgpPbjuZI=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBl04XQRSUGlGVcdjCZYTd7+y7ZABIFgrEjyjNzO
 nn98yszDTuJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZdOF0AAKCRDdI6zXfz6z
 ofnBD/9Ra+1UJr4OR3HBMkNheXmxAo23nS23hxgCplfnMgUUIRMTtOoArxbF4SraBlnDFiO1ol2
 S4lq/d6pxJpwMk8NzXUw4mhkZbMC0ZdIkMNQ6swUuD9b+4HLRSlF2blAFkT6j8TuQTkZKH3OiEv
 1OwuMbV2J3DsPYH/R50vrflCaY2qVFdj+QEqLuMLerbknCp8OEO7Rv+QyUeTKLZ1dFHS5QqXkaZ
 ioIPmP9wbhSvTgaoID29Gl4qAjbYm3a2JvgaYjfnOn9BAXnpxv6BB+JGnvO/JOD2ktb5fB2PStl
 plEqcQ3Uyw7S84N+zyti2MMgXegk4bn6KeSP24adJDCdlqCtrQbl1YpIjhfUcLGTa/TIGTs+OwX
 mxdlSaoniOrG9n0JDa7d3ODZiA50G2yQiP9wYscsMZyznTAGauVXZRXljSkp6O8TZz/+Ghldd6v
 iN5HeaBcaBSQLh/JBY2VfukMyRisCMymBIFcY4UhNzeH/o+rr9q9ERKUv4FgnCOFF3KEC7nB5cx
 9yihcWoS56PhiIHW4lRXrDJI++JTUdDLDOVS5Wo1jSn00FergKG9lqTLhJgwciVM+G/16phJ8eK
 8aAqmecwHSMNTvGrlUGoSXiJvcVOBxx3k4y9biWpjRWJ8qT9J7v8y/hvUNY9XI5bYAnFyyQVcCb
 ax0mcUrb5nlU11w==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

AXI bus configuration can, in most cases, be derived from the compatible
string, so instead of relying exclusively on device tree for the AXI bus
configuration, create a method for device drivers to pass along a known-
good configuration.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v3:
- add comments to help explain override logic
- add missing kerneldoc for new parameter
- Link to v2: https://lore.kernel.org/r/20240202-stmmac-axi-config-v2-0-64eab2bab17b@nvidia.com

Changes in v2:
- fix bisectability issue between patches 1 and 2
- Link to v1: https://lore.kernel.org/r/20240201-stmmac-axi-config-v1-0-822e97b2d26e@nvidia.com

---
Thierry Reding (3):
      net: stmmac: Pass resources to DT parsing code
      net: stmmac: Allow drivers to provide a default AXI configuration
      net: stmmac: Configure AXI on Tegra234 MGBE

 .../net/ethernet/stmicro/stmmac/dwmac-anarion.c    |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-generic.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ingenic.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-intel-plat.c |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-ipq806x.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson1.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-lpc18xx.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-mediatek.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-meson.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson8b.c    |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-starfive.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sti.c    |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-sunxi.c  |  2 +-
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  | 11 ++-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 78 ++++++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |  3 +-
 25 files changed, 87 insertions(+), 49 deletions(-)
---
base-commit: 35a4fdde2466b9d90af297f249436a270ef9d30e
change-id: 20240201-stmmac-axi-config-77ea05ea9eff

Best regards,
-- 
Thierry Reding <treding@nvidia.com>


