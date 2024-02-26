Return-Path: <linux-kernel+bounces-81198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 957068671E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D057C1C25BCB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4C053804;
	Mon, 26 Feb 2024 10:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fzNGZ+Yt"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6F53377
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944282; cv=none; b=Vb4URMdprpGRvbaA32JJ4h2eJaQo2AqZsLEVo4xFIjYHoYVIZmuMIVRECH6CSeuHrJdjGBiHcuhfPZYyOl15nf0tklqZTCh0YXIUyLj7Gf23SjIvzyteyL7tiXFX2NLG8GFrK/v2d8yi4HMZyM+LSe5aQGTUhaJFM6cqYVux2iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944282; c=relaxed/simple;
	bh=zJqafyG/D0WP0i/DQYcqp/5CARwROHHaiwqeOQUcUvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUo80wU5yf4Tyf2/9pUA78E887WQC4HnjcgkejCi3byAXIGMAgfK/9i/d516cMpLcaPOKSzEJjiMyiaYG3naTY73BPCwa7PmdXb65Tlm4o50cHbS/SxOd/wgdjCkR42Z+LYu545NzcJFYUPMNPuFlYTU7+ampDQxQT2pZB1F0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fzNGZ+Yt; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C835FF808;
	Mon, 26 Feb 2024 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UB1IOQo3ol1zgMkxzEY1pF40MDSbhNzWiuEXfhitfrc=;
	b=fzNGZ+YtkPXFUu15ymnBFHeanM/sUHd1Xd5ycAqqFj8uCd7XFNW3wj0a+U8R6qjWhVtqn1
	kZp+oHVdBSO73qt3/EhW6POoBWaY6Q7wM7Pq1/kRvhiCg4/VL8MNdmALyHInTVUzWXLQQO
	i7lcGnIDO3VFCi0ZnuiZjGwpnH0raSdGQKPy1AX29MQvXG5yJ7IYjxYri+SX0Pph/NeqNT
	qZPrfDqddX4jkUZk5J4rOCFrv1LN1FLC9GZforSfdA+MVTdn28xBAWCh84mJDX9QyoG32j
	b2jq2Pvxyu5vZcsbcNvOhSH0kERLTbd5jxMvd3cnfoqx4rCSisnHTlf/tgz2sQ==
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
	David Regan <dregan@broadcom.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 01/13] mtd: rawnand: brcmnand: exec_op helper functions return type fixes
Date: Mon, 26 Feb 2024 11:44:37 +0100
Message-Id: <20240226104437.489832-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-2-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd4bba1501f72e8af09f2cde3d327147de1b69f5d'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:46 UTC, William Zhang wrote:
> From: David Regan <dregan@broadcom.com>
> 
> Fix return types for exec_op reset and status helper functions.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: http://lists.infradead.org/pipermail/linux-mtd/2023-December/102423.html
> Fixes: 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op implementation")
> Signed-off-by: David Regan <dregan@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

