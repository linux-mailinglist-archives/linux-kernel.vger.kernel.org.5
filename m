Return-Path: <linux-kernel+bounces-16723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4789A8242F4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBBE22828A0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471C3224C6;
	Thu,  4 Jan 2024 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S2g4ucTG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE6224C8;
	Thu,  4 Jan 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ced19f15c3so60566a12.0;
        Thu, 04 Jan 2024 05:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704376056; x=1704980856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fJx2eUA4QrYnTkHv2f8bxgNQumbRSXupaTSMFkEsx/A=;
        b=S2g4ucTGZmQPv3XD4PCNEM3hD3vYdsRnYyJDsUi2zPHz86fiDn8FUva+XDXGolCqOV
         b+scMK0nkWpSxnoW6z4mS3lBCodTkEXJ3h4kOkFOxmHIqcz411YAavaBUBGuyZjKGN/f
         dOuI2Zjo5T7Sfs8JO6yTxkcRlQdrCBzDp7atFS3YzAwtIGNPqQn/Qmi+tr/REzSsxIyA
         M8HlaVDi+gk/EXm7xJErz8lE581Ki4SFahXBs6PMINgU94iy5K6ybEK5dlFr1uDEWwN2
         FDzVOPhEJuA9za/3nM0lzqF86rwTBPspxoWxca/fBcJ2Kg5xUtTm5asEkw+rmu7wNH4Q
         JRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376057; x=1704980857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJx2eUA4QrYnTkHv2f8bxgNQumbRSXupaTSMFkEsx/A=;
        b=IH4uQwsomlEts7u2H91vchykJw9WGotsOq+4xidx1EziNkJRo9iHQwGXfE6nvyHW9X
         Z1QmcqOPtw7ox7THTx/vYn8G9NNxeG/9TSDB3RFa1agZ3e3BYUldqHDraBM/9+ylsFkE
         Bv/IFPXOwdYnOajycEQwrJs7rKu6KfTim3zF8cPUUcpROH8KcyA03ihWbYp+yy1tYpsM
         WBra40HcYMZrizG9ywQrAqWEX3SWf91ZV5if/eyEHyyRM6amzEq0cKwk0VeDaKC5dhPy
         +rKYtwwNWPTVLHWxb3/O1GyulLoJ4ZGe6qR7pthR4USAr5dYDgx52TvMs+WCNJtr24ny
         t4XA==
X-Gm-Message-State: AOJu0Yyt3U8EMLn7QaI+422dk3qTFuPrSTmaTxkL+kwSUnCnWVyLJJee
	k+rVtKCHJT7A1hl0zVNmGMOBPo2pQV4=
X-Google-Smtp-Source: AGHT+IGZE/NXOWgtttp9e1/3lUPaoamjSYTfEqRWxFDRN7DGmeWnR15SllW87KhGw6a8ee0ispOstw==
X-Received: by 2002:a17:90a:bb06:b0:28b:aab3:ad45 with SMTP id u6-20020a17090abb0600b0028baab3ad45mr530121pjr.71.1704376056685;
        Thu, 04 Jan 2024 05:47:36 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709027d9600b001d425d495c9sm22990550plm.190.2024.01.04.05.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:47:36 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] Revise Meta(Facebook) Harma BMC(AST2600)
Date: Thu,  4 Jan 2024 21:45:26 +0800
Message-Id: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta(Facebook) Harma
specific devices connected to BMC(AST2600) SoC.

Base on : https://lore.kernel.org/all/CACPK8XePx+PvDKzPMjPRn_g9z8yrtAmLvP8Qbepm1AVjuCbaKw@mail.gmail.com/

Change log:

v1 -> v2
  - Add infineon,slb9670 information for tpm.
  - Patch 0006 - Add PDB temperature.

v1
  - Patch 0001 - Revise SGPIO line name.
  - Patch 0002 - Mapping ttyS2 to UART4.
  - Patch 0003 - Remove Vuart.
  - Patch 0004 - Add cpu power good line name.
  - Patch 0005 - Add spi-gpio.

Peter Yin (6):
  ARM: dts: aspeed: Harma: Revise SGPIO line name.
  ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
  ARM: dts: aspeed: Harma: Remove Vuart
  ARM: dts: aspeed: Harma: Add cpu power good line name
  ARM: dts: aspeed: Harma: Add spi-gpio
  ARM: dts: aspeed: Harma: Add PDB temperature

 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 38 +++++++++++++++----
 1 file changed, 30 insertions(+), 8 deletions(-)

-- 
2.25.1


