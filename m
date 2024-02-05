Return-Path: <linux-kernel+bounces-52738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8612849C18
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4FE1C23BD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE16210F0;
	Mon,  5 Feb 2024 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aQ3q4fo9"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B21EB56;
	Mon,  5 Feb 2024 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140484; cv=none; b=nqW8I1+IQyo4PrCVspOFdVF0QAiPbBBpe8xFrae83/O0YXkInYhPORzPcE55lxaFmAlJx/gnwOXcGIDSr7ImpKnCGla3V8gla5ysR4XvoSFFk3fONOnJksI9BDJnJImPIULOkKMwizWC6sEPbqiB6L+pNRMfhhE+lbJN8s+jHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140484; c=relaxed/simple;
	bh=zwnCHnD/MrNOf2YWF36/trUsPzg2/XiBSWgnK3k3VZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDMPEt4WlHq+uOBqKJ2Od1n6GqQw5jnJFgjPxOEQicbGsipiwb+JHSpI16K0n7R2Bn8By2lunR1sWTUH5geFCTs4CXyvZ6uEmJdQFwW2xHnhWi0N4o4alLjyGPom93GLbnPPuZf4VeKri74kQs+N3ipU9KFrAFtTrS10hh4Si5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aQ3q4fo9; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4314EC000F;
	Mon,  5 Feb 2024 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707140480;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UHxaJOQrQBChbPgfzc/BYTQVapSy4VamkViWwz56zDE=;
	b=aQ3q4fo9SCEczbC/c8OFRLgF05stNC165Db1f3Wi0/CDf+1DYSCCuJvZ9RKT4a4/C/jMq6
	Aw91YI+KAuVztHqsY+QHAGYsF1mIUe8WPkAYqK2Jj0ZRM113f54H2knjiwjgXIQINhBcZZ
	+W7Y1lwNgKb1vNX2iGFnfEXPJWGUNnC+dV+ZdF9GwKXQW+09rqm+5uEZVbNnRS1DiKlR70
	6HUUVaj1xkhqvAAZRbjOEKwO+Z6ugalFlCBCNc4tR+9bgSuU45KbWDskmmZ0bRy/P/qC9S
	WitYJIflDPwgHMS+B1ES4/HMy6RI8UYIXZ7D7OCmr3xlIWZHn+VJFjThjqlJUA==
Date: Mon, 5 Feb 2024 14:41:18 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, andrew@lunn.ch,
 linux-wpan@vger.kernel.org (open list:IEEE 802.15.4 SUBSYSTEM)
Subject: Re: [PATCH net 08/10] net: fill in MODULE_DESCRIPTION()s for
 ieee802154
Message-ID: <20240205144118.12cdc824@xps-13>
In-Reply-To: <20240205101400.1480521-9-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
	<20240205101400.1480521-9-leitao@debian.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Breno,

Please be more cautious with your titles. It's your second or third
e-mail with this content without version number. And you also forgot to
collect Stefan Ack.

leitao@debian.org wrote on Mon,  5 Feb 2024 02:13:57 -0800:

> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to the IEEE 802.15.4 socket and 6lowpan modules.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

