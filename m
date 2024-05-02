Return-Path: <linux-kernel+bounces-166819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA858B9FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7706C1F21AF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAD3171E4D;
	Thu,  2 May 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="L7u2MDey"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7478F17164E
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 18:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714672916; cv=none; b=IsC5ymE38lOEavnDqld8N8h7ptHPhERfIZfQ53O4+aFgNT+BVrpIsVTpY3hWlGObDgJMNvNIkYskOrugQADf94wk7vBPU3XPEwkSzAMuNqqpfCprJ+AwaSBcYAkSd1Jt1Yy+eCXEc0eUx9e1Z+V7QA9aVxQBlHo2U0vAf+OlbFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714672916; c=relaxed/simple;
	bh=DAkYBXQJBlpsNF/cl0LhpQ554Vz5rmbPd7g3ktFfzqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSGE2u404Y8HCUkWKcTLttADyUY8UjwncR/3I9bQ2PaENKC7ySVW+lvKygPiuOWwvGCZ3v6yiVSBugxKJvlzO4lr2tBllkKFq4jxsFUiMn6e4KB+zPnfaWef6E1Gc+zgIqufA3dIkVSNlOs0sTAcLE9doGLKlAYkUArTsTvQv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=L7u2MDey; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=DAkY
	BXQJBlpsNF/cl0LhpQ554Vz5rmbPd7g3ktFfzqg=; b=L7u2MDey/d4F/lQ7UABU
	Z/M6vmijg7t+e+DEuCECZapnyPou4ovwXIhWAT0JM3JY7KwVvTdwympoZLsdyIWp
	qDhDthErgimKMhw3t3fzGgHm33jDUUwjsm3H5V++cdq+N7SRYmmwc7B/yaZJ6JLB
	Ho3q2OHEGD7QoDyw+Q0KP1wo+KLI1jIEhwaPn1tUFwR3Xbe9s+Dnm6iJGMee3D4p
	HzwHsu+onP+7LerXS9ho7953JHaBmgPgETbKH6geWWvkOVediD/L8UlKulMRI9vK
	AG30A8O3kpqU0+bDjwcw+BgZ2dvhCUiqc3+GpP3i1jUkUe5Q6NjSLMVl2DbEJsIZ
	4A==
Received: (qmail 3328518 invoked from network); 2 May 2024 20:01:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 2 May 2024 20:01:51 +0200
X-UD-Smtp-Session: l3s3148p1@aBfBZXwXBu1ehhrT
Date: Thu, 2 May 2024 20:01:50 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] serial: sh-sci: start hrtimer after setting up
 DMA
Message-ID: <20240502180150.r3pb2izsjlpqzszz@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	linux-renesas-soc@vger.kernel.org,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20240416123545.7098-4-wsa+renesas@sang-engineering.com>
 <20240416123545.7098-5-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="js57najwoohyptm3"
Content-Disposition: inline
In-Reply-To: <20240416123545.7098-5-wsa+renesas@sang-engineering.com>


--js57najwoohyptm3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 16, 2024 at 02:35:47PM +0200, Wolfram Sang wrote:
> In the RX DMA completion handler, the hrtimer was restarted before DMA
> was set up. If DMA failed, for some reason, it would clean up and the
> hrtimer would run into a NULL-pointer. Restart the timer after DMA was
> successfully set up.

Further investigations, please review:

Originally, I thought this was the race condition Dirk encountered. But
I didn't take locking into account. sci_dma_rx_timer_fn() is protected
by the uart_port_lock. sci_dma_rx_complete() is also protected by the
uart_port_lock. So, the position of restarting the hrtimer should not
matter.

However, I still think it is good coding practice (and easier to
understand) if we cancel the hrtimer at the begin of
sci_dma_rx_complete() and reenable it only if setting DMA was
successful. Because that basically means the timer only runs when DMA
was scheduled and has not finished yet.

There is some unnecessary unlock/lock in the error handling of
sci_dma_rx_complete(). I'll simplify this by moving the dev_err
downwards.


--js57najwoohyptm3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYz1Q4ACgkQFA3kzBSg
KbZm0w//eZ5cZq4DX8pPTTvVIVuT9AjpiB59BUYA79fhrfvqyyCVCBp723SSdNJT
7O+8oUCVy+jpkDb0CTCFYy2ejvEwDVBoq5TMgRREpGw04MnBzSvYmogeLhdKdqro
JCTuIdoU4K3OzXZsbqLi98ZQwpZmXaxNPF4Hjq3hQN+atJu9cmIgQq/2jbNptx7e
Cq9ow1Jowp1RngMR9i0CVypjwwz4FsPk2u8j9jhrv1+Jnj68ThkoTePx0wof2ky0
kYS6uNd+7P5MWVcLuFRCXAcPNNAxm4VgIRdd2qNJZ7G1v49uDwJ5IKlDlem5i3XQ
WpyXOx0RizXXxlDbho+eQi6WgaafJ9q8KgcqE5iIBkp4gPp6oZ+2sd0bTUT2Xu97
deDVQPoh1oiyY9T3reM50dRZ43zp/Yrt6Q8WC+zK7V6mNfuWQ6upN4umbOXPObCH
t3Si8GOtMEox8fhg96hbbw3qNDPMv85Vr11dGGXmwOc6VY7WA61B299blH82gacT
tPaa1oYuo7cm4yGc3ErqrwEs8a7rplctQNiE9YkTfIfhmysXiSjN4QwB6spxq3Ps
09Rgews6i6y+Lzez1/CTn7xEvXWKoPoYNFOYr/wnkE81dOqcTvFT3ca3mUFLBtNv
i0y/k12/IuQGweQn2G0lx5A4ahvtrGIKAzW28dHeJoVj7T6wq3c=
=4p+v
-----END PGP SIGNATURE-----

--js57najwoohyptm3--

