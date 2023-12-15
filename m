Return-Path: <linux-kernel+bounces-1280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C26814CD5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAABE286594
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60EF3C481;
	Fri, 15 Dec 2023 16:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7dm0Ddl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E853BB25;
	Fri, 15 Dec 2023 16:18:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FC0C433C7;
	Fri, 15 Dec 2023 16:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702657137;
	bh=YlcNrdt+0bdBjEoeknJhdd+iUZGMaHxrfBZN/74+PSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K7dm0Ddli65bXnpIe+H/ttDbslFE9q2kMgBadq97OkKtouXQIbEiyY2q9JXScuDsv
	 C1TjFxiht6mfl4VICqLkzK7PUWl+CGRGnU6fYOYPcX8M4yYc9TnjF9ZXpkWsSySLmw
	 CyyhNm54GFYsWjy2rItDi4vwFE9/ZhlLtsFlUG5+pOmeb3j63lrLaKJ7ABlRzd4YHf
	 FIPEL5mBy+6x1p0RKnf9kDaMW13b61pXy/Df0JjpQnoeYrO6LSmIPopfjK9+e6we66
	 XhmZW3p8qy6Nb89ngBM4O2Sk//rED3kWw0q23oLG3uetyunnmSGJbQZLPq0L+Kbm4x
	 OaRnvmY/t7uxg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rEAto-0000VW-1C;
	Fri, 15 Dec 2023 17:18:52 +0100
Date: Fri, 15 Dec 2023 17:18:52 +0100
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
Message-ID: <ZXx8bCVyxJ9Ddvqm@hovoldconsulting.com>
References: <20231214170146.641783-1-francesco@dolcini.it>
 <ZXxWX-Fw1InID2ax@hovoldconsulting.com>
 <ZXxa7yzKzG6048vw@francesco-nb.int.toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXxa7yzKzG6048vw@francesco-nb.int.toradex.com>

On Fri, Dec 15, 2023 at 02:55:59PM +0100, Francesco Dolcini wrote:
> On Fri, Dec 15, 2023 at 02:36:31PM +0100, Johan Hovold wrote:
> > On Thu, Dec 14, 2023 at 06:01:46PM +0100, Francesco Dolcini wrote:
> > > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > > 
> > > receive_buf() is called from ttyport_receive_buf() that expects values
> > > ">= 0" from serdev_controller_receive_buf(), change its return type from
> > > ssize_t to size_t.

> > > -int gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
> > > -				size_t count)
> > > +size_t gnss_insert_raw(struct gnss_device *gdev, const unsigned char *buf,
> > > +		       size_t count)
> > >  {
> > > -	int ret;
> > > +	size_t ret;
> > >  
> > >  	ret = kfifo_in(&gdev->read_fifo, buf, count);
> > >  
> > 
> > Why are you changing this function? This is part of the GNSS interface
> > and has nothing to do with the rest of this patch.
> 
> good point, thanks for looking into that.
> 
> from my understanding kfifo_in() already return an unsigned, both
> __kfifo_in and __kfifo_in_r return unsigned.

Correct.

> With that said this is used by 3 drivers:
> 
> = drivers/gnss/sirf.c:
> = drivers/gnss/serial.c:
> 
> The driver just use it into the actual receive_buf callback.
> 
> = drivers/gnss/usb.c
> 
> This driver does nothing with a negative return value (that is never the
> less not possible), it just check that the whole buffer was inserted.

That driver also knows it will never be negative.

And you forgot about

	drivers/net/ethernet/intel/ice/ice_gnss.c

> To me the change is correct, with that said probably this should have
> been explicitly mentioned in the commit message or a separate
> preparation patch.

It's a separate change and should not be hidden away in a tree-wide
change that goes through a different maintainer.

Please drop this change from this patch and resubmit it separately to me
if you want and I'll review when I have the time.

And when doing tree-wide changes, please try to follow the style of the
driver you are changing (e.g. do not introduce inconsistencies by
changing to open parenthesis alignment of continuation lines in code
that do not use it).

Johan

