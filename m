Return-Path: <linux-kernel+bounces-59739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C7984FB19
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74CBF1F22B85
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2A880C07;
	Fri,  9 Feb 2024 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="OJlo6k2S"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90B7F496
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500030; cv=none; b=SDtSK0HivDf+HugbxfP9FmAklVwMIcYYKDDlyWcG8nwfFapKcuViT6NtFtHRv0tBizrOi+38Id9uu4GmVXYBEJEiUqL/YcEodZdahbkb+JeFe638d3C3ZlzaQb4P24NQwhSwIdzdT1tdz3w8P7biUlYUE0Hs3SosEsuYX4f6peY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500030; c=relaxed/simple;
	bh=RKyLaCYcOuKgOwJ/abfkPuR4VjhD6wnEE2iEjrY9u1w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qE66FQQoKdS4Q5nqjvOU2C6VmnaY6riS9jr3eUFeizuX+WbrbCgCti4L21qY8LuYo+acupUAEy5NEE4mnB2vyRN44eogVHO0/V1Ann7rtYFAWsp2qFVI4f987iDeYkIL4JRDT8tcnbrheYiAMZwFHoUzaUp3FSO577bxF3fKzeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=OJlo6k2S; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a35c720b8so4265671cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 09:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1707500027; x=1708104827; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+wCQrKg4lem3H6X4ivk4Tc4IVPl1/Suib/kv/2Lkog=;
        b=OJlo6k2SSsgR19STCRrIn5SG+TWHaERVAFuZ/OdfOnfpDLMWlPcrA66iy1sTEYWUhb
         uKLTNWOyiSa2+V8WZs9uz0qsRQEBBbeWE5XiKFcHSiiroaBSsZzPG0tsFphKQRbY4YSG
         ba2icxLIk5OixWyHl2zcRq5U/pKQVBPKdV29sloutvwI8oaqMfQmBMstC7KL6lHzR+YE
         6X47/569tktiFl/I+ClAlBxEQ+L5QrqlZrwi3sVzTJGiQYClEKx4tj+ae5P9L429S6La
         hMS8KJwK3ejyZGStUuK5/7WxltBjSuSd2rudlSnk6KNrc6XCTEFvg2XMMOHxefsr/VyT
         RISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707500027; x=1708104827;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t+wCQrKg4lem3H6X4ivk4Tc4IVPl1/Suib/kv/2Lkog=;
        b=sjJnYgkhX4XGzhE7A2dqfnB3OdOxPTuEzhs+yrlWtGZwb9LnvzmkVTBMC5J136ex39
         Aok50HPOQs7fi21BpCOf8R1AOfd/2JYDCHkKob6Vku0Koj34HrCtXT66N0dEQNOziojJ
         wqUEPEkeVSpW3IouCcongXTxzSNNzO0uc2DTmyJGXvSNFfwjJEztW229bYq6taLUnuNz
         jBiUZHzWWo8c2XreRDoeAQ/dt9KKtqaM9Zzkt0P69ECsJkrGVhJ1tp02cONWOTw64Wyf
         /VaBcFJaPLdrPZ2slKTIisqMWJkBt755Wf5HqWFDl0QqrbUMlNnh0PnLJ1jLSeAUn0FW
         xtKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpJ3LSVFsYO4K1PIJr6+NlP1hsZrG1RXVjQ0g59rDCINEuYh0dc4wok2mod5qrIdeWmD0v2lNDxyK0fDUPtdD4ee4+JiZu8NHTga/L
X-Gm-Message-State: AOJu0Yygwtouc9h0GbiRP0LU5hwOBKX7kkwwVTS6QklwDmCTAtG8MebI
	MlXl0cJL6vSkTivc2gPXrfu6Wr6tH174AyBOZFGbem5ov5EZ/JxrlrvCwOZyFio=
X-Google-Smtp-Source: AGHT+IFmfC8wYXUThuVw4pJuxiaKGAmNB6cqQ62NC4StBW3cIFzbVY1fXDLROlcSIm11c9lVWhN7aw==
X-Received: by 2002:a05:622a:292:b0:42c:613c:b695 with SMTP id z18-20020a05622a029200b0042c613cb695mr1237864qtw.43.1707500027307;
        Fri, 09 Feb 2024 09:33:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVPDBi6RJDjDprdH22TJkaDgQLmzHhtgrwku8zxA/WHNMafcV0jy/g7VcaklNjhRLnsmZyzEhQhBlouQQfUu0InF5BwbD6No3wo9K5Z5RIOV/fb+wY+XX4xGgsFz8VLgp7eRW2OWpkpLoyxEE8kuMx/YfJGWbSRKw24iL2SXUyjf5SohRynbnOMpeptlVmua0X4HDVL+6ANzDASsTGcZ1wMcybfj8lT36AbSKQYGEDhOkY+WOa3mursEJ1tFlpkUoGy1VA8tVv5BIkvFrI7a3GpDx1x0LL2JCfXiYr5bSmeOAjubFHwl9GQ697g6tGeh6OTJlf0kO5y6VlbpmoPMqWBmZjeq4/1Ptctp5tSAZZjq66IjNsVAbgHaxNjkFcxkvzCxWX0kjz64rM=
Received: from nicolas-tpx395.localdomain ([2606:6d00:11:3354::7a9])
        by smtp.gmail.com with ESMTPSA id z13-20020ac8454d000000b0042c00beee84sm870956qtn.43.2024.02.09.09.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 09:33:46 -0800 (PST)
Message-ID: <99bf4d6d988d426492fffc8de9015751c323bd8a.camel@ndufresne.ca>
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Brandon Brnich <b-brnich@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Nas Chung
 <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, Darren
 Etheridge <detheridge@ti.com>
Date: Fri, 09 Feb 2024 12:33:45 -0500
In-Reply-To: <20240205192003.3qns6cxqurqnnj7c@udba0500997>
References: <20240201184238.2542695-1-b-brnich@ti.com>
	 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
	 <20240202125257.p4astjuxpzr5ltjs@dragster>
	 <8091a8cf-c1c0-49b0-b136-1ad0d185aa6a@linaro.org>
	 <20240202155813.szxvi7bfp5xh7rvw@babble>
	 <adfef53c-d64e-4855-ab61-101b6fa419e5@linaro.org>
	 <20240205141255.z5kybm42qld44tdz@portfolio>
	 <20240205192003.3qns6cxqurqnnj7c@udba0500997>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Le lundi 05 f=C3=A9vrier 2024 =C3=A0 13:20 -0600, Brandon Brnich a =C3=A9cr=
it=C2=A0:
> On 08:12-20240205, Nishanth Menon wrote:
> > On 17:08-20240202, Krzysztof Kozlowski wrote:
> > > On 02/02/2024 16:58, Nishanth Menon wrote:
> > > > On 14:56-20240202, Krzysztof Kozlowski wrote:
> > > > > On 02/02/2024 13:52, Nishanth Menon wrote:
> > > > > > On 11:47-20240202, Krzysztof Kozlowski wrote:
> > > > > > > On 01/02/2024 19:42, Brandon Brnich wrote:
> > > > > > > > Wave521c has capability to use SRAM carveout to store refer=
ence data with
> > > > > > > > purpose of reducing memory bandwidth. To properly use this =
pool, the driver
> > > > > > > > expects to have an sram and sram-size node. Without sram-si=
ze node, driver
> > > > > > > > will default value to zero, making sram node irrelevant.
> > > > > > >=20
> > > > > > > I am sorry, but what driver expects should not be rationale f=
or new
> > > > > > > property. This justification suggests clearly it is not a pro=
perty for DT.
> > > > > > >=20
> > > > > >=20
> > > > > > Yup, the argumentation in the commit message is from the wrong
> > > > > > perspective. bindings are OS agnostic hardware description, and=
 what
> > > > > > driver does with the description is driver's problem.
> > > > > >=20
> > > > > > I will at least paraphrase my understanding:
> > > > > > In this case, however, the hardware block will limp along with
> > > > > > the usage of DDR (as is the current description), due to the
> > > > > > latencies involved for DDR accesses. However, the hardware bloc=
k
> > > > > > has capability to use a substantially lower latency SRAM to pro=
vide
> > > > > > proper performance and hence for example, deal with higher reso=
lution
> > > > > > data streams. This SRAM is instantiated at SoC level rather tha=
n
> > > > > > embedded within the hardware block itself.
> > > > >=20
> > > > > That sounds like OS policy. Why would different boards with the s=
ame
> > > > > component have this set differently? Based on amount of available
> > > > > memory? This, I believe, is runtime configuration because it migh=
t
> > > > > depend on user-space you run. Based on purpose (e.g. optimize for
> > > > > decoding or general usage)? Again, run-time because same hardware=
 board
> > > > > can be used for different purposes.
> > > > >=20
> > > >=20
> > > > Why is this OS policy? It is a hardware capability.
> > >=20
> > > How amount of SRAM size is hardware capability? Each hardware can wor=
k
> > > probably with 1, 2 or 100 pages.
> > >=20
> > > > Traditionally
> > > > many similar hardware blocks would have allocated local SRAM for
> > > > worst case inside the hardware block itself and don't need to use
> > > > DDR in the first place. However, for this hardware block, it has
> > > > capability to use some part of one of the many SRAM blocks in the S=
oC,
> > > > not be shared for some part of the system - so from a hardware
> > > > description perspective, we will need to call that out as to which
> > > > SRAM is available for the hardware block.
> > >=20
> > > Just because more than one device wants some memory, does not mean th=
is
> > > is hardware property. Drivers can ask how much memory available there
> > > is. OS knows how many users of memory there is, so knows how much to
> > > allocate for each device.
> > >=20
> > > >=20
> > > > Why would different boards need this differently? simply because
> > > > different cameras have different resolution and framerates - and yo=
u
> > > > dont want to pay the worst case sram penalty for all product
> > > > configuration.
> > >=20
> > > Choice of resolution and framerate is runtime choice or use-case
> > > dependent, not board level configuration, therefore amount of SRAM si=
ze
> > > to use is as well.
> >=20
> > I am arguing this is similar to what we have for remote-procs. Yes,
> > usecases usage come to a conclusion that sram size X is needed. Sure.
> > Lets even argue that sram =3D <&sram> has X+100 bytes available, so as
> > far as allocator is concerned, it can allocate. But how does the driver
> > know that 1k of that sram is already used by a remote core or some othe=
r
> > function?
> >=20
> > This is no different from a remote proc usecase, following which, I
> > wonder if "memory-region" is the right way to describe this usage? That
> > would be a very specific bucket that is made available to the driver.
> > And I'd say sram and memory-region are two mutually exclusive option?
>=20
> Wouldn't this just be a static allocation of the SRAM then? I believe
> the correct way to do this is highlighted in Rob's[0] response. This is
> also something we have done in the past[1], but I thought dynamic
> allocation was preferred method so that the VPU didn't hog a portion of
> SRAM. Seems wasteful in cases where the VPU is not being used.
>=20
> The device itself has the capability of doing runtime allocation before
> any decoder/encoder stream instances are opened. All of these opened
> streams will share this one allocated pool, meaning first open stream
> allocates and the rest share. Because of this, the goal is to allocate
> enough to meet maximum use case of VPU (4K60) or max case supported by
> the SoC itself if the SoC is unable to handle 4K60.
>=20
> Is there preferred method for dynamic SRAM allocation? I understand
> point that framerate and resolution are runtime choice, but these
> properties are not guaranteed to be known when streams are being opened.

Indeed, the driver won't know until the decoding process, the processing of=
 the
stream headers, will have started. At this point, it is too late to introdu=
ce
usage of SRAM. A "static" probe time allocation base on the selected board
capabilities seems like a fair direction, you may combine with driver param=
eter
perhaps to allow per use case customization. At least, you don't wastefully
allocate sram even when there is no driver on your OS or if the driver is n=
ever
loaded.

>=20
> If static SRAM allocation is the correct method to go, then this series
> can be ignored and I will add section in device tree and remove check
> for parameter in driver as that will now be a bug.
>=20
> [0]: https://patchwork.kernel.org/project/linux-media/patch/2024020118423=
8.2542695-1-b-brnich@ti.com/#25696671
> [1]: https://patchwork.kernel.org/project/linux-media/patch/20231108-wave=
5-v14-rebased-v14-8-0b4af1258656@collabora.com/

Ack.

> =20
> > >=20
> > > >=20
> > > > Further, Linux is not the only thing that runs on these SoCs.. thes=
e are
> > > > mixed systems with autonomous operations of uC cores who may or may=
not
> > > > (typically not) even need to communicate with MPU to state which pa=
rt of
> > > > resource they are hogging (hence the board level definition).
> > >=20
> > > OK that could be the case but I could also say choice of RTOS or any
> > > other is also board-independent.
> > --=20
> > Regards,
> > Nishanth Menon
> > Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 =
DDB5 849D 1736 249D
>=20
> Thanks,
> Brandon
>=20


