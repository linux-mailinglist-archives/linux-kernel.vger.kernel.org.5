Return-Path: <linux-kernel+bounces-91357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 557C5870FF5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 886571C20DE2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CE47BB00;
	Mon,  4 Mar 2024 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CBO/PZrh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC767868F;
	Mon,  4 Mar 2024 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709590564; cv=none; b=dP4usFVXo1up3TTZ5/TgH96gpZ0+tbgwNLKKDtYvBWrF/I2mBcT2itkbW2Pclro0hDNwnvAz2T81PNU23MDmWU/I1XfMYu883xJZCwGW2ctazWlnou4RHFoqvkMuxukmd1w4J3m67OOgsPmhue1e+e2oB6la9UlsosH/nSltfZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709590564; c=relaxed/simple;
	bh=B+/HnwLCpt/nEMTn4HJHKj5QZDdRYTH3xkzZZRrm/f4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jbyKdr1GfD8fU49/KYdc8axTXi8lrg6T2Ny1Ej72GtMTg4V1LRwkZTEwLBBDujVZQRHz+z6rkPr+a3W5flae5YumsxAJ6yq0aZ0dXtnrcrf4Z3IeHgSAwozGpKTVJCeuLdFNKrL6bK5byC/TVYkXxXkTnxOvhFZRb/8HT1BI4fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CBO/PZrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8818CC433F1;
	Mon,  4 Mar 2024 22:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709590564;
	bh=B+/HnwLCpt/nEMTn4HJHKj5QZDdRYTH3xkzZZRrm/f4=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=CBO/PZrhwSGAEynPUUI7ML6hnhaCbGTiiTHzoHmr+9ec0e5SmimPveLrvY4LQv0me
	 TB2ANRLYFVCnP1MvwrCsp+mQDJo7QhAJrPc4hxwn1sU+PoR7uGdJM4qOf32KyIcpNa
	 GpI9yQrlW0wk4KF7FwpoaQQrgEvr+j+y8l50ThTjH9InyidHtNRu7R5CglByl39ihI
	 Q+YumRMidl3W5wFHOEAE2k0WzHfjhjPGIPnEW1yrIeY+qYTpVM7R2Wrf/motGoaWvj
	 UoYDMRCq/G+kMZ5bjeEEvwaCxFwJSnsmihpqBYVNLd3H/H9+Nwajp4Ly/63l4detSQ
	 ww8WPT8KJ9qXg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 00:15:55 +0200
Message-Id: <CZLB9UXFAHK6.26ET7BAGSFZLB@suppilovahvero>
Cc: "Shawn Guo" <shawnguo@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "NXP Linux
 Team" <linux-imx@nxp.com>, "Ahmad Fatoum" <a.fatoum@pengutronix.de>, "sigma
 star Kernel Team" <upstream+dcp@sigma-star.at>, "David Howells"
 <dhowells@redhat.com>, "Li Yang" <leoyang.li@nxp.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, "Tejun Heo" <tj@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-security-module@vger.kernel.org>, "Richard Weinberger"
 <richard@nod.at>, "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v5 1/6] crypto: mxs-dcp: Add support for hardware-bound
 keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20231215110639.45522-1-david@sigma-star.at>
 <20231215110639.45522-2-david@sigma-star.at>
In-Reply-To: <20231215110639.45522-2-david@sigma-star.at>

On Fri Dec 15, 2023 at 1:06 PM EET, David Gstir wrote:
> DCP is capable of performing AES with two hardware-bound keys:
>
> - The one-time programmable (OTP) key which is burnt via on-chip fuses
> - The unique key (UK) which is derived from the OTP key

This is somewhat cryptic explanation for the commmon and reoccuring
theme of having a fused random seed and a key derivation function.

I'd just write it is all about.

"DCP is able to derive private keys for a fused random seed, which
can be referenced by handle but not accessed by the CPU. These keys
can be used to perform AES encryption."

My explanation neither includes acronyms OTP and UK and still
delivers the message so much better. That actually further makes
it better because less crappy standard consortium terminology is
always better :-)

BR, Jarkko

