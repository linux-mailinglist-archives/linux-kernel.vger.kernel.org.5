Return-Path: <linux-kernel+bounces-130982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C54898188
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54FC91C223DB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBE13838C;
	Thu,  4 Apr 2024 06:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2NP+i3z"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033311CFB9;
	Thu,  4 Apr 2024 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212467; cv=none; b=Xd90+nWBbrRRWycT/FapeeW/oOqX7A2BB2L1dge8wfH5hVY1HIlIGAVSeq7Pu1ZUuGSYyJ7gmvzKptG4Kf5AI6n3Pu7jYwK+XG7vQ6hLf9L9GcnVvFU2qGuBcf7UK4BySjVyrNeTc/zZqt8yvI6IHKJ2qFefWJd9Rdx1APv6pOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212467; c=relaxed/simple;
	bh=FHp7gwfHIb6KDlNgXICkQODBQ/9hhhpvocf9u5mF+BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vC4nvBCLyoCxsI1JnMHw8beakARiCeZwZkjXCXeFzEq92PIwXf0n1tv0jkd54FplWRfkM2vZvIR3t14JGyTB61TwhWndhIiT0GnNYtF3ulXB3AzhSkNcTvJAXLg04QXTUBivkGNabxlC5TLHbJl+MempW9HBafCSGLZnZ0GTsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H2NP+i3z; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a4a14c52fcso387224eaf.1;
        Wed, 03 Apr 2024 23:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712212465; x=1712817265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQhelsDTj1UznWewSHonFFvxGfv5FQP2z0tCUi3eH7Q=;
        b=H2NP+i3z0l2wEIbkD+ZAXeSyNAAMr6Jb3K+g1kVKBUL3WzRrhkYVNieONpz3+hqS+3
         G/QZso9uYVywRewRWeZr4mA+HVxziC2ww2HFBSXePsly+sJs+a/DISOqQ7j+zb4PDW9p
         McrxPG4Y5X3CWCP5PHhAIPPN3NmeTlaRt+V6Z60qwDqX6kNK9RIAoTSTFs1baYW7i8Zs
         oMCLJW8044vouFu86dzUB3RLiIGJjMGr1sR6m4VXl2uNBlrXEwCHXRjWVom8MAMtvZie
         AgpLwihcqmkUQx3//KrvCbHcQO6xJooipB7j1o1Gz+YylnM79XakchCn3T6se5/1DScv
         H0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712212465; x=1712817265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQhelsDTj1UznWewSHonFFvxGfv5FQP2z0tCUi3eH7Q=;
        b=HFw9cxp0MQYVPl9U//Qg7ZixxgQ7HUOi19fSPjmPTf0HpDrWwq6Btzh0B5213GJs1v
         hg6z3M1uv07cE6QqrSR25W/rJGyrpYGuGNkfzeY6P5nj6d+FWkHX8++oiCw0K7EZ9x1V
         5f8zlpObtY/+1GC8iAjbIRos0/xuN/Ixxkuusx/CHVCYqxylsOYZcv4BEB3BjBYkz7Uy
         bK2wRF/xr9s1+wtC0xIjEVtoN4nsSLy1118e9JRpDDw6cH1ynmPql41UHLHmtJSh1F/e
         cyckDAkN/zrbhd3P7+feui8O6RTjJJONXjtj6mctjbUnHZUc1LWiBj68jPMhnRT1KoG9
         Rk0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWa8s6NOyby0oe3KhyfDlIYrHnzWBFxOlVXZPirafokPHr3FQ9j+Echx++WdqmDzNBwxplm9+KgQN2fvkD5YqcJo/q4h01EVg4UQkWTw7KUdIUHCImhOKGaJGnwDJT025qPtzc1DZQgLINZ5JcE2OM/otzEYu4Ma2G3KIAm+Aae3QkXow==
X-Gm-Message-State: AOJu0YxLxNcTRUz0L37O4ZGNKyRY9Q9LjuZgQqlfnGdP/dPbMMpkgEOs
	/iFHoGLQ4EDSUOBAXqq4algW1tZ/dUuUmrRHUVotZAfMpIYF1GhSL67ksX8qHDj6wxhJdMg+dWD
	pkOV8tj/ShMJVUMKXJ3fLTZeEMBZoVUI8
X-Google-Smtp-Source: AGHT+IEsuEN+i0n5eZx7glAwKTp1CRGVOa+m4T3Vrw7L0OzIBSke73D8YUDUXutRJgKSqj+TavU7BaByldSY86uphMc=
X-Received: by 2002:a05:6820:260c:b0:5a5:2553:5036 with SMTP id
 cy12-20020a056820260c00b005a525535036mr1454823oob.9.1712212465090; Wed, 03
 Apr 2024 23:34:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231204144429.45197-1-linux.amoon@gmail.com> <21673bfd-bb87-4c7d-a53f-337c263f3a00@linaro.org>
 <CANAwSgSo37B0zg-xjrmqndSZ5SbyB3m27_wRsqqN9WTONooeiw@mail.gmail.com>
 <604e653d-c1e2-45c7-b121-8a6b4be5c6bb@linaro.org> <CANAwSgRB=XWo2-40rDru=Zy277-kgGNjozJ8Lxnxgv_4ABB-kg@mail.gmail.com>
 <1a78d453-62a2-410a-a40f-1ff0c2b62e86@linaro.org> <CANAwSgTy4N7Q8e0OQLsFRkRDWksTSbkOetKQGygaqsQ8++U1_g@mail.gmail.com>
 <2e688f4e-11d7-4f8e-b8ec-58f4a97304a8@linaro.org> <CANAwSgQstkS-SDaV2hj0fimt7vgfEgOT_x4efshZ6sZQ0gWSEA@mail.gmail.com>
 <8f28ea77-b3d0-445e-8d8e-80f980775f89@linaro.org> <CANAwSgRLORHb6qiHWRBR0tMbYB=O=gwatuGhk72SwZyhYMopCw@mail.gmail.com>
 <d2962ffb-badd-44a6-bdcc-53e15d4a4379@linaro.org> <CANAwSgSpuh-+HFYg2UTgX27SHFyCBddV46MgKakiSCOtFX4+aw@mail.gmail.com>
 <436ed6a4-2ed9-47bc-bcc9-18a52b1a791b@linaro.org> <CANAwSgS8ip+FvuvgusjNwnVL5Z68PRmEdwfQxhst_ZoVZFoFNw@mail.gmail.com>
 <CANAwSgSftb3KkXvzNyGGixVtK8SWcOYjxO9WWpLt-B3mf_B6tg@mail.gmail.com>
 <194aa24c-2763-47e2-8ccc-1637d299c1ba@linaro.org> <CANAwSgR4zwoHUZRFmbjV9Z5kX9P_bU=HjkUokZm3eNStPXwwOw@mail.gmail.com>
In-Reply-To: <CANAwSgR4zwoHUZRFmbjV9Z5kX9P_bU=HjkUokZm3eNStPXwwOw@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 4 Apr 2024 12:04:09 +0530
Message-ID: <CANAwSgTTpJ5wiwGFHmkUTX9zyzCYaRh=2bGPBo6H8KFznmksxw@mail.gmail.com>
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

On Thu, 4 Apr 2024 at 12:02, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi,
>
> On Thu, 4 Apr 2024 at 11:42, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 04/04/2024 06:27, Anand Moon wrote:
> > > Hi Krzysztof,
> > >
> > > On Tue, 12 Dec 2023 at 18:47, Anand Moon <linux.amoon@gmail.com> wrote:
> > >>
> > >> Hi Krzysztof,
> > >>
> > >> On Tue, 12 Dec 2023 at 18:39, Krzysztof Kozlowski
> > >> <krzysztof.kozlowski@linaro.org> wrote:
> > >>>
> > >>> On 12/12/2023 13:51, Anand Moon wrote:
> > >>>> Hi Krzysztof,
> > >>>>
> > >>>> On Tue, 12 Dec 2023 at 17:22, Krzysztof Kozlowski
> > >>>> <krzysztof.kozlowski@linaro.org> wrote:
> > >>>>>
> > >>>>> On 12/12/2023 12:37, Anand Moon wrote:
> > >>>>>>
> > >>>>>> Here is the list of warnings I observed with this patch
> > >>>>>>
> > >>>>>>   DTC_CHK Documentation/devicetree/bindings/usb/nvidia,tegra186-xusb.example.dtb
> > >>>>>> /home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> > >>>>>> hub@1: 'vdd-supply' is a required property
> > >>>>>
> > >>>>> You always require the property, but it is not valid for some devices.
> > >>>>> Just require it only where it is applicable (in if:then: clause).
> > >>>>>
> > >>>> I had already done this check many times before.
> > >>>
> > >>> I don't ask you to check. I ask you to change the code.
> > >>>
> > >> I have tried this and it's not working for me.
> > >>
> > >>>> my v6 original patch was doing the same and it passed all the tests
> > >>>> but since I updated the required field it not parsing correctly.
> > >>>
> > >>> Your original v6 patch was different. I don't understand what you are
> > >>> trying to achieve. Or rather: how is it different, that my simple advice
> > >>> above does not work for you  (as in the past you reply with some really
> > >>> unrelated sentence).
> > >>>
> > >> Ok, It's my poor English grammar, thanks for your review comments.
> > >>
> > >>> Best regards,
> > >>> Krzysztof
> > >>>
> > >
> > > Any reason this device tree binding got removed,I cannot find this file
> > > Can not find the commit which removed this file.
> >
> > Use git log.
> >

I got confused with the file name and my local changes.

> > Best regards,
> > Krzysztof
> >
Thanks
-Anand

