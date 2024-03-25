Return-Path: <linux-kernel+bounces-116813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0612D88A42A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AE441F3E6C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8073584A3E;
	Mon, 25 Mar 2024 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hRlXOVOx"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0D12FF95
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361957; cv=none; b=tbg+tg2NE6kkXJ0GzT904ScJrjSSAcD4bAAzHIkg61DAPyiHwSjE56a6+/AZ3qczdmwKYsKdnzsk0IPJA7sBT3p4PVisMLZlIomE10S1IVoc605+QX9wKmndXOpyS2Oky2lt6wZTtsMGBMDomtb/z+dFEh4FCv9Ju5gvmLs/12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361957; c=relaxed/simple;
	bh=9UaMoSqmJJln9g5N9nW40TVfIBobJDAeVnEpPZe/81k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s4HHRL/AZhNn4x8FWUqwcutzj+VYiZHBsjA2sLcVogir3ael+GLm6Qb+z/qRrBdddgc/u3eSlUn6yiZSiFhXPYwVu57MfYUGp6sHlnf9O4GYLR60ahTvXIuDNvwm5OP8oy3l2D9XKLY+Xggw7hZBEgTG0zPmftogVDKkOPcLeLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hRlXOVOx; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 957731C000B;
	Mon, 25 Mar 2024 10:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711361947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YfyfSJVpatiwJ7IL85VnWJ1RNscN5N99xsF1+nRqgf0=;
	b=hRlXOVOx6NLWO4g27MFkDxgGUOInNR6JItdfvD98tGzNImHNO94aHnxs86XSPGYObcoxyX
	+E+aQV+u3FniTQh71nuVyJ2mzP3oh1sT9QhAqHWChVPPXFYWaCvfPfAtQttqF1K2R8eOAN
	QJfkbcgZ7u3Ao4r3B0bz2n4korQLQs/nJk2FTMVAUk/lRi8gl/a5WyI8sm7QD6QlaYfVQm
	hzA9HJxLJt8KU3UzWKpOaXUpGBWPzytFQCwirgcSCCFehAyjra16bkC3Pt8eibU65FFgkI
	z7zU0veQSYWpwgTxSlpDnCeKZ32NPlzUUY1XXHSSa0m5G65ly6u9/z/CN0xCvw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herver.codina@bootlin.com,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH 1/1] mtd: rawnand: davinci: Add dummy read after sending command
Date: Mon, 25 Mar 2024 11:19:03 +0100
Message-Id: <20240325101904.262591-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240308074609.9056-1-bastien.curutchet@bootlin.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'31e6bb6787e730ddedf5cc9b90863c5ff438ead7'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-03-08 at 07:46:09 UTC, Bastien Curutchet wrote:
> Sometimes, writes fail because the tWB_max is not correctly observed
> after sending PAGEPROG. It leads to the R/B pin to be read as in
> the "ready" state right after sending the command, thus preventing the
> normal tPROG delay to be actually observed. This happens because the
> ndelay() that waits for tWB_max starts before the command reaches the
> NAND chip.
> 
> Add a dummy read when a delay is requested at the end of the executed
> instruction to make sure that the sent command is received by the NAND
> before starting the short ndelay() (<1us but rounded up to 1us in
> practice). This read is done on the control register area because
> doing it on the Async Data area would change the NAND's RE pin state.
> This is not perfect as the two areas are behind two different
> devm_ioremap_resource() and could possibly be located on different
> interconnects (I did not find more details). This means either the
> additional latency due to the load operation is enough impacting, or it
> has the expected behavior of ensuring the write has been received.
> 
> This has been tested on two platforms designed off of the
> DAVINCI/OMAP-L138. The first uses a Toshiba NAND Flash (TC58NYG2S3EBAI5),
> the other a Macronix one (MX30UF4G18AC).
> 
> Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

