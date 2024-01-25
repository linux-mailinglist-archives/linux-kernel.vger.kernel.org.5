Return-Path: <linux-kernel+bounces-38409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4D83BF8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DF2B2B8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1C28E3C;
	Thu, 25 Jan 2024 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+WC6q/p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B3C2C68A;
	Thu, 25 Jan 2024 10:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706179353; cv=none; b=nw81h/hgHNL90AU6RqcHY4DE3qbLeLM72nMH5i0q3G2ydnHTAcHxPT6fY0akjC9jkrQ/fthYBs/Yd6MZ2bitnzhAl60LnKnhsqvtFbIPFmcnVtAZZtuBD++8u4EvDrquNRpv0tcc8cb3tGj6gi5uD+zX+sQRNrn9UndRwklmnzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706179353; c=relaxed/simple;
	bh=1/AQZg5NNw9HG13KiYI6HfNvwqZ4xcS6GaNad1Jmb/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sObF5GHc+SYeKQleyaV+2r+GlSNgaqOv9UMB/CT6fvKecMkzEoGKYSpK3BB2T42hIfWrQEh1nGO5FatnE1Qjb5kV1i6swH9LG/iRCkV/EP8W41yg4hqtQo39QSYzSV8SMIStHSNOfCKySUcXcFAsAskPo//+zaJOP58AdfPIZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+WC6q/p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A8EC433C7;
	Thu, 25 Jan 2024 10:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706179353;
	bh=1/AQZg5NNw9HG13KiYI6HfNvwqZ4xcS6GaNad1Jmb/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z+WC6q/pwbwzH6zhMdWS153JB6VUWqmZcSDN5fViUQMl+zNnFkr+L5iCIZC4Lmv2j
	 bS4xt+Jc+fIKPiuc/kJRIJ6TAeALxfXs7+VoI8ancJ7e9QSMZf9u8wlf8juOT449Gm
	 dGuxdVykXP+YbuK9da+3YP4AGDYrHkdmnPt65LdsuIx8gGLD4hTB/s1rjqbkVCKiUD
	 oli8l8eXT1ku4I2e/jROQgRMNh1cOo8JM8FSB0c1qy9mR6qP4bCyS6fEZ4sW83WE4H
	 dvME2O/MBNNvzFmFBAQf8Pqk3H35BFWj4WMW1H3tXE6hY7SpsHA0xe4mZ94kyccwIt
	 HEVRnGIIo3ahQ==
Date: Thu, 25 Jan 2024 10:42:23 +0000
From: Lee Jones <lee@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, greybus-dev@lists.linaro.org,
	linux-iio@vger.kernel.org, netdev@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, Rob Herring <robh@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] treewide, serdev: change receive_buf() return type to
 size_t
Message-ID: <20240125104223.GD74950@google.com>
References: <20240122180551.34429-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122180551.34429-1-francesco@dolcini.it>

On Mon, 22 Jan 2024, Francesco Dolcini wrote:

> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> receive_buf() is called from ttyport_receive_buf() that expects values
> ">= 0" from serdev_controller_receive_buf(), change its return type from
> ssize_t to size_t.
> 
> The need for this clean-up was noticed while fixing a warning, see
> commit 94d053942544 ("Bluetooth: btnxpuart: fix recv_buf() return value").
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
> Link: https://lore.kernel.org/all/087be419-ec6b-47ad-851a-5e1e3ea5cfcc@kernel.org/
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> #for-iio
> ---
> v1:
>  - https://lore.kernel.org/all/20231214170146.641783-1-francesco@dolcini.it/
> v2:
>  - rebased on 6.8-rc1
>  - add acked-by Jonathan
>  - do not change gnss_insert_raw()
>  - do not change the code style of the gnss code
>  - commit message improvements, explain the reasons for doing only minimal
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

Acked-by: Lee Jones <lee@kernel.org>

>  drivers/net/ethernet/qualcomm/qca_uart.c   |  2 +-
>  drivers/nfc/pn533/uart.c                   |  4 ++--
>  drivers/nfc/s3fwrn5/uart.c                 |  4 ++--
>  drivers/platform/chrome/cros_ec_uart.c     |  4 ++--
>  drivers/platform/surface/aggregator/core.c |  4 ++--
>  drivers/tty/serdev/serdev-ttyport.c        | 10 ++++------
>  include/linux/serdev.h                     |  8 ++++----
>  sound/drivers/serial-generic.c             |  4 ++--
>  19 files changed, 40 insertions(+), 42 deletions(-)

-- 
Lee Jones [李琼斯]

