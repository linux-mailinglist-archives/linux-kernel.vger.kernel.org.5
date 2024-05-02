Return-Path: <linux-kernel+bounces-166831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 015898BA02A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922371F23C9D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5AD16FF3F;
	Thu,  2 May 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="EUyD36SC"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF07615B96E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673861; cv=none; b=hqiRasxjJ7tJRL5HI4dCdaE8VcpC/1rsKY1EMLazvXSjUapJ+SFB2M2Lad/sOxcOrlEFy/c7mMQTesgHg4Gpe4Thb3iGvL9LkLA71YYEMKzalCck+56+jWa0SNdIsG1PAOTdXaIFqnmccjWzNvUUe85CIDZLV3j+/oXMzaTsAvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673861; c=relaxed/simple;
	bh=KhdkdyVLO1m1Lp33vPRYarXehHaipcBx459m/LvdYGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUDKuD3m3R0k3WkIdnk1gLsD92GbR8LdBvpngToiyKXrDp/PUkKqhxcQGBWl/Ft9X69DSt4K8EB2Uzj0Or+A+DjuT2YhFxC52iy6y9s1HrarMVLHtvzGQ8Nx5biN+7ULzmFni4xG45vUGjpgc4fyIRehykSlpMfKr1143JEA+Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=EUyD36SC; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=ra8p
	SWsauUgo3TWihYTMQJ5qhlBnHKFupkcSfPmlHL4=; b=EUyD36SC3T6b7DHFxdIV
	zbkesz6FiHj7eeUDDY+1h4GwM52KL4aaJGReqseJfcBjmxQCw3ga8NAYSeS2heIK
	/6gpZ3XTLDTIJUfJq3bPFrZD8qcltWPNM3fNaZeGLL9c27EKhdA+pVQgKBEyqQxH
	4T9PhEHJrfdYE8ga8SYW4Br3jSAQQzPJ/ZgBb5KbBSp/X4deTO6bqHuRwO++pnlG
	ajN3Ctinf5EZmBuu/G2h30SFZjLH2A0ss0gWF6jrOxjJx9jwTagXAWQWNIZYpNq8
	j26xX0U8LYwujzJtpb/nqDf5INtFZzDehkQlhs0x5nfD7gCJ+VW2vFrv+Bp8/Mru
	7Q==
Received: (qmail 3332279 invoked from network); 2 May 2024 20:17:37 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 May 2024 20:17:37 +0200
X-UD-Smtp-Session: l3s3148p1@BLgvnnwXNKlehhrT
Date: Thu, 2 May 2024 20:17:37 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Aleksandar Mitev <amitev@visteon.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] serial: sh-sci: always cancel hrtimer when DMA
 RX is invalidated
Message-ID: <20240502181737.b5vvghnwzievvlgj@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-renesas-soc@vger.kernel.org,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Aleksandar Mitev <amitev@visteon.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
References: <20240416123545.7098-4-wsa+renesas@sang-engineering.com>
 <20240416123545.7098-6-wsa+renesas@sang-engineering.com>
 <CAMuHMdUEvft0B9WdfZ936ccomZW4Qea8MVNSj-Q-Dyn8EKSUdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h6vetrfs6rdknizx"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUEvft0B9WdfZ936ccomZW4Qea8MVNSj-Q-Dyn8EKSUdA@mail.gmail.com>


--h6vetrfs6rdknizx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Geert,

good news, I was able to trigger the DMA rx code path. I dunno what I
did wrong last time. I started from scratch again and it worked easily
by dd-ing random data to the second non-console debug port.

> I do think you need to cancel the timer: even when not restarting
> the timer in sci_dma_rx_complete() due to a DMA failure, the previous
> timer may still be running, and will cause a NULL pointer dereference
> on s->chan_rx on timer expiry.

Taking locking into account, I think this patch is bogus. If we run into
this NULL-pointer, we have a locking problem and cancelling the timer in
sci_dma_rx_chan_invalidate() is not going to fix the underlying locking
problem. sci_dma_rx_chan_invalidate() does not only clear the pointer
but also the cookie_rx-array. sci_dma_rx_timer_fn() bails out via
sci_dma_rx_find_active() if that array is cleared. It does so before
accessing the chan_rx-pointer. So, it looks to me that should work once
all calls to sci_dma_rx_chan_invalidate() are protected. And there is
one path where this is not true, namely via sci_dma_rx_release() during
shutdown. This is why I asked Dirk if the system was about to shutdown.
Currently, I don't see any other problematic code path.

> > -#ifdef CONFIG_SERIAL_SH_SCI_DMA
> > -       if (s->chan_rx_saved) {
> > -               dev_dbg(port->dev, "%s(%d) deleting rx_timer\n", __func__,
> > -                       port->line);
> > -               hrtimer_cancel(&s->rx_timer);
> > -       }
> > -#endif

Also, this chunk needs to stay. I suggested in patch 1 to cancel the
timer on successful dma_rx_complete, so the timer only runs when a DMA
is in progress. Then, of course, we need to cancel it in shutdown.

I hope I am not seeing "no wood for the trees" by now. I am not
convinced that I actually found Dirk's race condition yet...

All the best,

   Wolfram


--h6vetrfs6rdknizx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYz2L0ACgkQFA3kzBSg
KbbZQRAAsQIP51T8nRbMyG0IcszboQuFisobiJLZh/Bshh57hC/j3aIacLk8kpBm
V3rR1WRUgfMdFlRxxoo3W1kYFZC0O8JXQvM5+5J3VAfvD3+7ukEbmYvBe/6brMf+
Ji4p9kow5Q6mCaB7aQLmwkFf8NDtbThYX2/jSKug4MPE9ta4KK49XecNfnJHNeD4
imOH3XWX65wb4qNomiDagbmM8FHeVWq7hNh0ERrlkHWXZQNSO0gRHEUj19FNgLmX
ctDJNJNZQEe1y6UapsukFQyycJXvOn2WIRbDdqk1ysew8Vol/wF4s9XRbCnT4HDc
Ga851NbnAP7ke19XRs3PT65PAFVjobknnNFi1Bm0zlCGnS3gcMX+/wJ1yQbU3zot
mqeLYxzZU/VKzA48dni/pHT2SGTUb9OZOZCTq2LjwnPkEhwFKmZgWzXqixewFqpI
MhYh41dViiUvPVgVDYgB63Zu3TyAlE0j9L6zGTK9cxrfLiwidObp4N4SchNtf6G2
UsibHNx4Px3QiCOw17EbWzqTsr35xkOiB1elw+Uzq5Yk6REFgpjx1yy1SrF3XkiW
1ZbgFr9hHPqWVol8Wb/NGj6vflSqGyDYBbxchfZD6s2Y2LfFopxnsybB3m+SCVV1
5GfdQrHI6MVQOt+HfpWJaJ1lVgj/ztN7zYkqrCBy+9AgF7u8oUc=
=PYh5
-----END PGP SIGNATURE-----

--h6vetrfs6rdknizx--

