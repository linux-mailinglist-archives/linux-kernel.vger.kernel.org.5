Return-Path: <linux-kernel+bounces-60441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6138504FC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0EE51C21B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F35D85BAF6;
	Sat, 10 Feb 2024 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXfjBnIn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC202EAF9;
	Sat, 10 Feb 2024 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707579917; cv=none; b=KYpAIYh1x5N9ylCAmlqXaCB/V6S4O4sDvbz3Nt0FVNe6tNBDXwvWEuEAe2NyiHCh+vVimYGbHd0WdDzQQpasv+sJL5pRZb6UShjcLHLYSiMDEPyfGmmDqIXCXLnrKySKVVAwPFXCyDYGO30x6UFDGcI0K6HqULNJz/kVCrQCXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707579917; c=relaxed/simple;
	bh=5279zwp7RW9/rOcq5SM/+hk6cu+IlXnySNrsfEDG88E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibmAP2oovI5q6weV48zKYhIQLehBhd8woNWQorhb+qe2ThLi3KIkBrvG415XCVPnw3hfi3MAx4yxv0cSwjW6Oa1GoSy0N2WFhbCo7vziBDfbKs/HFB4rPPC0yOKDjDunv5stC6haZ5hUA6bV4jikAXLI2LdSLl80QcfCjZL2gqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXfjBnIn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59D1C433C7;
	Sat, 10 Feb 2024 15:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707579916;
	bh=5279zwp7RW9/rOcq5SM/+hk6cu+IlXnySNrsfEDG88E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXfjBnInypFv78kbYxBiI07S5cBKCGBgnjU9RMCWY40GE+SFnDlWh7RNAyiag4E/1
	 bQ3IKHa85DjbcT9xJ13Vh+u9ZKmt/7nYfHCUBMNlz0UY4EILTWD6SAeXUrQ2BtSg6m
	 ihjV9m48GP8ejex0QAl7kYk7xSW9R7mgRgahLEl/JX8PKImzqhXZ0b1gmoOP8OkfG6
	 rSyNks18cKL0npHy7cGxbnj+zydy6/zfF2aHad36GA5n2LGyaAMAgOsvxBADp1gOwQ
	 5BX0kOnCF4u/7ACvqHACoBncVkcXYB2sf3hPTK6wYr1i56iOpRu3mDDjxp5JtSDuQX
	 ishNnFoFWR2BQ==
Date: Sat, 10 Feb 2024 15:45:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] iio: core: make iio_bus_type const
Message-ID: <20240210154504.0656f230@jic23-huawei>
In-Reply-To: <77e7ed84395c716e17d783e9411fd57ad8c22295.camel@gmail.com>
References: <20240208-bus_cleanup-iio-v1-1-4a167c3b5fb3@marliere.net>
	<77e7ed84395c716e17d783e9411fd57ad8c22295.camel@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 09 Feb 2024 08:38:03 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2024-02-08 at 16:37 -0300, Ricardo B. Marliere wrote:
> > Now that the driver core can properly handle constant struct bus_type,
> > move the iio_bus_type variable to be a constant structure as well,
> > placing it into read-only memory which can not be modified at runtime.
> >=20
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > --- =20
>=20
> Acked-by: Nuno Sa <nuno.sa@analog.com>
Applied. Thanks,

Jonathan

>=20
> > =C2=A0drivers/iio/industrialio-core.c | 2 +-
> > =C2=A0include/linux/iio/iio.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
> > =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index e8551a1636ba..9b2877fe8689 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -42,7 +42,7 @@ static DEFINE_IDA(iio_ida);
> > =C2=A0static dev_t iio_devt;
> > =C2=A0
> > =C2=A0#define IIO_DEV_MAX 256
> > -struct bus_type iio_bus_type =3D {
> > +const struct bus_type iio_bus_type =3D {
> > =C2=A0	.name =3D "iio",
> > =C2=A0};
> > =C2=A0EXPORT_SYMBOL(iio_bus_type);
> > diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> > index 4f89279e531c..e370a7bb3300 100644
> > --- a/include/linux/iio/iio.h
> > +++ b/include/linux/iio/iio.h
> > @@ -669,7 +669,7 @@ DEFINE_GUARD_COND(iio_claim_direct, _try, ({
> > =C2=A0int iio_device_claim_buffer_mode(struct iio_dev *indio_dev);
> > =C2=A0void iio_device_release_buffer_mode(struct iio_dev *indio_dev);
> > =C2=A0
> > -extern struct bus_type iio_bus_type;
> > +extern const struct bus_type iio_bus_type;
> > =C2=A0
> > =C2=A0/**
> > =C2=A0 * iio_device_put() - reference counted deallocation of struct de=
vice
> >=20
> > ---
> > base-commit: 81e8e40ea16329914f78ca1f454d04f570540ca8
> > change-id: 20240208-bus_cleanup-iio-1e5714e23bb9
> >=20
> > Best regards, =20
>=20


