Return-Path: <linux-kernel+bounces-17694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42072825145
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76131F22DD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E545324A1F;
	Fri,  5 Jan 2024 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PUMEpirG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059F024B2F;
	Fri,  5 Jan 2024 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-595ac2b6c59so642965eaf.2;
        Fri, 05 Jan 2024 01:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704448459; x=1705053259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e1Mg7Y/nP7M4caTdak02rb9LIFCJvL4baVqQFj4wERQ=;
        b=PUMEpirG08zorAYYSwyOdpv13SIngFZcEI2NHiRx17uX7pxI3lBrbYKkdCg5IgmWNS
         F4dPu1XXCzI33NNPBbIL+nY5NxSMQMis2NQ3d632PoYLZwoZ8q4TOB0Vc7oWQMCQPsY2
         9XNVDi4rAOfTLyt1LfrVizhVugKoqN+fm4Rh1tGzcLCbup629IJn1BZF/Msv6I4vwWrH
         cCw9rD8TW8Owg899VFhlVEJwWyFs8dMpqgTDAC2zBxF2BcEdMfl9cr1Qv2SB2VAVEZ4n
         obipqAIQeJNmGnMtc4jbh94nTN+vWHy3jqlvGza0nsYRK0LHDeYXgeiN305gcBX7UVZe
         nDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704448459; x=1705053259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e1Mg7Y/nP7M4caTdak02rb9LIFCJvL4baVqQFj4wERQ=;
        b=FsN+dQgefJp1i0sEpEa7MEXUu+6lVoLSTTgpOflhRSmvofGjTmgSHKvcjUXmmpLduE
         6C5pmmIPDlX7HeZfzJS0h5eViOvyJlpuX2459SAZaTJ4IEdQlt18JdXKnd2geqyoEmIp
         ioib5j0OZT9ixtHDP7GcD/N08/hRw1DjYh09fxkll/LFlAOykNSQHr4m4xIiBhZwSDAY
         k9b0Kj2+m7UYtGMHzeQA1ViaKu13n8vNssQe/kZhEWpfFr70IrLnkWk2+aqnQReVYIIv
         9I2oDUqqgBEB0X8RUJYBDhiz7AB2xhmVdKOlRhUTu3bUU76Y7cWhWurE3D4VdKSDNCG6
         2qUw==
X-Gm-Message-State: AOJu0YzjUKPfimy5eMVmm8iFz02gwgUQjLyz3C192U4cs1KJSFImwOf6
	72kwcjoWXVc2Da6E7Pi715/9P1+Tpn+jZMqShXY=
X-Google-Smtp-Source: AGHT+IGyjUIs1c4ftPJrLJrn6fR51rDLSeVBfUA+oYT8voFLb3g11UdVbkDpZryF+d9cEbpPCKH476QlrovJ32K1Hkw=
X-Received: by 2002:a4a:98a6:0:b0:596:31c6:c13c with SMTP id
 a35-20020a4a98a6000000b0059631c6c13cmr729367ooj.12.1704448458555; Fri, 05 Jan
 2024 01:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
 <20231229090643.116575-4-qiujingbao.dlmu@gmail.com> <942d79d0-08a8-4cda-90de-57daa44d9dd7@linaro.org>
 <CAJRtX8Rv0Ws=fcgDf2jh6GRz3ba+CkjH4u6JUPZnN61-CqqzZA@mail.gmail.com>
 <73dc5e85-0442-4b48-8abb-4a323403f3c0@linaro.org> <CAJRtX8QKyGDrCa_L8YY_Bsy3TTJsfw0LOt2T8uLWEfKE9QrQDg@mail.gmail.com>
 <5cdd7549-1b44-4612-b020-84ce5a24e15a@linaro.org>
In-Reply-To: <5cdd7549-1b44-4612-b020-84ce5a24e15a@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Fri, 5 Jan 2024 17:54:07 +0800
Message-ID: <CAJRtX8Q+MpR=SOfZC-_FEBRF7f4UByx+1wVO-761Fs=y9=HCMA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] dt-bindings: mfd: sophgo: add misc MFD for Sophgo
 CV1800 series SoC.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 8:03=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 04/01/2024 12:42, Jingbao Qiu wrote:
> ties: false
> >>>>> +
> >>>>> +examples:
> >>>>> +  - |
> >>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>>>> +
> >>>>> +    misc@5025000 {
> >>>>
> >>>>
> >>>> misc can be anything.
> >>>
> >>> Actually, there are RTC and (Power On Reset/POR) here. I can't find a=
 suitable
> >>> word to describe him. Can you give me some advice?
> >>
> >> Then maybe just rtc? If there is nothing else, why RTC is separate sub=
node?
> >>
> >
> > There is also a por submodule used to provide power off and restart fun=
ctions.
> > Do you mean to use RTC as the parent node like this.
> > rtc{
> >     //something
> >     por{
> >     }
>
> por is empty in your binding, so there is little point in having it as
> subnode.

Thanks for your patient reply. I will remove POR from RTC and
clearly state their relationship in the description.

Best regards,
Jingbao Qiu

