Return-Path: <linux-kernel+bounces-28815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE95830355
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10791B211E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CB814A81;
	Wed, 17 Jan 2024 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWUTyFho"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD314276;
	Wed, 17 Jan 2024 10:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705486351; cv=none; b=KB7YbEZ/Q/SHg+KtsTk2poZ/LwhZy+hO8Vi1JwHDQzMCYIHg23kJT2HXz1FNzyYo7R/DmNlFz9Bxpt0IOr142P8Ue8xhAY/ReoAst9m4p6Sa1+wJ7mDZBkHaBpaeSplWj7GxwyzC+P/NoDij2IAFW1D1O0QSK11nb7s501642Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705486351; c=relaxed/simple;
	bh=ia8LAy1qRW53Whay4jiw2TwI9CXHaMpl6mIWk44GDKI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=Z9oK/JgHVaOwKm+UKOH3SLSYENf8ISGmejEt4vlD2bCZGiAlMrE+9LwbYKWSf7Uoz5HNKveFY7iGI26Q/wPuvj5VwzBPgKAiOQZFEaF79F4w/TYEul5g5qSLzJCZRDGL+2DjkPwRzkSJ2+c9H/qTHmWU+VTrif+IjbVqbZD6OyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWUTyFho; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59502aa878aso4956572eaf.1;
        Wed, 17 Jan 2024 02:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705486348; x=1706091148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wMkS8Old4swOOf+36J4+LH8y/2w+i/lxZ0l3Z/+Jf0=;
        b=QWUTyFhofYepTG2hJcri/FjtMXvR2pPK4VnGcIVDwExpFRTJkEIt52eGqsygeD9XBk
         rmBwY+xzCsJtBZzM/xGG2JUh5SAwKQtZ51UdkQoh50rSEiUqD3j6cBz0aKzXZZD9x6zQ
         fKCVKXMjPcJAdiMzaLkhZMrM1zHCzULrkMBozotf0lq+ARInCQyYdmY1r31T8M5d2jD8
         H+Jk+xfi9LjZ4gpEz/JJpTmCtXQ+HPJZmUvcE0inTMB5m4QZxpHzBqDxiwULVAowAfhw
         pj/iKx48d7PEWYKvXySULN/z10wxjch2XARDNrZMcqNfR6MMKxLMVAcrtZboaRPzilbn
         mr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705486348; x=1706091148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wMkS8Old4swOOf+36J4+LH8y/2w+i/lxZ0l3Z/+Jf0=;
        b=XhWgR7OKWEkNn3JqzzupnESxAbORtdOwlH2Q3PTxsibLZ4Lx3ZSDGl0SIrC2SBHYfO
         rHuzENMsBscCMA7MMFMM76o3f0uBFVSwfXw0NZfD1cbTdIKsuJ3MkIa1zk0q5Ubiwg4d
         LcVw36iP/N269E68QNfQ4z8heJveCEVi8sghwfnnydpohG1YykJA5ZV6TiObWSrUkbX1
         PQfyWSOLOHx38j3Dsz3AInZDmwB7VPZQBhXnTPEd2tv7z0QdRcHQY8W/5ru+WArKcFQ4
         P6ajf1lGVpsLpyu/cF0yh8aV9mzjD7g3PfCkK7nkWoe62sZjdayPNsyr8SDyAp659FU0
         CIqw==
X-Gm-Message-State: AOJu0Yy1zbFUxnuKXSjlV8IHR1srINsXbKCzKLyM5GiQdMRf0SRM+u/J
	x7BAMugMWQQEowEYAaIbIwsTkvMRfXifkz80/98=
X-Google-Smtp-Source: AGHT+IF/ytADASP9nv4mHvvrF7mO9vfM7hlPVt0HZrSx1nsXTuP/wjsW+A+zw3cZjYTk0Ae4cX99UmPkDFIpQD58DkI=
X-Received: by 2002:a4a:ac89:0:b0:595:518e:be8d with SMTP id
 b9-20020a4aac89000000b00595518ebe8dmr4679587oon.0.1705486348137; Wed, 17 Jan
 2024 02:12:28 -0800 (PST)
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
 <20240116165356eaa221fe@mail.local> <CAJRtX8S9dQddoxWv9T36i852ZgX6x-kjYvrGvRNd-2cXD8B=wQ@mail.gmail.com>
 <2024011709010227b73d33@mail.local>
In-Reply-To: <2024011709010227b73d33@mail.local>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 17 Jan 2024 18:12:17 +0800
Message-ID: <CAJRtX8QJsVGfTTBSsZu0p8Q_TWG6zBK82S5BQQi_Cn7S4dBXVw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] riscv: dts: sophgo: add rtc dt node for CV1800
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 5:01=E2=80=AFPM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 17/01/2024 10:54:08+0800, Jingbao Qiu wrote:
> > On Wed, Jan 17, 2024 at 12:53=E2=80=AFAM Alexandre Belloni
> > <alexandre.belloni@bootlin.com> wrote:
> > >
> > > On 17/01/2024 00:29:28+0800, Jingbao Qiu wrote:
> > > > On Wed, Jan 17, 2024 at 12:03=E2=80=AFAM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > > >
> > > > > On 16/01/2024 16:51, Jingbao Qiu wrote:
> > > > > >>> CV1800 is a RISCV based SOC that includes an RTC module. The =
RTC
> > > > > >>> module has an OSC oscillator
> > > > > >>
> > > > > >>
> > > > > >> I am not going to read pages of description. Please write conc=
ise replies.
> > > > > >
> > > > > > Thanks, What I mean is that this hardware includes two function=
s, RTC
> > > > > > and POR. How should I describe their relationship?
> > > > >
> > > > > Your POR does not need to take any resources, so no need to descr=
ibe any
> > > > > relationship.
> > > > >
> > > > > ...
> > > > >
> > > > > >>> Your suggestion is, firstly, the por submodule does not have =
any
> > > > > >>> resources, so it should be deleted.
> > > > > >>
> > > > > >> So where did you delete it? I still see it in this patch.
> > > > > >
> > > > > > Should I completely delete him? How can a por driver obtain dev=
ice information?
> > > > >
> > > > > Delete completely.
> > > > >
> > > > > Device information? What is this? We already agreed you don't hav=
e any
> > > > > resources for POR.
> > > > >
> > > > > ....
> > > > >
> > > > > >> Device is only one thing, not two.
> > > > > >>
> > > > > >>>                     reg =3D <0x5025000 0x2000>;
> > > > > >>>                     interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> > > > > >>>                     clocks =3D <&osc>;
> > > > > >>> };
> > > > > >>> However, in reality, the POR submodule does not use IRQ and C=
LK.
> > > > > >>> Please do not hesitate to teach. Thanks.
> > > > > >>
> > > > > >> I expect one device node. How many drivers you have does not m=
atter: you
> > > > > >> can instantiate 100 Linux devices in 100 Linux device drivers.
> > > > > >
> > > > > > I understand what you mean. A device node corresponds to multip=
le drivers.
> > > > > > Should I completely delete the POR device tree node and add it =
when
> > > > > > submitting the POR driver?
> > > > >
> > > > > ? I wrote it in previous messages and twice in this thread. Compl=
etely
> > > > > delete. You do not add it back! Because if you ever intended to a=
dd it
> > > > > back, it should be added since beginning. I don't understand what
> > > > > submitting later would solve.
> > > > >
> > > > > > If that's the case, how can I explain that the rtc device tree =
node
> > > > > > uses the syscon tag?
> > > > > > How can I describe a POR device in DTS? POR is a submodule of R=
TC, and
> > > > > > it also has corresponding drivers.
> > > > >
> > > > > I said, there is no need for POR in DTS, because you have nothing=
 there.
> > > > > Why do you insist on putting it on DTS?
> > > > >
> > > > > > It's just that his resources are only shared with RTC's Reg.
> > > > >
> > > > > What resources? Reg? That's not a separate resource.
> > > >
> > > > I'm very sorry about this.
> > > > But I found a binding file that only contains Reg and Compatible.
> > > >
> > > > rtc@80920000 {
> > > > compatible =3D "cirrus,ep9301-rtc";
> > > > reg =3D <0x80920000 0x100>;
> > > > };
> > > >
> > > > Link: Documentation/devicetree/bindings/rtc/cirrus,ep9301-rtc.yaml
> > > >
> > > > >
> > > > > To summarize: Drop POR from DTS and never bring it back, unless y=
ou come
> > > > > with some different arguments, which you did not say already.
> > > > >
> > > >
> > > > You are right, if there is no por device tree node, how can the por
> > > > driver obtain the Reg?
> > >
> > > I guess the question is why don't you register everything from the RT=
C
> > > driver?
> >
> > Thanks, POR provides power off and restart functions as a child node of=
 RTC.
> > So, I think it should be placed in the power/reset directory.
>
> No it doesn't, have a look at the jz4740 rtc driver

Thank you for your suggestion.

Best regards,
Jingbao Qiu

