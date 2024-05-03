Return-Path: <linux-kernel+bounces-167727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B988BAE28
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE691C2262E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A65154453;
	Fri,  3 May 2024 13:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnP/+WAH"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEFF1E4B1;
	Fri,  3 May 2024 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714744513; cv=none; b=b8FWD1HK2uWdgH7MaWQGu6QIVdCRvZXU3E3vT51aj9k2rCLbhDgeLjkoKmuIxui2olStzHXjb1xFzeMwitbJcOQC1vMf6z9JkH7o4kHVpnunDS/ZQv83/UG6Vd4YTRsKvAKia780NmfBlvnUs6Q0b3rZwtz9FAsia9C4u4P9Yuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714744513; c=relaxed/simple;
	bh=X5QO4KOGbGZJaTwHuLYxcPBvxqlKNKY3v1yg8Ls0+go=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RVvxled1de7iV7tov7higxZQilQpDnsaeQlePjys3BXZrHUfHaPMkbTIkH8tu/9EZT+gL36jAtJ96jDpydeTXmJn+wDTpDbEws/gDaqCpNgmRsnWEBrJVYs3SyVnJSCkWyEsejeszXrpSlx69aC8IHnwvtW4JCuo5xgu97DeT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnP/+WAH; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso119073081fa.0;
        Fri, 03 May 2024 06:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714744510; x=1715349310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L64tyzVkGm6ZnLwG0YS7ddVliyJ40mixqMJfBnGOk24=;
        b=ZnP/+WAHe23RMqEfslEiBOSKFJYcyljjMzMUbyLkl+6TR4VBF1iyFDmq4cQwOWekD6
         NXFKftocnRptVC4nLpTopbH6TrY+SKTp3xmZCB5UJ3ZDRaM48aig4HMRMpQR/3jymDbR
         iwBFIwyuKDApVu1oSo6jggLn1BH2+gn44X0l3M/DAMAcKNt91jOdrjZuIV8JBBfOrbvX
         +UR/ffsvOle7Jwzq6p+kq+i71O83+7sVaBE2CemcGOsLJ68aNAeXrLaIjcycts1yeFSu
         SW5mLlFcjlImMvukt5b9QmGJMps2t8II+eJ57y8B5Iad5QQ86bw5fx/gfmiLa6UYa0s9
         fkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714744510; x=1715349310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L64tyzVkGm6ZnLwG0YS7ddVliyJ40mixqMJfBnGOk24=;
        b=p2vBpCxQMBuAEUovyIMVvPjeKEGipG8+zSeapzZZkCA23OohjPKXFPv6roIPFZKybF
         inICllUk6WJ8d6t67SeYogp1ef7uIC9jponBQawSB1rxbuxAXsLyo0gyRCUPnEgqSWjs
         U1+rdvBd6pqIchcZQF0RGwMRH+oTTGZodBLzrDXEEqjIM0EyhCn8mTc1i6Q9pM8T5jCo
         72adsBStKESP87m9riBLqNdruuPJxSfp+z6R7BsCDQ5rV631EsF07UZo70FWFTihUmr1
         H8wwcSKmtnMHCQ8YaKXUKfL22EtPLwuOE4YEGbXc7p8UQbnVdPDMhGDj45lppeN6uf3a
         biZA==
X-Forwarded-Encrypted: i=1; AJvYcCWN/myHjCF6ZqtZhtvAMli3o1PxxoRhaNkEtyI+cbw23AeTcub1loWkq4IpvzO9VxpwCC6P9u3Q05fuXoJmXDTWGXl2iTIzisWW5dyYJ01zv5XvLsQlGBv0C4M/UB4pKe4ChIbdCkMRilDm4hi3hOFUUXM3sJiP4NFGeYGJstitP5QSbTU=
X-Gm-Message-State: AOJu0Yw0vPA5P5qYsMdjap8pmM6BqOaoMdvKhETh7yMwBlFVt1kVOJqO
	hYWSrY1XcYmGY71xk6nO3pvmtQpftA5ddGu34GjpKwrPk5yyXHWD
X-Google-Smtp-Source: AGHT+IHOl2Kg3iE9iM1nr2DIDcmCd8kOUd5tYMdL0fsi38kQMMkhUD5Ya7t8EhoQuCDZq7gW456EGg==
X-Received: by 2002:a2e:8208:0:b0:2e2:902:e664 with SMTP id w8-20020a2e8208000000b002e20902e664mr2160236ljg.45.1714744509400;
        Fri, 03 May 2024 06:55:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id k8-20020a05600c1c8800b00418a6d62ad0sm9537339wms.34.2024.05.03.06.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 06:55:09 -0700 (PDT)
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
Subject: [PATCH 1/6] mips: bmips: BCM6358: make sure CBR is correctly set
Date: Fri,  3 May 2024 15:54:01 +0200
Message-ID: <20240503135455.966-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240503135455.966-1-ansuelsmth@gmail.com>
References: <20240503135455.966-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was discovered that some device have CBR address set to 0 causing
kernel panic when arch_sync_dma_for_cpu_all is called.

This was notice in situation where the system is booted from TP1 and
BMIPS_GET_CBR() returns 0 instead of a valid address and
!!(read_c0_brcm_cmt_local() & (1 << 31)); not failing.

The current check whether RAC flush should be disabled or not are not
enough hence lets check if CBR is a valid address or not.

Fixes: ab327f8acdf8 ("mips: bmips: BCM6358: disable RAC flush for TP1")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 arch/mips/bmips/setup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
index ec180ab92eaa..66a8ba19c287 100644
--- a/arch/mips/bmips/setup.c
+++ b/arch/mips/bmips/setup.c
@@ -110,7 +110,8 @@ static void bcm6358_quirks(void)
 	 * RAC flush causes kernel panics on BCM6358 when booting from TP1
 	 * because the bootloader is not initializing it properly.
 	 */
-	bmips_rac_flush_disable = !!(read_c0_brcm_cmt_local() & (1 << 31));
+	bmips_rac_flush_disable = !!(read_c0_brcm_cmt_local() & (1 << 31)) ||
+				  !!BMIPS_GET_CBR();
 }
 
 static void bcm6368_quirks(void)
-- 
2.43.0


