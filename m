Return-Path: <linux-kernel+bounces-96841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0672876212
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A653283B24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4CD55788;
	Fri,  8 Mar 2024 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXmhltp3"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4814E53E32;
	Fri,  8 Mar 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709894105; cv=none; b=b5IJZL89kPGM+T3WWF1yu44X0USTqluFVg5GHd/rxTVj/NLaY0UyyOSPna5ZQrax+TCrlogz4pfuNrp6g8LvFG+qnv2PV9MVpqORGs2Kg0hO0icGqyNLbYKdmNtIbQ/xTHPLumaLI1CpoCeybSj2i6I63xvjISQiN32YqM44SGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709894105; c=relaxed/simple;
	bh=QqQo83n+faPQJamm1/JWVngSPVUeTrISrmCaha96sD4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qdF5L5h3zuzoDFCBjNoY7T5e6IKBQBRvN2RjnomhJogO7NSoJcPVETN/QD3a3bd5VrqNBNvedBs5azKM9rdYV/OW2eTm7IB2HEtzxwjmj/Zx7H9tju1PHi1+WOknlHTWPsLdkBAGigidEEexgtyBZsgVcnRdmeYTEIvwOOsk8IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UXmhltp3; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a36126ee41eso268734366b.2;
        Fri, 08 Mar 2024 02:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709894101; x=1710498901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqQo83n+faPQJamm1/JWVngSPVUeTrISrmCaha96sD4=;
        b=UXmhltp3Gvk5/0yJFpTIOjRDvlGHFsKDr1NUxkv09wuABBOIJugt3hfM4itQKCGaDJ
         darFREWWf/UPcdZIDvbKVqXCsX+NAIx5NUsA0HppbZL+JcERMD2gG4EKeC98UCC7Eehg
         QDwYQl1eXmDB9WznGMX1DGFYNpgpq8siqzLDF/f1Vvi192zuEqB88LlZjST23gbhKak0
         Mt3texRGQFq8L4NbWokVt8OR3zQaL4zP/7CyJszTUiZTFsNLEmnuMsJtoknfeVbtQoGy
         qJ1s6vcfDK3wWAYVNnRHZgX9aq84DEgAc7X2Td+mDsSYg61uB8hB/eDnJSxEs7McunOZ
         hgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709894101; x=1710498901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqQo83n+faPQJamm1/JWVngSPVUeTrISrmCaha96sD4=;
        b=ZnFEMZCezUOM1I+lT6ty+NmytA49cvgg2Gchi9ktwidA7rHveNM3930R1GcWJxcaVB
         Y8eFyZ2hkya+tsIQqNiEUXXy+kl1rMUspbut5L/I7MjUOzLUYrz8I4CPvyrmpRTCpqtM
         mssuuLbtO3j8fWgWPATw43bqX9hSsXb7NLLIqvu32W1VGOeQsxt3kHshwHfckW80ebtP
         GzrUG3jV/bNTPYsrI0UfeAdnttz4XIrLwUMDxnEiUXFToi6llNpbevd7brHHc/5Ce6un
         Fp0tNKoWiYIlQCNFpjnAuN24QlrF/LLE0dIw1KDQa+UWPZUTZx9EFFEQOmMDSp9Nt1su
         ihyg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Tu2A3w/ZyQfHWqml4l11qku21U1eSuGx11KDxjP5sQT5YQf6Q7xkIjRg9UHfjZer0mNmKb9JhrcymJIc4KwLrd9+tS0/H8Y5SYhHxoO4LzBzGDXPL7Imk2wIqbC0R4kh2CYcmYUc4XnJFsWF/kGTmz8C/5XpkKHU1Szo0rgWhlRhwpI=
X-Gm-Message-State: AOJu0YxHEn1pSp5ExgtU2Tlpofi/Wb8sYjAoMwPtg00PDruZ+Xh6eslu
	9CXT4alUEGVvpUsBzuGofpLhJksKMuKeDef2PzrViEeizXDiKMvoyJWoXxaxV0Vd3tP86kepgiy
	oZMoQvnU3tvRsbWGFn8hG8jlqCQQ=
X-Google-Smtp-Source: AGHT+IGArkGfyP86++2lyRCUOPMZVhbq1m+pSg37/vv4Q35tzjb2dqz2G8kZLpmEHr5oWdpRpd9x2BF3JZ4ErVEQsNE=
X-Received: by 2002:a17:906:4088:b0:a44:d084:926b with SMTP id
 u8-20020a170906408800b00a44d084926bmr10247290ejj.77.1709894101044; Fri, 08
 Mar 2024 02:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306235021.976083-1-chris.packham@alliedtelesis.co.nz>
 <20240306235021.976083-4-chris.packham@alliedtelesis.co.nz>
 <87edclgoon.fsf@BL-laptop> <CAHp75VfmSWH3FWEHU+bGYDuo-nt1DJhY5Fvs83A-RGrtrsgWTw@mail.gmail.com>
 <8177b94d-82c9-42b6-85eb-728dec762162@app.fastmail.com>
In-Reply-To: <8177b94d-82c9-42b6-85eb-728dec762162@app.fastmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 8 Mar 2024 12:34:24 +0200
Message-ID: <CAHp75VfiaWFricM4Or771P0LJVoFoEmQtoJo1hySo=BRS-59DQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ARM: dts: marvell: Add 7-segment LED display on x530
To: Arnd Bergmann <arnd@kernel.org>
Cc: Gregory Clement <gregory.clement@bootlin.com>, 
	Chris Packham <chris.packham@alliedtelesis.co.nz>, Andy Shevchenko <andy@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Rob Herring <robh+dt@kernel.org>, 
	krzysztof.kozlowski+dt@linaro.org, Conor Dooley <conor+dt@kernel.org>, 
	Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 12:19=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
> On Fri, Mar 8, 2024, at 10:56, Andy Shevchenko wrote:
> > On Fri, Mar 8, 2024 at 9:36=E2=80=AFAM Gregory CLEMENT
> > <gregory.clement@bootlin.com> wrote:
> >> Chris Packham <chris.packham@alliedtelesis.co.nz> writes:
> >>
> >> > The Allied Telesis x530 products have a 7-segment LED display which =
is
> >> > used for node identification when the devices are stacked. Represent
> >> > this as a gpio-7-segment device.
> >> >
> >> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>
> >> Acked-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> >>
> >> Normally, this patch should be taken in mvebu and then merged by
> >> arm-soc. However, I haven't seen any other patch touching this file (s=
o
> >> no risk of merge conflict) and I think it's too late for me to make a
> >> new pull request to arm-soc. So I'm not against it being taken with th=
e
> >> rest of the patches. However, I think it would be a good idea to see
> >> what Arnd thinks about it.
> >
> > Arnd wasn't Cc'ed, now I added him.
>
> I already have a 'late' branch for stuff that for some reason
> was too late be part of the normal pull requests but should
> still make it into 6.9. If this one is important, I don't
> mind taking it.
>
> On the other hand, from the patch description this one doesn't
> seem that urgent, so I don't see much harm in delaying it
> to v6.10, and using the normal process for it.

Thanks, I will defer this one then.
Chris, please handle this one after v6.9-rc1 is out. The first two I'm
going to take today.

--=20
With Best Regards,
Andy Shevchenko

