Return-Path: <linux-kernel+bounces-81197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B43098671DA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D661C27F49
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AA4537E4;
	Mon, 26 Feb 2024 10:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E+YASnOU"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095B941A94
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944278; cv=none; b=p2nfSFQtDEyK7SXxF9gWCWZum7POAu54jo7TjNnweDcf9Js55inD2+wWfHL2LkrZwrI5fkFJDnLuNFTUej/40Qwwyrr3KYK+AmRsuDOxa6eyJAI/IxIVcrYuQmgKer/Gys4m3XBtcHLc2lcyCKvAjjo77sYut9nj/Vf0vNEA7i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944278; c=relaxed/simple;
	bh=Saj3aj8E7fNZJSgmSLkchH2ojUB8Qq0da/I14cyOUQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLYV87obz/Z2ZlI1eng+/qV6EmP4xfO+uMhFY9+wKRjEYKIFewwYvpdfA9p72EboHT4oC+BNUatiPeAufphwIN1XUyxSd2f2DEuuZc0jTM28KXAdEKUkLJKQG01yNoB0y8cRLKo/TufCEYHat+a5F4aLxZjyrhKw2/leLQXXpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E+YASnOU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 862F960007;
	Mon, 26 Feb 2024 10:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wEfzB1nd/zVZF23uR/LjdFqixm6QUNJQL8/Lb4lp4ck=;
	b=E+YASnOU/WN00JkzEqMHSEXuDgjlzyoiCaRS8ZT2/ci7zz8S4tozzBFXoBggpq83qAL981
	JdtOIN/PuGWnWjGuDkQldGosWdKUOD196RDIzx+8W2FTseo6bA6C0OeVH7y7qgS6Szk3R/
	dXKEnp9Ph/yRC6+H9UvdnV5Y5TnkA+LgFVDD1n14PqZ1yEuQM8jf/3H+5KbjN8GAzuvO9k
	WSWL55ICAE/D0DelERo/y62bptEUx5CQrcSsf8C0tbByPYhSAJNE3Gz/72YBLlfyvUZ+MH
	IiutkJMlQsriXYiV7uQkQme4IgQ9JJq2b4GIfKAMUP15IVj1jLLlQZXtR3FrIg==
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
	linux-kernel@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Brian Norris <computersforpeace@gmail.com>,
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 02/13] mtd: rawnand: brcmnand: fix style issues
Date: Mon, 26 Feb 2024 11:44:34 +0100
Message-Id: <20240226104434.489790-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-3-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8e6070e5a39cb2202d66b78134f8b7681cdf3cd8'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:47 UTC, William Zhang wrote:
> Fix various style issues.
> 
> Signed-off-by: David Regan <dregan@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

