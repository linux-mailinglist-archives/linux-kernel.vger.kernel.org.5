Return-Path: <linux-kernel+bounces-162559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AABF8B5D58
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45757280ED9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276A184A28;
	Mon, 29 Apr 2024 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KS73PH4e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6919D83CB0;
	Mon, 29 Apr 2024 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714403730; cv=none; b=ko9Bo2a76VJXm6xQ21rhHBQvTV7XPSjV96qYhmOMz1XQkowW7YeRwsg0aqi+ciSvqIVW/a4v4FRVyHXOrGwhxxzpNZUx/PznyljlfOGWQvexY7KpdIBbggfIt68HJoctsNnk8q0O3ulp6KWYoEorVa7acqldjIgkF7zVRRP7oh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714403730; c=relaxed/simple;
	bh=wu12zaSMIGGFJjFWB3nUQrzOKJrMtS1x5OqUcW5sFnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaXeu5HdcZgUpb6vIa4lBlf3+uublvAt5j0XgQnJQ4CYMQ/vilVA49Gux9o48PIz/RWGnLWS9K2DHe1vE+VK64IBt4/LY+4nquOG4ydz6BTljIkQx2kLfckA49hLGZnqG79xBXEpvtdVa9PxutxNXJrhtbxwIkfnq8xjXkTYM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KS73PH4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03067C113CD;
	Mon, 29 Apr 2024 15:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714403730;
	bh=wu12zaSMIGGFJjFWB3nUQrzOKJrMtS1x5OqUcW5sFnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KS73PH4ea82H+oXLw2zFwrixSfwJtyWJypE4es5tTbKkgXCRpxqfl6DlKwbXiSqbn
	 0/xpDjCn8pJztaxMjHC1OuljIcgYyW5rtnpf4SDaYjNL84+6d2E2X3zvL3HCq6pMJm
	 CBP/rt9+hiiYw5Xid6csr8IDQRHFeFjeOKQ7NrIe6FI6w/YXljs5yVIlZl+Sz4K7je
	 Fk6A8gMYkkJYyB2Olflr1BTwSecJy+A+X1nMdiglgj33wpGCanwiKgmHj5dKDHsuxC
	 7Sb/r7GbUTefv/i+3kvYp72EV35w/TJbr7oGCowP5xwqByn04xZjmIQZDKI3zO3vkb
	 WzlnYeSIab5Dg==
Date: Tue, 30 Apr 2024 00:15:28 +0900
From: Mark Brown <broonie@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] spi: armada-3700: use 'time_left' variable with
 wait_for_completion_timeout()
Message-ID: <Zi-5kPXYWqgIWCcS@finisterre.sirena.org.uk>
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
 <20240429112843.67628-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P2+0N1AUJVSP5mpc"
Content-Disposition: inline
In-Reply-To: <20240429112843.67628-2-wsa+renesas@sang-engineering.com>
X-Cookie: lisp, v.:


--P2+0N1AUJVSP5mpc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 29, 2024 at 01:28:34PM +0200, Wolfram Sang wrote:
> There is a confusing pattern in the kernel to use a variable named 'timeout' to
> store the result of wait_for_completion_timeout() causing patterns like:

Please remember to send cover letters to your patch serieses to relevent
maintainers...

--P2+0N1AUJVSP5mpc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYvuY8ACgkQJNaLcl1U
h9Cf5gf+Pu7MicbOC/5MWhvOla9qP0QOsWbB09QL9r87rhMCyExaVIKVTPXFrxDC
Evfd68wRbTh29t+Kmyk4KSAkrS+yqA0SSuk+lDjW1x9ns4VI8TJQCkPgK0Hz3eTu
txnDq5vzHBSYo+2iHQc1yluIJW/WVPw8lKTtml0/f3GVHebMAjDXY0dPaWb26oVk
vAJrA/LWm+Q9ozkwDehnxyuY52ouylrT8j3cTwfHrh83HnOKoQy4ecdcA3JqBTga
Q81sohIJPM1m+atu2+OR0E2udtXPLs/3RvW9os5FZGOS9oBGQ0OqklVxIE1adnto
DK4evpkpsEGGVa4g0/pxXHf9kMamBQ==
=zdUY
-----END PGP SIGNATURE-----

--P2+0N1AUJVSP5mpc--

