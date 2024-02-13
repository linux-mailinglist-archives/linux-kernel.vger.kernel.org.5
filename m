Return-Path: <linux-kernel+bounces-64009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E848538F1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DF641F24178
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1569E605AD;
	Tue, 13 Feb 2024 17:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCEjD3eb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23D1DFFC;
	Tue, 13 Feb 2024 17:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846551; cv=none; b=DZoEIMUGnD8f5if+dNhmvcPGaGG8CCpPiMyjzVIC4EJVhvWy9OBTI5r9kh9vIWbmdXJIULzbQedDLMND/KL4bVLSUomDQmFFySNNEXakIOgwvjZd/IPIbjpCO9Jxq3xCUYfcLQapYgDKBW7/GXEf1fUrlaFq3Up5ikNB22Qllgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846551; c=relaxed/simple;
	bh=UyyYmXNGhgU5jq0ULTCXSP50tpfUZFTMO5XauI2c7pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYPXyXE64f0LoyIbso/Zb8Syb/qjjSEC6yJxr96Bp5HxdF7prRCN39QTavAFZD+HnR6eIP9ecDBSJai5LgtKyH8GjVsxfy5pu9awvLAgeTmxITJSa7hfBoD0M8EJfKVX3s+Ir8pKOjSqFmuouEu21aF852RfjoCgG++h4r0++Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCEjD3eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CAEC43399;
	Tue, 13 Feb 2024 17:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707846551;
	bh=UyyYmXNGhgU5jq0ULTCXSP50tpfUZFTMO5XauI2c7pA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCEjD3ebELcuXUlpUJX/e6dC4zRcvMRVfKqiO71AL6tuNQ08jvnJ9AuNl6ShdHQqP
	 gPqiDlREvpNtixGRo6SSmvod/eJtqFl9Zc7oNkDtkBFJz6skHbCwOOFw/s7gPHU84X
	 7uN7AR2IXUPp6wikm2cLCnzQiHjLJu8UW7je6TcRP0x9iMfbOYDte4nVdnxQNErbQR
	 76rW9CxYjz0QTR1oeGB3831oKVpVF0UN1SYA+WEeiCtOgT5p6EnMaQmE/Z6UB9PlTb
	 d1p1LIHt1HcqjBOqNRsxsFgqgboEj5lOF/7wi7Pp687F5RoaMdHa3gDf1oY/WiJkgk
	 /xd4lg+ApnrUA==
Date: Tue, 13 Feb 2024 17:49:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
	Viresh Kumar <viresh.kumar@linaro.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_ztu@quicinc.com,
	Matti Moell <Matti.Moell@opensynergy.com>,
	Mikhail Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [RFC PATCH v3 3/3] SPI: Add virtio SPI driver.
Message-ID: <3b8e947c-51fb-461e-bb9e-7bc1bb547471@sirena.org.uk>
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
 <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6avdtmeem8xIAq8b"
Content-Disposition: inline
In-Reply-To: <20240213135350.5878-4-Harald.Mommer@opensynergy.com>
X-Cookie: Does not include installation.


--6avdtmeem8xIAq8b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2024 at 02:53:50PM +0100, Harald Mommer wrote:

> +/*
> + * See also
> + * https://lore.kernel.org/all/6171c1c3-55ba-4f74-ae60-764820cf1caf@quicinc.com
> + */
> +static int virtio_spi_set_delays(struct spi_transfer_head *th,
> +				 struct spi_device *spi,
> +				 struct spi_transfer *xfer)

Please write actual comments that can be read standalone, the reader has
absolutely no idea why they'd want to follow the link and there's
nothing being referenced by that "also".

> +static int virtio_spi_one_transfer(struct virtio_spi_req *spi_req,
> +				   struct spi_controller *ctrl,
> +				   struct spi_message *msg,
> +				   struct spi_transfer *xfer)

> +	/*
> +	 * Got comment: "The virtio spec for cs_change is *not* what the Linux
> +	 * cs_change field does, this will not do the right thing."
> +	 * TODO: Understand/discuss this, still unclear what may be wrong here
> +	 */
> +	th->cs_change = xfer->cs_change;

> +static int virtio_spi_transfer_one_message(struct spi_controller *ctrl,
> +					   struct spi_message *msg)
> +{
> +	struct virtio_spi_priv *priv = spi_controller_get_devdata(ctrl);
> +	struct virtio_spi_req *spi_req;
> +	struct spi_transfer *xfer;
> +	int ret = 0;
> +
> +	spi_req = kzalloc(sizeof(*spi_req), GFP_KERNEL);
> +	if (!spi_req) {
> +		ret = -ENOMEM;
> +		goto no_mem;
> +	}

Why not just allocate this once, it's not like it's possible to send
more than one message simultaneously?

> +	/*
> +	 * Simple implementation: Process message by message and wait for each
> +	 * message to be completed by the device side.
> +	 */
> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {

This is processing transfers within a message rather than messages.

> +		ret = virtio_spi_one_transfer(spi_req, ctrl, msg, xfer);
> +		if (ret)
> +			goto msg_done;
> +
> +		virtqueue_kick(priv->vq);
> +
> +		wait_for_completion(&spi_req->completion);
> +
> +		/* Read result from message */
> +		ret = (int)spi_req->result.result;
> +		if (ret)
> +			goto msg_done;

It's not clear why this isn't within _spi_transfer_one() and then we
don't just use a transfer_one() callback and factor everything out to
the core?

--6avdtmeem8xIAq8b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXLq5EACgkQJNaLcl1U
h9ASPwf/RGY6PViAydc8xVzV3a0Uva7DfKFC+w7Hn7i7ewnVuOGKWevhp4xmn6eu
EDdgXSW3LoCRVjGp+1IGdRLqZFNhV5kjEbEs9ktRc70IYPej8WuQk7GjUE1hN1Da
VxJy+YwhwbUoOW/eq808588WPuvFiHXSGz0FRjgERb4pM/YmjnCPD5EbSknvp0YY
VCDQsDfdCS0X90aG0vSrPbSQlglhfhzc5/2RNrXXRnPy0NUekwy//dhyvipEr3Mf
J278CnLlVKKKtzpQz/YA1p5d7fHMg6Ov1zf14bP5lW/0vZ94VwSa4y1S8X9JDQwA
N60fHrUA/bhzulYkeK4a7zftYYIihw==
=qnB3
-----END PGP SIGNATURE-----

--6avdtmeem8xIAq8b--

