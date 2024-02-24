Return-Path: <linux-kernel+bounces-79772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F06862679
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF8A1F22C32
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E8D481DA;
	Sat, 24 Feb 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nr7/l/Ds"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A00847F57;
	Sat, 24 Feb 2024 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708796702; cv=none; b=XF+6V98D4ZKXFEenmBzjTNSiYnsHm1TAaUzAGRFYgb44LZE7aFrHlrf6P9CrIV3WmitA/Emqt7m1X6Cd0rJifO0A/RvRd76y8OjHG+3jnJuysF12f8t/T3KTgp9fJP8Z2noHIUo2B1Y5ZDNXiTx3bPjquGKIVHvpS5D/TYBetME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708796702; c=relaxed/simple;
	bh=woSEirEgxk5nDxSKXgKZhmGAUu4mIYHB7i2UM798t/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fR7dqjy24igNiSnGODnRFmRCcbEaMFs8DDL0IM3Bnki6tSyTycjpH8ixVF9djqGPUMbGmbKz8YRYjiBCSnv8QEGGeW96tzpGNs8+DW+ww3eBoR5QUqu2PcYBkZ+ZgNNq5yxS0VXYa8qXO1t6Zs7Sjzf29/OOXzUwYEwPXOZ47EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nr7/l/Ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77379C433C7;
	Sat, 24 Feb 2024 17:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708796702;
	bh=woSEirEgxk5nDxSKXgKZhmGAUu4mIYHB7i2UM798t/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nr7/l/Dsh9VA/ak1wgOPkO2o8018LA8pL3xoFNMNoRScKwx4+Rb6UnzAalxygCB5w
	 DT+XlQqf0znU8nYhM1Yqq6LMeH6prgmOn5bSwChyXm0fcw1a0XQGeeG4YRaSjWWRBq
	 n9Ntok0ERSEBghmuDU1FFnUcpi4T3zFIGVcw8k1WQjsC63fEngaVvkgEWKLAELJ1CE
	 mQGstW7xsHX2Ze0LlZFd057K/OQlXdDgRB7nQDELBCRGD5cZvArhvj2xJOaccwGXMZ
	 tehSuoS303QNTdRnbizw0za2/dxN51OrOx7R+EbbP0SLmeiI+01zaVjq3XZcproOVe
	 VOwdFpWz5p8wg==
Date: Sat, 24 Feb 2024 17:44:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ceclan Dumitru <dumitru.ceclan@analog.com>
Subject: Re: [PATCH v5 4/5] iio: amplifiers: hmc425a: use pointers in match
 table
Message-ID: <20240224174446.1565bfb9@jic23-huawei>
In-Reply-To: <94f7e7f2568d0d70055954f628b2bd56cbe78d9b.camel@gmail.com>
References: <20240220153553.2432-1-mitrutzceclan@gmail.com>
	<20240220153553.2432-4-mitrutzceclan@gmail.com>
	<94f7e7f2568d0d70055954f628b2bd56cbe78d9b.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Feb 2024 14:17:22 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2024-02-20 at 17:34 +0200, Dumitru Ceclan wrote:
> > Change the match table to use pointers instead of device ids.
> > Remove type from state as it is not used anymore.
> >=20
> > Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> > --- =20
>=20
> One comment (Jonathan might be able to address that while applying)... Wi=
th that:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
> > =C2=A0drivers/iio/amplifiers/hmc425a.c | 29 +++++++++++++++------------=
--
> > =C2=A01 file changed, 15 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/iio/amplifiers/hmc425a.c b/drivers/iio/amplifiers/=
hmc425a.c
> > index 13e018a59637..77872e2dfdfe 100644
> > --- a/drivers/iio/amplifiers/hmc425a.c
> > +++ b/drivers/iio/amplifiers/hmc425a.c
> > @@ -41,15 +41,14 @@ struct hmc425a_chip_info {
> > =C2=A0
> > =C2=A0struct hmc425a_state {
> > =C2=A0	struct	mutex lock; /* protect sensor state */
> > -	struct	hmc425a_chip_info *chip_info;
> > +	const struct	hmc425a_chip_info *chip_info; =20
>=20
> Since you're doing this, I believe you should also constify hmc425a_chip_=
info_tbl[]
> and mention it in the commit message.
>=20
Absolutely.  I've made that change and added a note on it to commit message.

> - Nuno S=C3=A1
>=20


