Return-Path: <linux-kernel+bounces-1302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA236814D1D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EAC41F24D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6251B3DBA9;
	Fri, 15 Dec 2023 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u23Widco"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67E3FE2C;
	Fri, 15 Dec 2023 16:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECD69C433C8;
	Fri, 15 Dec 2023 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702657953;
	bh=5xSZ6gC57XpMcrBYmJ5djtgBGtNosockr7ypfWQ/UoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u23WidcobeXI8hJTBO02gH39xAVyMZg3S/gk8R3+oMsy1a46PrrJRqER62yDtrdtf
	 1sP9G3jW6bt0TkUH+FVWaUXb2WUMuoifq5UkKLSL9Vihbw/4tLEgQtVy3f2vCcs/Dv
	 wXTrDDgayoevbU8NQT5CXG0gCcWFBHIOSHMEoJhbkn1WLbj/H/Eu2Fuq4FA4d679tr
	 0edO8rQox64QgmVeY5DX9u/1v/sBmf4kwA7Zaxt4jUW2eY9C5xbVFoGtvPd+mKK3Eo
	 sfxBmvoKrJU1x51n4fbHg8VooER+eL425YDkyzu8lDJ1d7HJ/0OT8IaPHRNo28jX8y
	 dWVhTFyyt4wKA==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rEB6x-0000ZV-31;
	Fri, 15 Dec 2023 17:32:28 +0100
Date: Fri, 15 Dec 2023 17:32:27 +0100
From: Johan Hovold <johan@kernel.org>
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
	Alex Elder <elder@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lee Jones <lee@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v1] treewide, serdev: change receive_buf() return type to
 size_t
Message-ID: <ZXx_m1R0x7omubxE@hovoldconsulting.com>
References: <20231214170146.641783-1-francesco@dolcini.it>
 <ZXxZzd1iBOCmnczH@hovoldconsulting.com>
 <ZXxbx+laQk35W56U@francesco-nb.int.toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXxbx+laQk35W56U@francesco-nb.int.toradex.com>

On Fri, Dec 15, 2023 at 02:59:35PM +0100, Francesco Dolcini wrote:
> On Fri, Dec 15, 2023 at 02:51:09PM +0100, Johan Hovold wrote:
> > On Thu, Dec 14, 2023 at 06:01:46PM +0100, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > receive_buf() is called from ttyport_receive_buf() that expects values
> > > ">= 0" from serdev_controller_receive_buf(), change its return type from
> > > ssize_t to size_t.

> > >  drivers/bluetooth/btmtkuart.c              |  4 ++--
> > >  drivers/bluetooth/btnxpuart.c              |  4 ++--

> > > -static ssize_t btnxpuart_receive_buf(struct serdev_device *serdev,
> > > -				     const u8 *data, size_t count)
> > > +static size_t btnxpuart_receive_buf(struct serdev_device *serdev,
> > > +				    const u8 *data, size_t count)
> > >  {
> > >  	struct btnxpuart_dev *nxpdev = serdev_device_get_drvdata(serdev);
> > 
> > A quick check of just the first two functions here shows that they can
> > return negative values.
> 
> This is already fixed. Patches are in next.
> 
> There were 3 buggy user of this API.
>  - 1 patch was merged a few days ago in mainline
>  - 2 patches are in next, the maintainer decided to wait for the next merge window
> 
> commit 687d2de93b11 ("Bluetooth: btmtkuart: fix recv_buf() return value")
> commit 7954bbcdd7ea ("Bluetooth: btnxpuart: fix recv_buf() return value")
> commit c8820c92caf0 ("platform/surface: aggregator: fix recv_buf() return value")

Then why was that not mentioned in the patch (e.g. below the --- line)?

You are certainly not making it easy for reviewers, but good to see that
you thought about this, and I see now when reviewing the mail archives
that those bugs were the reason for this patch in the first place.

Johan

