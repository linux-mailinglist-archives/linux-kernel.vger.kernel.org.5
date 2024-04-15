Return-Path: <linux-kernel+bounces-144886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F56A8A4C2B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EE801C214A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B316535CA;
	Mon, 15 Apr 2024 10:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VeIeYz1H"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959A552F8A;
	Mon, 15 Apr 2024 10:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175637; cv=none; b=BpHHpf4udoQ7f/B+167ylHTUxUXUBkR3pzkjSuET/c9Xin5zqaxa6gBx2wSmryx+1yS95XE7HcfIb1hSgsFuZlyEfeuyrPuwaFv3b+7Y+wLRBs8ThY1AL1ewJhcmh1Y6NXm68VrZsdVtvtRLs8ALHUUZFtOehFxmzJEyZkX1+ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175637; c=relaxed/simple;
	bh=vk1/i6detDD7VE5Bt1G8UH/mQuXy8jTVYWZwYABl8W4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DHb5rXdbss5ZYJ6v4sXKwTAiwlPGhYdRK4wQzn4YrOKAeTw0IZBalLHT2w1R8lwINfkw0n1xJBv+RxgodyiBXicnUZQ6icMRMKrM8wqaXQZtEtwGfBVhRLt2G4VsbLQlaiMvkLr1nVzMnFlbWIxc+Xbkn2Q2WZd3BO8/gSuGX8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VeIeYz1H; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F31B560003;
	Mon, 15 Apr 2024 10:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713175624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzh6KDR0h3E2eLm0JI3eKxgZxPnuJOrm7c/ie9flbm8=;
	b=VeIeYz1HQNTmCzsI6Fi1bUuBwGsHemZZrrcjz152OK1dAtDiI3UqF1TmPNHbrfFFum4gOL
	skLSAEVI4xYPRc9lIFdoPJmw0VLf+6mtaqEMLAV2yN3LqVzTVeMu+SluWoPdG+pVWME832
	ebZVHsdToNqrys6A6xxzF1GmSkIXLLJ7KFRW+1znKJYYy1+WzcS9zElrnYG6yCYmY1jzGK
	ztkLfRUCkEUQRn+0T/TI9LS8uVA7dq1851e1h0t7PLmmQWi7dHTewFgZKk6AoiR2Snd8im
	JSxUyE6dVKGRJReYEabKOgFmQBLJGuKnziRW3g1CDdYGiQwgGarb/pJ/4cBeaw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Simon Glass <sjg@chromium.org>,
	devicetree@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	U-Boot Mailing List <u-boot@lists.denx.de>,
	Michael Walle <mwalle@kernel.org>,
	Tom Rini <trini@konsulko.com>,
	linux-mtd@lists.infradead.org,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/2] dt-bindings: mtd: fixed-partitions: Add alignment properties
Date: Mon, 15 Apr 2024 12:07:02 +0200
Message-Id: <20240415100702.32115-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240412153249.100787-1-sjg@chromium.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd8d42d47a9ff9a997abccab1e4ebffe4fce28f32'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-04-12 at 15:32:48 UTC, Simon Glass wrote:
> Add three properties for controlling alignment of partitions, aka
> 'entries' in fixed-partition.
> 
> For now there is no explicit mention of hierarchy, so a 'section' is
> just the 'fixed-partitions' node.
> 
> These new properties are inputs to the Binman packaging process, but are
> also needed if the firmware is repacked, to ensure that alignment
> constraints are not violated. Therefore they are provided as part of
> the schema.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

