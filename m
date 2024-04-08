Return-Path: <linux-kernel+bounces-134960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714C689B95D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 234EE283EE2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C63D3BB2A;
	Mon,  8 Apr 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="1ZHkJbeT"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C723BB3D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712562605; cv=none; b=sbfdWStH6ad3SUUeOYPsBcTdmP9fPx7OZ8Pxu3zkkQ2qgsrXfri+JEocwsoLlDEnssxtenqpociyxnrW0NiyYzeOQ8Dg57s9SWJhMksWuGDD4jZskafWgYPkyOEt125OLGuDlZtXO8r2yTZvi+3W1zDehSpIVf8YDlBZ2lFX1hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712562605; c=relaxed/simple;
	bh=62vWMyM9ah8wOO+7CU7SyM0WhITWK9lt/sA4APfNOvo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=En9+qNsom2/4tJMcxJwMFHVBlAQJAbdtwD36pD9ZCFz7ubi3sU2ZfnkciRdK5HSjs0iqetTdtK2sohQZx4vtrF8PEq8OhJvXX3lcS4l6YBSTU3Sw9dQZOFMQqwC1VbiDGIKdmIZiAtpVZSqM7E1GJNAaAZqSpT401KjW3VSYCb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=1ZHkJbeT; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e509baddaso772051a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 00:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1712562601; x=1713167401; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfgzFQr5Wn5nGNjOjmePsm1TRI//Puj9xojQkt54LHE=;
        b=1ZHkJbeTpAz+gh+CUHHOfINR/SX3pJAR9hMbB3wxyRUDRunYDfG5g+qzkRZouNpLqk
         aTF1FfFqY8BKsi2XpEnNPnJ6x2+CV+yLBlbY3xd1v2peLrEuGRKa0l7FNdUwuCdnFq4c
         /H4p479Zf+MLLQRzbBDDQvI67NAYI4Po7SGL3i7haDNQyck77d2+j5cNiHzA1rN6sGi4
         akb2fHCVe2nSgsABZJIWiu+Q0W43T0UWPE1ysyMTji2NAUUqGt+D5t+/N6Dm/HJmpR/I
         enscToTqvko6SQtq9IegujD9dIiX6JybwwlQCXpivGQOTCySGKZhuqEqiNyINuwpkadA
         NJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712562601; x=1713167401;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KfgzFQr5Wn5nGNjOjmePsm1TRI//Puj9xojQkt54LHE=;
        b=EeZyADC8EX+N5i89N860+uTBuS5iuprB5JQjcCcw0I+9rHvk1YE8ckq+wN3+rxRf8R
         RNQjHc6Ppx8EEpadr23kx7zAosG0bDADo0IXFNNQBwhokksLNoOxUc207dKfo2+6tDmv
         kfFGS2sthHoWN92VI5SrgofkAgm3c43KRV1r6UnPZu7bPCl094whWo8jaKLiDxfOaJ1Z
         AG4Cy+ieqsaO/chOHFmPKQGsNa+DqOSYRZ7nVmur0FHqRhDIjzaBAocUs9v6v3murgjM
         22Y/14jyYMKXkHI8CPRRgod8ckzT7/olSIPxt66bM4+bfqBKJUEB5TYrw8wAOiv7Dufy
         jTbA==
X-Forwarded-Encrypted: i=1; AJvYcCUpYZjrZ0RkdRoLqn+akcvyod3IU3fTbR98IUExSfGVTlQmxMvNWTfuRBJ7FhsuypX31WZb/+96qdGLDyygUI8ncLGchsm5OwYdaOZg
X-Gm-Message-State: AOJu0Yzp+nMD0fyds7QitbqkcoVdK/75z7aLy/c0CYXMayjNIwi07Lzb
	wH7j5hUUk1RnX8e7Y6zDNpm75aLCbnF+MST6CvzvqD/P+N9pVXSpwYmrqMSyzZY=
X-Google-Smtp-Source: AGHT+IFJUfdSA6v/lBANNp6iDa2JuX8w0cZ5BpDfKTm0N9EV+TTWcWipmjmt3PpztCVgiHFVkU3nzA==
X-Received: by 2002:a17:906:ac7:b0:a4e:5a23:24d with SMTP id z7-20020a1709060ac700b00a4e5a23024dmr5000388ejf.38.1712562601498;
        Mon, 08 Apr 2024 00:50:01 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id lx26-20020a170906af1a00b00a4e440989f5sm4079452ejb.159.2024.04.08.00.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 00:50:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Apr 2024 09:50:00 +0200
Message-Id: <D0EKRXT8JJCG.DJW8LMIPMWX5@fairphone.com>
To: "Luca Weiss" <luca.weiss@fairphone.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@linaro.org>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] arm64: dts: qcom: add USB-C orientation GPIOs
From: "Luca Weiss" <luca.weiss@fairphone.com>
X-Mailer: aerc 0.15.2
References: <20240408-hdk-orientation-gpios-v1-0-8064ba43e52a@linaro.org>
 <D0EJR77G6HF0.2LUJ3XY1YFG65@fairphone.com>
 <CAA8EJpqUz8anQ9V_Ht67DMrMXw49u9R01mHKDMxnGf-UpXrrUw@mail.gmail.com>
 <D0EJTA1YFZRW.3LWBWJC0QYQ62@fairphone.com>
In-Reply-To: <D0EJTA1YFZRW.3LWBWJC0QYQ62@fairphone.com>

On Mon Apr 8, 2024 at 9:04 AM CEST, Luca Weiss wrote:
> On Mon Apr 8, 2024 at 9:03 AM CEST, Dmitry Baryshkov wrote:
> > On Mon, 8 Apr 2024 at 10:02, Luca Weiss <luca.weiss@fairphone.com> wrot=
e:
> > >
> > > On Mon Apr 8, 2024 at 4:33 AM CEST, Dmitry Baryshkov wrote:
> > > > Populate orientation GPIOs for some of the PMIC-GLINK-based devices=
.
> > > > This leaves only FairPhone5, RB3Gen2, SC8180X Primus and SC8280XP C=
RD
> > > > without the orientation GPIOs declared.
> > >
> > > Hi Dmitry,
> > >
> > > How would I find this GPIO on the schematics, or downstream devicetre=
e?
> > > I scanned over some relevant areas but nothing jumped out at me excep=
t
> > > for the USB_PHY_PS signal coming from PM7250B CC_OUT and going into
> > > GPIO_140 of the QCM6490 - but I'm guessing this is something else?
> >
> > It is exactly that GPIO.
>
> Great, thanks! The PM7250B datasheet and my limited USB-C knowledge
> didn't help me there much ;)
>
> I'll send a patch to add it.

One thing I've noticed now is that the dt schema currently explicitly
disallows orientation-gpios for anything that's not sm8450, sm8550 or
x1e80100.

  arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dtb: pmic-glink: orientati=
on-gpios: False schema does not allow [[84, 140, 0]]
          from schema $id: http://devicetree.org/schemas/soc/qcom/qcom,pmic=
-glink.yaml#

So I'd think also this series will cause some extra validation errors if
the schema is not adjusted? Are you planning to do that?

Regards
Luca

>
> Regards
> Luca
>
> >
> > >
> > > Regards
> > > Luca
> > >
> > > >
> > > > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > ---
> > > > Dmitry Baryshkov (4):
> > > >       arm64: dts: qcom: sm8350-hdk: add USB-C orientation GPIO
> > > >       arm64: dts: qcom: sm8450-hdk: add USB-C orientation GPIO
> > > >       arm64: dts: qcom: sc8280xp-lenovo-thinkpad-x13s: add USB-C or=
ientation GPIOs
> > > >       arm64: dts: qcom: sc8180x-lenovo-flex-5g: add USB-C orientati=
on GPIOs
> > > >
> > > >  arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts        | 2 ++
> > > >  arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 2 ++
> > > >  arch/arm64/boot/dts/qcom/sm8350-hdk.dts                    | 1 +
> > > >  arch/arm64/boot/dts/qcom/sm8450-hdk.dts                    | 1 +
> > > >  4 files changed, 6 insertions(+)
> > > > ---
> > > > base-commit: 8568bb2ccc278f344e6ac44af6ed010a90aa88dc
> > > > change-id: 20240408-hdk-orientation-gpios-141bc7fd247d
> > > >
> > > > Best regards,
> > >


