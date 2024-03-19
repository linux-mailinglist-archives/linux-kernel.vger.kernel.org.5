Return-Path: <linux-kernel+bounces-108183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CEE880732
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E3111F22DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 22:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D0454BC3;
	Tue, 19 Mar 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtZA6t61"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729124F5F9;
	Tue, 19 Mar 2024 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710886646; cv=none; b=SjPcXhXqIwuh4b96t2lYZEP11l7kcKrDA/HUyVrsl5V9XsXrMBMKyVBgxIIp8Yej9WTubIZip1NOQX1ClWhLcy7LJxVC6U0iVxQgXAEbMZUwYHwrPMum+ejDyLe0ULArWUG8NsPgtrWY5cq0rnBbntoyw96wOgSq0rrOUdADaMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710886646; c=relaxed/simple;
	bh=iSWaMEWDug/PqAcpOySOPvs1GqiZV7u1C4XYEixAJCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ot612y7tmShKUDBIqQ7X/tRPxTJ5w8SyNyp5OXMJKSFQHmrZx5qTV6kIU67g5Iaw9eQJOcAq6iFogQZCASTZPNPcfa/OtwdjD/44LPyjU/JRnKG4gsrAM5YzMrY0iSEGNOed82pesDCPumedBDDcb47y658tce/OdxVTIa6KFUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtZA6t61; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56ba73c02b2so765141a12.0;
        Tue, 19 Mar 2024 15:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710886642; x=1711491442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSNk7Vf1g7S81rJhVAJNnvcZ02nEXYFCinajVc9WiKg=;
        b=jtZA6t61Cp8qIl7A1LRA27ekgSA9h3CbMO5+RrTkH7geKuJb5svNaRvdRyOniILrEj
         wnF7eJOyB9HRpX7sZ/gNZGnhmGUEG7HUrmW6RRN1cEkJQwTnMsbNHFje1Tfn4CGaaCfb
         p4jVWPY2xBZJqIZpZLtzDJHY9Q7X19XpSLR00aJ0c+0fy4099212J2OJtNttnoTHxA/q
         pSqZbp8NDWYbJP0obajERx3etm9iBs9IAfB29H6dsqGFkTkd7A12KIP1kCoQHbDUnBlG
         G11SrYErxVLndnIfGOJi+9F0aLy9i3xfeTMLG/lnnSWwP7IOlVFFBizmNze0aUbH37Uj
         ig1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710886642; x=1711491442;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSNk7Vf1g7S81rJhVAJNnvcZ02nEXYFCinajVc9WiKg=;
        b=R4Mg3yeqUrvcGzUI+V9mq3s2+98j9rys1WUgckF8WQMupu2obotfoDd3egL8OK74Vx
         JpZAF44c9yEKZdeovhfRbpIAQ745P504Jo3+7LQ3pcAXpcYtzEVZw5mM+Z2ENk591E98
         l3NqaQdIMFbuk2C8EqU855BzRiSUkYXnVsEmCRtL3PtrOnzbSJ4Q/I7ihexJKIT27kk8
         4jA3GrG0W/2ld7h1VJ5V24DF2CHNiABVseBmyhJDE4Bq/2OOAs0B44M7UM+T/Nnclk1f
         XevOnk5oOy9P1XnqSwuZYst+qwWyPOjFluzjdHRAKX5tWjqfrWJJ4j7o3vBsHCTgWVxk
         LaJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZds5yINfqgGTDg95y1A4yqiWMt/YNozlDen3WgRspe7Z/6pJN6COmgfnRq2uQefvJ+JNXKl6YCnp7HOjWHTmka2IP4CvkdauU4dimwdXMjuqdzoVbnHISGqExF1TgersxrHTb9KP09No1lgtQtPwIO7o1jhA5c2TyxAm3KFLktZMI0iKhMw==
X-Gm-Message-State: AOJu0YxphkJ6LdULXh/m9/JcTLG1tG7Dqa/lxUhwFKudngHe8fXtX8NY
	63dCrwwJi9H288aShz1WYCVyc4RvhFvKYOdnwj22gmT1Uj6tLg+b
X-Google-Smtp-Source: AGHT+IGMRTODL29KcDlbOCHNLwkDAaChUKnvdXRP1BG+7isiw1RpTe6iNe5o6suqQifNVnwSPURhdQ==
X-Received: by 2002:a05:6402:4499:b0:568:c6df:d23 with SMTP id er25-20020a056402449900b00568c6df0d23mr6871268edb.1.1710886641585;
        Tue, 19 Mar 2024 15:17:21 -0700 (PDT)
Received: from bhlegrsu.conti.de ([2a02:908:2525:6ea0::11c2])
        by smtp.googlemail.com with ESMTPSA id n13-20020a05640204cd00b00569aed32c32sm2761182edw.75.2024.03.19.15.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 15:17:21 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: 
Cc: Wadim Mueller <wafgo01@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Chester Lin <chester62515@gmail.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Marco Felsch <m.felsch@pengutronix.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Marek Vasut <marex@denx.de>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/2] NXP S32G3 SoC initial bring-up
Date: Tue, 19 Mar 2024 23:16:08 +0100
Message-Id: <20240319221614.56652-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This series brings up initial support for the NXP S32G3 SoC,
used on the S32G-VNP-RDB3 board [1].

The following features are supported in this initial port:

  * Devicetree for the S32G-VNP-RDB3 
  * UART (fsl-linflexuart) with earlycon support
  * SDHC: fsl-imx-esdhc (SD/eMMC)

== Changes since v1 ==:

  * fix the reported checkpatch.pl errors. Two warnings still available but can be ignored
  * clean up unneeded DT nodes and properties
  * fix 'make dt_binding_check dtbs_check' errors
  * remove the S32 STMMAC driver and DT node which will be introduced in a new patchset
  * add NXP authorship and copyright into the dtsi header
 

[1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3


Wadim Mueller (2):
  arm64: dts: S32G3: Introduce device tree for S32G-VNP-RDB3
  dt-bindings: arm: fsl: Document missing s32g3 board and linflexuart

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 .../bindings/serial/fsl,s32-linflexuart.yaml  |   3 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 arch/arm64/boot/dts/freescale/s32g3.dtsi      | 236 ++++++++++++++++++
 .../boot/dts/freescale/s32g399a-rdb3.dts      |  43 ++++
 5 files changed, 289 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts

-- 
2.25.1


