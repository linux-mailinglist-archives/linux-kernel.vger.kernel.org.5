Return-Path: <linux-kernel+bounces-21602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F2C8291B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B511F26A1D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26E1C15;
	Wed, 10 Jan 2024 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8pUQUww"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21E645
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704848702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XDAJkCct0QqlJ2J1QN5K4XkP3EqrDChHOlqcjsZZ3Ok=;
	b=G8pUQUwwlaZYOUQEtI0WYclxDEP1aM9ELZqvS4vdlIET8fYI/8/WJnM5Fa5Cc6yH1AYKxl
	PqYE5oKUOlcLgnlO7l430RiiB9LJwhGmuCTtqg4LzT+TUjikknHScSxo+TAR+R+FKW2su4
	K4aNVBmjS24kvwoOVvxrenJnUCgk3GQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-uK7ew5PIMqCiUzOKsE878w-1; Tue, 09 Jan 2024 20:05:00 -0500
X-MC-Unique: uK7ew5PIMqCiUzOKsE878w-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ccc360edc4so30015881fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 17:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704848699; x=1705453499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XDAJkCct0QqlJ2J1QN5K4XkP3EqrDChHOlqcjsZZ3Ok=;
        b=bD0IuB0MKDoMcvlFoMf3522I8Vmj0Nvdgvqd6ZL8e46+bRhT/kaNldm/meMXlcteyP
         YR025eQn1EVCpO3detG1b354U0XFiE+Die5V0EuroH36bKayBn3632PfnaCL70/5DBld
         7+BilH7Uu9915+vnyyjvf4sRW/hSELoKP1FvqkLUrSwzKxZEioAwmlt/ENxdLqXWVyow
         bEaiBJSYTdhWVKIU+ITdW5ye1GLlkgK3/fuGwC5uRScpkBf5YgpMKLbJQyh7FN1K+W+o
         L+PThab3GScthWbFJfkVFPNFetPdOiVJ0ffBZrEQ9csMRZPEP66Bw9cUidqOf5uXFHRL
         AOiw==
X-Gm-Message-State: AOJu0YwO5AB+1qapMglqmTFShL7UH+icdrW2Z0bxvtaHU2dO5kpbT1+y
	Bn70wX1yDF1gIpkXGDpwDVYSqSw92f7ZelLoy4GbUklGzbE5rV8lrLS3HEQZYiIz8bAoedsuV40
	U7mbIrZXyMGi7YLluHfv9sWT0tA/dCucjXqFp/tmsabhSN3hQ
X-Received: by 2002:a05:651c:1047:b0:2cd:3487:9a05 with SMTP id x7-20020a05651c104700b002cd34879a05mr98286ljm.88.1704848699515;
        Tue, 09 Jan 2024 17:04:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKqSK/YybrS4hqOkpNnDVEZbPGMecxKjNnfERUMKoTvZqBP1EhGdJBrkbTbH5Ki7NxC6cHcaGGQZdKcc7uVcA=
X-Received: by 2002:a05:651c:1047:b0:2cd:3487:9a05 with SMTP id
 x7-20020a05651c104700b002cd34879a05mr98276ljm.88.1704848699158; Tue, 09 Jan
 2024 17:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108181610.2697017-1-leitao@debian.org> <20240108181610.2697017-8-leitao@debian.org>
In-Reply-To: <20240108181610.2697017-8-leitao@debian.org>
From: Alexander Aring <aahringo@redhat.com>
Date: Tue, 9 Jan 2024 20:04:47 -0500
Message-ID: <CAK-6q+jy-0+bZRUKhRsB2RMtpJ=Sw1A5qHk+rpnYaOzV8WFD5A@mail.gmail.com>
Subject: Re: [PATCH net-next 07/10] net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, Alexander Aring <alex.aring@gmail.com>, netdev@vger.kernel.org, 
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-bluetooth@vger.kernel.org>, 
	"open list:6LOWPAN GENERIC (BTLE/IEEE 802.15.4)" <linux-wpan@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 8, 2024 at 1:21=E2=80=AFPM Breno Leitao <leitao@debian.org> wro=
te:
>
> W=3D1 builds now warn if module is built without a MODULE_DESCRIPTION().
> Add descriptions to IPv6 over Low power Wireless Personal Area Network.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/6lowpan/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/6lowpan/core.c b/net/6lowpan/core.c
> index 7b3341cef926..80d83151ef29 100644
> --- a/net/6lowpan/core.c
> +++ b/net/6lowpan/core.c
> @@ -178,5 +178,5 @@ static void __exit lowpan_module_exit(void)
>
>  module_init(lowpan_module_init);
>  module_exit(lowpan_module_exit);
> -
> +MODULE_DESCRIPTION("IPv6 over Low power Wireless Personal Area Network m=
odule");

Here is a nitpick as well. The correct acronym [0] is "IPv6 over
Low-Power Wireless Personal Area Network", otherwise it is okay.

Acked-by: Alexander Aring <aahringo@redhat.com>

- Alex


