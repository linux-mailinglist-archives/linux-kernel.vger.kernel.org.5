Return-Path: <linux-kernel+bounces-123313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6C489066A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D899B247DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AEE3BBD8;
	Thu, 28 Mar 2024 16:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1QE8VBF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6440852;
	Thu, 28 Mar 2024 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645027; cv=none; b=CfxH1W73S0oz+NGfK3+tu4BYLJwnikHEARD+BuDNjscwSHVUT3Ro1Bhjj3CMVnSZgirZ12v4dmkZ3PbnacNswwJaHNbBT8NeLlff/FVaDyDBab1W63ts0NB8CdI0MRXFl54Aapjuy+H0YSxzV9W7WGe4YwjcwTgRq1PXa7PXZAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645027; c=relaxed/simple;
	bh=qX8ERP3MjA3dKFRsy6HjmzCyO64pCY9x430Gltfx0wQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OvY8MQ+MgEwQcvcdRgY1hANlbG4ISP8KiPCetgOd6PpiUdvW1Xvcz5dQq6MbxfqjNzZbEYaNv1nPLXr+ql9R36Zs1p1euooHKdM3A8Bd1HUrxmwzRYHJEganFWYHX7j/0pXrYL3B2usCHVQG2N72PZ/5Bhz5auv4Y97Ist6qB38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1QE8VBF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BB1C433C7;
	Thu, 28 Mar 2024 16:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711645027;
	bh=qX8ERP3MjA3dKFRsy6HjmzCyO64pCY9x430Gltfx0wQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1QE8VBFbj7+ZnTIFGyvwBRCOb9d949THgq1iDHiI+raKzEQpa37gDXpBmc2NwSwU
	 97k1a8IuOfgijujEdWntt6utCM36V6FoUx01NXu8V2PglNd4W5GdtZh4kJu4Zgo+7x
	 Ql9VpSpme+BkbesDto3S3eEeBulvKcpehpjmP6rPSRtdTuxGYKdnNWMvSNWtOy8gyQ
	 inwer6xXQNAk/FmKy4FHH7zCUnsHLH8m3qXvIRLUrvtsd/5oaiTP6w9DYoP9XfJXld
	 rRPjnTEpihv/rGnp8xBZO58zjhwz1PpzGvSAK7Cr1XwM9HQoVJ0yDz542AJZ2fESLo
	 hkexWnPXmHXDQ==
Date: Thu, 28 Mar 2024 16:56:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti Bhayana
 <jbhayana@google.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/6] iio: temperature: ltc2983: small improvements
Message-ID: <20240328165650.1d8d4216@jic23-huawei>
In-Reply-To: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
References: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 28 Mar 2024 17:22:00 +0100
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> The v4 introduces an new dev_errp_probe() helper to deal with cases
> where we want to return error pointers. The refactor in the IIO ltc2983
> is an heavy user of the pattern and was the main motivation for this.
>=20
> Also added two new patches so we have three users of the new
> dev_errp_probe() helper.=20

Probably better to do this as 2 series. The other ltc2983 changes in one se=
ries
and one with a cover letter title that will get noticed by
those who care about dev_printk helpers.

=46rom a quick look the content of the patches is fine.

Jonathan

>=20
> ---
> Changes in v4:
> - Link to v3: https://lore.kernel.org/r/20240301-ltc2983-misc-improv-v3-0=
-c09516ac0efc@analog.com
> - Patch 1
>  * New patch
> - Patch 2
>  * Use dev_errp_probe() instead of local variant
> - Patch 5
>  * New patch
> - Patch 6
>  * New patch
>=20
> ---
> Nuno Sa (6):
>       printk: add new dev_errp_probe() helper
>       iio: temperature: ltc2983: convert to dev_err_probe()
>       dt-bindings: iio: temperature: ltc2983: document power supply
>       iio: temperature: ltc2983: support vdd regulator
>       iio: backend: make use dev_errp_probe()
>       iio: common: scmi_iio: convert to dev_err_probe()
>=20
>  .../bindings/iio/temperature/adi,ltc2983.yaml      |   4 +
>  drivers/iio/common/scmi_sensors/scmi_iio.c         |  45 ++--
>  drivers/iio/industrialio-backend.c                 |   8 +-
>  drivers/iio/temperature/ltc2983.c                  | 260 ++++++++++-----=
------
>  include/linux/dev_printk.h                         |   5 +
>  5 files changed, 151 insertions(+), 171 deletions(-)
> ---
> base-commit: 27eea4778db8268cd6dc80a5b853c599bd3099f1
> change-id: 20240227-ltc2983-misc-improv-d9c4a3819b1f
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20
>=20


