Return-Path: <linux-kernel+bounces-112436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BF78879CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB871F218E9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 17:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA25337E;
	Sat, 23 Mar 2024 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gT0DGOjM"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7A056440;
	Sat, 23 Mar 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711215931; cv=none; b=eFSH9VXkrUunKjIBoU7rSRaiZkKtyUIHzw40OaqNsxPzlr8zrHk6WSG1HC78wlQO+YhrTTbNNiQWDJoYqzOfk8Lt5KS8f11EcGGsmalJetYft7vtBZhNxJrVSmIO+Fh7C65/d6Qff84o1X3FlLwyhVW8Jw3VkUM7ClVrwcrRCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711215931; c=relaxed/simple;
	bh=09Jlw6JAYNxan0UgyQwmL0W49AB8IvibjbCytlUkkmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LTHLJICnKN0TBii7o/sZcCa4EIgwd4Z1X63z3Sj/Bc476HCzogVxG0wo1H+PmmyGupcmPakjUQB0/Zshl1TS/ncJcCxpKuaLGrusH+guhANlAnFN9HfJB4/ZBWAsHirYvU1rgJL7zmVgOyHZcJiH0j7j+TL8XGfBOyu9OUZHCRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gT0DGOjM; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso3028413276.2;
        Sat, 23 Mar 2024 10:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711215929; x=1711820729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09Jlw6JAYNxan0UgyQwmL0W49AB8IvibjbCytlUkkmI=;
        b=gT0DGOjMJvCm8SPXawi+8jE4daHdbnslTFHIFtNTxR9peiEeLVJGPt5pikp09H7WNe
         WXmLq3CzVVuSfUT5ITh62/q8KliihSzK0z94/X2AP4vhqRR3aXH5+/VCt2rGPFiMASZi
         LRimtEcZPurMyZPuBLjKFer+TrtYdnEOK/0VpMK3Kdi/cs8wsxmfrPIn/2E4E7GmJ5RT
         Own4CyPkDkzK+Yy5cWHnPafqSMgM7cvwkTSjzbShuUrcE2HtZMXbwRKKlfDIlLdPxXff
         2fq5mVQs/coar/GaLPp0vmvK6+W8wGi7qNf3o3ZOZrsuhXNuEilZIbafLDV7AAS/kCma
         uMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711215929; x=1711820729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09Jlw6JAYNxan0UgyQwmL0W49AB8IvibjbCytlUkkmI=;
        b=umu0GibHo5Ur6aFdfFFiO1UFkZGMzAHr4rvRtO03bAP6cU4tWHOeoyyGGg+hsLfLav
         1rznj6ce9xQJFo6arqOnkBopVm59cUzRfLBxQyKo3ejMLY2Slpfol3yKAICfZE330hM5
         BzBRYWd7bQNJjfCAXstZZa8H/zSJaNVUZSKWqEmGM5pyJBDuUSDqHEx4n+r32OOU7vVF
         m3003dk1GXuVSHgkoN0FCO7hbl0Y0kqNFBlR442v99aRAE4AhVF8fD3Bfokgeo2Zx029
         4OsJrUkqGf/0jIVd3dorau7GpL4pqRCdCtYVcCtBpts1O+mWEq+AlS9zZb1UxBtaLkrm
         DddA==
X-Forwarded-Encrypted: i=1; AJvYcCUOdEwLhpLeyLr+uLGXhp7WCr83wdlbVpuUwVpxdZr9o+pbQIIZUl5zjDwp2uFzPq25yO7yFF5j+jrobDWAj3BJ5J4fQsUcbPESFfh8JxyzX3OxJggON1xZAQVHLr9rMDDxjfgT+UVT40BTZerh8uE5BpUu1YCTHRhtTbuffAUukDtBmg==
X-Gm-Message-State: AOJu0Yy5JqATBTHRT5iPw/8EBBRHB6b7CtqlRBardca1y0L6+CQL4oKC
	UKReSKfyyA8htEMyZMVsBl7by98NKKzqbhWkllLdvV3vJ6WYAuI3gY3jXGqfWe/GAUqlNJoGf0H
	3GGIg7exKD//0p2u6a7obmaGu/TE=
X-Google-Smtp-Source: AGHT+IEFb6YvIfpbWjIkc0eHeWpdtr2FGrRcO1jVvrslMjqGs/8hmtHC2bqq1nx/GCiXoXXoEJxM6NTxA7rIqLiBKF8=
X-Received: by 2002:a25:2690:0:b0:dd1:3cc1:5352 with SMTP id
 m138-20020a252690000000b00dd13cc15352mr2152175ybm.15.1711215928904; Sat, 23
 Mar 2024 10:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322003713.6918-1-l.rubusch@gmail.com> <20240322003713.6918-4-l.rubusch@gmail.com>
 <20240322021739.GA3418523-robh@kernel.org> <CAFXKEHYrRn+vKZB9eX_RFDLanhqLsRwT1b-wxUdeZTrBrshSzA@mail.gmail.com>
 <60ed3d61-1ece-498f-97a2-7b1c618ceacb@linaro.org>
In-Reply-To: <60ed3d61-1ece-498f-97a2-7b1c618ceacb@linaro.org>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sat, 23 Mar 2024 18:44:52 +0100
Message-ID: <CAFXKEHYVhj2yhaEjJmh+qRN8YbtN_LyeQ65YX1aL-4j7FJ=r6Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: adxl345: Add spi-3wire
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, lars@metafoo.de, Michael.Hennerich@analog.com, 
	jic23@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 23, 2024 at 3:27=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 23/03/2024 13:04, Lothar Rubusch wrote:
> > On Fri, Mar 22, 2024 at 3:17=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> >>
> >> On Fri, Mar 22, 2024 at 12:37:13AM +0000, Lothar Rubusch wrote:
> >>> Provide the optional spi-3wire in the example.
> >>
> >> That doesn't match the diff as you don't touch the example. But really=
,
> >> this should say why you need spi-3wire.
> >
> > I understand. The change does not add anything to the example. which
> > is definitely wrong.
> > Anyway I'm unsure about this change in particular. I know the spi-3wire
> > binding exists and can be implemented. Not all spi devices offer it. No=
t all
> > drivers implement it. My patch set tries to implement spi-3wire for the
> > particular accelerometer.
> > Do I need to add something here to dt-bindings documentation of the
> > adxl345? Or, as an optional spi feature, is it covered anyway by
> > documentation of optional spi bindings? So, should I refrase this parti=
cular
> > patch or may I drop it entirely? Could you please clarify.
>
> Whether you need to change bindings or not, dtbs_check will tell you.
> Just run dtbs_check on your DTS.
>

I'm not changing upstream DTS. At most, the documentation should
mention something.

> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=3D1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
> for instructions).
>

No, I didn't. dtbs_check did not work right out of the box, but it
sounds great and I will figure out. Currently my setup is a bit
customized. I compile the modules out of tree, dockerized with several
DTBOs. I use an automized setup to verify spi, spi-3wire and i2c
probing still works on the hardware. It is tested at least somehow.

> AFAIR, spi-3wire requires being explicitly mentioned in the device bindin=
gs.
>
>
> Best regards,
> Krzysztof
>

