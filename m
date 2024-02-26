Return-Path: <linux-kernel+bounces-81191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EA48671CE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5D392958AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635845024E;
	Mon, 26 Feb 2024 10:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="U5pFjkvY"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82D82110E;
	Mon, 26 Feb 2024 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944252; cv=none; b=NWHgk6lqOEVCKUv17/jOZiBCXMQOPe+rlQ0maHJJL0TaOgXJoPekU1avclE4mebo2JaBRMnlxjVh+WRzB/UGrezSDYJlm6PuVxBefKhwQXLTKuBfLCd+Rvo4TpA/6a00ligP4D4+FYYUiqAKTc8974Np2yKpWCSIcIoSqzO3x0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944252; c=relaxed/simple;
	bh=UMiMf1vbqgLMyCu46KwXO7jglctc/vDFZnZvfLZwwss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i88lPDq1e6ElVdJT7GEmt482FYJlkcUPPRhau/EwNW063whQLuvAIR5cF/4TB/QHUk3THfsq+RyCWxzS2Wnq7el+zrHd4exXJDu1BR/fy1Vx0+mW24ZnYrEdklqvsYaGPR34/aWjvR419xMeMJUtOq48h+RtNE/0DFggaKlgSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=U5pFjkvY; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82CEE1BF20E;
	Mon, 26 Feb 2024 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YS0xtPJLUWz/J44LlF/6XFwOsdD0shWEo8A0ddxsJAk=;
	b=U5pFjkvYgh0y2PiE1W+62YAIs4NhEF7VTUKjSqllfIkvKmONJALI1a8QyJ5n/uvwPnp57c
	LdULRXff4M5HuUZbFTA16ibyXoseEq04WA7gPw0h9puZVwIb6T3nVCwZCw4pgutuI0QD8L
	Af95BjzvRGOORziuyaAMKpIPtI0QHYVGnAJ02qRW2kodeFUFzJzyrxbvqKxKYDs6jduiEH
	1u6h81SeVhgHO2e9xWPW8m8bKG0SMuqO9whFoDDQs7QVsaU/+IvdCMt8+30RnkQvN5is5B
	9254ysHoT2/0P/c5tOZY3Dc23ACqaISLfUszKcrhUZvwjGsg4gx9Z330yH86MA==
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
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: Re: [PATCH v6 08/13] arm64: dts: broadcom: bcmbca: Add NAND controller node
Date: Mon, 26 Feb 2024 11:44:08 +0100
Message-Id: <20240226104408.489472-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240223034758.13753-9-william.zhang@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'87b0c3f2cd0247c843dd118068ff0d7539b8f791'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Fri, 2024-02-23 at 03:47:53 UTC, William Zhang wrote:
> Add support for Broadcom STB NAND controller in BCMBCA ARMv8 chip dts
> files.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: David Regan <dregan@broadcom.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

