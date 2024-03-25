Return-Path: <linux-kernel+bounces-116818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D070288A431
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DCE31C3B538
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FCB18BC3B;
	Mon, 25 Mar 2024 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q0MxbHtR"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21312FF80
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361945; cv=none; b=Qp1aAYgITgtAYYsdaPXM0ftSwxyS/1G+FNkcu3OgAJeHdDTxKFQCtd4mJSjBiLrhUnTllRPYCSXd7R2L4P/5x7RaJ3Eh7jud6jMZhfXhyisP+kKWSbEDxYX7fAnYn0la5+gm3Nxpveb3pQqf1niyXA0ZSpvKPEEDuDYEBqn8BXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361945; c=relaxed/simple;
	bh=ukM/PmOSEhPCGm07GAprsYA0zMF2NT+TMuGk6HOCLFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=phmCJKyYzE2L3WnVUK7a4458+xIDezHcxPXpcZbl6Piu1WmCzqqPqOl119sggzFE9C8AOipt0ADufil7+ZYOqYEn2IvQD6O6h3/YbhosTxb6+EBsVpFF5JjvZlzc+BDX3NQi6Wfe0IICk/2hxnnZwmQ+/D5SPKCr3c881aOqxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q0MxbHtR; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 96B1CE0006;
	Mon, 25 Mar 2024 10:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711361941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4tr6jXQo2B5No46bghO0NGB40nWqUW2K62Prsk80Uc=;
	b=Q0MxbHtRzFK0Vmp7ppEFvERfQdOZ8doOZ6S3NyLVl6rwts7McABZG1LMlkuSiblr/bRn/W
	it9JeXBTJvCCAsbz6dDCekCNDi8nH70IhYtbJuHvaO61XvsTb0n4Gcz8bEDTPTNc4DrCj5
	GdE/YxF9s0sMLMXyNBZHfbOO9T386cWwiyb/G2eCGVus2m72BQdeSCD0Hbqu04tZMjicXq
	wl8WTt/0cz1i41rpAk2pY3zwA+RZNuc2ESCkcps1/KbIz61fcPOX4s12wRn17NbWq0v4km
	N8dUfn97crR51GZubWU5F/JuLPItzJUn/gAnzvbm/16qNOu2okkp6g52OAxhYQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>,
	Boris Brezillon <bbrezillon@kernel.org>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Hector Palacios <hector.palacios@digi.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] mtd: rawnand: hynix: fixed typo
Date: Mon, 25 Mar 2024 11:18:59 +0100
Message-Id: <20240325101900.262562-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240313102721.1991299-1-korotkov.maxim.s@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'626ae9c828be56c5854296d44bec19a23627fe91'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2024-03-13 at 10:27:20 UTC, Maxim Korotkov wrote:
> The function hynix_nand_rr_init() should probably return an error code.
> Judging by the usage, it seems that the return code is passed up 
> the call stack.
> Right now, it always returns 0 and the function hynix_nand_cleanup()
> in hynix_nand_init() has never been called.
> 
> Found by RASU JSC and Linux Verification Center (linuxtesting.org)
> 
> Fixes: 626994e07480 ("mtd: nand: hynix: Add read-retry support for 1x nm MLC NANDs")
> 
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

