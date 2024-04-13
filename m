Return-Path: <linux-kernel+bounces-143893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F078A3EDB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D59B1C209F4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A758156B66;
	Sat, 13 Apr 2024 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqu0aoE4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DED10FD;
	Sat, 13 Apr 2024 21:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713044669; cv=none; b=vEQPvtndvtGpWGEFHLbOn74iAnjQieFIdomDXqs79BGsa3b56RxUJDgdXH0Rzd/flWv5LezqC+mjukNLf8hK6y7wZtI6EtkK1zVyc6w39cRIihicajw50gsRZJdPIuvXvJoEnUT9HzfZn6AUE0UgKLhwDMSDavJgw/tqXjpsvSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713044669; c=relaxed/simple;
	bh=qef3IXh1hrzGJtBo8riNKnbW4w89RpdgyjPQtVzhG28=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VYj6gB4PlzgZ1e1KlIPpgy36Q6jK8tMKDKtsfsy0eHcfDsVg0s9eUUz+bgFTd78Ik+OkURAhWvbQW/KzNXfBe/L/I7X6yCkXHZ83GtowrM3/uPGjRR3Hk2uxbR7H5UzMVWC92qT1Mc5pBX/GEXmOSf+f4qlxkjszK7d46vbB1m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqu0aoE4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51408C113CD;
	Sat, 13 Apr 2024 21:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713044668;
	bh=qef3IXh1hrzGJtBo8riNKnbW4w89RpdgyjPQtVzhG28=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Zqu0aoE4KGSDrDhhmbRwFDoKr6wDi6muM9KFSQ0RD0gBcoSFOEG1PQBo1LsWXLBXk
	 C0jzon4zllhj13s8rDOhyGazZrxlMz15NXDeP0QnXxYsnbCEmRXQP7WPkcn7nw5m4z
	 cHX944YtQkiHy8LvG5THdsMe0sEzGqej9Ykp/IeUyn2gWimtBwWSi6RJEVnxglWn5T
	 MEqfB0WMTbb+cKEFFBN7ds1DcyRHj9f6c8XbkLSY+ERma0qrRDcRpT8Py1Vh1WgVK5
	 BfWVNHNk+RJIFBJzejgXpv+qg3qO+nl6DPaXY59DPWLXIjWNYrU6lc4nMWtgqUrb3l
	 cfZn5ZoL9uqng==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 00:44:20 +0300
Message-Id: <D0JBNGXAUBLT.1HW29NDQUKW72@kernel.org>
Cc: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "David S. Miller"
 <davem@davemloft.net>, "Shawn Guo" <shawnguo@kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "NXP Linux Team" <linux-imx@nxp.com>, "Ahmad Fatoum"
 <a.fatoum@pengutronix.de>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "David Howells" <dhowells@redhat.com>, "Li
 Yang" <leoyang.li@nxp.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, "Tejun Heo" <tj@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-security-module@vger.kernel.org>, "Richard Weinberger"
 <richard@nod.at>, "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v8 6/6] docs: trusted-encrypted: add DCP as new trust
 source
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>
X-Mailer: aerc 0.17.0
References: <20240403072131.54935-1-david@sigma-star.at>
 <20240403072131.54935-7-david@sigma-star.at>
 <D0ALT2QCUIYB.8NFTE7Z18JKN@kernel.org>
 <ZhjUH3TZ99cT3Rhq@gondor.apana.org.au>
In-Reply-To: <ZhjUH3TZ99cT3Rhq@gondor.apana.org.au>

On Fri Apr 12, 2024 at 9:26 AM EEST, Herbert Xu wrote:
> On Wed, Apr 03, 2024 at 06:47:51PM +0300, Jarkko Sakkinen wrote:
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > I can only test that this does not break a machine without the
> > hardware feature.
>
> Please feel free to take this through your tree.
>
> Thanks,

OK, thanks!

BR, Jarkko

