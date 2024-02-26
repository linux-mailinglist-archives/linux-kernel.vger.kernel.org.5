Return-Path: <linux-kernel+bounces-81193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A286C8671D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC5F295861
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61513524C1;
	Mon, 26 Feb 2024 10:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="hWdv3ucc"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2376250F3;
	Mon, 26 Feb 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944265; cv=none; b=uy9nOFRpbW8X8r0BUWV8ya6F67LugbFsCHt1TGTQP6I2RSk7xkCZNDtBWyo2k9LMjV4H4o2HOR0kp7oEjQiDn+5z3no6+T5Xptea7Mfo79FFYgNDpEyaYskgQdSI1s9muBwiCjl0YJLChVhgU4HdtEakMJ0ZfslV49NZ4mkcFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944265; c=relaxed/simple;
	bh=Mzg4VQDL7/+JjZ0LamZA5un67+MkmbTypdD0xYwByHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TwUUeq4d1rHJlnIJm478a1d5XhesbOZdV3EIWn7FjMUq5LVW6b1KfgC7rAnlL4cJ9EIHu0e013NAL7PKwmLOnuy6uAa3XZky+sCNFHYG9KBgBoBDSIPURcsxy+IzglErSLK0bEoNy0GMBGFyz7GbUMaEco8zUspRMlix3Z+Qk/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=hWdv3ucc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71EA91C0014;
	Mon, 26 Feb 2024 10:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=igltBX1RS9CACcoo51+Edx1JXCfvvMD3zziOJnrUnRA=;
	b=hWdv3uccgP5E0Amuaxr8HuqdxkuoA2qnMsmPpOKY+fRYp4N4uSMkm/WisxzLd1aiX0c4A8
	aMwG65eQ9u4GmNGphWebNTnQzapQddmmaLISYNsQPZ6pauYSAszpcnkp3FXNSPcUwVMlfB
	6HMxmRexNKYj5XPKUHYAzjNk4ND9Gb4oWGzoKmilPQbNA1ZH5H4wC7uQ8D9xOVtBHM50j6
	OfMrVqCZXGipu2u98puF4todaGLGx5P1x5Lfk4eb6z8Fa1LYgwA4bxN4Qg11F2ilpEMDdz
	Y802+sds+7NFmgKSa5ICAZkFBZU01T8xZ1kwuUG+bBP7RFH7/4kHuA66B3rWjA==
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
	devicetree@vger.kernel.org,
	Conor Dooley <conor+dt@kernel.org>,
	Andre Przywara <andre.przywara@arm.com>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v6 07/13] ARM: dts: broadcom: bcmbca: Add NAND controller node
Date: Mon, 26 Feb 2024 11:44:11 +0100
Message-Id: <20240226104411.489517-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-8-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9bc2c33cce32171427e604eb678dad693c6925b6'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:52 UTC, William Zhang wrote:
> Add support for Broadcom STB NAND controller in BCMBCA ARMv7 chip dts
> files.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

