Return-Path: <linux-kernel+bounces-27542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D065182F1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:52:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F658B22B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37631C688;
	Tue, 16 Jan 2024 15:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ih+Sho4O"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811491C69E;
	Tue, 16 Jan 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-206689895bfso4054771fac.1;
        Tue, 16 Jan 2024 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705420313; x=1706025113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSmZUh3wUzs91A4A3CcZFPoVqjRsxTp681neAND3/Bk=;
        b=Ih+Sho4O9c/ZWgo++R8Vw21t/aAtde/C5GuuDnH6iSfBDUgfvATL/3QdCzpxJq1ZCr
         NKY+QxQdg4SDICxmZdOlcs1HaioyTaYYW64U1ns+KTYIPN8BGGXV+xEvUsw1L4yA+0VB
         KgWnZiKTSP1GPkH98sfeMyaVP5Nii7iVSo7vz3m+orhJaEOXpQAmdGPCVreBQhh7oEHv
         mArueMlJwAlO6W6tJte4tU+yzE8Nksv1l9a7kSVBbNNGL/ivLlw2X/6e9RboUkascrq3
         5e9vJkuuWRnDcvCaKCNxUrNITZkd+haVFEVWWTlAYvMGJ22qkFATSmx5jNpE2IN2Xe2e
         hMdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420313; x=1706025113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSmZUh3wUzs91A4A3CcZFPoVqjRsxTp681neAND3/Bk=;
        b=r4eXy+JIG9Q7oYOIMRRqGRuSDPDPk37CESfFHQxbmgKGxpiUJ8N0a7ZB/3MkRpAtie
         3SPEwgJPZ0VVwpw41yKAGNDryvMXQEqs16U02wRSoa1PrH1b0UzjZcHr5FTMG60+uuJS
         6ha+Y2qo07XcUJxefZOKFFn2ewFW1QvfBm5+eEEzDyMyRMWbbZbTro9acxHg8RezQsXw
         eb1jc0EL+Iwp44lO7BbJT1Gg1fFqdoCASXrF1AYVYyS3xG1yTVeLbgSu9mBgvynb52u7
         CbHVBuQQzp7JZ3ZrGcGzAIlhe6b+gs46buSb0thBBmc308tDV95TLduaQemz8HAOtuor
         xhYw==
X-Gm-Message-State: AOJu0YwQlpzIPmRrqh+u5RX6jKPLGnwhdnUKLtgJoDxcSC4llie47Mkw
	ByXbXpkSh+S3yC776rogPWlKE8ADXMQPlfCcWZw=
X-Google-Smtp-Source: AGHT+IGqv28YSzvergjY+wIibqXD5vahGcjGZUluQCWVzRqXbuA0nfLg/BK3ftH1B1CvMEXz2hSBPFtXP4NWEIHELvk=
X-Received: by 2002:a05:6870:d0c3:b0:206:c330:97d1 with SMTP id
 k3-20020a056870d0c300b00206c33097d1mr6182505oaa.3.1705420312878; Tue, 16 Jan
 2024 07:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
 <20240115160600.5444-4-qiujingbao.dlmu@gmail.com> <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>
 <CAJRtX8QFLoWnJBkepZrbneHX8qZdde=aw+zbdErVC91B=u==MA@mail.gmail.com> <007e8c14-13eb-4917-b9da-8d47d6c965c7@linaro.org>
In-Reply-To: <007e8c14-13eb-4917-b9da-8d47d6c965c7@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 16 Jan 2024 23:51:42 +0800
Message-ID: <CAJRtX8ROH4R_s1=ML5ka340PAE0SWJKK24yVWHw5gCd+7d9pkA@mail.gmail.com>
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

On Tue, Jan 16, 2024 at 11:25=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/01/2024 15:41, Jingbao Qiu wrote:
> > On Tue, Jan 16, 2024 at 3:44=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 15/01/2024 17:06, Jingbao Qiu wrote:
> >>> Add the rtc device tree node to cv1800 SoC.
> >>>
> >>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> >>> ---
> >>>  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 12 ++++++++++++
> >>>  1 file changed, 12 insertions(+)
> >>>
> >>> diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boo=
t/dts/sophgo/cv1800b.dtsi
> >>> index df40e87ee063..66bb4a752b91 100644
> >>> --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> >>> +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> >>> @@ -119,5 +119,17 @@ clint: timer@74000000 {
> >>>                       reg =3D <0x74000000 0x10000>;
> >>>                       interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_=
intc 7>;
> >>>               };
> >>> +
> >>> +             rtc: rtc@5025000 {
> >>> +                     compatible =3D "sophgo,cv1800-rtc", "syscon";
> >>> +                     reg =3D <0x5025000 0x2000>;
> >>> +                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> >>> +                     clocks =3D <&osc>;
> >>> +             };
> >>> +
> >>> +             por {
> >>> +                     compatible =3D "sophgo,cv1800-por";
> >>
> >> What is this? Why is it here, how did it even appear? It misses unit
> >> address and reg or is clearly placed in wrong place. It seems you
> >> entirely ignored out previous discussion.
> >>
> >> NAK
> >>
> >
> > I'm very sorry for wasting your time. Furthermore, we would like to
> > thank you for your patient response.
> > Let me realize the rigor of Linux kernel code. I greatly admire
> > this.Please allow me to briefly review
> > our previous discussions.
> >
> > CV1800 is a RISCV based SOC that includes an RTC module. The RTC
> > module has an OSC oscillator
>
>
> I am not going to read pages of description. Please write concise replies=
.

Thanks, What I mean is that this hardware includes two functions, RTC
and POR. How should I describe their relationship?

>
> > and POR submodule inside.This OSC oscillator is only for RTC use, so
> > it does not need to be described
> > as a dt node. The POR submodule provides power off/on and restart
> > functions for CV1800. So I need
> > two drivers corresponding to RTC and POR respectively. RTC requires
>
> This is DTS, not drivers. Please do not mix it.

Thank you, I will pay attention to it.

>
> > the use of irq and clk resources
> > in addition to registers, while POR only requires Reg resources. The
> > current problem is how to describe
> > the relationship between RTC and POR, and how to make registers shared
> > by these two drivers.
> >
> > In v3, I thought RTC was an MFD device because it not only had RTC
> > functionality but also restart and
> > power on/off capabilities.So my example is shown below.
> >
> > syscon@5025000 {
> >   compatible =3D "sophgo,cv1800b-subsys", "syscon", "simple-mfd";
> >   reg =3D <0x05025000 0x2000>;
> >   rtc {
> >     compatible =3D "sophgo,cv1800b-rtc";
> >     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> >     clocks =3D <&clk CLK_RTC_25M>;
> >   };
> > }
> >
> > There were two suggestions you made at the time. Firstly, I only
> > described RTC and did not describe
> > the POR submodule. Secondly, regarding the name issue, system
> > controllers should not be placed
> > in the mfd file.Afterwards, I released the 4th version, in which I
> > described the POR submodule, which
> > is included side by side with RTC in the misc device. Then, by sharing
> > the register, both RTC and
> > POR drivers can access the registers.
> >
> > misc@5025000 {
> >   compatible =3D "sophgo,cv1800-misc", "syscon", "simple-mfd";
> >   reg =3D <0x05025000 0x2000>;
> >   rtc  {
> >     compatible =3D "sophgo,cv1800-rtc";
> >     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> >     clocks =3D <&clk 15>;
> >   };
> >   por  {
> >     compatible =3D "sophgo,cv1800-por";
> >   };
> > };
> >
> > Your suggestion is, firstly, the por submodule does not have any
> > resources, so it should be deleted.
>
> So where did you delete it? I still see it in this patch.

Should I completely delete him? How can a por driver obtain device informat=
ion?

>
> > The second issue is still the name, misc is any device.
> > Afterwards, I released the 5th edition. In this version, I removed the
> > POR submodule in RTC.
> >
> > rtc@5025000 {
> >     compatible =3D "sophgo,cv1800-rtc", "syscon";
> >     reg =3D <0x5025000 0x2000>;
> >     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> >     clocks =3D <&clk 15>;
> > };
> >
> > The question you raised is why syscon child nodes are used.
> > In this version, I will try the following methods.
>
> "Will" is the future tense, so about which patch are we talking?

Sorry, this is my mistake.

>
> >
> > rtc: rtc@5025000 {
> >                     compatible =3D "sophgo,cv1800-rtc", "syscon";
> >                     reg =3D <0x5025000 0x2000>;
> >                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> >                     clocks =3D <&osc>;
> > };
> > por {
> >                     compatible =3D "sophgo,cv1800-por";
> >                     sophgo,rtc-sysreg =3D <&rtc>;
> > };
>
> NAK, because:
>
> "so it should be deleted."
>
>
> >
> > My idea is that this register can be accessed through the syscon tag,
> > RTC driver, and reboot driver.
>
> Again, what drivers have anything to do here?

Of course, the corresponding driver for POR can provide power on/off and
restart functions.

>
> > Then complete their functions.
> > I'm sorry if it was due to language differences that caused my misunder=
standing.
> > Perhaps I can accomplish it through the following methods.
> > rtc: rtc@5025000 {
> >                     compatible =3D "sophgo,cv1800-rtc", "sophgo,cv1800-=
por";
>
> Device is only one thing, not two.
>
> >                     reg =3D <0x5025000 0x2000>;
> >                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> >                     clocks =3D <&osc>;
> > };
> > However, in reality, the POR submodule does not use IRQ and CLK.
> > Please do not hesitate to teach. Thanks.
>
> I expect one device node. How many drivers you have does not matter: you
> can instantiate 100 Linux devices in 100 Linux device drivers.

I understand what you mean. A device node corresponds to multiple drivers.
Should I completely delete the POR device tree node and add it when
submitting the POR driver?
If that's the case, how can I explain that the rtc device tree node
uses the syscon tag?
How can I describe a POR device in DTS? POR is a submodule of RTC, and
it also has corresponding drivers.
It's just that his resources are only shared with RTC's Reg.
Looking forward to your reply.

Best regards,
Jingbao Qiu

