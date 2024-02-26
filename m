Return-Path: <linux-kernel+bounces-81186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643E78672EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 593D1B2A45E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516E44E1D6;
	Mon, 26 Feb 2024 10:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jq0JikuM"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD6200A0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944240; cv=none; b=V5Ce4gp3Q67y18MTPoFo85qzwemxJffXBBSAew22mS7Zv7WCWRDLpxh0+iH4X7uYa4tr1UXSu+JXFfBRCahKJ3mP6EBArdWQEg38NMlN9kbrqVQMDbhZwTkGCc0ukg5MAIx1tVAGbEF1L5qLA4trdNm8AyfbfszqK3WziUqpt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944240; c=relaxed/simple;
	bh=4G9c1LruoJnAwgurNIMzmmYSB6ZQBZFpXt8EnYFHE1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CZjgTETx7s8l/DpOEjRiujWBSEhK3jTpj9byhRIfl2e684V5GEiEaGlSDyzY34pE5Woa+9IeAqPj/1nGQpBQiFjS6hwuTmgNjGuXIgaoiRG9eVCQK7HydaSI+0Eyt2FSFr0xupQ3GjOainr7PZ81A/rAJ3xkPrjeWPgEkolNNII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jq0JikuM; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BAD1F24000C;
	Mon, 26 Feb 2024 10:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sxwncBqF1qChlTGcNzhdeu4dak1hlGz+T1xYbis3nVE=;
	b=jq0JikuMnQnPzXUbLe14yIF7SUov0LVLSA1b8GHSmwLsk/ScG6LAChVhvoUV23EHMSmsgI
	QWfLAiogK3Gx2vpH7VUEoIh6rvmQ8qvUsIoOvE7y5Tj4/oT1X39RWa7Az8Ye3zoggRRvyO
	7NrbSZXeuD38EIkD45v5VJK5M6Pdm0LtdV+MkxL9V/TrMewyemWaBl8G3qcOtapZgL/ToQ
	Y60u6SPXqzfqbPRcsWLw4+uQAABn/tiEIPbKNHENp39n2m9NjK6mQ5Lu9pOwhy7LbqPH6d
	+4EUk86u9as0t4hwb7KGsqeB4sUp/0IC+ZvsrbA0pV0/znaDDY1RynE4+l8pjw==
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
	Richard Weinberger <richard@nod.at>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v6 11/13] mtd: rawnand: brcmnand: Add BCMBCA read data bus interface
Date: Mon, 26 Feb 2024 11:43:54 +0100
Message-Id: <20240226104354.489350-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-12-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c52c16d1bee5c3b074989e839eeceed2a0a8cc43'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:56 UTC, William Zhang wrote:
> The BCMBCA broadband SoC integrates the NAND controller differently than
> STB, iProc and other SoCs.  It has different endianness for NAND cache
> data.
> 
> Add a SoC read data bus shim for BCMBCA to meet the specific SoC need
> and performance improvement using the optimized memcpy function on NAND
> cache memory.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

