Return-Path: <linux-kernel+bounces-71323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 004A985A388
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6961F2225D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE66364AD;
	Mon, 19 Feb 2024 12:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f7SvxbYa"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8DB2E844
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346040; cv=none; b=QrhVb8R4GQMPKHo8mwZabLcWfGSUyjFFx0q2fShddqhUyA4+aLLsizoJKQ/s8o9rSOhDB8JYo62hm+pAQoz73V/3xdEM6yvwuC0GdpY2W1Opz00qBkHHMCs2njyAhQIz/BcStu217YSdjsvGd+2+FEuwHxWTK5x/0/pGONiwRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346040; c=relaxed/simple;
	bh=EfyswbkjFGsreX6zvvh/xGLIF699ZsioDWGcgzOacl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6ZcBjDCoJPCyZzMtkslN8LTgbkFr5Wvty7pa3ddZ4b9APPQXFgcUDwyvimniUZ7xPhZXa7eBzHdBVXRQXDqE9pazBacWkS92aCE1YmJNqMW/H/hRnmVYlCZPK6qsPBNE9XHKqvhqn3EZWtH/tL2F7ej1rJl0q2lnnvmwVSLwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f7SvxbYa; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so3769207276.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708346037; x=1708950837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfyswbkjFGsreX6zvvh/xGLIF699ZsioDWGcgzOacl8=;
        b=f7SvxbYapz8Q6xY8ShG4PYzpMxeuML9KOgHMMAP2eVOv40D6nw1X8eNmIB55yscPoR
         mNFvTfUmZDnvRVHmzmFyYQTyi2rJqWmEHXvNO9AvPv6CJ+kwsfRkYW5QpyPmPx14q6GW
         m77054HH2xIa260GuwYUAhLtxpWM8ZKs/Xg0kxMQPpZCjggGwl9Ruo0VN+eSuHCxDAbo
         3ThhqKLAEl81nIq2huqMPtf4tjs37B0b/w+04j+n6oytayQhTKK3kUGoztfMQxk0WHoH
         s7072BCUVk7BntWRB1B3wlzWQ0f8CvSKaUnFYaSmUlFf5ffvRPPS0gPvoNIpJWdOQt3R
         Sqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346037; x=1708950837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EfyswbkjFGsreX6zvvh/xGLIF699ZsioDWGcgzOacl8=;
        b=cEUwFqUR4w1Hle210Pa7zPNHp6rumIVHd+O49lTrOZA5xneX9a+PTQ3yQj0QsLwI3B
         FdW6GX6NFE0hvqt162KqK/JXjXm5BNftZthzrKLVZsTsWhhZV2UDUkrbljyPgbJFfegx
         rJTWTYO/VjIOaTDj0WYJSO3lpj9OfMRuYhiw7CsJXk4cCy02lsMHM6vMf/RkcXMdjagA
         KY0+niQfhm6df2WnHp7oSyv6AtERLEwdYVaTz3jqOixvKPq4dPN0F/Yny75H1wgohiLu
         AaZi0a9mS5eYEfHGzc4BGS/q4N1V/lJDVfKpvfiY4F6yQDAsJQx5gcqnGC5pnmvZSEeM
         yEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr7upnUSP+mwn6Fg6ACxY/sOnZiSJdXn2rxiwGUVBzgqpL3kGH60cfHdtRqWmTwga/nl/Zi3PnyncITjKP5f+QeoY+EHhR66UifWMA
X-Gm-Message-State: AOJu0Yxv+lLWnqv00RSFwyfGcAhWIlSX0GK3SFPA1DEV7D+f6PD8e+Do
	jOfPgvWUD8ak6uyadcU8Q8F0lT4lh/mFH6UCDQwqmAZ1PpCEZ8IAHcN/fHfmW7KG+yq74WK8CLb
	RdOOGRK8RM58YcbJYTliGiyKEgVKWy8fVTJSgiQ==
X-Google-Smtp-Source: AGHT+IFW8hhd6M3At62V/9wLITSoPMQHLrtCAz5Offi/bXn5seDzbGyDiAZKXHo0tEWEDjfOFoAQhZeOCTlFpOff0gM=
X-Received: by 2002:a25:adc9:0:b0:dcd:63f8:ba32 with SMTP id
 d9-20020a25adc9000000b00dcd63f8ba32mr10169009ybe.65.1708346037293; Mon, 19
 Feb 2024 04:33:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216203215.40870-1-brgl@bgdev.pl> <CAA8EJppt4-L1RyDeG=1SbbzkTDhLkGcmAbZQeY0S6wGnBbFbvw@mail.gmail.com>
 <e4cddd9f-9d76-43b7-9091-413f923d27f2@linaro.org> <CAA8EJpp6+2w65o2Bfcr44tE_ircMoON6hvGgyWfvFuh3HamoSQ@mail.gmail.com>
 <4d2a6f16-bb48-4d4e-b8fd-7e4b14563ffa@linaro.org> <CAA8EJpq=iyOfYzNATRbpqfBaYSdJV1Ao5t2ewLK+wY+vEaFYAQ@mail.gmail.com>
 <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
In-Reply-To: <CAMRc=Mfnpusf+mb-CB5S8_p7QwVW6owekC5KcQF0qrR=iOQ=oA@mail.gmail.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 19 Feb 2024 14:33:46 +0200
Message-ID: <CAA8EJppY7VTrDz3-FMZh2qHoU+JSGUjCVEi5x=OZgNVxQLm3eQ@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] power: sequencing: implement the subsystem and
 add first users
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: neil.armstrong@linaro.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Feb 2024 at 14:23, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Mon, Feb 19, 2024 at 11:26=E2=80=AFAM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
>
> [snip]
>
> > > >>>>
> > > >>>> For WCN7850 we hide the existence of the PMU as modeling it is s=
imply not
> > > >>>> necessary. The BT and WLAN devices on the device-tree are repres=
ented as
> > > >>>> consuming the inputs (relevant to the functionality of each) of =
the PMU
> > > >>>> directly.
> > > >>>
> > > >>> We are describing the hardware. From the hardware point of view, =
there
> > > >>> is a PMU. I think at some point we would really like to describe =
all
> > > >>> Qualcomm/Atheros WiFI+BT units using this PMU approach, including=
 the
> > > >>> older ath10k units present on RB3 (WCN3990) and db820c (QCA6174).
> > > >>
> > > >> While I agree with older WiFi+BT units, I don't think it's needed =
for
> > > >> WCN7850 since BT+WiFi are now designed to be fully independent and=
 PMU is
> > > >> transparent.
> > > >
> > > > I don't see any significant difference between WCN6750/WCN6855 and
> > > > WCN7850 from the PMU / power up point of view. Could you please poi=
nt
> > > > me to the difference?
> > > >
> > >
> > > The WCN7850 datasheet clearly states there's not contraint on the WLA=
N_EN
> > > and BT_EN ordering and the only requirement is to have all input regu=
lators
> > > up before pulling up WLAN_EN and/or BT_EN.
> > >
> > > This makes the PMU transparent and BT and WLAN can be described as in=
dependent.
> >
> > From the hardware perspective, there is a PMU. It has several LDOs. So
> > the device tree should have the same style as the previous
> > generations.
> >
>
> My thinking was this: yes, there is a PMU but describing it has no
> benefit (unlike QCA6x90). If we do describe, then we'll end up having
> to use pwrseq here despite it not being needed because now we won't be
> able to just get regulators from WLAN/BT drivers directly.
>
> So I also vote for keeping it this way. Let's go into the package
> detail only if it's required.

The WiFi / BT parts are not powered up by the board regulators. They
are powered up by the PSU. So we are not describing it in the accurate
way.

Moreover, I think we definitely want to move BT driver to use only the
pwrseq power up method. Doing it in the other way results in the code
duplication and possible issues because of the regulator / pwrseq
taking different code paths.


--=20
With best wishes
Dmitry

