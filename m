Return-Path: <linux-kernel+bounces-34044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF05583725E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E21E1C2AAC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CEB3DB8A;
	Mon, 22 Jan 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWc9O+uu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1F63A6;
	Mon, 22 Jan 2024 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705951264; cv=none; b=mmOMqeUolfzoMT6gIz10vJe3Okpe4YzRQJxz3LKrz9KKeKm5e1ruDi9YckOlJtfWbMubVr2ydj/a5FPGJqzlac2HKJqWsHVtOv6d96Of2ODhZkAzic6W9RV2/rQZCzkpPsBIT3wH7WcIoJRNNS4kdn+BdJ9vIJisYi57L/WBR5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705951264; c=relaxed/simple;
	bh=Jr5+xCxZXMU6VVRJPZYVF9NQaQ+RMq3m0sbrrc1QccM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=netMVTUzRVNZHziPX5LcaO13y2VA/xrkfJBh0J8hEHaaEVInpJyW9jvIv0Syd0duzpC3oLjbEqK9HRV9pXwiE7v/pGj9xkorJvxD5pa23fUuIACFeaQ3WF7BE6U1Qc/iRhaicLMuTe+ByH8O96C7aGWrnnI6yULXMGvr8d8Sye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWc9O+uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD75C433F1;
	Mon, 22 Jan 2024 19:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705951263;
	bh=Jr5+xCxZXMU6VVRJPZYVF9NQaQ+RMq3m0sbrrc1QccM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oWc9O+uuW3lGJ8okxPnW3m1C4e6wuJh2IAAsZdQlCndHkj8lVZvgxVO3Oo7+vtjfq
	 NHInuZ7WAx/5cGuBPVXmLPKmk0R/g71RazIp4OqFfag7h5XYCZrgbs5mvaiURopYSp
	 xcxB0lHXY5GQ/EAHKgDVlKOMeYYEhyfwexwGx/vC8rEc70BILwoHDQcUm1goNKIpts
	 QQQAKnFpgHxUfGbElyrzmxG2FQu2nxVq8MhTD29GH53mTFKKrntCXGR280iX6NDW9L
	 hx/qg4YvVmlAqcNyYEFd16kfjN2evvQx8D7AHTk/XvAL2gBepJYW0+dVPg+oaia+Zn
	 UIYQ+0X0KJzKQ==
Date: Mon, 22 Jan 2024 19:20:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: dummy_evgen: remove Excess kernel-doc comments
Message-ID: <20240122192051.15a83d02@jic23-huawei>
In-Reply-To: <CAMRc=Mdj=nN0cHpVpV2cckS=z9vr_ZW4tNX7yS_1V-caLYiPsA@mail.gmail.com>
References: <20240121055005.20042-1-rdunlap@infradead.org>
	<CAMRc=Mdj=nN0cHpVpV2cckS=z9vr_ZW4tNX7yS_1V-caLYiPsA@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Jan 2024 10:04:48 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> On Sun, Jan 21, 2024 at 6:50=E2=80=AFAM Randy Dunlap <rdunlap@infradead.o=
rg> wrote:
> >
> > Drop kernel-doc comments for struct fields that were removed to
> > prevent kernel-doc warnings:
> >
> > iio_dummy_evgen.c:43: warning: Excess struct member 'irq_sim' descripti=
on in 'iio_dummy_eventgen'
> > iio_dummy_evgen.c:43: warning: Excess struct member 'base' description =
in 'iio_dummy_eventgen'
> >
> > Fixes: 337cbeb2c13e ("genirq/irq_sim: Simplify the API")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: linux-iio@vger.kernel.org
> > ---
> >  drivers/iio/dummy/iio_dummy_evgen.c |    2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff -- a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_d=
ummy_evgen.c
> > --- a/drivers/iio/dummy/iio_dummy_evgen.c
> > +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> > @@ -31,8 +31,6 @@
> >   * @regs: irq regs we are faking
> >   * @lock: protect the evgen state
> >   * @inuse: mask of which irqs are connected
> > - * @irq_sim: interrupt simulator
> > - * @base: base of irq range
> >   * @irq_sim_domain: irq simulator domain
> >   */
> >  struct iio_dummy_eventgen { =20
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Applied.

Thanks,

