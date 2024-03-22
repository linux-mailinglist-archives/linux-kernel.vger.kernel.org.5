Return-Path: <linux-kernel+bounces-111664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 312B8886F3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0CA2815CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8EF4C601;
	Fri, 22 Mar 2024 14:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="SZOUo6hk"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997864E1B3
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119437; cv=none; b=BBS0rshuuMsbBv+/rsoX1rJrFl4+GuVHWA0SqvOGeX3I4tI4mJiFZWBClLP37RN/Dp3fCSmt6FDtLk6CNO/ll2ORjtJNa8JPJdAoORjJ2LkcLLX2kt082qUiVJ+l/lRFrLAX2Vy16sc9FgCd1Omed9NCbc1/+uMweKhGxBZj+Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119437; c=relaxed/simple;
	bh=o3JhQ0qHV6zswN/4yjEibtmn3jJU5IgKzMreC96p6CA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKShhoFj6uHB3Dg4CQ3LzCh5adhqDm0BzUrtwGf7drr0uiQ7g+vkempOOZhjE9DzO4I6Zo1gVTvp1awtvHB/1+hHxy2Fo49x2xxRwdOQ2UfTTUMiKOBmqfRS0HY9TLklM/++Z3ccW0L195sxG0NjJTOchd6KxbpIkl4a5pawTqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=SZOUo6hk; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7e06168551eso810147241.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1711119434; x=1711724234; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZorJDZHV3S35zuqaxSThGm8XOeoTPpTjb5tz8dN4eJI=;
        b=SZOUo6hk10idlRynBULMmc/Rbt45OmvAHDJMDTPPdAWA8BcBU2CQG2dQyZ/k9nO9Vv
         SD57nMn7c0RQezGdNgJkj3KumUN3j+McF6FNyYLzjafOjaPwqf/zMF4rKRBMYrp7e4Wr
         GM7UmFbfVlf7+IRbUfxBlaYiuWBFJJN7JCSEgG/mnTl08Ecny3jSBRDwya8lC1+rpBzs
         PQE9r/zJMHfIx/4gQXrda3QHNwthL0G1mlMrXCXtvE7jG/HXRvD8Oipq09CT01LesuLg
         JIdWqjoEBkRDJH6fVXgV1vm86l7E0h1UJu8iLicVfst2UiWlFzS+gt2mx28+JHCiMWtd
         jyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711119434; x=1711724234;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZorJDZHV3S35zuqaxSThGm8XOeoTPpTjb5tz8dN4eJI=;
        b=eyg+RQyV2FaBUr/vJiFqU4K/JP7OyEP8hwXb7XJ6A6SE2zo7aoy0HllyHLSORzJ5ta
         pLDnGoEBX9egpAfOV7WlGqTyytqNs+7m/2qnGweunEpxtBiSVGktlcN+2JUcqJYBCEMw
         lvOfwemrFeLjJaU+BuR4qB37M+AvxMtJDMP22gdZLE8ftjsjZ5/i5ymhXrty5wb0r69n
         fCXSDjEqSfRcfoGeimQpqMWiKdEz89rTTgLqU6HvQV2eVJFjcht4DfgE/tgLtbrTdzbd
         G3lHhkgJ7s72ICjdBe708o0XHoPQJoDWf07ql5/j5l1n771CCycoT4j4d5a/F6ew1UAk
         xsJA==
X-Forwarded-Encrypted: i=1; AJvYcCW8pFG1GZA51K0pGOfX9tqgDRIVKWg4WQWNo9AHd+1RVPem/suoy1gzmKt4yQ9CDqZBCXvaZ33D6VzLdyqLUd5YlSd6256ke+5mEW3D
X-Gm-Message-State: AOJu0YzvAdtAPawSOcRzYV89NkHSCn579AbpV28efBOBDtrSR00OXC/P
	KQo5PVITsYfjiTzX2g5zV1kkDiIvllwU0jaL2Azcoc5nEcjKSB68YrSjEMgE5Y8=
X-Google-Smtp-Source: AGHT+IF7KOamQ/ZSV2W2kGIMahMBrt6DfYcXh8dFA2yNq70TGAUvTUROE3goyGZT3KN/zY040q01ew==
X-Received: by 2002:a05:6102:1789:b0:476:577f:aad8 with SMTP id je9-20020a056102178900b00476577faad8mr2952736vsb.14.1711119434492;
        Fri, 22 Mar 2024 07:57:14 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:10:d05::7a9])
        by smtp.gmail.com with ESMTPSA id e10-20020a37db0a000000b00789fc91dcf1sm816098qki.87.2024.03.22.07.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 07:57:14 -0700 (PDT)
Message-ID: <f490bd15fd8ee36cd3e759483bbcfb3288cace74.camel@ndufresne.ca>
Subject: Re: [PATCH 2/4] media: dt-binding: media: Document
 =?UTF-8?Q?rk3588=E2=80=99s?= vepu121
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Emmanuel Gil Peyrot
 <linkmauve@linkmauve.fr>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Philipp Zabel
 <p.zabel@pengutronix.de>, Mauro Carvalho Chehab <mchehab@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Cristian Ciocaltea
 <cristian.ciocaltea@collabora.com>, Dragan Simic <dsimic@manjaro.org>, 
 Shreeya Patel <shreeya.patel@collabora.com>, Chris Morgan
 <macromorgan@hotmail.com>, Andy Yan <andy.yan@rock-chips.com>, Nicolas
 Frattaroli <frattaroli.nicolas@gmail.com>,  linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org,  devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,  iommu@lists.linux.dev
Date: Fri, 22 Mar 2024 10:57:12 -0400
In-Reply-To: <2798331.BEx9A2HvPv@diego>
References: <20240320173736.2720778-1-linkmauve@linkmauve.fr>
	 <855507987.0ifERbkFSE@diego>
	 <70439a01-7949-46bf-a701-c82ba961171a@linaro.org>
	 <2798331.BEx9A2HvPv@diego>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le jeudi 21 mars 2024 =C3=A0 10:32 +0100, Heiko St=C3=BCbner a =C3=A9crit=
=C2=A0:
> Am Donnerstag, 21. M=C3=A4rz 2024, 10:19:54 CET schrieb Krzysztof Kozlows=
ki:
> > On 21/03/2024 09:47, Heiko St=C3=BCbner wrote:
> > > > >      enum:
> > > > >        - rockchip,rk3568-vepu
> > > > > +      - rockchip,rk3588-vepu121
> > > >=20
> > > > What is 121?
> > >=20
> > > That is the strange naming of the ip block inside the soc.
> > >=20
> > > I.e. the rk3588 TRM lists a number of different video encoders and de=
coders:
> > > - VDPU121 is decoding h.263 and mpeg1,2,4
> > > - VDPU381 is decoding h.265, h.264 and some more
> > > - VDPU720 is decoding jpeg
> > > - VDPU981 decodes AV1
> > > - VEPU121 is the jpeg encoder above
> > > - VEPU580 encodes h.264 and h.265
> > >=20
> > > Each of those are separate IP blocks with their own io-memory, their =
own
> > > interrupts and their own iommus, etc.
> >=20
> > Thanks for explanation. Short introduction in commit msg would be nice
> > (e.g. VEPU121, one of two VEPU encoders). OTOH, why not documenting all
> > of them? Bindings are supposed to be as complete as possible.
>=20
> We have a concurrent series for the vdpu121 running at
>   https://lore.kernel.org/all/20240316071100.2419369-1-liujianfeng1994@gm=
ail.com
>=20
> I think not all of those encoders/decoders are based on the Hantro IP
> or at least at the moment we don't know this yet.
> Hence people adding compatibles for the blocks they have actually
> managed to run on their hardware.

Correct, on top of this legacy core, only VDPU981 (AV1 decode) is a chip fr=
om
Hantro / Verisilicon. Everything else looks like their own design and deriv=
ed
from their original rkvdec codec pack. We didn't name this AV1 decoder afte=
r VSI
brand as we didn't have the proper version information available, but we su=
spect
that is variant of their VSI9000D cores. In short, we tried to avoid docume=
nting
our speculation, even if we believe we are right.

>=20
> Bindings are supposed to be as complete as possible, but revising a wrong
> binding later is very hard. And the whole media part is full of binary li=
braries
> in the vendor kernel and has not the best documentation.

I agree with this, but I must give to RK that despite the lack of documenta=
tion,
their CODEC software is fully open-source and blob free on this platform.

>=20
> So I guess people are just cautious ;-)
>=20

exactly!

Nicolas


