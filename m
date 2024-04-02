Return-Path: <linux-kernel+bounces-128586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F78E895CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9121E1C227DC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6A15CD47;
	Tue,  2 Apr 2024 19:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDDmubN7"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D328415B98D;
	Tue,  2 Apr 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086553; cv=none; b=FMt7S+MVfuWDaHoUugWsL3gu1RbaGsBZutFMRbQk2l8PcLrpbv1iD0+MiWoNae3AmJLMkYoOTXB7aSwkfsA4pPKbi9JphXQp3C7AQenKcm/3Vz1IqLCcXd5k07xyJb85I5hM+GyKJSVc0sr2VJEHrhM1IseJqmvtk7weoRdxU+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086553; c=relaxed/simple;
	bh=w6Zk1mErBPhMR/fPvTKIp80OCxzxeQAfQ1sc1ZTrGqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WoUSRRR4zIvwXeQ8jQc8Bt1THdMMbspr83JhgpCPQsD23rmblxfNqAjuvgWdW0A9HaL8vWt+sZd1XEu4CrmyKE/CPuZRC1Vre1y8vxJV1NxU+XX2lzWrvauDpB1Zf+EZhDtB0MxuXmjW5Qw1eFKuEBgkbPNFRKyZe+0CE3EjFRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDDmubN7; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e252f2bf23so20047405ad.2;
        Tue, 02 Apr 2024 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712086551; x=1712691351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RngipVMjADW9RKKBJpWn5bUjtga81BHfJMQO2kVCeRo=;
        b=iDDmubN7bBC0VOVb5112L5WvoOojpQt3h6f2PliJqCTU2ASZcz/Qe+2VWo7hdWBgdk
         NJxQ7XjcGL28dMZwbiYV0//DIfLn6EE3SIAr82WuDE+iB3Cq62Ff8+M1zoD+woDw8IrR
         wsB+17XGJGmcangPeL6K+xDjejEOO96i1Rpi7A5j4Uau/VO+lYtCKA9nBj2/wjcaE9yy
         BjfkBVaWlDQD6CliRIJuRcpq4F2Dy2jVgHpZXWnaoXpHPoovtXjRiIBnXtNBs6/pe/oD
         64MSQmU8jEmoIx6uPQHGJxZ+aJesloekjpz7FVM47DJVBMjCGueIUMpLNRZIoJCsvZWj
         JaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086551; x=1712691351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RngipVMjADW9RKKBJpWn5bUjtga81BHfJMQO2kVCeRo=;
        b=ccq2SJgZvIyZ6VGg2cwQho5rvGo3duw7Q2uXTqxX/WcdTwg0f71y7BZ/oGCz7Nmddr
         Cv2UW4u0WuYZ7u0mjQdUH/P524vP0lrnJj02tuXOcuWG5Z1BoXx/JGvmA/Zl94eoKlWi
         nPH9UDfdBkup670ay7NiLRPJG4mLnyBy3AXkKm+WDFLL9ZdKvLU9fhOulx5W8s6gSeBV
         msyJ80kfx4Je17lXH41S2HzR4HYzjvV1QT1x8x+Zv7LzlU0mqOn58TZRI/QBlyUCu6DF
         q3jxrXbLBQONb38e4oaLXJUwdkU/LHLfLSSqc8ZbRwjpu31VyxsMl1avEHZU8sbdW2PF
         r7gw==
X-Forwarded-Encrypted: i=1; AJvYcCWWRQ7LdKRCj1q6ZM2XjdKKGThJJBGc6sKgHZDT+Tc5mudESdmWbupwysy7/ZT9ox5mF0t1goEthdy+hOk0070EMF2DPEqTYnq3uWLMfrkSX3WwQR1bIYwxuZmp2NfzWm6mPTeoZdnVFQ==
X-Gm-Message-State: AOJu0YxuMAI68Z1lcn5qoxRiHaBqI13BOn6LttMgN0t1uid+6UqmK572
	7fCwY0j1E537Cuswtj+hClyqBNjD9jERi5jm3FZ9BDLg3M7lSNcl
X-Google-Smtp-Source: AGHT+IHkn8aFme4OXrpn85RNfDGAyTRZqwdG1hTXtcrnOUJFUUK8ztRNaqtmIG4ZzSBOiQNLb8Lvmw==
X-Received: by 2002:a17:902:e80e:b0:1e0:1486:e80c with SMTP id u14-20020a170902e80e00b001e01486e80cmr732619plg.7.1712086551183;
        Tue, 02 Apr 2024 12:35:51 -0700 (PDT)
Received: from frhdebian.. ([2804:14d:8084:b86e:ac17:f518:b547:13a8])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709026b4600b001dd59b54f9fsm7775841plt.136.2024.04.02.12.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 12:35:50 -0700 (PDT)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hiago De Franco <hiago.franco@toradex.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/4] arm64: dts: freescale: Add Toradex Colibri iMX8DX 
Date: Tue,  2 Apr 2024 16:35:08 -0300
Message-Id: <20240402193512.240417-1-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

This patch series introduces support for Colibri iMX8DX SoM and its
carrier boards, where the board can be mated with: Aster, Evaluation Board
v3, Iris v2, and Iris v1. This SoM is a variant of the already supported
Colibri iMX8QXP, utilizing an NXP i.MX8DX SoC instead of i.MX8QXP.
Therefore, this patch series also adds support for the i.MX8DX processor.

Hiago De Franco (4):
  arm64: dts: freescale: Add i.MX8DX dtsi
  dt-bindings: arm: fsl: remove reduntant toradex,colibri-imx8x
  dt-bindings: arm: fsl: Add Colibri iMX8DX
  arm64: dts: freescale: Add Toradex Colibri iMX8DX

 Documentation/devicetree/bindings/arm/fsl.yaml   |  7 ++++---
 arch/arm64/boot/dts/freescale/Makefile           |  4 ++++
 .../boot/dts/freescale/imx8dx-colibri-aster.dts  | 16 ++++++++++++++++
 .../dts/freescale/imx8dx-colibri-eval-v3.dts     | 16 ++++++++++++++++
 .../dts/freescale/imx8dx-colibri-iris-v2.dts     | 16 ++++++++++++++++
 .../boot/dts/freescale/imx8dx-colibri-iris.dts   | 16 ++++++++++++++++
 .../arm64/boot/dts/freescale/imx8dx-colibri.dtsi | 11 +++++++++++
 arch/arm64/boot/dts/freescale/imx8dx.dtsi        | 13 +++++++++++++
 8 files changed, 96 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-aster.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-eval-v3.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-iris-v2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri-iris.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx-colibri.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dx.dtsi

-- 
2.39.2


