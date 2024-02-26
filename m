Return-Path: <linux-kernel+bounces-81185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218898671C4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE041F28C7A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF51F5F3;
	Mon, 26 Feb 2024 10:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ccjhfYPR"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04C4D9E2;
	Mon, 26 Feb 2024 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944229; cv=none; b=D57EY9qehJEPkcbAAT6uN6qkIeBb6Mi6oHdROU1fCVBx441KXQX51ehyP1N6sg31k05CMO0Zon4mu0l+4zbtyPdT29g8h39aVctMKWu1oCalBJXMFVW5+zOsyi64O78l60QFWYVYVgRgdpzqgG9PJY3a1P62Ebb49d0Gv3q3pQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944229; c=relaxed/simple;
	bh=vDtt1qad7d+14ut2THuDeEEY3FL6dIHf7i9adMicIZk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NsQB0Q9TRUF1LR0ZsynDpuA91y7im7YF7DFJe9ur8TvfUjnfa13dMnWlyM31XhqeXiwJdS7NngFToJHLqaLAu/ZLXecqNP/ZDv7KYlSOJYJapekcTFvRM5HWvFKZy89K6U6Sjh8WywG74BY5PuUCjLg5lZbcqe2u2A7HwPs7fsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ccjhfYPR; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C070AFF804;
	Mon, 26 Feb 2024 10:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbuG9zKlK6ziqZGMdcv8Imk0IwSOjhpEoUUTm5M8p7I=;
	b=ccjhfYPRzGq4Vk3DqllusYqNYAwB2BN5xggKYeKVaKP2EEWfNew/SZroBqrrz6vZ+ic8aV
	gp67fl3aQKY4eT5Lr//50VQayl1gH5fnYrTiEPjiIEwBqEOybJOXe8vG0mG4opEisUnS5P
	1Bu6HrhlrHGhhxjofOHJbT6FXQWtnEad3u4jsvbT5xKN2v2sdS3IkQETYsDxp6rYJQiOcf
	dgquHrTFfyT1SG/nNqx0EPFjYZlnnnjhzDLz5q1SqqJN34Oq7sk2OZaR5PERjHKnbqfjSG
	vh9F9rEQNYmOxtVHKeJ9KcHAL2yajQIfPDAZOHgdHJdi5ljQ8kSu8TdVuP0Z9g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
	tudor.ambarus@linaro.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/39] dt-bindings: atmel-nand: add microchip,sam9x7-pmecc
Date: Mon, 26 Feb 2024 11:43:44 +0100
Message-Id: <20240226104344.489249-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223172520.671940-1-varshini.rajendran@microchip.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3c1f9b7fa20aed8b3227d4ed7ed630da6077304b'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 17:25:20 UTC, Varshini Rajendran wrote:
> Add microchip,sam9x7-pmecc to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

