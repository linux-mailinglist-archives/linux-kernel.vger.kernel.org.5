Return-Path: <linux-kernel+bounces-27574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16DF82F264
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C28401C23681
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ADD1C6B8;
	Tue, 16 Jan 2024 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpukmRnR"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA4B1C6A0;
	Tue, 16 Jan 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-21086556f32so211786fac.3;
        Tue, 16 Jan 2024 08:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705422580; x=1706027380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2EGnddz4HVPEzCJyDOKwQL+fRJZRBk2jtXoB7hv7LM=;
        b=GpukmRnRlfDL3rFVYNUsCDvhMKNI/5C0Os/NCg6p7CavfcRcNh+mv35N8gFbvqsxHu
         EYGSLoIMiOtpOAKqiM9pBw/lp+0F6wZnduxVvN7ObhRGGah1R7CwKImtwBQLfjct3pOP
         xEwm4VViy32BUzhIB1zkOcmkTgWteqDRlj+SgkjRHTnnLDrDvVKpdTQrgVL+YjYK9WXa
         jETKW/vIuYisq5d3CnkEHju5CqsxAh2084DNO79CPXEdxZzhhDReBZQ/s8E2mVolVx5Z
         meSKK9++gdEruk5saczDHwbmbWjhEZZMLbK1jXpvZEBTlVdSNCEA0IDM6LHntN15zBjF
         lyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705422580; x=1706027380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2EGnddz4HVPEzCJyDOKwQL+fRJZRBk2jtXoB7hv7LM=;
        b=BKhGsjP8a5JvJZMQAAhNQRofVyJLmWoW68e/5rqJEJJsk16nKiBNw3xUtRswxA223H
         jdsR9ncj278vala0SDrYGQgtA9xUNEjZvD208feiZZKjIaAu6QBGWj8PFmlJ/AHSq/kD
         MrT2erdsYd34lpA9j0jJ5Mc6Swq6gArNReGbjfmr3lKeEmfx+aRLE2UVIijgWqaXG7Vr
         hX4PiE/igtRWx0Ld8YVXfirxIm3w+le9KEkdeQIYluLZ39brfKQnUz4CLE83Y3BEY73Y
         BKShn8eknqfFWrGx6nKx0dGsPvEpoFDYZ2/8DX1e9l5VxoS1p99vDvn6qVMsHyoF5TKw
         4Hhg==
X-Gm-Message-State: AOJu0YwZttRnJ1jWrcfZXb2ViRuehfhKiuCZ97n2xKFNxrK+Tb3ecesh
	UQvT3NzhzrTJJ0q7CUKExqt74ZuhpjasyZ4G5EM=
X-Google-Smtp-Source: AGHT+IHCQhTy467LiJCm+Ces7xo8Nf4D2WYTeF8aTO9nIK+JFa2hlgRzM/t9mbpUinDQzzdaKdcYgGUSWsNvY2jNX/g=
X-Received: by 2002:a05:6871:413:b0:203:743e:ba22 with SMTP id
 d19-20020a056871041300b00203743eba22mr10223706oag.89.1705422579663; Tue, 16
 Jan 2024 08:29:39 -0800 (PST)
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
 <dfcf74a9-db76-43fe-9261-20bf7a993bc3@linaro.org>
In-Reply-To: <dfcf74a9-db76-43fe-9261-20bf7a993bc3@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 17 Jan 2024 00:29:28 +0800
Message-ID: <CAJRtX8Tkie+ykLv8L2EgBQcy9tVP5Yz-_J_eHE-9N9hjt+6gkg@mail.gmail.com>
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

On Wed, Jan 17, 2024 at 12:03=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 16/01/2024 16:51, Jingbao Qiu wrote:
> >>> CV1800 is a RISCV based SOC that includes an RTC module. The RTC
> >>> module has an OSC oscillator
> >>
> >>
> >> I am not going to read pages of description. Please write concise repl=
ies.
> >
> > Thanks, What I mean is that this hardware includes two functions, RTC
> > and POR. How should I describe their relationship?
>
> Your POR does not need to take any resources, so no need to describe any
> relationship.
>
> ...
>
> >>> Your suggestion is, firstly, the por submodule does not have any
> >>> resources, so it should be deleted.
> >>
> >> So where did you delete it? I still see it in this patch.
> >
> > Should I completely delete him? How can a por driver obtain device info=
rmation?
>
> Delete completely.
>
> Device information? What is this? We already agreed you don't have any
> resources for POR.
>
> ....
>
> >> Device is only one thing, not two.
> >>
> >>>                     reg =3D <0x5025000 0x2000>;
> >>>                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> >>>                     clocks =3D <&osc>;
> >>> };
> >>> However, in reality, the POR submodule does not use IRQ and CLK.
> >>> Please do not hesitate to teach. Thanks.
> >>
> >> I expect one device node. How many drivers you have does not matter: y=
ou
> >> can instantiate 100 Linux devices in 100 Linux device drivers.
> >
> > I understand what you mean. A device node corresponds to multiple drive=
rs.
> > Should I completely delete the POR device tree node and add it when
> > submitting the POR driver?
>
> ? I wrote it in previous messages and twice in this thread. Completely
> delete. You do not add it back! Because if you ever intended to add it
> back, it should be added since beginning. I don't understand what
> submitting later would solve.
>
> > If that's the case, how can I explain that the rtc device tree node
> > uses the syscon tag?
> > How can I describe a POR device in DTS? POR is a submodule of RTC, and
> > it also has corresponding drivers.
>
> I said, there is no need for POR in DTS, because you have nothing there.
> Why do you insist on putting it on DTS?
>
> > It's just that his resources are only shared with RTC's Reg.
>
> What resources? Reg? That's not a separate resource.

I'm very sorry about this.
But I found a binding file that only contains Reg and Compatible.

rtc@80920000 {
compatible =3D "cirrus,ep9301-rtc";
reg =3D <0x80920000 0x100>;
};

Link: Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml

>
> To summarize: Drop POR from DTS and never bring it back, unless you come
> with some different arguments, which you did not say already.
>

You are right, if there is no por device tree node, how can the por
driver obtain the Reg?
Thank you again.

Best regards,
Jingbao Qiu

