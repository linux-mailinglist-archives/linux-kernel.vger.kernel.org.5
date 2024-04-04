Return-Path: <linux-kernel+bounces-130980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFA8898180
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587552881FE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3529D29D01;
	Thu,  4 Apr 2024 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS32xUXx"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168BD18E20;
	Thu,  4 Apr 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212376; cv=none; b=FACBeK5TzJbHTE6IRS/23ULK24qHZ7RlTe/VFg24xaBudPS2ThFl4MFFoKsb6rCjtUx+JDkn7ABnYiyaR/jpjju12vzVgd5mQto8CZMd9VdWjCZO9q+JJEbY3En/QLlObTuu25Jl2lWSI6W5nUMk9ydEHsyFMUqcpuK1ZC1H960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212376; c=relaxed/simple;
	bh=vGyu7fArGU4JqjHwRSLDh9Z8nvuwqu3kgPuqkn+WkM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUGUBsSUUWsYjfWf8cu1iVCYxaQECzcPke1yXuStXPQbieqen+ohJkfrR6GZIkRcamTn+fcsGQ0fXt2lKuGhRNQBpo9TYPnT2R8lEIYOLek4NgX3B3apQygKQaE2JrxpF4G+7z2hYmy1jBm/cQxfYyZviTAIrqAZkmgmlwlxEAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS32xUXx; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5a49261093cso318641eaf.3;
        Wed, 03 Apr 2024 23:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712212374; x=1712817174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pj7mtPwxXeiOI90eJ23PpfoAYasKt78w/08LA9L6e0M=;
        b=VS32xUXxZ2y08hQMWM8Nj+1Vdb+EmngZJovUgBhsilB0SNPeW35vk75CG8IAHSeNwA
         0vNxE2utES5GY7p0oixZZyYt49aae6qtpr6tvebEJrRM+85fo2VwbygMVwGOCNyG7m0T
         UIZhofkBOdp+l3mfupIYIFdtcEh1C+jeRFgESjMUEVd/yTDh5jj60ql081XTRAM7Be/C
         khvcey+7U/p2OrF8ZyKe5UAZGEl2geNvDXgir6vScgDkLjb5yw6mepAzUU2MkTw54qY4
         998Kk8iABXymHOnErufiMvIYaX0RB1yJZezem8V/UybQTR7NxW+ffGwBGRGbR/boU0M9
         Hhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712212374; x=1712817174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pj7mtPwxXeiOI90eJ23PpfoAYasKt78w/08LA9L6e0M=;
        b=pnQ7fsxBktHad0fqWf/gc7iHUI7MN86EDynv4rXSQ9i0UarpnQYxNvxsBadK2T2g2X
         nekfKKXLPT12MvMlWu0HxBq6ybZCJkdgH3fjUd6sl2iQQc86V7Y1atMiJSUjMEjE00Eu
         Apw2ZVYZiZ7thi8pJr63Bo81Q1UUKtOJJeAuwqcAjj3s1UXuieTgoyyUru15aAVRbgtB
         SH1QIwWRmI0CRn+WO/QtSBpkBOYDuGc0DWrvrk8wIKAqZWge5MT0T6eg1x+mG55AzrZl
         0jMwaipmcJowL9R8VyN1uvfybzHsTOvficnfKwb6HAAWoesPACw1x4099KoCNUDwNj2n
         YBSg==
X-Forwarded-Encrypted: i=1; AJvYcCVMSmkILP6ItqQgUMIdykxSPJ2caJdzm1g8GsGTQT7aCNkKd/tgcS2vTdpomAFGOBIARyLRRuVtm1/SS2UAlBUNAztCu8swJ0ntOIjmbwxR+iFv1qcZbAs7jrCoMlCkdgeArpf4Miivhu5ks/M/Nc+aD054G3XJhDPvFSWN3E+OA9lf7A==
X-Gm-Message-State: AOJu0YygkSFY5O1q/l5+itI+aqJYvcVBoT58rd+UHsjCaMG7SjcMQ5IF
	ULODZ9CT/JCQZ21Bl8+MuqlZQIFQABOhSklKSxZjxP2jD2plGe6EN9/kOTiAI1UxF0Ibb/6kI5F
	CbI64h9nv7+gNvhvH02e+SD19FZ8=
X-Google-Smtp-Source: AGHT+IFU298ki3F3ZIF233kDIl2xjoKCe2Kx7EDWtmHBMuzJsoYktNQbuUmvSvqD56FK9wSDx2qlDBlYsnmJPqqGGrg=
X-Received: by 2002:a4a:e911:0:b0:5a7:afa0:4a0f with SMTP id
 bx17-20020a4ae911000000b005a7afa04a0fmr1532139oob.8.1712212374215; Wed, 03
 Apr 2024 23:32:54 -0700 (PDT)
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
 <CANAwSgSftb3KkXvzNyGGixVtK8SWcOYjxO9WWpLt-B3mf_B6tg@mail.gmail.com> <194aa24c-2763-47e2-8ccc-1637d299c1ba@linaro.org>
In-Reply-To: <194aa24c-2763-47e2-8ccc-1637d299c1ba@linaro.org>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 4 Apr 2024 12:02:38 +0530
Message-ID: <CANAwSgR4zwoHUZRFmbjV9Z5kX9P_bU=HjkUokZm3eNStPXwwOw@mail.gmail.com>
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

Hi,

On Thu, 4 Apr 2024 at 11:42, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/04/2024 06:27, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > On Tue, 12 Dec 2023 at 18:47, Anand Moon <linux.amoon@gmail.com> wrote:
> >>
> >> Hi Krzysztof,
> >>
> >> On Tue, 12 Dec 2023 at 18:39, Krzysztof Kozlowski
> >> <krzysztof.kozlowski@linaro.org> wrote:
> >>>
> >>> On 12/12/2023 13:51, Anand Moon wrote:
> >>>> Hi Krzysztof,
> >>>>
> >>>> On Tue, 12 Dec 2023 at 17:22, Krzysztof Kozlowski
> >>>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>>
> >>>>> On 12/12/2023 12:37, Anand Moon wrote:
> >>>>>>
> >>>>>> Here is the list of warnings I observed with this patch
> >>>>>>
> >>>>>>   DTC_CHK Documentation/devicetree/bindings/usb/nvidia,tegra186-xusb.example.dtb
> >>>>>> /home/amoon/mainline/linux-amlogic-6.y-devel/Documentation/devicetree/bindings/usb/usb-device.example.dtb:
> >>>>>> hub@1: 'vdd-supply' is a required property
> >>>>>
> >>>>> You always require the property, but it is not valid for some devices.
> >>>>> Just require it only where it is applicable (in if:then: clause).
> >>>>>
> >>>> I had already done this check many times before.
> >>>
> >>> I don't ask you to check. I ask you to change the code.
> >>>
> >> I have tried this and it's not working for me.
> >>
> >>>> my v6 original patch was doing the same and it passed all the tests
> >>>> but since I updated the required field it not parsing correctly.
> >>>
> >>> Your original v6 patch was different. I don't understand what you are
> >>> trying to achieve. Or rather: how is it different, that my simple advice
> >>> above does not work for you  (as in the past you reply with some really
> >>> unrelated sentence).
> >>>
> >> Ok, It's my poor English grammar, thanks for your review comments.
> >>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >
> > Any reason this device tree binding got removed,I cannot find this file
> > Can not find the commit which removed this file.
>
> Use git log.
>
> Best regards,
> Krzysztof
>

