Return-Path: <linux-kernel+bounces-59355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D338484F5BE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 729E51F2200C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D92381B4;
	Fri,  9 Feb 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BsESt9iT"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073DD381A1
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707484986; cv=none; b=bgLSafgUEUym+E3+B/Q0r3HAFXIVoHTTPnMvPrb23TxDGaPu3C/nLB9baeN+rtDNmwlbcCwDva83hkkFk+dk0DGa9Tjy2++cQEOOb0BdcLB/kiyNY/x1hFxrKJkEoXOQGlw5eilWkF7m8GpoL65SdQUwg9rBsdN1ac10ImGj8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707484986; c=relaxed/simple;
	bh=4LbfICbexA9VtoAo6E6/I3a3KsNtqbh04wcc+kSk8wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BC62hbQPhKKPawQSLtT8ddXBHDjaDo/4dwnQBPrQ00hBbw7JeePG1wKqJuocTtef7gLA/ZZFWBeao7EJAGyo7QzK4XysEhXIvih9sFbKspJHdROwIa2ok366+idh5JPzqE+K6JaIAyNPlLiysiBiJS0K836Hgi2uhlL+AqVv7vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BsESt9iT; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-604aab67616so10523457b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707484984; x=1708089784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LbfICbexA9VtoAo6E6/I3a3KsNtqbh04wcc+kSk8wg=;
        b=BsESt9iTW17J7wiBHiVHdK19y7EdQOYGsVliYnnPIFoPQA++qzUB3MRLFONmNHnkAR
         ZPLDu+6ayxZLk7v1pTJxJCYwR1OOrsI/p33MKvBQqpfei2nsi6SaUnjYKFimk7XM3Las
         5F3DxTFqaracJuB8ICV9yGOlvqltK5WJg6laYC1B5i+UI5+FT6H/6sAHTdNI4W6estLu
         SMsPNYAlvnVJ5DpH4VU9fN66IYL6wOPGbYkGfqMNuHQtN6XCFBqiRcboa3pogsQUR8l9
         ib3VE5UEpkjRrARm2rWL6SIncI+WY5QXqgZN8sDvnxcZ8Tnh6eus7iHdT71MNpCzMNX0
         STgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707484984; x=1708089784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LbfICbexA9VtoAo6E6/I3a3KsNtqbh04wcc+kSk8wg=;
        b=dmEZ2NXjj2Kf5ssSCxo5cPEJ6GiVV6VEilnzIO5VIb1GT/9AhMc2wTrWglB6Jv1HXo
         pTvWB3/4a5NvUQQgNG+WuV+bg/SGXZCPavhII9szrJJ5zIfbETGYiknyDnBCdhJzBv2X
         6dBn1co+aJtQpFz6YDdkZK3koOfs5ZNnyboGaJXGwzg/pPwv6mRYA8i10SYUNfQSs15I
         yWeJAM+fZj3en+X2z6WfVKclE1Yc/D1X+jx911I8xJ6uO9RjjVGTK8bO6KTnfB1JB2OS
         EGjG5kKL7gsluO9qRWibnafSj7++x8YVgIuFNECOZKZBiRo6mg5Vn3CmY7nNS4ML6iHj
         u1AQ==
X-Gm-Message-State: AOJu0YwWgNK/zd4aUCyObMf0sPynvelAGzZsi0sFAOkM0cpExK4UKjyX
	AXtoXCljn/r8IQObSkZ5q1IpkHonHflgnwqtJVPeSbtS01GciWHeET6wlEUnv+pZjbTqDHkig0h
	h9w1KAs6KaPQkRMRy3JrtWLWit0/1xKehVyevf2B9S26eXQq+nrQ=
X-Google-Smtp-Source: AGHT+IExS1Ag0qFq7hd6iWFvBp6Tx6jE/ZOGxQYBaVy0ImALf/OWmu7VkWn9Phrm1WVOv+ATksyDHZOJkIi1IKNQbDE=
X-Received: by 2002:a81:7b85:0:b0:604:aeeb:d569 with SMTP id
 w127-20020a817b85000000b00604aeebd569mr1482367ywc.36.1707484983905; Fri, 09
 Feb 2024 05:23:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com> <20240209-realtek_reverse-v6-9-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-9-0662f8cbc7b5@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 9 Feb 2024 14:22:53 +0100
Message-ID: <CACRpkdbHyNG+QPK1Gx7CYPK=NaYxAUDEZ4ewpQTB83T2Hp4DCw@mail.gmail.com>
Subject: Re: [PATCH net-next v6 09/11] net: dsa: realtek: migrate user_mii_bus
 setup to realtek_dsa
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 6:04=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> In the user MDIO driver, despite numerous references to SMI, including
> its compatible string, there's nothing inherently specific about the SMI
> interface in the user MDIO bus. Consequently, the code has been migrated
> to the rtl83xx module. All references to SMI have been eliminated.
>
> The MDIO bus id was changed from Realtek-<switch id> to the switch
> devname suffixed with :user_mii, giving more information about the bus
> it is referencing.
>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

