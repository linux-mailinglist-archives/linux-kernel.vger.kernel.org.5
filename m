Return-Path: <linux-kernel+bounces-159358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 845488B2D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68C71C21B95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB74B156878;
	Thu, 25 Apr 2024 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="eEt/3Q70";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hysgz7YG"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C4E156655;
	Thu, 25 Apr 2024 23:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087380; cv=none; b=uV97pae2zEX23BSaP9cLAfUvzTnAJNYaz+lXUNSvfW0e5tlQY+El8CAIlu1k4ZrGZspnLkpnvfT6JqzIW04aun6sGHEk4+zsCvB3awbvsClUIMjJRCp15GdTWyywBkPcVCzQvoUNfctwpReaHcZyD662vznVkgX9AjMIjHhIvo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087380; c=relaxed/simple;
	bh=AUPfJtbm2kSrH0QmczwP3g8eBPLF8qUBWjvy9grRqWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEXaG54wD3aD//IXr4Rev9Z1Z5HR7rjRPXKR9MhplZaRj+LDOchCZOoHLYGg0xtPaVHhzcWbQ57qYQcGaOiUH+2WyIH4elofYlmDIiLwPeqs/5SFfc3YKUDbszyGCnJn/WWfEK8PE250tH+U3mk6LR1KyUosHQ5YJUsj86pNvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=eEt/3Q70; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hysgz7YG; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id AF36F18000A2;
	Thu, 25 Apr 2024 19:22:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 25 Apr 2024 19:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714087376; x=
	1714173776; bh=bTVVtfOqbo6S/FLcC/gLjDKd/B98VKpL8AN5HW3FuHc=; b=e
	Et/3Q70fUlgnT0ur+U4lzfdLo7twBI8/Z1I7G9NM20VLfY/U9XjGKScYWfBqoUml
	f26lMDnYqXHsdrycL0TcdeWrwWquvhGzrnrosr5WYZ77Snqq+2rO0Qg/2qlEcOSW
	V5yLGIqy8Pcqvcqex0CT2peylLH3boJKyphqqQVOJ1WfesaHaRf+aFsLno+s7xYI
	Cfkxsy6hfY/x7F+hU2IxdtvlW0Pq/aK53hV0nubeh9ceMXo+aXpiY8GNfraiMbzo
	m6KcGuyVoVlXw0IauaAccVXS+fDBHu0iyhRK7ZGtADc4PhwSDwYCn4MHXJFOCW/N
	UN7IM4PwAyMxEQVLckNKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714087376; x=1714173776; bh=bTVVtfOqbo6S/FLcC/gLjDKd/B98
	VKpL8AN5HW3FuHc=; b=Hysgz7YGzRDOXRxpOsWgNzJBu7NIsVWH2plmH5W4k3dQ
	phZp9XWf+XCfCm3y80RGCLE4e+LJ/nKnuAOsXDH2AAhHT0ga4o2+U+spVNqyxj9L
	vtKHhoZo81+rRDeLv+AsXQKAcC/sNWQ4wDf5UgGMfzxLYmzZ6WcV7RNfmRm2owqU
	iy7HDR3GkBbmKk2xJ8eCnB/IN1eoC/chl0oSMKz1z06Gyp59udc2/yrPqkJowZMa
	6v32ACzZ93T/RFyW6taDAMZgF2XU0KazyZOq3M8rlzlCOJ+suAbY9jaAGvUlHB/k
	LH04nxIEuErGOBlcruCNeh+2xGNDh/UfXKZvJKdjkA==
X-ME-Sender: <xms:z-UqZg60HvThyVwAPPHMzPhNlItn0UuOFaMPWm8z9ushI-ZtgZYkNQ>
    <xme:z-UqZh5ate-DtKZ7pK6NboQubOx1BqZ2U6LeRh8tRv3iLDRvMpgpRLEmLxEmHb5sz
    gDADd4q87FeEQ_Cncg>
X-ME-Received: <xmr:z-UqZveqNg5gj236nDg1JAp3xMfBsqCLdgjcOREtl7MWyaWPZoX91LRBmxSx8WfIkD7LeP1JIg8iX-c_lRq9rLfbKF3DwMKxG5d9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeei
    ieetvdelfedtgfefuedukeeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:z-UqZlIheD0fEkxrR7AwFJKZuVt249rFdJHwngiwKs00lHZancY4YQ>
    <xmx:z-UqZkKg8SknRgHohfuGJdMFfLwzjGuMwnT-_EN1qCmxGoKP9hBsmg>
    <xmx:z-UqZmwkm2upz-gSwbV4THcRjrocObQ3lKUH9l9cs-ffMuQOiFmyFw>
    <xmx:z-UqZoIb9eE4hXbfLj1VyAaMXzTXlGvWrUpvqnnHq3QVM05YDFWn9Q>
    <xmx:0OUqZtqnwU9L8aowp9HNZK-adQ4ky6oPvKdNwXgBrPt0Rn6t3tOwT7-q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 19:22:53 -0400 (EDT)
Date: Fri, 26 Apr 2024 08:22:50 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Ivan Orlov <ivan.orlov0322@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] ALSA: kunit: make read-only array buf_samples
 static const
Message-ID: <20240425232250.GA205425@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20240425160754.114716-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425160754.114716-1-colin.i.king@gmail.com>

Hi,

On Thu, Apr 25, 2024 at 05:07:54PM +0100, Colin Ian King wrote:
> Don't populate the read-only array buf_samples on the stack at
> run time, instead make it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  sound/core/sound_kunit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
> index eb90f62228c0..e34c4317f5eb 100644
> --- a/sound/core/sound_kunit.c
> +++ b/sound/core/sound_kunit.c
> @@ -167,7 +167,7 @@ static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *
>  
>  static void test_format_fill_silence(struct kunit *test)
>  {
> -	u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
> +	static const u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
>  	u8 *buffer;
>  	u32 i, j;

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

We can see the other similar cases in the kunit file. I'll post the fix
later.


Thanks

Takashi Sakamoto

