Return-Path: <linux-kernel+bounces-81201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 950858671EB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47B61C286DC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF3F54F82;
	Mon, 26 Feb 2024 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jiEJxhHb"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E1354760;
	Mon, 26 Feb 2024 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944293; cv=none; b=RI/CGFy2ssifM/YgSPwmqGeMa4Z8Bgyrc4QaPw2njhOJdf0avmX1qya6n8FTuIGwUmgofQqkmV0JjmNL+OJuQvSM0Xsfk6stB1HiqE+xLcIPKXiiel8WvboTs29bP1Ouh3705EIo4/2yf8wqHak7qB6tMr9Y2W74+rQKLTh46mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944293; c=relaxed/simple;
	bh=HAg5F7r41878RhX+ofIVtKZecIgzbEH90bBIxdxIxv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oG4NBwKool3K90ZFEI+GFFYlWNL+H+fC8WjDw16TF/z3wqS6fTD0VU/grJuxF9gUOV4T+45vTpQicbrqHh6sWw7WrnwRjsqbxBPPVhMzC1ZBsjcBDVnSFW9ZaY67tOQfXnjko8sKsvS88OO3YFIhgG6zbHOKTlP4B5JR8WNLyqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jiEJxhHb; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54FB320008;
	Mon, 26 Feb 2024 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708944290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zzSFIT7MUTdqhAgfVj+8pV00eLEvvOdPb3HM2pVYF0=;
	b=jiEJxhHbIty5WaTnlEx2gU2oW7J9sbnyrVqZcZXWQiZMqWd0xrHpjn38KGXf84/c2NC03C
	NkrlSL1/WQkdZTqo/OE9ECtcnrEgYFS4+FQ/rK6GUnnPqcdL9M/8PdDpTCMzPJNCuF8pdr
	VKmjscmbd1q/8bAwtYceFSHlVRsfWCGsSSP3RvozfjDe+oYAze163MrhhvZr7kUwBXuwLC
	mu/w65iJRuqLO0QrUn+2R8XtbyEfW8yZs+beKMfDaZGLdD/zt0rXb/wV4xaEtbEGTJ8ox4
	8RcSxsQ1aT7hxttUiUyFm5cEsYdEVH6sdk++RFtKQt6zBpLbnnjwUeqHzy6+Iw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christophe Kerello <christophe.kerello@foss.st.com>,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: st,stm32: add MP25 support
Date: Mon, 26 Feb 2024 11:44:48 +0100
Message-Id: <20240226104448.489969-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219140505.85794-2-christophe.kerello@foss.st.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c1e04ab409aa0df2f554d7b318d82e8730ac4fa6'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Mon, 2024-02-19 at 14:05:03 UTC, Christophe Kerello wrote:
> Add a compatible string to support MP25 SoC.
> 
> FMC2 IP supports up to 4 chip select. On MP1 SoC, only 2 of them are
> available when on MP25 SoC, the 4 chip select are available.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel

