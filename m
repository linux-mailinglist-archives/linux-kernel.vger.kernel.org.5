Return-Path: <linux-kernel+bounces-130865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD5E897E35
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86F41C2541F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B3B2E62D;
	Thu,  4 Apr 2024 04:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iroVsgtK"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B66101E6;
	Thu,  4 Apr 2024 04:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712204856; cv=none; b=VhdIvtHfOs5YXOJHKPbAr3zOHd7i+VLfaAiUxMRhczLgGpRg0WGECp7b+EqYK96BXO0pkuEPTgB6sowKh9q4nYPDUtGI44M65dYKVOsSyI9oc2seDVsajExbPdPZiGc7URikRz6nZpcM0cCius5CYDdAbmNCQrmjvEtY6tIPhW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712204856; c=relaxed/simple;
	bh=9GCKDit7IM2ObL3AQTrHgktI46ZunWxbzR9/oDBunyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTJXRhkwCEhS7ftw6hzXnB7jLPG6E0+EwBy0JgVzg8cb76imc5xd/9AXsWVcWPAdbCaVXdUVZcCWSbzgZVLpUobiScSCKE6Jn0vXDUw+RfQpLv8/TVch/DV+/1S9yKBz1jbwNl3OKHh/XxOCS5jYRwTxKPqz8OtIXPVYJanqn0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iroVsgtK; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5a56a5f597dso342643eaf.2;
        Wed, 03 Apr 2024 21:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712204854; x=1712809654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WWP5RAoFT0kiTo+qfZyglyrEgEHCHG1QIQ9F/lt7B8E=;
        b=iroVsgtKGv79j4hU/NrvS6bv3fkZDcSu2d2ClY5M57dfC9YxJuasHiqQtJFFnD1vmT
         /2BPFkeQhS+1At/r8eu/SBJP/gRXoCu45r26b7heopHm66zqGo1/vwFLz3FS+7BviytJ
         va+7jRtfiHRsmPtaWeEpmgiwQax5muaoJGfRtQDhJ4CZ84Lp5kP7kKhuk/ALkpzmcj0d
         j3mz/iThC0LL8nSgMZNAf7yG+FaD/DgFg8FV389Dww8E0C2z/Wp089VLlYmpOgniKmJC
         EAzheaFaA9xD4cJsM8qTcCZg8okw1SCR+QVMqWYEprPQAk0YgMQ8Tfeq39uXBFMBO60J
         qBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712204854; x=1712809654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWP5RAoFT0kiTo+qfZyglyrEgEHCHG1QIQ9F/lt7B8E=;
        b=C53bfcovyFNacgN3TNmP7F1lHsNGxS3Bp56xzPxiWm61X/1wWGWh0dTa/d6Us4V8Pq
         /KmedVVsojBXpd4BF4kBk9RKOtJmezqbA/LNy7PoqbMw/lsYMjnRFgEtEKiL8bbu6AYN
         P9zFNXdp1oxrLmLuuzTHR78cgtlhZMKqjEH2chKVw4N9p3sVwStYOn6y6tfJEx1T7rq2
         6SY6p9Ik8t+eOU8PaEPoe35ipjM4rgipc4rOeLGPQH7j4cmi2ah0JAyD6wCgesiD/w9n
         xnKH5rzK1TpgVTGHS8/aizTtShRiupNSqy5lSxPgJLgzqu1H35/0ET3mb77nvWT3bpJr
         dqrA==
X-Forwarded-Encrypted: i=1; AJvYcCWGMuJxDy6ZMSSHhZyRpEG02B6pE+gWEfw41GtSjozgNMIFn3vg/GPKeT4X4g3d18Z/Q3sBTDC/hKhZcn/Bq1mYbGVlnTxDe57T5XaVL5SNq4z6FLRr8QRWMfwWwavQGPKzPeSGqV1Dhd7pvPXUF5H13JfglKWSL/k5yURcprNl9X0aZA==
X-Gm-Message-State: AOJu0Yz2OvnVoqGP1X1BmUAYSN0sB34yiXvKw7N2QPgWhC3KZmuTknMp
	6Ap83Rqz9FycThCSq5K+DLzxWIjPPlrtREPQ2t326lG3RLpt/oF05Qj75buDgvhVEZL91Fs/MtK
	7UDJN8KPMqNazAhWZc2d93134USA=
X-Google-Smtp-Source: AGHT+IFwojGdn5TFA69NQKI8EHFePsm+grycDmM/kwemTgKo/lxJRDpk6nDdoeK1+VDGtXqMUJ0Dsn4FbyEFO4nF0nc=
X-Received: by 2002:a05:6820:2012:b0:5a5:639a:2faa with SMTP id
 by18-20020a056820201200b005a5639a2faamr1825200oob.2.1712204854408; Wed, 03
 Apr 2024 21:27:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204144429.45197-1-linux.amoon@gmail.com> <20231204144429.45197-2-linux.amoon@gmail.com>
 <20231206135311.GA2043711-robh@kernel.org> <CANAwSgTS0ZSFPv4x803pCLEpjH5imh8vEoWpbiJRH14Sy3GZww@mail.gmail.com>
 <21673bfd-bb87-4c7d-a53f-337c263f3a00@linaro.org> <CANAwSgSo37B0zg-xjrmqndSZ5SbyB3m27_wRsqqN9WTONooeiw@mail.gmail.com>
 <604e653d-c1e2-45c7-b121-8a6b4be5c6bb@linaro.org> <CANAwSgRB=XWo2-40rDru=Zy277-kgGNjozJ8Lxnxgv_4ABB-kg@mail.gmail.com>
 <1a78d453-62a2-410a-a40f-1ff0c2b62e86@linaro.org> <CANAwSgTy4N7Q8e0OQLsFRkRDWksTSbkOetKQGygaqsQ8++U1_g@mail.gmail.com>
 <2e688f4e-11d7-4f8e-b8ec-58f4a97304a8@linaro.org> <CANAwSgQstkS-SDaV2hj0fimt7vgfEgOT_x4efshZ6sZQ0gWSEA@mail.gmail.com>
 <8f28ea77-b3d0-445e-8d8e-80f980775f89@linaro.org> <CANAwSgRLORHb6qiHWRBR0tMbYB=O=gwatuGhk72SwZyhYMopCw@mail.gmail.com>
 <d2962ffb-badd-44a6-bdcc-53e15d4a4379@linaro.org> <CANAwSgSpuh-+HFYg2UTgX27SHFyCBddV46MgKakiSCOtFX4+aw@mail.gmail.com>
 <436ed6a4-2ed9-47bc-bcc9-18a52b1a791b@linaro.org> <CANAwSgS8ip+FvuvgusjNwnVL5Z68PRmEdwfQxhst_ZoVZFoFNw@mail.gmail.com>
In-Reply-To: <CANAwSgS8ip+FvuvgusjNwnVL5Z68PRmEdwfQxhst_ZoVZFoFNw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 4 Apr 2024 09:57:18 +0530
Message-ID: <CANAwSgSftb3KkXvzNyGGixVtK8SWcOYjxO9WWpLt-B3mf_B6tg@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: usb: Add the binding example for the
 Genesys Logic GL3523 hub
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Icenowy Zheng <uwu@icenowy.me>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-amlogic@lists.infradead.org, Conor Dooley <conor.dooley@microchip.com>, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 12 Dec 2023 at 18:47, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Krzysztof,
>
> On Tue, 12 Dec 2023 at 18:39, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 12/12/2023 13:51, Anand Moon wrote:
> > > Hi Krzysztof,
> > >
> > > On Tue, 12 Dec 2023 at 17:22, Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 12/12/2023 12:37, Anand Moon wrote:
> > >>>
> > >>> Here is the list of warnings I observed with this patch
> > >>>
> > >>>   DTC_CHK Documentation/devicetree/bindings/usb/nvidia,tegra186-xusb.example.dtb
> > >>> /home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> > >>> hub@1: 'vdd-supply' is a required property
> > >>
> > >> You always require the property, but it is not valid for some devices.
> > >> Just require it only where it is applicable (in if:then: clause).
> > >>
> > > I had already done this check many times before.
> >
> > I don't ask you to check. I ask you to change the code.
> >
> I have tried this and it's not working for me.
>
> > > my v6 original patch was doing the same and it passed all the tests
> > > but since I updated the required field it not parsing correctly.
> >
> > Your original v6 patch was different. I don't understand what you are
> > trying to achieve. Or rather: how is it different, that my simple advice
> > above does not work for you  (as in the past you reply with some really
> > unrelated sentence).
> >
> Ok, It's my poor English grammar, thanks for your review comments.
>
> > Best regards,
> > Krzysztof
> >

Any reason this device tree binding got removed,I cannot find this file
Can not find the commit which removed this file.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/usb?h=v6.9-rc2

Thanks
-Anand

