Return-Path: <linux-kernel+bounces-49798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AFB846F86
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B364B2B1F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF813E222;
	Fri,  2 Feb 2024 11:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9QVJac9"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54F713E202;
	Fri,  2 Feb 2024 11:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706874826; cv=none; b=PFLPk71K3rbR8vvGHGXCM1JZvhtYSfMmpjfVQws4K3qKpeETDPLE0GD3iqdRxry12N7cdtoSiQD76FGz60wYxsAbv8OqGf98EYQm+ifLY3HHfz+bZJsjKSHZULksleHCC3YNwuQZPH1eAb/VSO+xLe7bO1hLwLyHeCX+cPRX7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706874826; c=relaxed/simple;
	bh=2Fi6uD62P5Yg1+WAmH8+Q39MZE72Tw9+Nbbc48m0FfQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FSzqEcysE3Ly9yPryr+RdLRTMPalPrCDvSa5ItHukaewiKfeycQtddfEfKb7swCcmnY9y3fKlcdIU8Qu8uu3G9Tap1cs7T1uPxcZQBOJqjpZza0qvBM9TOgVUzhK5CyKvc6J+hgGWqZ9LQ9XGKIupx3kpHAW6ivUsr6MbedAp2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9QVJac9; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a370315191dso74554566b.2;
        Fri, 02 Feb 2024 03:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706874823; x=1707479623; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cElRODCjC8UJ6A1BiMBGDabPtQgXz8GNgekyJrxCdpE=;
        b=b9QVJac9QQWm4ZsGA1raWUpotT98Y/PuxuAoWsMtxueDLdy8xensdBVfBUQsOtP7il
         k2bpaIZtx1ZwXh/GSsQW6pqvEArRcoG4KWvCKGX2lc+d/l8o56X0ZnwiJpYM6qqHHWZM
         UFK8rirGh4nTDGscYaBZKud431M0N0xugXpIuHJTFp8vTjecb73ZxYiobg5Rg1nJhs+Z
         /qoyBSBngE2OihSQ3Rv2haS97EfgQCrjqjIr4ncYDiRDUFl/O0lz6MgoCnxlJIvltG5b
         HIzyko4GCh3zYvcDVdrqJOSKP13WEZZ8wzLI8/oK462n9rxx9THwBkit7769/nW6BCiW
         ctog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706874823; x=1707479623;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cElRODCjC8UJ6A1BiMBGDabPtQgXz8GNgekyJrxCdpE=;
        b=bNp6PebqK2ldhjLufDZ1mbOerOt1IYYqHad+rGJtIEcwZW0ur0KjDxdAdj767aw53d
         uqfnWXbWn6RbhOqr09aCW4bQZzgP0QNBBzNJzqW4L3OBgM+GbtFxXajR/X750rPeIOCb
         3lAraUQvu1tMApt63JSr6BV5lIwUewXxmg+wksJm0MjDR0TMavEAVKWfZvk9zJOjLhsB
         uoksz8Qq1WsqYM/dcI+UpKpVcjhcdMPu+bPXrnEXM3EK7+Be/rgTH8cYmsF57dp4I2bQ
         OpS2OzpmG+PSd4NJdOFnPgvNPKAKoEFlXuo4keSVvZU5Fj0/8EQNBd8c8VUsxniUmtYW
         cVMg==
X-Gm-Message-State: AOJu0YzVG3E9HCVUUJrkW8qazQMapynsRRvj8/ySMnLlI3AA4QPCMHGN
	bPk+gG4xFCVDMNUujTZ5lM6d0OmUuqD0YYgU/ORlKcSQX8/9haXa
X-Google-Smtp-Source: AGHT+IEJTHGC+v13fgVvyRQAj1XcHy8pMiYKB3TmEpBtFRyFcsQvvU3UmipyFA1ismU9PrKI/lBNBw==
X-Received: by 2002:a17:906:b2d4:b0:a31:8d44:99d1 with SMTP id cf20-20020a170906b2d400b00a318d4499d1mr3752100ejb.12.1706874822695;
        Fri, 02 Feb 2024 03:53:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV71sQHv1MhhN+H6zOv8SWlq9HHSzB2B+5Rz3E8gt2yhQHOhrR4aFyXD8LXq+v0lOXtTOW9ODBoNO4YissBfgMJHtEriHGFxLEIW/kpDHVSbjeWrtuN0crC/1/Z3zjxn4K7+7GyKN2bpvlodqUSg1HucoQEt+1tVw9jZeM7DxZgypVHN68wwjUYPFKXQrWxYuqHhlM+hbfR+q8tvMJQzBQwJY3TPG6E1JfqHejNUb/kN0LZ1/OytqxzsP9D2HG7vCJcHEUBGLvN5e8pO/oYQzSMN9MFaxCyTq+oRPHP36hmIKzHoAkOvqRiJniwhUSsI54XKSFqQIDWGzB1Kqh3/eydcmUxNx+lZGEqQLElDYowX/4hvmwCWZtU1wW1euU=
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id o24-20020a17090611d800b00a35e3202d81sm802192eja.122.2024.02.02.03.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 03:53:42 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH net-next v2 0/3] net: stmmac: Allow driver-specific AXI
 configuration
Date: Fri, 02 Feb 2024 12:53:32 +0100
Message-Id: <20240202-stmmac-axi-config-v2-0-64eab2bab17b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALzXvGUC/32NQQ7CIBBFr9LM2jF0omJdeQ/TBcLQzqJggJCap
 neX9AAuX17++xtkTsIZHt0GiatkiaEBnTqwswkTo7jGQIouilSPuSyLsWhWQRuDlwm1ZqOubAb
 2Htruk9jLejRfELhg4LXA2MwsucT0Pc5qf/g/3dqjwjsRD/pNjm78DFWcmLONC4z7vv8AyLfT/
 r0AAAA=
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2445; i=treding@nvidia.com;
 h=from:subject:message-id; bh=2Fi6uD62P5Yg1+WAmH8+Q39MZE72Tw9+Nbbc48m0FfQ=;
 b=owEBbQKS/ZANAwAIAd0jrNd/PrOhAcsmYgBlvNfF7t3q6ozLOE34PMK/Lq8wJBywTc1EZ197a
 aKpt1FtTSaJAjMEAAEIAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCZbzXxQAKCRDdI6zXfz6z
 oRMUEACRPiJDtcPM8d2BpaIjQB5ftFDCOUoCdNPo8+iwVKJrf9gi+msdAGY2UStiIlt9dmeRP/z
 UdcDMjmKCsVTx91Svd1fnBqpXJ9NTzTMd7YdBJ7IeWbGSbNxSfRiwMoVBQMFILQzZk4ZdxhNVYn
 lBEgVDsxryVum6TF6Og8yhuwqxQdJGxYdzDAjJQ/1SQMBTxu9qjfw1A8gBrUqHfcAGpNPNtnOqX
 kx/+DNvXI7axRcpz3yf8LE3Z45TJhC519Z2dKteAKm9X04eCPc1so+uULLCKODvjMsI2kFpG4yY
 YhVYo8Agol15t+98QLT0c5y48cnVjG1tuy2ZGi5/T5YIlgvkppk5cWhRQ3p7mxV6WjC7ndiLrx6
 lAvDd43OFDOUWoXu8O3/O88w8qZkgCaaBN64fUMgXmlKN1frEST8ub0ywtxZgo6pYx/U9PmuACy
 S50/R6DlFJWdxy8hrKyZLVju0OZJ8LT0A+AWLaPkpH3cPtRYGNzGlV6kn+9/jIUjJD+bQQTsTMf
 hKW2ivMGAJnotWKnyb83IHOL6tmMcK/2uy4Pq5woCciPVJwtG/wCIT8Q0RIywPevLRohTOC7w2l
 iQ67aLgtcbG3l2FdyWv5hx2vjUomjBglyKVfkDmJgwKW1BXa2E3E0B8W6upyOU5xwB2HWDSpgoR
 tGgk2wg6srPE1Sg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

AXI bus configuration can, in most cases, be derived from the compatible
string, so instead of relying exclusively on device tree for the AXI bus
configuration, create a method for device drivers to pass along a known-
good configuration.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
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
 drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c  | 11 +++-
 .../net/ethernet/stmicro/stmmac/dwmac-visconti.c   |  2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac.h       |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 66 ++++++++++++++--------
 .../net/ethernet/stmicro/stmmac/stmmac_platform.h  |  3 +-
 25 files changed, 77 insertions(+), 47 deletions(-)
---
base-commit: 076d56d74f17e625b3d63cf4743b3d7d02180379
change-id: 20240201-stmmac-axi-config-77ea05ea9eff

Best regards,
-- 
Thierry Reding <treding@nvidia.com>


