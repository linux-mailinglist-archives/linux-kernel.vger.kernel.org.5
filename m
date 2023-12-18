Return-Path: <linux-kernel+bounces-4330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66637817B99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 21:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 067BAB23949
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E169672062;
	Mon, 18 Dec 2023 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="mb/useEv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LF1Xkp2v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BD495DE;
	Mon, 18 Dec 2023 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id B69CA5C020B;
	Mon, 18 Dec 2023 15:12:25 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Dec 2023 15:12:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1702930345;
	 x=1703016745; bh=LWYyWkDsY/Zi8FphFf+H4zFoydBDiorSz1khQkPdMEE=; b=
	mb/useEvR5Rr6NLotqJE7xJWNLJ+871ZGy2/uYtuW2wQXO4yYeUTVbM0SsBzoj0r
	CzGNA7FvC0317zUMQnG6wLHyTcPZdpmpSSHQCi7sEgM1nTWuk8DpTkQSrtUrwfz2
	Ih7R0NjNdsj8fZ2CT0HzxSuaqNB2a/9Z5IwFFR5lJIm4TZHt7WpRbqupcfWk+flg
	hLIzRnHovyAEpOu9WtoLABYKqYR7Y0CXXqmZIldqSaRaTix89BeZTc8sxEWnjycc
	Szx0VnfX3lvp9K9yPvWFh5v0nX5cFfN8FrvZ3x8fAspjwEm2u/6gURTjdQix3Z6w
	6FJnphYvBziTP5qGbFYYaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702930345; x=
	1703016745; bh=LWYyWkDsY/Zi8FphFf+H4zFoydBDiorSz1khQkPdMEE=; b=L
	F1Xkp2vIwgqV/4OdisyCGMQFVTW5IFoaaqJj3kCayBQNrYZM9ndbo+Y9cmAmjwcx
	pbbFhfdrnZqf/fzmntpD/WaxjdiGgE8nMhJbjvvzVnmJl4ijveL5KGerpFgWMNJU
	Are/Hdy33E1sKsJ0S4ythvV85FNpLYyD8n5+bp4mW7zFAOKZBEe824d0YIuYXtgQ
	0ChzimvOs/bpWkN+6D/6YZymwuFEBu+yLOcsFZ0JVCAEapToQ0FETVfpOKt+utHM
	WmEwpFVZ6QkZMZEy8TptfwHDwJf0XtfeC1Ejti5cCaoJc3wMZ013i+NlGX2A8oea
	gB9EEedZVnqrgai433oBQ==
X-ME-Sender: <xms:qaeAZVNU9jc9V7p_xXLit5xJB7G8mRHv_3ZA2nCGZ8ny4ifmovULOA>
    <xme:qaeAZX-VHiIKbDAN6kZVWW-E3xDR5_-vJ0q5PiabrgANmOeI8F7J8ioFwWK5ic3Y8
    dKU3hDueUpu6XH2Ip4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddtkedgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    tehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrf
    grthhtvghrnhepgfekueelgeeigefhudduledtkeefffejueelheelfedutedttdfgveeu
    feefieegnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:qaeAZUQZyuvtnu9jG9ZCE373jnslc6O9xHM9fgvua2oHX0tj1zoerA>
    <xmx:qaeAZRtGU3-JqMbkcdE_Qxt1dyMekmGFHGzqJQwMY9vDqDT-YNVqOw>
    <xmx:qaeAZdffmE7gyHKDv0fAB6a4Heq0I1HVzJOhzTQ4MCVo2OS1d_C1ag>
    <xmx:qaeAZXt95DbkWPruTOYNUd6HK2gC3gt8H4Pw8fmCaN_8MTgdIqvU2A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2CAD3B6008D; Mon, 18 Dec 2023 15:12:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1283-g327e3ec917-fm-20231207.002-g327e3ec9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0877a767-dea5-4c49-8125-d1995ef55407@app.fastmail.com>
In-Reply-To: <20231218-net-skbuff-build-bug-v1-1-eefc2fb0a7d3@weissschuh.net>
References: <20231218-net-skbuff-build-bug-v1-1-eefc2fb0a7d3@weissschuh.net>
Date: Mon, 18 Dec 2023 20:12:07 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "kernel test robot" <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] net: avoid build bug in skb extension length calculation
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023, at 17:06, Thomas Wei=C3=9Fschuh wrote:
> GCC seems to incorrectly fail to evaluate skb_ext_total_length() at
> compile time under certain conditions.
>
> The issue even occurs if all values in skb_ext_type_len[] are "0",
> ruling out the possibility of an actual overflow.
>
> As the patch has been in mainline since v6.6 without triggering the
> problem it seems to be a very uncommon occurrence.
>
> As the issue only occurs when -fno-tree-loop-im is specified as part of
> CFLAGS_GCOV, disable the BUILD_BUG_ON() only when building with covera=
ge
> reporting enabled.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes:=20
> https://lore.kernel.org/oe-kbuild-all/202312171924.4FozI5FG-lkp@intel.=
com/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Link:=20
> https://lore.kernel.org/lkml/487cfd35-fe68-416f-9bfd-6bb417f98304@app.=
fastmail.com/
> Fixes: 5d21d0a65b57 ("net: generalize calculation of skb extensions=20
> length")
> Cc:  <stable@vger.kernel.org>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  net/core/skbuff.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 83af8aaeb893..94cc40a6f797 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4825,7 +4825,9 @@ static __always_inline unsigned int=20
> skb_ext_total_length(void)
>  static void skb_extensions_init(void)
>  {
>  	BUILD_BUG_ON(SKB_EXT_NUM >=3D 8);
> +#if !IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL)
>  	BUILD_BUG_ON(skb_ext_total_length() > 255);
> +#endif

The way I would write this is

BUILD_BUG_ON(!IS_ENABLED(CONFIG_KCOV_INSTRUMENT_ALL) &&
             skb_ext_total_length() > 255);

but of course the effect is the same.

     Arnd

