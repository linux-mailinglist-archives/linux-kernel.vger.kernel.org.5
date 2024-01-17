Return-Path: <linux-kernel+bounces-28604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFBE8300A0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBB91C23ADD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0649C2C6;
	Wed, 17 Jan 2024 07:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4vfPQV1"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85BBE4C;
	Wed, 17 Jan 2024 07:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477187; cv=none; b=jNLpkc8B1XuBuN5PJ9BHyp5u0snSIUS3uROPXvYukNGKUQQfjxFrNRtTlix/o5WifaEKFE6Uq4zZiGBzWezpCS1qTtvoTyiQsyoSSFTTauemZ8yJuVAHfbNnh/eJfgaMEoufuzCs12uk9gzpOu5DqDrXGptvejgyPmoxVeL+amo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477187; c=relaxed/simple;
	bh=SL3d01vukiAcAwQr9Teceq0pf76CwAOdJoe3PhM0S8Q=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=PTpeEQBlVo6zQBY9mT2MKZ8PnISC9bsx49zBObI8y+yMvjCsBK4Z4a410Y+BlU3Xt4kisMRtPzGFwMc48RHb8ePadgJnWpev/tUD0EVJx5yWkha2IHDu+hR3sGfHDPj9GFWUIVMrGgdoRbVrDqLYOSrW4OT3IovTJy0GdM9/d0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4vfPQV1; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-204dfd7a89aso4713340fac.1;
        Tue, 16 Jan 2024 23:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705477184; x=1706081984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYD5zbvtfChyDlLcJIGs/Zw02fCfi4YRD1ZA/Szr5FU=;
        b=Y4vfPQV1DsXIyI0dn/SsqRssPo8jZeKvRk6p+PWRLuQQ8BDuIeRYb2AKIV8ybN1PeL
         XOIB9XQDOWU9eD0NpME1hKUSnqImONCojBkJ+2xYfYbM2C38Fu9qYYn7VqBEHKMbjOSO
         HsDawO4vYUJ/7/SIuh1YC+6pQh8VolgOra5PZgs4QelZITgxIPl1gjvxId3BpSMVx84h
         f7gHjP6u+jFmnzfwc+GbtB2yTAFUw4MuVhBIezKRWdNVyzLpmMsAV9uHm2JW2tKt8hd9
         JCGrrhLSE0i+QTyQvd4/gOux2PzPXnSSw0e/8E5Jc+bV5oFvLIiQt0UTjy/shdB6Vam6
         J0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705477184; x=1706081984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYD5zbvtfChyDlLcJIGs/Zw02fCfi4YRD1ZA/Szr5FU=;
        b=FaMWdylEdQnshOQTPISBZEd8vAZgTv2xNsRmoJV6Pkh4WsCz+ZGYLtCAc5YprGo+dH
         N0U6V9vA2IYJIfwQmMs7ilZ4RoDt6aIQA/z/sJlsnrPo8hVZIUZJvfkiVLoGEqThTScE
         LyMIj+GblM4hKtipx4nlSi0kXxx8tV1bNJA7xnxmXZ++EiuUSWYRmxJPcOEjJ4noW7Ma
         v18dAsXTs2/DPqW5y+OVIHKl/4CeFDcp7WFxaHf0A+MQ4ta6T9j5voN+mpGyUw9yxuU5
         LOyaGTIVRe1OCn6pi8KLfDyTzF6WuZiCESE7FMyEvBwSaRjViXvm0epx6Ek1KilEb66u
         aHnw==
X-Gm-Message-State: AOJu0Yy4/dJztr86bblCR/22KzADishITqLF601CYydKcbntBiJsZpbS
	U+gmYvQZBhf5pGsVd0ZzSFizrgr8ZyPF7ZtLpfVsKzTkNh/MCFYR92YyNBWSUqJmlNaN3VaKQIh
	rHrRNx83AbTfm//mOF1Z0svJOQB0=
X-Google-Smtp-Source: AGHT+IEcv3FzT/Fdj+VChgYcLBpYuHIWnoLtDYE9bXNQy9SHNwddjEydJT1qGVRH//XUvd8Sg9X2k21JIKUSpQf70L0=
X-Received: by 2002:a05:6870:a7a1:b0:210:5f0c:ddfe with SMTP id
 x33-20020a056870a7a100b002105f0cddfemr148730oao.4.1705477183947; Tue, 16 Jan
 2024 23:39:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
 <20240115160600.5444-4-qiujingbao.dlmu@gmail.com> <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>
 <CAJRtX8QFLoWnJBkepZrbneHX8qZdde=aw+zbdErVC91B=u==MA@mail.gmail.com>
 <007e8c14-13eb-4917-b9da-8d47d6c965c7@linaro.org> <CAJRtX8ROH4R_s1=ML5ka340PAE0SWJKK24yVWHw5gCd+7d9pkA@mail.gmail.com>
 <dfcf74a9-db76-43fe-9261-20bf7a993bc3@linaro.org> <CAJRtX8Tkie+ykLv8L2EgBQcy9tVP5Yz-_J_eHE-9N9hjt+6gkg@mail.gmail.com>
 <f99da95d-a6ab-4646-8ad8-8245e275639e@linaro.org> <CAJRtX8Qxvpf_CTJG41U6JC3_qLL9raFxX3LD0LoPNhve=MDyFA@mail.gmail.com>
 <326dd12e-2d52-4d4c-8197-5d35a0c52cf5@linaro.org>
In-Reply-To: <326dd12e-2d52-4d4c-8197-5d35a0c52cf5@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 17 Jan 2024 15:39:33 +0800
Message-ID: <CAJRtX8RB9F9zm+1rEspv_ryREZKcM-8dvAPFjLDHGJcHEJuaZg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 3:28=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/01/2024 04:24, Jingbao Qiu wrote:
> > On Wed, Jan 17, 2024 at 12:58=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 16/01/2024 17:29, Jingbao Qiu wrote:
> >>> On Wed, Jan 17, 2024 at 12:03=E2=80=AFAM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 16/01/2024 16:51, Jingbao Qiu wrote:
> >>>>>>> CV1800 is a RISCV based SOC that includes an RTC module. The RTC
> >>>>>>> module has an OSC oscillator
> >>>>>>
> >>>>>>
> >>>>>> I am not going to read pages of description. Please write concise =
replies.
> >>>>>
> >>>>> Thanks, What I mean is that this hardware includes two functions, R=
TC
> >>>>> and POR. How should I describe their relationship?
> >>>>
> >>>> Your POR does not need to take any resources, so no need to describe=
 any
> >>>> relationship.
> >>>>
> >>>> ...
> >>>>
> >>>>>>> Your suggestion is, firstly, the por submodule does not have any
> >>>>>>> resources, so it should be deleted.
> >>>>>>
> >>>>>> So where did you delete it? I still see it in this patch.
> >>>>>
> >>>>> Should I completely delete him? How can a por driver obtain device =
information?
> >>>>
> >>>> Delete completely.
> >>>>
> >>>> Device information? What is this? We already agreed you don't have a=
ny
> >>>> resources for POR.
> >>>>
> >>>> ....
> >>>>
> >>>>>> Device is only one thing, not two.
> >>>>>>
> >>>>>>>                     reg =3D <0x5025000 0x2000>;
> >>>>>>>                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> >>>>>>>                     clocks =3D <&osc>;
> >>>>>>> };
> >>>>>>> However, in reality, the POR submodule does not use IRQ and CLK.
> >>>>>>> Please do not hesitate to teach. Thanks.
> >>>>>>
> >>>>>> I expect one device node. How many drivers you have does not matte=
r: you
> >>>>>> can instantiate 100 Linux devices in 100 Linux device drivers.
> >>>>>
> >>>>> I understand what you mean. A device node corresponds to multiple d=
rivers.
> >>>>> Should I completely delete the POR device tree node and add it when
> >>>>> submitting the POR driver?
> >>>>
> >>>> ? I wrote it in previous messages and twice in this thread. Complete=
ly
> >>>> delete. You do not add it back! Because if you ever intended to add =
it
> >>>> back, it should be added since beginning. I don't understand what
> >>>> submitting later would solve.
> >>>>
> >>>>> If that's the case, how can I explain that the rtc device tree node
> >>>>> uses the syscon tag?
> >>>>> How can I describe a POR device in DTS? POR is a submodule of RTC, =
and
> >>>>> it also has corresponding drivers.
> >>>>
> >>>> I said, there is no need for POR in DTS, because you have nothing th=
ere.
> >>>> Why do you insist on putting it on DTS?
> >>>>
> >>>>> It's just that his resources are only shared with RTC's Reg.
> >>>>
> >>>> What resources? Reg? That's not a separate resource.
> >>
> >> I meant, separate from the RTC. I had impression that IO space is shar=
ed
> >> or mixed with RTC? If it is separate, why it wasn't listed?
> >>
> >>>
> >>> I'm very sorry about this.
> >>> But I found a binding file that only contains Reg and Compatible.
> >>>
> >>> rtc@80920000 {
> >>> compatible =3D "cirrus,ep9301-rtc";
> >>> reg =3D <0x80920000 0x100>;
> >>> };
> >>>
> >>> Link: Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
> >>
> >> And?
> >>
> >>>
> >>>>
> >>>> To summarize: Drop POR from DTS and never bring it back, unless you =
come
> >>>> with some different arguments, which you did not say already.
> >>>>
> >>>
> >>> You are right, if there is no por device tree node, how can the por
> >>> driver obtain the Reg?
> >>
> >> The same as currently. Does your POR node has reg? No, so according to
> >> your logic it cannot obtain address space.
> >>
> >> Children Linux devices share regmap with parent device.
> >>
> >
> > Thanks, Power-On-Reset/POR driver requires Reg to complete its function=
s.
> > The compatible of POR is required in DTS to load the corresponding driv=
er.
>
> No, it is not needed. I also wrote to in previous messages to keep
> drivers out of this. They are not related to this topic and don't use
> them as arguments.
>
>
> > The POR driver was not submitted in the patch. However, this patch requ=
ires
> > the addition of RTC in DTS. Considering the future addition of POR
>
> No. Bindings *MUST BE COMPLETE*, not depend on some other drivers.
> Submit *COMPLETE* bindings for entire hardware. Then submit complete
> DTS. I don't care about the drivers and they do not have to be complete.
>
>
> > driver, I added a POR node.
> > I'm not sure why the POR node needs to be deleted, just because it
> > only has the compatible attribute?
>
> This is like a tenth message and I was explaining it multiple times. Go
> back to previous emails.
>
> > Or maybe it's because I didn't submit the POR driver, so I need to
> > delete the POR node.
>
> Please don't mention drivers anymore in this discussions. It only
> confuses you.
>
> > I found an example.
> >
> > st: timer@fffffd00 {
> >     compatible =3D "atmel,at91rm9200-st", "syscon", "simple-mfd";
> >     reg =3D <0xfffffd00 0x100>;
> >     interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH 7>;
> >     clocks =3D <&slow_xtal>;
> >     watchdog {
> >       compatible =3D "atmel,at91rm9200-wdt";
> >     };
> > };
> >
> > Link:arch/arm/boot/dts/microchip/at91rm9200.dtsi:114
> >
> > Like this, when the por driver insmod is activated, the por driver can
> > obtain the regs of the parent device.
>
> Example of what? What is the question? I found a bug in Linux, so can I
> create such bug again?
>
> This discussion is fruitless and tiresome. You are repeating the same
> issues and asking the same questions.
>

Thank you, I have been misled by historical legacy code.
I will completely delete POR. Sorry again for wasting your
time on repetitive discussions.

Best regards,
Jingbao Qiu

