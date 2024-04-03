Return-Path: <linux-kernel+bounces-129304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6736389685B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DC381C25F1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3CD6F51D;
	Wed,  3 Apr 2024 08:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="M7LkaR3E"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394312EBD0;
	Wed,  3 Apr 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131885; cv=none; b=oB0eHvGY+HmqoucRLD7LxgJYhzBIQGCwkwOrKtOsCfLJgs3nDnb1xEykMVI7uSUB+mSzAzykv6Da0gHK6DXpCVGlCVZlzHmrFvdZD0ISLAY4PgGLtGIk+Qw0YJd0uUusylOJia5iMF4UAg2XeytQEygdiHdxc84orad24iK4n44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131885; c=relaxed/simple;
	bh=e7kLGjTCap1sBGPBufjFVpeA82zNLXCUOPl7MnZqlss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XtMXLlBr+7ifyDD4M4YBIBZj1SxMBaKjmmWO1FK8XBuVNQkRigEVulkczuR2AK+uxNBrh+v0WFTQpGx1aZl0KpAxSJIv3XzRquY8Gvzy1ayyMn9HEV05pv6xeLRaRyMHyx5V9HXTqLJtNndX1HpWfEy1iIYrLjQPQ+KFpo9LLtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=M7LkaR3E; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2AEFA1BF207;
	Wed,  3 Apr 2024 08:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712131875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4KOOUEfgcRxydGIT+hu+sFi4XdO06GJeHmXwYX2lypA=;
	b=M7LkaR3EMeFWW33WuZx7RPKzUEW9x4ARBxuj9e22nltCjpukWqFMQPO2eFza3A4vAoyi38
	bDK8U0jS5FypVpnbXZN3Kig9plQ+NBBuHcoJCsZH62HrD/SlwgHkiLW2ajWhivmCJ2HcUX
	y9ha5Fk2ROIYhz8AE1llwHI517TtNLkash1gGqkudlFaQFtM8hSf5DRUPRWMge6aF/SIvH
	ebsvO4s/cVE67SiwTAORoSVS6cqcqmuJkSUkb+kM/ueZviWeHoL7SLd6VFed5EWc159fkq
	SHI79yug6C2IskaNDXNW6jj+gHPwiq7CeQe87WjAmL5nwzsdM5wGCkp+JNxlog==
Date: Wed, 3 Apr 2024 10:11:11 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Romain Gantois <romain.gantois@bootlin.com>, Rob Herring
 <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
 devicetree@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, Magnus Damm
 <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, Eric Dumazet <edumazet@google.com>, Jose
 Abreu <joabreu@synopsys.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>, "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [Linux-stm32] [PATCH net-next 1/2] net: stmmac: introduce
 pcs_init/pcs_exit stmmac operations
Message-ID: <20240403101111.2e3f0749@device-28.home>
In-Reply-To: <E1rrgQJ-005ZO4-GB@rmk-PC.armlinux.org.uk>
References: <ZgwoygldsA1V8fs9@shell.armlinux.org.uk>
	<E1rrgQJ-005ZO4-GB@rmk-PC.armlinux.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Russell,

On Tue, 02 Apr 2024 16:51:43 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Introduce a mechanism whereby platforms can create their PCS instances
> prior to the network device being published to userspace, but after
> some of the core stmmac initialisation has been completed. This means
> that the data structures that platforms need will be available.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

