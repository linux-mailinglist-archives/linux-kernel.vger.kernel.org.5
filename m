Return-Path: <linux-kernel+bounces-78089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87CE0860EC2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB6928488D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF75C91E;
	Fri, 23 Feb 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dZ9yY35a"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE71B95F;
	Fri, 23 Feb 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682195; cv=none; b=hU5sA6YepUZjav3j6UkB7ccYlOAjO+yilH0SVgQDuZsGz+bKkzzsAIIdldpLVdPQ9pbsjz+GXxD17bITWuKXCJiAzJJE7tyY10kwwsleYKtDtZf2yLKEnNTMRN4wtyDMV8AuJc/V+JgIYIJNOLv1yPa1ydWvzR7znIdI2Co1Z0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682195; c=relaxed/simple;
	bh=H+5Q8S0fCCHH/72zW00OZ26QcIirOOQqYtSEZXPW3hE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9GkB62ISUtb23KvM5apZY5k6T2BQnDI5BhVNAcrTWAIBl3jOMsF3BnlsT/n1dOiWCHXIJ1LSoJzY2Us8RPP+W6pTmUZR+tp3znABCy5e4oLKC+TUrDFr/FbjQMPi26kq8YUvGpqjUSEieNbcY2OkMZg/GWPsUg73Msdd6w7nWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dZ9yY35a; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A86031BF20B;
	Fri, 23 Feb 2024 09:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708682191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+3ui4MTey0h3yMuAIR85kZGD6qDVbJZoIy/CfcoFU4=;
	b=dZ9yY35ac+PkpZTeHWyoX8fwl12pTM/KBK+uK5NZOMXMMwRu7nZt/nPeb4WrtkpE4kUVoG
	JtoC2VWAhV1v9zPBannrTy349VpaZMT8tg4VSG6Q/EWcDRZXFd/h5h7tMPZ9NIMLBVJSiG
	j9lgUJBiqrBPKpEofmPDCJjpVN7EZIlQ6DFjT09C/lWARcUcc2G6mRte7K9mGNRpbQt7gE
	a/gwK+Zv3yQWzPPNar2HVpMepeiVcmBZ7FqVUyN8gO6DdzcFP/CYUpFXIkrLEnk+DvwAsZ
	v47LMvVbmHF26lJbaDZqWd6im5aO9I2IbKkwcrwaomUqmRQiaKtzWnm9+wRr6w==
Date: Fri, 23 Feb 2024 10:56:26 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Jose Abreu <joabreu@synopsys.com>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, Tomer Maimon
 <tmaimon77@gmail.com>, Jiawen Wu <jiawenwu@trustnetic.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, openbmc@lists.ozlabs.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: pcs: xpcs: Explicitly return error
 on caps validation
Message-ID: <20240223105626.71b2bcb2@device-28.home>
In-Reply-To: <20240222175843.26919-5-fancer.lancer@gmail.com>
References: <20240222175843.26919-1-fancer.lancer@gmail.com>
	<20240222175843.26919-5-fancer.lancer@gmail.com>
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

Hello Serge,

On Thu, 22 Feb 2024 20:58:23 +0300
Serge Semin <fancer.lancer@gmail.com> wrote:

> If an unsupported interface is passed to the PCS validation callback there
> is no need in further link-modes calculations since the resultant array
> will be initialized with zeros which will be perceived by the phylink
> subsystem as error anyway (see phylink_validate_mac_and_pcs()). Instead
> let's explicitly return the -EINVAL error to inform the caller about the
> unsupported interface as it's done in the rest of the pcs_validate
> callbacks.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

This looks good to me,

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

