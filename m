Return-Path: <linux-kernel+bounces-98250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2FD87776D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 16:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A741C20ADF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 15:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC5739846;
	Sun, 10 Mar 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en0B4Wia"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64745383A9;
	Sun, 10 Mar 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710083230; cv=none; b=cqLCXu2aEuCPYDnAd+fqxrCJili46nAF/zfDm9KCr7lZlgYGHJnlApDOKTKud1AQGWZOJW43otcXpBsJGk9cS2eygNa9c91adBlZk5ngtkP7lNv7OnUoh7Sbwknn9xIYxyTjaf252QhbPv/gia8+TFyT/CeqwaD707bz1M+sxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710083230; c=relaxed/simple;
	bh=afcnmJT95Pd1UIsaUu6edR4yn2rQrLbjJDhmbuTrqBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M8MVsRhpOU6YneLoVsSdSsvEioWM0sAatMc7XuqHIkSCX+6Hd/okinynHf8Hy50TfXqCNypS7MQNKPiCylUMfiGj6TtFsm7H28npdf6glE6fC8KZ+cLgb+eCf9QCEhHhRs5mH9qUyLRqq27ALDOcQIpkgza8cIFqbm8mZLRBOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en0B4Wia; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71EFC433B2;
	Sun, 10 Mar 2024 15:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710083229;
	bh=afcnmJT95Pd1UIsaUu6edR4yn2rQrLbjJDhmbuTrqBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=en0B4WiagQAvJc7PLPrqAmAeULV4005aHH419KSR4BaEV+NWoyPQrClWAKrV9jPQU
	 MvDkjxEaZ54hNnlZxtnRGQhY5bv3sDB52sOiQcr9qW2otFD7xomycrjxA4FED22jVj
	 GfjM9GWmdZYvpzrwYFwBkBlJRsVvjlvtWu0o7v4JaBOW2DWiRUyeG4gcz0U6eRmcrJ
	 TJMLJgzHZX7H6t539Ll2ekUmjGUVWHxhU/nUjuOV2fsFJLh2/52Ou7BEclohqCpo0G
	 0/Pr1RlPLnTmuBYieVuMUIrxFZYcfyapftTXFmq6Hce7CsyYPnIV6MXcPT5bPixWiD
	 pXDhAd/mKL6aw==
Received: by mercury (Postfix, from userid 1000)
	id 2E8761060B14; Sun, 10 Mar 2024 16:07:06 +0100 (CET)
Date: Sun, 10 Mar 2024 16:07:06 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/17] dt-bindings: input: touchscreen: fsl,imx6ul-tsc
 convert to YAML
Message-ID: <7tynuiwqaaskkuhi2vzo5wtxhyoyigym44ieomianfkwvzx7qj@hnelnwsgrfv2>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-5-sre@kernel.org>
 <Ze0OQ0DB1TZEtJ-6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iueh6vurfusbt5wq"
Content-Disposition: inline
In-Reply-To: <Ze0OQ0DB1TZEtJ-6@google.com>


--iueh6vurfusbt5wq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Sat, Mar 09, 2024 at 05:34:59PM -0800, Dmitry Torokhov wrote:
> On Tue, Feb 13, 2024 at 02:00:53AM +0100, Sebastian Reichel wrote:
> > Convert the i.MX6UL touchscreen DT binding to YAML.
> >=20
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
>=20
> Applied, thank you.

Rob send a message, that he applied all DT binding patches from this
series (incl. this one) at the same time you asked how it should be
handled:

Message from Rob (Tue, 5 Mar 2024 11:34:32 -0600)
https://lore.kernel.org/all/20240305173432.GA3745196-robh@kernel.org/

Message from You (Tue, 5 Mar 2024 09:30:47 -0800)
https://lore.kernel.org/all/ZedWx79qP7QXc3Om@google.com/

I assumed, that you would see Rob's message and thus did not bother
to reply. Obviously I was wrong, sorry about that.

Greetings,

-- Sebastian

--iueh6vurfusbt5wq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXtzJYACgkQ2O7X88g7
+ppFBQ/9Flau3SaBAgw2slPgEDr4J56Avgv0iopbKv653T6+7YbvHDxTWW0T3b6k
A3pDq7saZ/16seTe8wieM/xg5Bo7HVegKwoaCXlDV6rGOeoFTWyeEnM6o5Wb9kAr
sbT8t82p4VzioxEYChNtp0c8qNnzQW7ZcKW7PLs4/l9dN+e3GkE4ZaYnXeMSN2zb
T3H7lTw8FAxV5pwTuKo5cZ1/rdrkejgK853xes0zL8JPhykk2KRXzc4RFwu59LWC
zENJx1KCx+fmufK2ggXup/9UqkaIfhlU6DTG/A+catrhiD9Ct0cim05KbXh2H4hx
UFHTjCU4yl4cnvsGB7eIPfHmmgLAjSNR3pSRKGOKk6LH018FGkfsIbPXtWleT919
Bm/s/KMPEYC92sYQrfaTLFA1mmCI71qk7LzXfysLPL5erl8XTfi2MRcHXeCLyCF3
zbj1ZpmT/h612mMVF2yzlbXu43+ATFeSzTtDnOs58IS/RBsbQPpdvaOzUpSjIPBH
b84s39w9157X7Vvk6rEr6oq8tFyZypbX2iPmC77ezHRN+LID8TRiW0zDViM3feFa
AfWywSeJSyJVSVvxUsHlHWPB2grM2tYhv6Trf3svdt5whxXZLbS5qbwnpV+BkLJ1
bxVp9lUszVPQaOGY24kWLoNX5xdM3Ri+IC+wSuDsk+WoCeqMy9s=
=LRZG
-----END PGP SIGNATURE-----

--iueh6vurfusbt5wq--

