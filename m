Return-Path: <linux-kernel+bounces-27470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D89682F0B8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01086B22A83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205001BF33;
	Tue, 16 Jan 2024 14:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OygdoxNa"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006401B976;
	Tue, 16 Jan 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bd884146e9so610244b6e.0;
        Tue, 16 Jan 2024 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705416116; x=1706020916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQ4d+SlUG6im65swBc/lE81/JJeu4tSZ2OjB3i8zM48=;
        b=OygdoxNanq0dbpjHN7wuYqbaPT9odFOHVn1PCo+TQOUDWRPw2uQHNP+7/Aehs8aNcj
         UYxzjWuMuU9SPN5yO/5XLd5uAI71Ha+HURLUyvYQ3775I3YPu8rYorcVjvN0lLzunSG1
         jdb1dbygzUrgzUQ3MrFLqE4cPLf7+oSQKYGaphcxowsNNdh295f3bQzn34NNYejQcW0i
         S5lRbseY9HM+vRxrKclHidJcIC2KsavfqNVv8ytSvIR8T+Wo6me2tYePOo1cMnqbrBpS
         GkB/ZRS4x4fj40BXmDAxqSsUwC6nr60DjAUJwKjKzCFPrLgSIlmV0apD2Ek/8vV6gVM/
         /qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705416116; x=1706020916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQ4d+SlUG6im65swBc/lE81/JJeu4tSZ2OjB3i8zM48=;
        b=qf1SRIFAMqJhRXs0O/80LTZEgsP2DR3baGoYqPcFQEl4siiSqnOsuBdyQ+w6L6ajuL
         Jm2XzfTEqlbw22cdVAC8U2FLaYpAzNgbScYOmVUKPp+5nnMFg81yRP4JhHf9OzTctGa4
         fxFgUCIPH7qNrVdM0DsCjYHfSYsV9SoOh9/pznomJOT9Zhu5NuhgvrzbPkEOqagAs96H
         SWqC7YQ0KEoIfLPMZkAwleX0lweDxc2P3dDeXuaclt61dNr1qzcwTJy1fCkoMQEzis9u
         mt9W8qbZt9y6NqxARjulI35nYVc7ArlhK3DKNeuEkuxSkdM1a8KAmf+NSqt6pGmK08Fq
         18Mw==
X-Gm-Message-State: AOJu0YzZJm1cm5aQXdVuuLQTSGZBWR3BUlKcp99HG58UFTqWtVOTD0U2
	LHuCXC8CKyhnW325Y8fwAL9Qu6N8kVHrmsKKgTw=
X-Google-Smtp-Source: AGHT+IGdN42iTr1pjIYzZRVPqpOkdba/69EuP+xiL6yzLztkZqhXPgykIy6zP7S0/jTHm/ia2tFzbofM6OSceHK7xBE=
X-Received: by 2002:a05:6870:1687:b0:203:8474:e84b with SMTP id
 j7-20020a056870168700b002038474e84bmr10287293oae.24.1705416115534; Tue, 16
 Jan 2024 06:41:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115160600.5444-1-qiujingbao.dlmu@gmail.com>
 <20240115160600.5444-4-qiujingbao.dlmu@gmail.com> <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>
In-Reply-To: <f2b3dff2-ce0d-4ddb-ad61-74abf2c3022d@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Tue, 16 Jan 2024 22:41:44 +0800
Message-ID: <CAJRtX8QFLoWnJBkepZrbneHX8qZdde=aw+zbdErVC91B=u==MA@mail.gmail.com>
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

On Tue, Jan 16, 2024 at 3:44=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/01/2024 17:06, Jingbao Qiu wrote:
> > Add the rtc device tree node to cv1800 SoC.
> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
> >  arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/=
dts/sophgo/cv1800b.dtsi
> > index df40e87ee063..66bb4a752b91 100644
> > --- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > +++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
> > @@ -119,5 +119,17 @@ clint: timer@74000000 {
> >                       reg =3D <0x74000000 0x10000>;
> >                       interrupts-extended =3D <&cpu0_intc 3>, <&cpu0_in=
tc 7>;
> >               };
> > +
> > +             rtc: rtc@5025000 {
> > +                     compatible =3D "sophgo,cv1800-rtc", "syscon";
> > +                     reg =3D <0x5025000 0x2000>;
> > +                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> > +                     clocks =3D <&osc>;
> > +             };
> > +
> > +             por {
> > +                     compatible =3D "sophgo,cv1800-por";
>
> What is this? Why is it here, how did it even appear? It misses unit
> address and reg or is clearly placed in wrong place. It seems you
> entirely ignored out previous discussion.
>
> NAK
>

I'm very sorry for wasting your time. Furthermore, we would like to
thank you for your patient response.
Let me realize the rigor of Linux kernel code. I greatly admire
this.Please allow me to briefly review
our previous discussions.

CV1800 is a RISCV based SOC that includes an RTC module. The RTC
module has an OSC oscillator
and POR submodule inside.This OSC oscillator is only for RTC use, so
it does not need to be described
as a dt node. The POR submodule provides power off/on and restart
functions for CV1800. So I need
two drivers corresponding to RTC and POR respectively. RTC requires
the use of irq and clk resources
in addition to registers, while POR only requires Reg resources. The
current problem is how to describe
the relationship between RTC and POR, and how to make registers shared
by these two drivers.

In v3, I thought RTC was an MFD device because it not only had RTC
functionality but also restart and
power on/off capabilities.So my example is shown below.

syscon@5025000 {
  compatible =3D "sophgo,cv1800b-subsys", "syscon", "simple-mfd";
  reg =3D <0x05025000 0x2000>;
  rtc {
    compatible =3D "sophgo,cv1800b-rtc";
    interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
    clocks =3D <&clk CLK_RTC_25M>;
  };
}

There were two suggestions you made at the time. Firstly, I only
described RTC and did not describe
the POR submodule. Secondly, regarding the name issue, system
controllers should not be placed
in the mfd file.Afterwards, I released the 4th version, in which I
described the POR submodule, which
is included side by side with RTC in the misc device. Then, by sharing
the register, both RTC and
POR drivers can access the registers.

misc@5025000 {
  compatible =3D "sophgo,cv1800-misc", "syscon", "simple-mfd";
  reg =3D <0x05025000 0x2000>;
  rtc  {
    compatible =3D "sophgo,cv1800-rtc";
    interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
    clocks =3D <&clk 15>;
  };
  por  {
    compatible =3D "sophgo,cv1800-por";
  };
};

Your suggestion is, firstly, the por submodule does not have any
resources, so it should be deleted.
The second issue is still the name, misc is any device.
Afterwards, I released the 5th edition. In this version, I removed the
POR submodule in RTC.

rtc@5025000 {
    compatible =3D "sophgo,cv1800-rtc", "syscon";
    reg =3D <0x5025000 0x2000>;
    interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
    clocks =3D <&clk 15>;
};

The question you raised is why syscon child nodes are used.
In this version, I will try the following methods.

rtc: rtc@5025000 {
                    compatible =3D "sophgo,cv1800-rtc", "syscon";
                    reg =3D <0x5025000 0x2000>;
                    interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
                    clocks =3D <&osc>;
};
por {
                    compatible =3D "sophgo,cv1800-por";
                    sophgo,rtc-sysreg =3D <&rtc>;
};

My idea is that this register can be accessed through the syscon tag,
RTC driver, and reboot driver.
Then complete their functions.
I'm sorry if it was due to language differences that caused my misunderstan=
ding.
Perhaps I can accomplish it through the following methods.
rtc: rtc@5025000 {
                    compatible =3D "sophgo,cv1800-rtc", "sophgo,cv1800-por"=
;
                    reg =3D <0x5025000 0x2000>;
                    interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
                    clocks =3D <&osc>;
};
However, in reality, the POR submodule does not use IRQ and CLK.
Please do not hesitate to teach. Thanks.


Best regards,
Jingbao Qiu

