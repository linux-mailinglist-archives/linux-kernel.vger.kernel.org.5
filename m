Return-Path: <linux-kernel+bounces-81190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F09678672C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F006DB347F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27552033F;
	Mon, 26 Feb 2024 10:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f8kLNpX9"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3495103C;
	Mon, 26 Feb 2024 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944249; cv=none; b=nYYhUZ+13x1OCGC43F6mo3Qs3XeIHOAc3EArkvwYImUs8OBO6nNbIx4uwaLDm2OTOi9QmZlTgYpWT3yxQsqniqPu1p20UHoevRM7hVT0uOW4SMcjpYZQbybs56n9+rXkmR313AADK2UZEHV6kToF40hfV8LBsE3+3Jky6paRi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944249; c=relaxed/simple;
	bh=HQMu/oOh420fJ7AHG9K/vL/hcvE5i3kInA1eeltnIxE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sa3ywBpMWuwg5Ka4I+6UOZPiOfNXsZGVhoNm4Ejzrrd6+7DxHITlQxablofpftk5AiWKyeCxBYSvh1oJtmhqKnyhJJgPlw2ZcstwdVgjPgPYskm/dvXp2L0gzW+Dn9ikyJZMJDXc00nHuM/WgK2BcWK5931lnXHzm5TXcOldNsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f8kLNpX9; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2041720002;
	Mon, 26 Feb 2024 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oZw1GMftp1KrNWQjhMWWgMUk509FXaKVoKCSPcn2Akw=;
	b=f8kLNpX9GIsrf8h/tAWvTuwuV+BLz+rwcZSt+/2Hra//PDVtzxX5JwPOxQJ6zSkz2Qekc6
	ulB4NQVB6dynLlSuu9g5g7WXxZakSCZMswL6Iu+r7BG07jPOlCFcQnV1+OE5aimvcxJ4dQ
	nXJ1LiRGw5KphcmBTVRbL+QTgSBmCnAuIJ9Hd7TYNesdsgbcJqUowSlj0YWrLN5nJJfuu4
	1gfWjup3Sk0bJr7pA98a3Uf1NChdhtFvld6opWY0aXCO1Pr2+tv2ajB1mTAvYiugiQcAx8
	jQxC3KASY7j7l44xTjmUG9poJapRThUxeDY8Dnrii4svxoRor248PFljq8c5Sw==
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
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v6 09/13] arm64: dts: broadcom: bcmbca: Update router boards
Date: Mon, 26 Feb 2024 11:44:03 +0100
Message-Id: <20240226104403.489429-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-10-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd6d2af9ce774474b6c01541cfea1573d44ae665a'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:54 UTC, William Zhang wrote:
> Enable the nand controller and add WP pin connection property in actual
> board dts as they are board level properties now that they are disabled
> and moved out from SoC dtsi.
> 
> Also remove the unnecessary brcm,nand-has-wp property from AC5300 board.
> This property is only needed for some old controller that this board
> does not apply.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

