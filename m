Return-Path: <linux-kernel+bounces-6207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568BA8195E6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5C18B24919
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8E25C9B;
	Wed, 20 Dec 2023 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="D7ofODUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uewWNLnu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55A41C26
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 9CFAB32009F5;
	Tue, 19 Dec 2023 19:48:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 19 Dec 2023 19:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1703033302; x=
	1703119702; bh=ZZWeUI8Z6NJ3zfoU+DP0OJNgoKe55BRX9UMdfeIctTw=; b=D
	7ofODUMlAGxBgYVTq1fZBWb06CY0WPrgXozpAxQ9ulW/fwXpDxIF672okV6Tfsxh
	e5E2rHplwD/QrCHUycdrwjbFO7eRL4CBGBw3TvE4s+ik/LrZwY9PPoSxdv3ZnenW
	gSUt40EfcqHZ25JJyihnW9g814n4JSK4Qareb24CNizy0FeQe2zo/Y3i/YIbRmtg
	hf57HcUZVgdXKU8NWtLDYXbOB4K3etKnAaRd2MDFg+kGfA1yJIaaDWbMdOxrzj4C
	x9qZYSsjxBEGATiaNETnFTZqTbOTRjgqseQQKsdmyJS9zeUAeZpzoDwHKhht8dSL
	tiAyhT7oo2sQroc62MpLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703033302; x=1703119702; bh=ZZWeUI8Z6NJ3zfoU+DP0OJNgoKe5
	5BRX9UMdfeIctTw=; b=uewWNLnuEdpjYfamCH4qz6jqsdaeCnhVWZUn/T3X2uSv
	mPVjsYK/FEV5KWQwn1L4XgZWwTqBhYouRhejSBZsDCK5KjPlbsU17iSsxDzF0Rx0
	stVHNCHaPxM226BrjRk3v7Ej/EyxLmDUBZu+sDXqrBsbrR+Uz6Z4MW4cgbVvAluH
	/4eI9+ApVYomn0zo+z8N/YIh3zRYCmJ7UbjaaB56EIh2sYHYGZtyGC5kIsg7Uwv1
	ureAMAI7kEm2Wae7bPV+jqt59pf6BaKOdUcBWfZM46DiZDvwGE7/p5lmEIjmsd4Y
	KSBLk/NulSoTSqRZhXGHXoRcS+cad3pmc+JEzUinJQ==
X-ME-Sender: <xms:1TmCZSw3g4zBoNrHzP6esesnfXj20kG4coTWEUGqWdlg8ufgoq4uJQ>
    <xme:1TmCZeQh9gMi1yZSOUzksk6uDLFGIIH9tviUkul3EP17kptvdf-Pqv1smfCMz9UQV
    ZAlkkvAVHQlsddoCQ8>
X-ME-Received: <xmr:1TmCZUWez7--OfTZIwkb-oq4vlKNTE0K8REVLQGL9t8CcRzA3pys8CSd9VOLquGveohKMPHG6nBblAMMraBqr9Ex3UWuczST3UA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:1jmCZYjNFzbXRrL9rYrE609Rov3ADATeq2FgqvlkkJAvM1Uci7wxNA>
    <xmx:1jmCZUB3bhCEdPhV3YLORq0EdlnwDZTaj81f-JDbaoIPaHEk5O1jHg>
    <xmx:1jmCZZLiEi42vgSSGfI8hOgkWoZBVt1OYm3Uy8Yb8lZuAqXaRREI2Q>
    <xmx:1jmCZd4BuAmATv0jMv1TtlLO1_DiAcgFdPrzWf9ogAhtpIIfW89eGA>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 19:48:20 -0500 (EST)
Date: Wed, 20 Dec 2023 09:48:17 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] firewire: make fw_bus_type const
Message-ID: <20231220004817.GA6217@workstation.local>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
References: <2023121931-skydiver-dodgy-d1bd@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121931-skydiver-dodgy-d1bd@gregkh>

Hi Greg,

On Tue, Dec 19, 2023 at 03:59:32PM +0100, Greg Kroah-Hartman wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the fw_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Cc: linux1394-devel@lists.sourceforge.net
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/firewire/core-device.c | 2 +-
>  include/linux/firewire.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks for the patch. I applied it to for-next[1], since the following
commits at v6.4 kernel have already allowed to keep it as constant (your
absolute work!).

* commit ad8685d0f61a ("driver core: bus: constify bus_unregister()")
* commit 00c4a3c47da7 ("driver core: bus: constantify bus_register()")
* commit d492cc2573a0 ("driver core: device.h: make struct bus_type a const *")

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/log/?h=for-next


Thanks

Takashi Sakamoto

