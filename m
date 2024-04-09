Return-Path: <linux-kernel+bounces-137099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FACE89DC61
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AF4B281D85
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9621328B6;
	Tue,  9 Apr 2024 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tgXNWeb3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MAY6r94R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tgXNWeb3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="MAY6r94R"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06FEF9CF;
	Tue,  9 Apr 2024 14:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673269; cv=none; b=o0r18jbwxSmLnuUVAeSIUnWtkmDiKHwRam/U+cO9bCW/a+ZfrupjpN6sGtcBIdyrS1lTckLk9qqw3yN8apqLiqJetRkR7jlcKDCI3fmiaOtdTPvrVifwngVqTdpotO5AlEBJT7bPsxKsILJ0A+dvqJ0F8oWzsRsdwICuYR14VIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673269; c=relaxed/simple;
	bh=kcqnmPfj42U746vkM5YOoaKWmnT4KJ27OYdFBzpj7Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwxEnkcnPkoZECgNjkLS4xbeVPnKG5xB2UUs349qhSNWi1hd/5NdZhj46ng153Yl5OVyYob9kDnveE5rf/0sLudszcjacnoIOzLfbxysUzYW3D4qVMhqgoWTeMRyztIsLpHvjQJRuOF6kLR2WoxRG3ikc7A1TFAmd26W2SusgKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tgXNWeb3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MAY6r94R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tgXNWeb3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=MAY6r94R; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from samweis (unknown [10.149.242.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9C1FC20A58;
	Tue,  9 Apr 2024 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712673265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+WiBy4FWOTGoEXIkyBK/Nx+ZoOsHqXAWe7RJ7TXREo=;
	b=tgXNWeb3iNYRlHRoEvwbEW0ZcGojI7VHUZY6IzhAmgaOB4RQb8osAsFspffvf2k+trjS/0
	vhJuoMSRNRNRj299R03/NYfr9S/ev3EIRewBGRzKp9udnvD4XTIAtPMZm922xayaCEXUma
	mnycau+Dsen6ElM46Q/C1hsqHGAKMD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712673265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+WiBy4FWOTGoEXIkyBK/Nx+ZoOsHqXAWe7RJ7TXREo=;
	b=MAY6r94RZJOfjDRppCA//rRkzAC5G3yAyALE+lYTm3jhHWuKJLNdRPbh54UL3RyUfAoTFx
	QUKxrOP7etkekRBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712673265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+WiBy4FWOTGoEXIkyBK/Nx+ZoOsHqXAWe7RJ7TXREo=;
	b=tgXNWeb3iNYRlHRoEvwbEW0ZcGojI7VHUZY6IzhAmgaOB4RQb8osAsFspffvf2k+trjS/0
	vhJuoMSRNRNRj299R03/NYfr9S/ev3EIRewBGRzKp9udnvD4XTIAtPMZm922xayaCEXUma
	mnycau+Dsen6ElM46Q/C1hsqHGAKMD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712673265;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A+WiBy4FWOTGoEXIkyBK/Nx+ZoOsHqXAWe7RJ7TXREo=;
	b=MAY6r94RZJOfjDRppCA//rRkzAC5G3yAyALE+lYTm3jhHWuKJLNdRPbh54UL3RyUfAoTFx
	QUKxrOP7etkekRBw==
Date: Tue, 9 Apr 2024 16:34:23 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Simon Horman <horms@kernel.org>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] bonding: 802.3ad: Avoid packet loss when switching
 aggregator
Message-ID: <20240409163423.7d0b8fe9@samweis>
In-Reply-To: <20240406160354.GW26556@kernel.org>
References: <20240404114908.134034-1-tbogendoerfer@suse.de>
	<20240406160354.GW26556@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_ZERO(0.00)[0];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,greyhouse.net,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[]

On Sat, 6 Apr 2024 17:03:54 +0100
Simon Horman <horms@kernel.org> wrote:

> On Thu, Apr 04, 2024 at 01:49:08PM +0200, Thomas Bogendoerfer wrote:
> > If selection logic decides to switch to a new aggregator it disables
> > all ports of the old aggregator, but doesn't enable ports on
> > the new aggregator. These ports will eventually be enabled when
> > the next LACPDU is received, which might take some time and without an
> > active port transmitted frames are dropped. Avoid this by enabling
> > already collected ports of the new aggregator immediately.
> >=20
> > Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de> =20
>=20
> Hi Thomas,
>=20
> I will leave the technical review to Jay and others.  But as a fix, I thi=
nk
> this patch warrants a Fixes tag. It should be sufficient to respond to th=
is
> email thread with an appropriate tag.

current behavior is older than our git tree. So should I really add

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

?

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

