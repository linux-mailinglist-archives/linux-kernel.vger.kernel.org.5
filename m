Return-Path: <linux-kernel+bounces-37501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52583B0F0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14A83284C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053E212BE9C;
	Wed, 24 Jan 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Br4mhTz3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C90F12A17A;
	Wed, 24 Jan 2024 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706120420; cv=none; b=VDNsY7bzxSVBAjWZBbSI5fsSYXpsK9hUXk9X1caL0LwnGjLPHeV1c8S6d1HaumkF5TqIcMcPFoCj4hK8htQqvx8I1OnTub9DdUHfI8DvdNmV7KgIT9bAg5X+aeYBOpbWlwlKu72EX9VU5Ok7gDWslrQSVfD/3/vr64ckLkCVQsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706120420; c=relaxed/simple;
	bh=8i7hW/P7gRwZbg6eJhfWSHuYfwNb6fjxwXNOYa+zX2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uvbt8VOh2YMlU93dpHyDsHorJaND6nVPN7sVdVFF3QEvBGjfZGzNqa1wxVlHadVwURmoPNKBcShewV8t81J/hoIrTm8i8lJvdfAk+fT4KYT12tQJ9pnSdfVwNQRHzJKsS4jvGuFPpx73QsrlJ7bGCe3BAYmH/Us5Ew7xt8mEGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Br4mhTz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92D4C41679;
	Wed, 24 Jan 2024 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706120419;
	bh=8i7hW/P7gRwZbg6eJhfWSHuYfwNb6fjxwXNOYa+zX2M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Br4mhTz3ABsovsBh891iFtITCloETm7Xd3auyJ06H5OtOXYpmgIubWlxfBF2VAGmf
	 OlGgldHJriEwX+TyBKeNai970ecogEG/P+gUzZX4GkxGns9Tk6eEXHb1JVxvu6/qbt
	 skPzgvzkoqvZSI3fIk0qzZS1oVVsfORv8XNRdsm4o8jNjgkmRgXjCqeQuzGAQ/loQ0
	 MNqC/og/U/JCX02ROA4VSt/31hoJJKyDJYB6eTiM5FtscPo50IXJxuwfPJcISYJ5Bo
	 JVUzkTQyQJDT/DwPnh/6uJPHvZSstEkjmSaAd1oD/2eYSXBm+WQRf3GOuraJ/L6/c7
	 dAa8p4/Z1vrVg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf13c259f3so21609701fa.2;
        Wed, 24 Jan 2024 10:20:19 -0800 (PST)
X-Gm-Message-State: AOJu0Yxwpt606+LtDw54OIps+yrDeL+Duhbv0ZdkYRSgbE0kDoNurYaM
	RRQVhBsZoRJHRy0yuNNyA0kCkqO7uUtAj6p6eoLQ0vZJz/tZFlQy1Y8PJsSjALFq6Y2v+oAYjAT
	NdqZa/snRZCRp+bmrDS40Zs1R2g==
X-Google-Smtp-Source: AGHT+IFQ7o9sj+x/bj/29pY9Rds1Cng62HUIvJOWJ1X7OlDRC8xWzyyEJAbOfVXOJaSePIJD48bw3TcKGaUGSzwtDq4=
X-Received: by 2002:a05:6512:1295:b0:50e:ca83:887e with SMTP id
 u21-20020a056512129500b0050eca83887emr2710515lfs.34.1706120417667; Wed, 24
 Jan 2024 10:20:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122180551.34429-1-francesco@dolcini.it>
In-Reply-To: <20240122180551.34429-1-francesco@dolcini.it>
From: Rob Herring <robh@kernel.org>
Date: Wed, 24 Jan 2024 12:20:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKHjj5SfPTxhXUtmNh1nr1-eNKnL-Mmv-XdyONxgn9UVw@mail.gmail.com>
Message-ID: <CAL_JsqKHjj5SfPTxhXUtmNh1nr1-eNKnL-Mmv-XdyONxgn9UVw@mail.gmail.com>
Subject: Re: [PATCH v2] treewide, serdev: change receive_buf() return type to size_t
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	greybus-dev@lists.linaro.org, linux-iio@vger.kernel.org, 
	netdev@vger.kernel.org, chrome-platform@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-sound@vger.kernel.org, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lee Jones <lee@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:06=E2=80=AFPM Francesco Dolcini <francesco@dolci=
ni.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> receive_buf() is called from ttyport_receive_buf() that expects values
> ">=3D 0" from serdev_controller_receive_buf(), change its return type fro=
m
> ssize_t to size_t.
>
> The need for this clean-up was noticed while fixing a warning, see
> commit 94d053942544 ("Bluetooth: btnxpuart: fix recv_buf() return value")=
.
> Changing the callback prototype to return an unsigned seems the best way
> to document the API and ensure that is properly used.
>
> GNSS drivers implementation of serdev receive_buf() callback return
> directly the return value of gnss_insert_raw(). gnss_insert_raw()
> returns a signed int, however this is not an issue since the value
> returned is always positive, because of the kfifo_in() implementation.
> gnss_insert_raw() could be changed to return also an unsigned, however
> this is not implemented here as request by the GNSS maintainer Johan
> Hovold.
>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>
> Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@ke=
rnel.org/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #for-iio
> ---
> v1:
>  - https://lore.kernel.org/all/20231214170146.641783-1-francesco@dolcini.=
it/
> v2:
>  - rebased on 6.8-rc1
>  - add acked-by Jonathan
>  - do not change gnss_insert_raw()
>  - do not change the code style of the gnss code
>  - commit message improvements, explain the reasons for doing only minima=
l
>    changes on the GNSS part
> ---
>  drivers/bluetooth/btmtkuart.c              |  4 ++--
>  drivers/bluetooth/btnxpuart.c              |  4 ++--
>  drivers/bluetooth/hci_serdev.c             |  4 ++--
>  drivers/gnss/serial.c                      |  2 +-
>  drivers/gnss/sirf.c                        |  2 +-
>  drivers/greybus/gb-beagleplay.c            |  6 +++---
>  drivers/iio/chemical/pms7003.c             |  4 ++--
>  drivers/iio/chemical/scd30_serial.c        |  4 ++--
>  drivers/iio/chemical/sps30_serial.c        |  4 ++--
>  drivers/iio/imu/bno055/bno055_ser_core.c   |  4 ++--
>  drivers/mfd/rave-sp.c                      |  4 ++--
>  drivers/net/ethernet/qualcomm/qca_uart.c   |  2 +-
>  drivers/nfc/pn533/uart.c                   |  4 ++--
>  drivers/nfc/s3fwrn5/uart.c                 |  4 ++--
>  drivers/platform/chrome/cros_ec_uart.c     |  4 ++--
>  drivers/platform/surface/aggregator/core.c |  4 ++--
>  drivers/tty/serdev/serdev-ttyport.c        | 10 ++++------
>  include/linux/serdev.h                     |  8 ++++----
>  sound/drivers/serial-generic.c             |  4 ++--
>  19 files changed, 40 insertions(+), 42 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

