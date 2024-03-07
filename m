Return-Path: <linux-kernel+bounces-95938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF2875523
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3180B1F213A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7C6130AE5;
	Thu,  7 Mar 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L6YDjfJd"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257B612FF6B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832516; cv=none; b=Ew7Y4ZAr3lEmT00yW/ZJ1VP2azZJnIkhmdkMVLkeohBFqEP9wBvBiBRtx8Uv+FbmuUHYfWxjWKlgFbO78awvkrTpH/9LmVyH+vnemdJl2RBJVtzaPEyNjk7fUiLJ514aLydc0zUnoNVOHA0Izx8V8c72LVpBw3riA25nCuXB1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832516; c=relaxed/simple;
	bh=eUyO9rhMXVKn01pAFohb0VUY5VmkrCydR+ew98YHgpg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R3mCubS2cwzvrrrsUX2/dEH7seqexP5xmNteytpQjlOguASgJYqt597MH2XgI2qlxDDqzqIcFWQo2YB64fys7jbP3i0dpLHUmM+i1QMVDbl94k+Jrb25c/BvMdEnCuh/DYDHb6EgggU76tzAI5jEWhAGezgQchVVm/GhXmgtMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L6YDjfJd; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C1DD51C0009;
	Thu,  7 Mar 2024 17:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709832511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvqGNYjR4WC6GopVrnu5/4J2kVdfdEOltg3boap4Qro=;
	b=L6YDjfJd5Q+nUDymtN+wg7vcVQ7Ts0mKC8gAycf1oRGEhcuMOHZnYdQxVHwuFBgTwD3AeD
	8McWOKf4YvR+OgOT2XeO/xpCN9+cF2RfXgEqGxGbcZPWWbuaDgg5Al0m501qQ7t9QVioxr
	C+PByjymJ8XQ/lnmuFdRu9VonOfjPZTa2fFE1XfdtZ08dXM/ijSbPuM3AhwvUDivN1ANMs
	hTZ4p+BjwFztF2Mcmg8YH7f2GZDO3MJYkAiaJPWlqg28PulGFdDDJLzDxaKRYr+1mja4rY
	Zku1cba1FjB6HzIhXj+oavOMKMWvoi4gPj1WKbfDguD1s10MjYZmEK6dz3qKOQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>,
	Linux MTD List <linux-mtd@lists.infradead.org>,
	Linux ARM List <linux-arm-kernel@lists.infradead.org>,
	Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	f.fainelli@gmail.com,
	kursad.oney@broadcom.com,
	joel.peshkin@broadcom.com,
	anand.gore@broadcom.com,
	dregan@mail.com,
	kamal.dasu@broadcom.com,
	tomer.yacoby@broadcom.com,
	dan.beygelman@broadcom.com,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	David Regan <dregan@broadcom.com>
Subject: Re: [PATCH] mtd: rawnand: brcmnand: fix sparse warnings
Date: Thu,  7 Mar 2024 18:28:27 +0100
Message-Id: <20240307172827.3453020-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240227190258.200929-1-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ea31fb60222262df8cf0e2c5c783097f90b7adea'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Tue, 2024-02-27 at 19:02:57 UTC, William Zhang wrote:
> Fix the following sparse warnings:
> sparse warnings: (new ones prefixed by >>)
> >> drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:79:41: sparse: sparse:
> cast removes address space '__iomem' of expression
>    drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:80:17: sparse: sparse:
> cast removes address space '__iomem' of expression
>    drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:80:17: sparse: sparse:
> cast removes address space '__iomem' of expression
>    drivers/mtd/nand/raw/brcmnand/bcmbca_nand.c:80:17: sparse: sparse:
> cast removes address space '__iomem' of expression
> 
> Fixes: c52c16d1bee5 ("mtd: rawnand: brcmnand: Add BCMBCA read data bus interface")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202402270940.gmVLVRg0-lkp@intel.com/
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

