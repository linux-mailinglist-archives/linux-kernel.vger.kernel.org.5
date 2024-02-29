Return-Path: <linux-kernel+bounces-86204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2E886C18B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA45D1F22073
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F81D446A9;
	Thu, 29 Feb 2024 07:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HITJQtNU"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423BF224D7;
	Thu, 29 Feb 2024 07:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709190087; cv=none; b=pp6stXtlpKNK+13WsLtQ4ez2sw5W4ov2m70Mj3mx48mgrS1xwP+u7VpuQDaadKhMIlssEY8fvKYkf/Pwtbz0pOhlBV2HSvzdKBLy/q9r5pGPLUQnQpCy9UKCs+ccKQiiESBcZAkx4xNxUzoP3uu63lDMIED2dJkmcLXikduJlAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709190087; c=relaxed/simple;
	bh=lbTHGy/A0TH62lQcwcqZXsooj3qK3g+U7b7nGvW0TDU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lB9Yn4wXYdSssmA5d9P5K6kEP+3n2+ruMgcEhyQ9na2ze0SpZzvQvgM9Y9BDDp75WjV2zTNlcGfOOPuuwaSpjuqD35m3UbxkOlmZjpZaQ7H510pRP9LJpZ7qjxP7XHFNNIltksTO+hJXBdWXJxCDnfe6+WgHjgMNi9Z9S3wkfXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HITJQtNU; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AF2F120002;
	Thu, 29 Feb 2024 07:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709190083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rzzxaarDPZK4SfL8HWkqA2JOswOQEen30YwCunBSS64=;
	b=HITJQtNUVVn+0A8zwl6ZPWFZBrMgqyaezwCRvd5nE3FoGDAbDg4hiaEeYcfEqsv6PihND/
	0l9/BJNUoT2xlYFGDhcGM0zAaTUEUelvlCynP5bM8z1e3mQheBNVqo7xnArj6xw32N8mD4
	R0PaGgvdEskVoGYS+LAxtf+eC0wYn6dQ5nh2C/HKveC1mqbTjTqt9or+Zf55j+wb5E85NY
	IBke3AsNA4f/Z9iq1Exb/X2EBiI/3psaIkZGJLXr9b69XrxG1uaIZLq6WwLPNcSPatk7rG
	gqxQmnVpOQAHBVBfgyLLC7AWphc5gjycYt0FGUsij+OqmF/Qhx59CqUvUhCdPw==
Date: Thu, 29 Feb 2024 08:01:15 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>, mwojtas@chromium.org
Subject: Re: [PATCH net-next v9 08/13] netlink: specs: add ethnl PHY_GET
 command set
Message-ID: <20240229080115.692f2dbe@device-28.home>
In-Reply-To: <20240228201018.44b7f97e@kernel.org>
References: <20240228114728.51861-1-maxime.chevallier@bootlin.com>
	<20240228114728.51861-9-maxime.chevallier@bootlin.com>
	<20240228201018.44b7f97e@kernel.org>
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

Hello Jakub,

On Wed, 28 Feb 2024 20:10:18 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Wed, 28 Feb 2024 12:47:22 +0100 Maxime Chevallier wrote:
> > +        reply:
> > +          attributes:
> > +            - header
> > +            - index
> > +            - drvname
> > +            - name
> > +            - upstream-type
> > +            - upstream-phy-index  
> 
> doesn't exist: s/phy-//

Arg. Quite a silly mistake indeed :/

> FWIW
> 
>   make -j $(nproc) -C tools/net/ynl/
> 
> should build reliably, again.

Just tested with a fix and it builds fine indeed.

I'll send another iteration.

Sorry and thanks,

Maxime


