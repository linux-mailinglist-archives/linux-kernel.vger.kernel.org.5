Return-Path: <linux-kernel+bounces-145596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D008E8A584E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86546281DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4182892;
	Mon, 15 Apr 2024 16:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pGp4TMgP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gYnkId0s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pGp4TMgP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gYnkId0s"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E747A8249B;
	Mon, 15 Apr 2024 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200256; cv=none; b=oyT57DzVokxjFfyJgXkCD9IDKJ8DETy5jO8XfJJDSMCKdcrixRHNQZodC4DpCjtGNcG6oYqkISGrRF0WanZtK5xtGm3nDaGWQN2/h4tiA9mcPTPPigRkSvf5YW6cKFCiBvGouhPzAzSiks6EI0wjeYj0MLg5rpurkry987pEYe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200256; c=relaxed/simple;
	bh=3Q2z3ZOcwk5PM/bVaMTg5cwLejXzcCrw952/vQ4w3t0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MQRi8pBBxNdrsn6gWcWJbon7OzJaq/ycnxUlbdrDtyoM1jH9kJXLCApqxWlZE4OUmfqttNJvL/2b6VNeXMrMuBj32DOBEJk5ga63hrACGbLi1jvDDvpvR+snyGyXs4i1ax+FfIxeqLhQzUe2LI7dZ3/vGzw0kkpTvg6m4SXiOjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pGp4TMgP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gYnkId0s; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pGp4TMgP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gYnkId0s; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from samweis (unknown [10.149.242.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A29C21CA1;
	Mon, 15 Apr 2024 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713200252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bneK5TNfAqWoVhmF1+3QNHHN83grbJAdEO5Q6mIqQVw=;
	b=pGp4TMgP+BTNF99QPFz8wB18knlOQsEaV5Bg0jDI0YslYEIDB3IIzdxtDUVNlY4ItLVxI+
	VcmKYJPak7DyMQpZXJqVE0VCTpY5DpKUPKEia33V+44Yly4fopYNRkzF+upMMrz/pZxHER
	TAVdZ/18O+jf37FdOY8l9zGQVWg5ewo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713200252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bneK5TNfAqWoVhmF1+3QNHHN83grbJAdEO5Q6mIqQVw=;
	b=gYnkId0sJPEMbzwpkT1n757CiaWEM/VYnUPzRpXnQ01NkNd693gmw5l/G5I+QQz0oLClnK
	6qd23GbR3/OJeLDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713200252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bneK5TNfAqWoVhmF1+3QNHHN83grbJAdEO5Q6mIqQVw=;
	b=pGp4TMgP+BTNF99QPFz8wB18knlOQsEaV5Bg0jDI0YslYEIDB3IIzdxtDUVNlY4ItLVxI+
	VcmKYJPak7DyMQpZXJqVE0VCTpY5DpKUPKEia33V+44Yly4fopYNRkzF+upMMrz/pZxHER
	TAVdZ/18O+jf37FdOY8l9zGQVWg5ewo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713200252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bneK5TNfAqWoVhmF1+3QNHHN83grbJAdEO5Q6mIqQVw=;
	b=gYnkId0sJPEMbzwpkT1n757CiaWEM/VYnUPzRpXnQ01NkNd693gmw5l/G5I+QQz0oLClnK
	6qd23GbR3/OJeLDQ==
Date: Mon, 15 Apr 2024 18:57:20 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: Andy Gospodarek <andy@greyhouse.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: 802.3ad: Avoid packet loss when switching
 aggregator
Message-ID: <20240415185720.399e054f@samweis>
In-Reply-To: <20447.1712795309@famine>
References: <20240404114908.134034-1-tbogendoerfer@suse.de>
	<21529.1712592371@famine>
	<20240410175052.25ac7638@samweis>
	<20447.1712795309@famine>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: 
X-Spamd-Result: default: False [-3.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.963];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_ZERO(0.00)[0];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Spam-Score: -3.79
X-Spam-Flag: NO

On Wed, 10 Apr 2024 17:28:29 -0700
Jay Vosburgh <jay.vosburgh@canonical.com> wrote:

> 	First, I'm not sure why your port is in WAITING state, unless
> it's simply that your test is happening very quickly after the port is
> added to the bond.  The standard (IEEE 802.1AX-2014 6.4.15) requires
> ports to remain in WAITING state for 2 seconds when transitioning from
> DETACHED to ATTACHED state (to limit thrashing when multiple ports are
> added in a short span of time).
>=20
> 	You mention the issue happens when the aggregator changes; do
> you have a detailed sequence of events that describe how the issue is
> induced?

setup is one Linux server with 2 dual port ethernet cards connected to
a HP 5710 Flexfabric switch with two modules. Using MC-LAG is probably the
key to trigger the issue, at least I couldn't reproduce without it.

1. create bond0=20
2. enslave 4 ports to it
3. wait for link up
4. do duplicate address detection

most of the time this works without problems, but in the error case
DAD fails with an ENOBUFS for the send call to the packet socket,
which correlates with the tx dropped in the bond statistic counters.

I've enabled debug print for the ad_agg_selection_logic() and in
error case the look like this:

[ 4488.603417] bond0: (slave eth6): best Agg=3D1; P=3D1; a k=3D0; p k=3D1; =
Ind=3D1; Act=3D0
[ 4488.603428] bond0: (slave eth6): best ports 0000000019ca9537 slave 00000=
000ee0c58b9
[ 4488.603433] bond0: (slave eth6): Agg=3D1; P=3D1; a k=3D0; p k=3D1; Ind=
=3D1; Act=3D0
[ 4488.603437] bond0: (slave eth7): Agg=3D2; P=3D0; a k=3D0; p k=3D0; Ind=
=3D0; Act=3D0
[ 4488.603441] bond0: (slave eth8): Agg=3D3; P=3D0; a k=3D0; p k=3D0; Ind=
=3D0; Act=3D0
[ 4488.603444] bond0: (slave eth9): Agg=3D4; P=3D0; a k=3D0; p k=3D0; Ind=
=3D0; Act=3D0
[ 4488.603447] bond0: Warning: No 802.3ad response from the link partner fo=
r any adapters in the bond
[ 4488.603449] bond0: (slave eth6): LAG 1 chosen as the active LAG
[ 4488.603452] bond0: (slave eth6): Agg=3D1; P=3D1; a k=3D0; p k=3D1; Ind=
=3D1; Act=3D1
[ 4488.610481] 8021q: adding VLAN 0 to HW filter on device bond0
[ 4488.618756] bond0: (slave eth6): link status definitely up, 10000 Mbps f=
ull duplex
[ 4488.618795] bond0: (slave eth7): link status definitely up, 10000 Mbps f=
ull duplex
[ 4488.618831] bond0: (slave eth8): link status definitely up, 10000 Mbps f=
ull duplex
[ 4488.618836] bond0: active interface up!
[ 4488.678822] ixgbe 0000:81:00.1 eth9: detected SFP+: 6
[ 4488.706715] bond0: (slave eth6): best Agg=3D1; P=3D1; a k=3D15; p k=3D1;=
 Ind=3D0; Act=3D0
[ 4488.706726] bond0: (slave eth6): best ports 0000000019ca9537 slave 00000=
000ee0c58b9
[ 4488.706732] bond0: (slave eth6): Agg=3D1; P=3D1; a k=3D15; p k=3D1; Ind=
=3D0; Act=3D0
[ 4488.706737] bond0: (slave eth7): Agg=3D2; P=3D1; a k=3D0; p k=3D1; Ind=
=3D1; Act=3D0
[ 4488.706740] bond0: (slave eth8): Agg=3D3; P=3D1; a k=3D0; p k=3D1; Ind=
=3D1; Act=3D0
[ 4488.706744] bond0: (slave eth9): Agg=3D4; P=3D1; a k=3D0; p k=3D1; Ind=
=3D1; Act=3D0
[ 4488.706747] bond0: (slave eth6): LAG 1 chosen as the active LAG
[ 4488.706750] bond0: (slave eth6): Agg=3D1; P=3D1; a k=3D15; p k=3D1; Ind=
=3D0; Act=3D1
[ 4488.814731] ixgbe 0000:81:00.1 eth9: NIC Link is Up 10 Gbps, Flow Contro=
l: RX/TX
[ 4488.826760] bond0: (slave eth9): link status definitely up, 10000 Mbps f=
ull duplex
[ 4488.914672] bond0: (slave eth7): best Agg=3D2; P=3D1; a k=3D15; p k=3D1;=
 Ind=3D0; Act=3D0
[ 4488.914682] bond0: (slave eth7): best ports 00000000413bcc63 slave 00000=
000931f59f6
[ 4488.914687] bond0: (slave eth6): Agg=3D1; P=3D1; a k=3D15; p k=3D1; Ind=
=3D0; Act=3D0
[ 4488.914692] bond0: (slave eth7): Agg=3D2; P=3D1; a k=3D15; p k=3D1; Ind=
=3D0; Act=3D0
[ 4488.914695] bond0: (slave eth8): Agg=3D3; P=3D1; a k=3D15; p k=3D1; Ind=
=3D0; Act=3D0
[ 4488.914698] bond0: (slave eth9): Agg=3D4; P=3D1; a k=3D0; p k=3D1; Ind=
=3D1; Act=3D0
[ 4488.914701] bond0: (slave eth7): LAG 2 chosen as the active LAG
[ 4488.914704] bond0: (slave eth7): Agg=3D2; P=3D1; a k=3D15; p k=3D1; Ind=
=3D0; Act=3D1

I've added a debug statement to find out why Agg 2 is better than Agg 1 in
this case and it's because Agg 2 has a partner (__agg_has_partner() is true)
while Agg 1 doesn't.

Wouldn't it make sense to also check for slaves in COLLECTING|DISTRIBUTING
state before switching to a new aggregator ?

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

