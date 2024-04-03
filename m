Return-Path: <linux-kernel+bounces-129311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA5F896868
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC27D1C20F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53BF97174F;
	Wed,  3 Apr 2024 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DUci3QcC"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB46F06A;
	Wed,  3 Apr 2024 08:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131954; cv=none; b=FNQq79AgZCJs/L/C6sjnyjtKh222n+A2MDpYFJlkeCj1EmvOFM/iQSlxIWG9huudNVUOL21QMMjR5ZS0sSA2ohWLnqq9LXIMKXqCZcY8BEgYwLJxF+tQPCYhbHX77i6w1mzTYDOZ90eZakn5sPc45QjKLqexhLm9z/PcNKDBHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131954; c=relaxed/simple;
	bh=EHa1zxyKWmZK+zmrxrh2RGr+d9+hXhxn4ElAbTApU+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JTby0sMbtdhrDqw//vrHN9/RCteY5ZNQZn6l600Q9BQ7Pi/go5Z8VRgOnH8gV5voxcX631D+QfagTQHs7m3g3tL+3ESc+6pSFBWYEtiG6k+JFKbFsDRx2j7xKtkMT7O7mFn/BOvr9tIXKlTGXPkXvZaxtjcfPsqFMg9oP+gqJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DUci3QcC; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8DF8B240006;
	Wed,  3 Apr 2024 08:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712131950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d7VmNXsVVzmynD0RU3YYpBwDxDMYzHSxROIRJMRyMYA=;
	b=DUci3QcCRqYH5n73+mf4W+BNdIe3VGa+vtx+ctsNebBek1RSWvHApFxoQJzvKWUsv8YBTP
	UvzQf4DtfkKGx2LaJ9vabDXwb+f7KkMl4cpHgtkaL3UOCZyRd7hIk7pzt0LocBxxEA/cBI
	xExFOxrTFKOaWNfwJ6ZnG8qw43TALkGhtgW3WK07ctTwEGQa7fgbiA4U7o6TzxKVrMpm89
	C0SbOM3d1XKJ4IC7YUokK9z1qrk0QNlCQ8qnyQlCFJSXeH0FijWN6msIRniXwrSOWhr+Wt
	lENNnrgDar/k4as8GHDSY9G6tuNkItv69gyiPQPlGKowzyzSQaOWNBNwWGJVnQ==
Date: Wed, 3 Apr 2024 10:12:26 +0200
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
Subject: Re: [Linux-stm32] [PATCH net-next 2/2] net: stmmac: dwmac-socfpga:
 use pcs_init/pcs_exit
Message-ID: <20240403101226.3db69df9@device-28.home>
In-Reply-To: <E1rrgQO-005ZOA-KT@rmk-PC.armlinux.org.uk>
References: <ZgwoygldsA1V8fs9@shell.armlinux.org.uk>
	<E1rrgQO-005ZOA-KT@rmk-PC.armlinux.org.uk>
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

On Tue, 02 Apr 2024 16:51:48 +0100
"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk> wrote:

> Use the newly introduced pcs_init() and pcs_exit() operations to
> create and destroy the PCS instance at a more appropriate moment during
> the driver lifecycle, thereby avoiding publishing a network device to
> userspace that has not yet finished its PCS initialisation.
> 
> There are other similar issues with this driver which remain
> unaddressed, but these are out of scope for this patch.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks for addressing this,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

