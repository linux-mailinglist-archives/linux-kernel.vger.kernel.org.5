Return-Path: <linux-kernel+bounces-81195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE33A8671D5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BFBB1C2424F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8EF53379;
	Mon, 26 Feb 2024 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vt8SWyJz"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E05852F9E;
	Mon, 26 Feb 2024 10:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944271; cv=none; b=HprFUe14NBmRYw12kSQr2/9u1aw8eRMCMYVcORgLLGkcFXNNNMSc7Tckr0wAKinH2GSjWABtc3KbpZvT2qwBB1M5/+vxXHPghnKxDJFjH2WAjiSNI6rzMqMNmXHsli03IAkH6U0IVALpJY7ySSnDxyM+oClgAROh2JbLj/j/RF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944271; c=relaxed/simple;
	bh=69wWbe/mEk0VJyv+TyFSRMjK5u8I2kjvN0O6anX54Kk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0jS4PEat8LY/x0fi1+6+iOgQgEFNONktA/DNPCNXqA/T7MsDm+zm2ww2S6A6Bq+c8QlUkLLhr6thvBdHdwmz27FY2RMx6oFMAIl9RLr1K3+IlXWkzxtu0bILM3ICAALDLRqqh7jmC+eimZYSYNvodnVwYVz1+5yQ2/GqxnYhx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vt8SWyJz; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B8AC8240003;
	Mon, 26 Feb 2024 10:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtJbw8drebThVn+++F6e1cdtMET0CoLNh6oFq9m0eQw=;
	b=Vt8SWyJzgk6IKZnzFORX4BEe5ryE1AkAm+FY/06nKZsWKYs8/Sg8xziXPSQPXUpiHBiIrY
	p4wS+HHnJnSSY3rYB/b3Vefc0cmaIUS+MjKCM8AfjXOscjMhFd4fSq+/K/h5dszmxu1vE1
	I0+8IoMNY2pGUexKXjrlKBzifLZBtHfnRXpL88qsVkTDZI4K/FCMd52FTMq6cAIoPrXl7a
	zXDmEoowyLQo8U8/Mk5MGEhgYsRmBor38BGPsK3yvMkGTMC5HVhjKUej58KSI7ODE7uinE
	RVtiYBAKxXg1IbfjJc/SkO+DsBVMKUiFaYE9X8r2Tzvrch8jiKLqyII5zrwkqg==
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
	Rob Herring <robh@kernel.org>,
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
Subject: Re: [PATCH v6 04/13] dt-bindings: mtd: brcmnand: Updates for bcmbca SoCs
Date: Mon, 26 Feb 2024 11:44:26 +0100
Message-Id: <20240226104426.489713-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-5-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'59e8c2e011160551124df919c5bd8689760dcea1'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:49 UTC, William Zhang wrote:
> Update the descriptions to reflect different families of broadband SoC and
> use the general name bcmbca for ARM based SoC.
> 
> Remove the requirement of interrupts property to reflect the driver
> code and only require interrupt-names when interrupts property present.
> 
> Also add myself to the list of maintainers.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

