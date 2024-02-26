Return-Path: <linux-kernel+bounces-81194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF408672DE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295B8B34CEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C518B52F7A;
	Mon, 26 Feb 2024 10:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OCtf67bi"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6589E2C85A;
	Mon, 26 Feb 2024 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944267; cv=none; b=t2ekY0ojAY2sOiuaeNUVTW0hEK02O5WuuCjsr4hn5zyyRIcIdYrj/wTjhk+WDW9hr7aPGhHdEZRMn5D8iIa9wuNgQJRTGf0qpFActcKL4XK+TA2t4oynGhc1l/VUSgIVVyzTRaD+0aeK1hfVNx1zFA4rfzk60g5Ke9xgxtQoWJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944267; c=relaxed/simple;
	bh=KgChHRTTo7OQwKFWE6bKTcZq0vzU8U1NkHXjfoExUKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dxHjele30w6kTRovpYqOoVj9DTKm5MON0YpAPCBSlXtHSWZ7T7RPzWn2a/xQGqEVlj5pqhx4etYmaBJbs32f2T90WBa4lpVp/9Bu22R0SH62Kcv3DZn6Th1XMdlk/7rJIv5+y99dm98fB3ilf2HXV/eWptSC7nM7xAchQerOYPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OCtf67bi; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C74171BF207;
	Mon, 26 Feb 2024 10:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C0jfSaNWPM8c7hemQqNUqquDEQ7dm7utmz7Pw/Vpj80=;
	b=OCtf67biXRAmquLsBCLSCV19/ukE313faNhAeIO05ukEICb/E+Xz0ZY5SHoT3rSTLRkkgf
	tSB0HPPzhqM+tSh1SAhft0qghO9Vr2LB2uG5D7lYvi8xap9hnKpCxjynTCn9qdXVdPGuVj
	ggVc/zvfQUZcdQRm/ucm9o6dWKw5mtLNt8R+JugDx/8G3ZnurUnwqeF1c6tQhrTkR3qrtg
	sP5Gt+X6VXPoK1wm/yVsxvdmVavM5/8/qyb2hj3RGBaaYQfqU+lZoh2FwfZAcKTpiIDuw6
	O0fTTH431PldL3VPxKZ1vUbwId1iktgkDt5WWlfoZh5P/+0VMbmTWYkIolTZHQ==
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
	Conor Dooley <conor.dooley@microchip.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	devicetree@vger.kernel.org,
	Brian Norris <computersforpeace@gmail.com>,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Weinberger <richard@nod.at>,
	Kamal Dasu <kdasu.kdev@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 05/13] dt-bindings: mtd: brcmnand: Add WP pin connection property
Date: Mon, 26 Feb 2024 11:44:22 +0100
Message-Id: <20240226104422.489635-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-6-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'638eff86cf9ae36796d704bec24b83e3a4e348bd'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:50 UTC, William Zhang wrote:
> Add brcm,wp-not-connected property to have an option for disabling this
> feature on broadband board design that does not connect WP pin.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

