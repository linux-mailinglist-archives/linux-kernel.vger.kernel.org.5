Return-Path: <linux-kernel+bounces-88082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C3086DD1D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D48C1B25999
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268969DE4;
	Fri,  1 Mar 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHAwqsJM"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6569E19;
	Fri,  1 Mar 2024 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709281828; cv=none; b=LKm0zcFYX/mkEVVJ6KOpwl0vtYPqCEIxAWr7Vz8HJ0q6oWMdLC4LIdBuQaU2e1V9aN6sspsfeUPrj/D/+Wl8lWNZXJZlWpBL7b6jBdvQ7/8pKGrjJnWf9pRRln2NQPWDLeXvggceQmXrK6QJwsD8w7pqwIZfmniATYor34ey7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709281828; c=relaxed/simple;
	bh=BBhgeRx4yOLdW6NNuh+M5S/wHVDDwGe+mJfSD+9oj4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiXKUBpLb/fI1CNFwv4sqJv5wVeESqoqBqNSVUsc3v8hj43bB1miem/2L/CSv0pgjJeQVYwLHjbAHSuX5GET9/c3R2iuPXyJGuSrKkO5hPo6QoOW0m+4XWeKz/G3267sKOjd5w0M3K1R/KGHW+CxxPlHeEBaZz82u6n3lqv1J10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHAwqsJM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a26fa294e56so342364666b.0;
        Fri, 01 Mar 2024 00:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709281825; x=1709886625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV7g20c61SLdcO3hJdJz8nvxom42Edf9pzms73nygYQ=;
        b=XHAwqsJMxScnnPgoOLY87hRy722D+DJG9l6B+JENMK/3hVyFFKcLqfHRIXmqgkfu3U
         KeDYPLB//2O50vFnprOnoNOPxpCbdtTEBqQoOUZUP+4y+umYnYKAbecWZZD5f6e7Hlxx
         B0HCrCwPvYTxwXNeOWjKaOhwcrbWS//JHA92rxIHFDCHRYsVcMbMB5pO/7g22oOgtlBA
         EwNJ2/9MdJAYlTDuz/HEu5W0Dyvs3+bmAPrx/LDDgEgZG9/4/TCwqABVrqGNiFPQHZkl
         zOuiNOs57xm0RqDPAkGb/bt1Hq/AgI+D3U34eji1ycxd23CMJjt5tuyLz3+pFaBYHrbh
         nWpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709281825; x=1709886625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV7g20c61SLdcO3hJdJz8nvxom42Edf9pzms73nygYQ=;
        b=qi6WFHDME76X11qKkuZ46C8qXoVRF5mGxXgRTm+7dphZ9G7A6GnAgrnrYz9I1mC3eY
         2fosmnilUl0fGEgMzVZhF/OtXsJnImxKBQ5IjgPnzI45qskKVQDGfG/3Erj3n4cSt9tM
         53K0ymST1lTTgceSyCyJqkB7JLiWESbhrW2ElxGSX10/u2ViCe+Awb7mVBqDk9IV7EXg
         8Q+ZW6hAiLwUAYzanqmVv5iWbHBE7mnLh3O5sNy95Yty5AgkL6/p7FRNHnpBbUpSQ+0N
         4h9CUR3yjGlA0v/8D+dRGn4TgIzXg0Bw4+TX5dpTRRDw3b9NNihp8yc9z+t1dxpUHtAt
         ZA9g==
X-Forwarded-Encrypted: i=1; AJvYcCVk+dgaZo0y6hVDG3WIfeTWAhwsNGqOFWpikJQ3h4MS2opm8n3x0PMNufwRaKq2tCgOKrqXmyd4h4muXWq6Hp2Cpy4aSuV4I0OK3d/DfQ1Qs10p1r8R/cc844AUdu0WvxmxXZrLH2EAUw==
X-Gm-Message-State: AOJu0YzAyZRqF3UZSorF1vSggPNBplJ/SV4kyrDySRXKvslRmK/5X9Jh
	xcXDonHQMYLeL7YAX3BHq1Lk9+OBPjfqA8eT26UG5MfjTFVTXx4IA5vl6ViQeQG2MPmGZ9GwMmv
	k0Nm626UtvRsl0JgTUkw00Jj9aUY=
X-Google-Smtp-Source: AGHT+IE+14OaOL2S1nEWF9pejEJNM+Y86qN34hhKNmuQ+PcOJOR+7Ftc71QqTn1J1VkQogD0UG7NN6abk3ewaAcfTsw=
X-Received: by 2002:a17:906:5ad0:b0:a43:900a:31c5 with SMTP id
 x16-20020a1709065ad000b00a43900a31c5mr756052ejs.4.1709281825127; Fri, 01 Mar
 2024 00:30:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
 <20240229-rk-dts-additions-v3-2-6afe8473a631@gmail.com> <823379825559bb76088c31f44f998dd3@manjaro.org>
 <CABjd4YybaQnKm+VpU_xVrCb=pxQ7oQXPHGZzn_u1w_h3yn7gwg@mail.gmail.com>
 <a8ebe39b28a34c3544481a4e43e61d2b@manjaro.org> <b16f1d40549554598a3658679ceba9bf@manjaro.org>
In-Reply-To: <b16f1d40549554598a3658679ceba9bf@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 1 Mar 2024 12:30:14 +0400
Message-ID: <CABjd4YwAq28C6gKTJKJdZQ_Fw1oEjR475oTS96xEXRj=XQ5_pg@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: rockchip: enable automatic active
 cooling on Rock 5B
To: Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:25=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> On 2024-03-01 07:17, Dragan Simic wrote:
> > On 2024-03-01 06:21, Alexey Charkov wrote:
> >> On Fri, Mar 1, 2024 at 1:25=E2=80=AFAM Dragan Simic <dsimic@manjaro.or=
g>
> >> wrote:
> >>> On 2024-02-29 20:26, Alexey Charkov wrote:
> >>> > This links the PWM fan on Radxa Rock 5B as an active cooling device
> >>> > managed automatically by the thermal subsystem, with a target SoC
> >>> > temperature of 65C and a minimum-spin interval from 55C to 65C to
> >>> > ensure airflow when the system gets warm
> >>>
> >>> I'd suggest that you replace "automatic active cooling" with "active
> >>> cooling" in the patch subject.  I know, it may seem like more of the
> >>> unnecessary nitpicking, :) but I hope you'll agree that "automatic"
> >>> is actually redundant there.  It would also make the patch subject
> >>> a bit shorter.
> >>>
> >>> Another option would be to replace "automatic active cooling" with
> >>> "automatic fan control", which may actually be a better choice.
> >>> I'd be happy with whichever one you prefer. :)
> >>
> >> Sounds good to me, thanks!
> >
> > I'm glad that you like it. :)
> >
> >>> Otherwise, please feel free to add:
> >>>
> >>> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> >>
> >> Thank you Dragan, much appreciated!
> >
> > Thank you for putting up with my nitpicking. :)
>
> Perhaps the following tag would also be deserved for this patch:
>
> Helped-by: Dragan Simic <dsimic@manjaro.org>
>
> I hope you agree. :)

Definitely! Thanks again for your feedback and contribution!

Best regards,
Alexey

