Return-Path: <linux-kernel+bounces-3165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E51D81681F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE3D11F21FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E8510941;
	Mon, 18 Dec 2023 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqKR6jTw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D471101E8;
	Mon, 18 Dec 2023 08:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FCAC433C8;
	Mon, 18 Dec 2023 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702888506;
	bh=PvieyW9kHU+3JjdvRizTuAsBF+M7+DN21zt8QD6huP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cqKR6jTwpmCKyTFqiDsud8Ud91Y2vl0XnJ70WkUUWsejg3N21krgNOC2hGTW6Sr//
	 PkugwCVTKDJbZBbTAjn2pZOtgeXLfIt4KhVQdagYFnoBeWEVHdgSDchIq1/IEoOYgz
	 UPhMPfMZofuUfwXr9yS3PhKhC0IHJypA2VlCOfPMF5X3opuQwu7Tnyq59gPlfhE2L7
	 BMOT1Z09reyctvlBiTybBEDPjQ60FLqs31RXDW6RG7gr4O0un4ilMkg7Cgrs/fszps
	 ppFsjdnc33uZ69wLfbVJFyRfIMVBseNo/FtnnrcNqwp53jB9iKEBeFsADcFruxnW5a
	 /8S2G6GLNLRGw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rF95c-0003FH-0v;
	Mon, 18 Dec 2023 09:35:05 +0100
Date: Mon, 18 Dec 2023 09:35:04 +0100
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
Message-ID: <ZYAEOCMwZGMNvpNX@hovoldconsulting.com>
References: <20231214170146.641783-1-francesco@dolcini.it>
 <ZXxWX-Fw1InID2ax@hovoldconsulting.com>
 <ZXxa7yzKzG6048vw@francesco-nb.int.toradex.com>
 <ZXx8bCVyxJ9Ddvqm@hovoldconsulting.com>
 <ZXyH1Zv3Pxd6S3ag@francesco-nb.int.toradex.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXyH1Zv3Pxd6S3ag@francesco-nb.int.toradex.com>

On Fri, Dec 15, 2023 at 06:07:33PM +0100, Francesco Dolcini wrote:

> On Fri, Dec 15, 2023 at 05:18:52PM +0100, Johan Hovold wrote:
> > On Fri, Dec 15, 2023 at 02:55:59PM +0100, Francesco Dolcini wrote:
> > > To me the change is correct, with that said probably this should have
> > > been explicitly mentioned in the commit message or a separate
> > > preparation patch.
> > 
> > It's a separate change and should not be hidden away in a tree-wide
> > change that goes through a different maintainer.
> > 
> > Please drop this change from this patch and resubmit it separately to me
> > if you want and I'll review when I have the time.
> 
> Fine, I agree.
> 
> I see those options (let me know if you see other options I have not
> mentioned):
> 
> 1. I add this change (taking into account also intel ice) as a separate
>    patch in this series and you may just ack it and Greg could merge
>    together with the serdev one.
> 2. I prepare an independent patch for the GNSS change and only once this
>    is merged I'll send a rebased v2 of this one.
> 3. I update this patch without this GNSS API change, that mean I will
>    have to cast away the signed type from a few GNSS drivers.
> 
> 1 is my preferred option, 2 is fine, but it seems a little bit of overdoing,
> 3 I would avoid, we are doing this cleanup to be a little bit more
> strongly typed and to prevent the kind of bugs that is the original trigger
> for this patch.

Changing the return type of gnss_insert_raw() is going to be a bit more
involved and should be done in a separate patch (e.g. you need to look
at gnss_usb_rx_complete() and ice_gnss_read() to avoid introducing new
warnings there).

And both option 2 and 3 will introduce conversion warnings (W=3, which
we have plenty of anyway) unless you add casts.

I suggest you go with 3, unless you insist on 2.

Johan

