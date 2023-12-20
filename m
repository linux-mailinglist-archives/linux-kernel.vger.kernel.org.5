Return-Path: <linux-kernel+bounces-6625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE742819B2A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A371282C13
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D611DA2A;
	Wed, 20 Dec 2023 09:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Io8w0y1O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732101D55B;
	Wed, 20 Dec 2023 09:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B88CE0002;
	Wed, 20 Dec 2023 09:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703063569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0LSf1jDXlMtYT+prq+GmYfXyuytNmV6xGmJKOfpfII=;
	b=Io8w0y1OJbpo94cHz3v3IlZepWhr3sNDZbjZwRffi9zpvY5EjSYmTGZttknqVciSIS/yDm
	9tlyX1vzHa65MMjAQY3HLuBacF65TZa9H3HEtLKxYm7nJlXcl986vwQ2oFrM40hzkLbGS4
	mdeyFyou2iQ7jv3VGAwe/fge0RhIaWyIb1xHDwlyFx3Fyq5sUvrNTpe1JBWUuOzI8ocqDI
	GRa2n/qR0eB6zeKbNQaiKIz6ZSih8fNbSajBPskcx+CHRepCIQV6OAt21JbPxQK9TsLhNP
	OfvQUuOF65PA2rBzijSItwlp/IY2Ufpt4ZgeEb9du7R3rHICFvsnQadEoCdyzQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	kernel test robot <lkp@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: fix Excess struct member description kernel-doc warnings
Date: Wed, 20 Dec 2023 10:12:47 +0100
Message-Id: <20231220091247.655421-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231216044146.18645-1-rdunlap@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'023e6aad7e5e7f2e086c399abd0675589c123728'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Sat, 2023-12-16 at 04:41:46 UTC, Randy Dunlap wrote:
> Delete 2 lines to prevent warnings from scripts/kernel-doc:
> 
> s3c2410.c:117: warning: Excess struct member 'mtd' description in 's3c2410_nand_mtd'
> s3c2410.c:168: warning: Excess struct member 'freq_transition' description in 's3c2410_nand_info'
> 
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312150611.EZBAQYqf-lkp@intel.com/
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-samsung-soc@vger.kernel.org

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

