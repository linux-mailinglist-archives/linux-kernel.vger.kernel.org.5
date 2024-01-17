Return-Path: <linux-kernel+bounces-28660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18604830180
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCFDE1F23422
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943A13FF9;
	Wed, 17 Jan 2024 08:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="dRN2eNIr"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FBE12B69;
	Wed, 17 Jan 2024 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705481271; cv=none; b=sZE9rPPDyjF5lNFNnSGgUA7cqi3/3mYDeJM8yRY/cy2K2WL25vqXRbT8XbLU89kZQqdnQBZnp8ZTx/41dYp6LfmRiIIWYZmXYzKGFiS1VL3/Fuj7Atz0g8aizkBGF4J4xdrOAaFynnXWtlHONK9BeP4cejV1dUY8FIjO2hhy+ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705481271; c=relaxed/simple;
	bh=0igOq/hZ7wqLwJ4zmvH8lJ33zRllN9XdUsSn9KPsCDY=;
	h=DKIM-Signature:Received:Message-ID:Subject:From:To:Cc:Date:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 User-Agent:MIME-Version:X-malware-bazaar; b=raYAAzZvf3eGwo9BdEywe2VHb7pERRPyOA1oyJSnnEmI+k7kKSOfCRmu7LcZuprhTIqmlIa7DewNEuUvuJ3VJGSMfMB7h6hqPwJALcMq4fA6zTT2du5Fc9z8LPGBBm2NC1OZL+Lc0aoK9bIErmo41TBes4V7qSo0ZngXyKt87TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=dRN2eNIr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0igOq/hZ7wqLwJ4zmvH8lJ33zRllN9XdUsSn9KPsCDY=;
	t=1705481269; x=1706690869; b=dRN2eNIreBAgABskcxxhaqAdzjrkKQEoeDsGndoQQqPU79Y
	YMsH4aodBKMkzchh3OPEmZSH/AFKERgTqbspaYFvv2G7G3yASYclfby34q9lh49KZP+zN1f0jz3K9
	rHuqdHssUumoSnkwA9xNZ05Z1G3COr1Ywc5xjLQ5RUGBc7c1Xlc/4xiRbUxUHB4/qNQRepLAaNh9d
	UX36mCZk7jziDCI6NflYt0GgZ/H3AfexHLSIGu46qw4HSWHuxes05rqw7P8w/bE6S41K84m+CaCgm
	uiwS/POYmPPXmQ2fRgfe0H1EC7uFgg+3N5bx2cxdJ5hKrpeK7xrHXKXKiLsUcLqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rQ1aL-00000006KBS-1I9g;
	Wed, 17 Jan 2024 09:47:45 +0100
Message-ID: <8cce0dee8588b9f3cd0c1a3f073466b01905a703.camel@sipsolutions.net>
Subject: Re: Question about reference to config KERNEL_6_2
From: Johannes Berg <johannes@sipsolutions.net>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, linux-wireless
	 <linux-wireless@vger.kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, kernel-janitors
	 <kernel-janitors@vger.kernel.org>, Linux Kernel Mailing List
	 <linux-kernel@vger.kernel.org>
Date: Wed, 17 Jan 2024 09:47:44 +0100
In-Reply-To: <CAKXUXMyfrM6amOR7Ysim3WNQ-Ckf9HJDqRhAoYmLXujo1UV+yA@mail.gmail.com>
References: 
	<CAKXUXMyfrM6amOR7Ysim3WNQ-Ckf9HJDqRhAoYmLXujo1UV+yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

>=20
> Commit ffbd0c8c1e7f ("wifi: mac80211: add an element parsing unit
> test") and commit 730eeb17bbdd ("wifi: cfg80211: add first kunit
> tests, for element defrag") add new configs that depend on
> !KERNEL_6_2, but the config option KERNEL_6_2 does not exist in the
> tree.
>=20
> Also, Kalle Valo [1] asked during patch review about that, but did not
> get any response on the mailing list.

Oops, I probably thought I'd clean that up and forgot.

> So, what is the KERNEL_6_2 option all about? Is this something that
> was just used locally for early development?

It's a backport-ism (backports.wiki.kernel.org) to restrict the option
to certain kernels.

> Can we just delete this dependency in these two config options?

Yes, we should.

johannes

