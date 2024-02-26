Return-Path: <linux-kernel+bounces-81184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D855B8672A1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF74B33D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57CD4D9EC;
	Mon, 26 Feb 2024 10:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Osh0I3sr"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D004D9E0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944225; cv=none; b=fLqYR0a1XmQe4uc/OVFCnCTD2LyW618B3NJjQ3VCigtb1mMBSoxxfh2++W+0Kpp63efrymzMI8F6QXDAS+J3ckdRAlbV2+htWhzOHW5C1G6fGGadGKBClcaUATaIu8KwIt4LyH1DK8F+EtqLwVbWvcMmMLrBT/J8zZpLeFApnzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944225; c=relaxed/simple;
	bh=S56AdYsPgbRX33VpMTmKr7XT1jH0WMI94bODsYbSVqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NowtVCPSYf4dER0x7wtZClWhcQ0MEin8jVpeATdwRQ8dgQ0gaWiaMIYOYA0LG+P4qjNnB2ZwSgA3JwQqY1ixy8M7umY4v9OOTcu/hgyGqnBG5QvI1JqN5oQydvSBzyTDq2h2ifmisSGb+NYy1qMAPNmQB+rlLbg8yt91v37AoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Osh0I3sr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2E96560005;
	Mon, 26 Feb 2024 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dNQgoYfi7C6CVKqEeoFf+YPrjABDQDJPO0VckYnKHe8=;
	b=Osh0I3srqRVicQtWgUk9tjWafpkveBVOMK/3dfID2ja4RcVTsHKVgBBXGTXXO7uFMJnfcj
	oUvo3lGOJ2wRtmlY7oKeB13cEOfLeCNkbcN/B7LPy61W7i2/tCXImD97Qfsh2LO3F2bA/r
	878QCo45Sn0xodyBHfmlpEtvYTY1VUuPS6IlBcZhGGMjO07TjeliUzGmWaPfhrxSt66ZtO
	t9T8Oh1djHZwlAStfT47vF18Jk237K/alI6T1Qv00V41Sc66vIYg/Gr3U59S0cdJq+7A3/
	TwA1w0FBFTqB0lx0XWZA5MPtad0Fyqsdt2qb9+uacaPQz/Q9YGsRh9BesjpDxg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: hynix: remove @nand_technology kernel-doc description
Date: Mon, 26 Feb 2024 11:43:40 +0100
Message-Id: <20240226104340.489214-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224014639.16145-1-rdunlap@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'65a7f244b15684856241d04b8f3287d9124bd1ff'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Sat, 2024-02-24 at 01:46:39 UTC, Randy Dunlap wrote:
> Remove the extraneous kernel-doc description for @nand_technology to
> eliminate a kernel-doc warning:
> 
> nand_hynix.c:39: warning: Excess struct member 'nand_technology' description in 'hynix_nand'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

