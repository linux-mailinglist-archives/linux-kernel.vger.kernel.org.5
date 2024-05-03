Return-Path: <linux-kernel+bounces-167726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FC88BAE23
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 008E8B21A5B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0675154433;
	Fri,  3 May 2024 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUJL8gXF"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532FA153584;
	Fri,  3 May 2024 13:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744511; cv=none; b=aPoBpcXoZ6Oqv5YOWFiBNgnF9smL4euXccYoOMBkMW42Scpa6yossQaO1DAKhI+RSOfXhql+0T3JoGYVTE6pubvTk2uzrqj1d/Ej4MZY+bHLGU5SPom3kcs29jzN1unAkH1rTh79Hg1u9hRiIF9BswIMw938tDhU/dvUnAhkxfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744511; c=relaxed/simple;
	bh=1TqRqX0vchG7ZeLj5rZpj0bbcajRLFLaX86OmUcFEYk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dAFNgMF/Ii7aQjjGsI630QnYvM0PZHGPPh/HOKQYrwtWxNdR5IzoYcJYxjXyfT8qjvUoPyREYhMUPUnwMg1pTwDsghAzzFNjSSkaQK4eok7gmYf2gp4j5soNuuAsbvDMM/aR7+kn4RuHZ6M0oj7YqSC7MReixjvAPTXClOk0Q7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUJL8gXF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41bab13ca80so53659785e9.0;
        Fri, 03 May 2024 06:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714744509; x=1715349309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2WBNj/VR5ac+nTFLoYRIDIw/3Obo4NiY5moJd8YisDE=;
        b=EUJL8gXFtHjfNAKHZvcdsi41XuhDNoxjV0TPrwotwUC24TgRu/5xainh0j1XcYbnNE
         WvPQz06nTLWrurHENIRnm7QEb9xZvVRUTRkA1JnLuZaAG0OFwNNXhaPWEobmiZKpCL+L
         e4HRRIMyNv1ihN2+GPyC7GpitavsEDoIzHBdMDFRFMNIePMp3RinTvwb0VhjLXeLe/g4
         Bf0QHZENDUFQxZCNBc7r/RX84cEAwvs+Ue9/WQOj98uVpjYgrn3bCdsrm9mffdo9hQ+5
         /STGQrmW7HE6CPZXScGdlZ2L9nyUe02NmwbmIBr656Ohcs3h+uKqF8lzaRIy5OVVL1UR
         NfJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744509; x=1715349309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WBNj/VR5ac+nTFLoYRIDIw/3Obo4NiY5moJd8YisDE=;
        b=WcmG+1mELBuqM4XkHyjpgnIGKI2h0UP92SS7EHW4GW8SfQKjO/w34Gj4+K8T88D7Mk
         MmHXltd9Ufa7X0UgV9iowZv14pbzfG2TyNr1LrCR/876vCn4JRKr5phRENITPKcpGAj8
         R6szQiJZa7DqTtrCfZ4X/skC0iDzUisirIF3MHqjZty5L/r9Fw00H3Yynsex4VRzXqDI
         wdtCYnDrGw66J7uqFMaoYs7LNHJOUIvq0HPME57Hve9jdkBCCmoYVS0PTYndYli5Md3s
         txKMj1XzF8fn8GBi21ZsVfg7vXqQ3tGo1ubEb3bKPpvCtBzuBLHoJp7n+dllxASqPfO8
         8b6A==
X-Forwarded-Encrypted: i=1; AJvYcCUqQnX00839TKt8DS0FREEp/TPfZPBvotVqLnAK5YZEtwhAJ3mrsjg4puLym19trXONXSIsLjeNnmcz2lwD1tXmJLaJ6lk5ONxjY2b0FItHU8CujKYpw+L52CffopobGT8o4nC7w/y7HuPwtsHaZJjgYY61vlF/K4VOdVq1bEA0ctnT/IQ=
X-Gm-Message-State: AOJu0YwVhY1t6h3vqvUE2IwMR0vOOFnXlbOjCpX7TIFBYDkI81Si2K2y
	sZkD7ReP7Z74UEwI95AlIrE2SK/E8bR9noehBkk9hAVJ2zvcC4d2
X-Google-Smtp-Source: AGHT+IFlrskj0LqTQQGBB2GxKrC+k+M2iyDA1OCBcbk+lQHMNMS0NoKYDT2EiE1y1YB/7xg/An/L3g==
X-Received: by 2002:a05:600c:19d2:b0:41b:fd63:1981 with SMTP id u18-20020a05600c19d200b0041bfd631981mr2042633wmq.41.1714744508331;
        Fri, 03 May 2024 06:55:08 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id k8-20020a05600c1c8800b00418a6d62ad0sm9537339wms.34.2024.05.03.06.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:55:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Hauke Mehrtens <hauke@hauke-m.de>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	=?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>,
	linux-mips@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Daniel=20Gonz=C3=A1lez=20Cabanelas?= <dgcbueu@gmail.com>
Subject: [PATCH 0/6] mips: bmips: improve handling of RAC and CBR addr
Date: Fri,  3 May 2024 15:54:00 +0200
Message-ID: <20240503135455.966-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

this simple series improve handling of RAC and CBR address and try to
upstream these simple patch we have in OpenWrt for a while.

The first patch fix a straight kernel panic where some Bootloader might
enable RAC but misconfigure the CBR address. The current logic only
check if RAC is enabled but doesn't verify if the CBR address is usable.

The DMA sync function cause a kernel panic for invalid write. (as CBR is
0 or something like 0xa)

The second is preparation for making the CBR address configurable in DT.
Since this address doesn't change, we can cache it and reference it with
a local variable instead of calling the register to access the value.

The 4th patch make it configurable with 2 DT property, one to actually
set the reg and the other to force set it.

The first property is used when CBR is set to 0. The second property is
to force it if the Bootloader sets it to something wrong.

If the CBR value is not 0 and is not forced with the second property a
WARN is printed and the DT value is ignored.

The 5th patch enable RAC on BMIPS4350 and the 5th patch is a micro
optimization to skip more call on DMA sync to save as resource as
possible on low spec devices. (since DMA sync is called many times for
the Ethernet Switch and we can reference the bool instead of checking
the CPU type everytime)

These has been tested on BCM6358 (HG556a) and BCM6368 (VH4032N) and
reported correct functionality.

Christian Marangi (5):
  mips: bmips: BCM6358: make sure CBR is correctly set
  mips: bmips: rework and cache CBR addr handling
  dt-bindings: mips: brcm: Document mips-cbr-reg property
  mips: bmips: setup: make CBR address configurable
  mips: bmips: dma: drop redundant boot_cpu_type in arch_dma_sync

Daniel González Cabanelas (1):
  mips: bmips: enable RAC on BMIPS4350

 .../devicetree/bindings/mips/brcm/soc.yaml    | 32 ++++++++++++
 arch/mips/bmips/dma.c                         | 12 ++---
 arch/mips/bmips/setup.c                       | 36 +++++++++++--
 arch/mips/include/asm/bmips.h                 |  2 +
 arch/mips/kernel/smp-bmips.c                  | 50 ++++++++++++-------
 5 files changed, 102 insertions(+), 30 deletions(-)

-- 
2.43.0


