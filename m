Return-Path: <linux-kernel+bounces-37358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5080883AEBA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E21285BBB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7007E57B;
	Wed, 24 Jan 2024 16:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YVulQNXr"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927D47CF3D;
	Wed, 24 Jan 2024 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115125; cv=none; b=nVwM6X/ZNhePB2fhlrWzTie43/CNzeXZ1lW1Wno210cccKGHuGRaXs4NfbFodc6kXcgUJNjEtzXo9GXFREapN7Q1CMndF4dWHKlxXQe89su6pDKWhsFvM+yOO+si2E5mx5i0x273InggAj1dB9nwHX8gL0yQVulz0vq+ae2Cbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115125; c=relaxed/simple;
	bh=QIeTCTHch/7rOF4+4kHAvCpl/cSG69Q6EDBjClEVtbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IT82N34O8km4FAv0UzApoL3teUMqNDEt/lyDJkuvNhKkfMkq7G18vOwwsbi/N2R09XT51ct6eC5Ia5nPDPc8vr1Uh64o5AhPRlh58UmVDOPQdO++7oFdZEhbHEuV7Xd0H1TfzAp0g3SRd5l5xFpICSTUtI1VxAWlg2H8wgcHi8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YVulQNXr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DA75A60002;
	Wed, 24 Jan 2024 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706115120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QIeTCTHch/7rOF4+4kHAvCpl/cSG69Q6EDBjClEVtbc=;
	b=YVulQNXrMfl14MdSxUApNWPw0NIwcmJGbHWtvMskD3Pvs2BhQyF16n9TAUzlO2e/MAirEs
	QU/nI8VKQPwcvm2P4YfH+huycdRBjReTB/pfb3yUPUwfuzgAw5dyafHMRQUqywx4nlPkza
	sc81Q7cNMWy18gzZEQwB2DUJXrIwU2XdWoBs818W7Z+5tNKKs+AkESX720BYevAjyns/mg
	WoYH3jtb1IoUeyCVrWm8wzwr3tuTRN5foQh+J1GcFolPL/ER9YSS9SiHQ6yX9p9STfUXMH
	SvDJiAy1Fk9kcKgh/pKC6t4GkMbPzqH4IsEERcb2RTVagvRitFUuKAz7D1y6Jg==
Date: Wed, 24 Jan 2024 17:51:58 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, abeni@redhat.com,
 edumazet@google.com, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt
 <stefan@datenfreihafen.org>, Paolo Abeni <pabeni@redhat.com>,
 dsahern@kernel.org, weiwan@google.com, linux-wpan@vger.kernel.org (open
 list:IEEE 802.15.4 SUBSYSTEM), netdev@vger.kernel.org (open list:NETWORKING
 [GENERAL]), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next 02/22] net: fill in MODULE_DESCRIPTION()s for
 ieee802154
Message-ID: <20240124175158.7c8b9490@xps-13>
In-Reply-To: <20240122184543.2501493-3-leitao@debian.org>
References: <20240122184543.2501493-1-leitao@debian.org>
	<20240122184543.2501493-3-leitao@debian.org>
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

leitao@debian.org wrote on Mon, 22 Jan 2024 10:45:23 -0800:

> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to ieee802154 modules.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>

I just see the v2 now. Please use "v2" in your commit title using -v or
git-format-patch.

I'll take it through wpan.

Thanks,
Miqu=C3=A8l

