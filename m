Return-Path: <linux-kernel+bounces-11888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AB881ECFB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E221F21089
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837865680;
	Wed, 27 Dec 2023 07:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbnvaZ+u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE363C6;
	Wed, 27 Dec 2023 07:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-593f7a1afd7so3016073eaf.0;
        Tue, 26 Dec 2023 23:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703662544; x=1704267344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0n+qAEBPiyG9ZBXxmkMErIapOslfZzRv1igP74DPiE=;
        b=RbnvaZ+uDCkvzRLYDXBCV6rzxHF+bZU9+Pb+eGgUz6ATQmktFKPOGm7IQsNkQh8pae
         dxuWsWEdkKvvT2xkD8luldApLt1ttgeWkzEl5cJNjgxPRnZACa6F6R0R+SZzuCaWgbrG
         +JQFJlGGf2vXCnd6aThEfR7xVtzS1IfmXi1Os7NoAUVbrvJejO0KMR6X8Li0STILU/uV
         9OJ0+nlmitDCkaVcIBH/ecVD/E5kcN3MrvWmG7HWvgCaGCcx9hs/Sjut/VQjrs5NJ8/7
         iUDHUq6oq+pncnwQ8PTdNyF8gR7OcWhjKScq250K9ZhGgLv23FJrUZFJEw9aLJ3Iobi3
         YS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703662544; x=1704267344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j0n+qAEBPiyG9ZBXxmkMErIapOslfZzRv1igP74DPiE=;
        b=tY7HC9zpQXgDnpRHunPLmD39cJgzRax5u8briubGWwZWWlk/emRFag233+8O/X2E2b
         ijV5RQXmxG8cb44FzP/DF254X9OTxJXDScSWVVyZrOtiic7KFKVgt4bnJCIDtnTmYHEB
         4mYWE/RyFKJ8MqATwv+W/HsbwtzHRe4v5fHCYhJVORa87RX/dd+R/Hp0THpYt5Ly+10u
         zBZr3+CRoIruNl4i3M+iiyTGbf3lzEdMwiKsh6pqX3e/ffH6Y+Uye5z7B9/p7kOKpIaF
         fIquPZNvLGBV6Q/YXFgKWz1l3h1Jk4oC1kjGUcSrNKCb7n336jt9O27kZ9xY8+9kfGXA
         kQ8Q==
X-Gm-Message-State: AOJu0Yw/Q2AMx78cRYpqjF0aHqAQagUqU4m2NmBRhkQtUoyrtmdq3C2i
	IeuzIHU9ERuFpxYF780OKOxo2fcR0pu6hmJhrO4=
X-Google-Smtp-Source: AGHT+IHj++fl1vcrKCff850uqq3+Lb4lfsMoerWerufL1puzucnTWFJkNfZsxOYXEnF9gb+Vcp0BeKy/2Ky0YCkjwsM=
X-Received: by 2002:a05:6820:229b:b0:591:cabb:dd91 with SMTP id
 ck27-20020a056820229b00b00591cabbdd91mr4931528oob.13.1703662544255; Tue, 26
 Dec 2023 23:35:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
 <20231226100431.331616-2-qiujingbao.dlmu@gmail.com> <8f5e5cc7-9795-4e17-8bb9-73448e960c3d@linaro.org>
In-Reply-To: <8f5e5cc7-9795-4e17-8bb9-73448e960c3d@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Wed, 27 Dec 2023 15:35:33 +0800
Message-ID: <CAJRtX8R=K6R0o-43cHfL2iKizEJYH+fGFtVj7tWFBuFN1cSsig@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: mfd: sophgo: add MFD subsys support
 for Sophgo CV1800 series SoC
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, conor+dt@kernel.org, 
	chao.wei@sophgo.com, unicorn_wang@outlook.com, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dlan@gentoo.org, 
	inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 8:18=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/12/2023 11:04, Jingbao Qiu wrote:
> > Add devicetree binding for Sophgo CV1800 SoC MFD subsys.
>
> Subject and commit msg: there is no such hardware as "MFD subsys". Is
> this a PMIC? Does not look like. You must describe here hardware, not
> Linux subsystem.
>

I don't think this is a PMIC device. the RTC restart and 8051
configure register share one
common range address, and the address have other function that power manage=
ment.
the datasheet link:
Link: https://github.com/milkv-duo/duo-files/blob/main/duo/datasheet/CV1800=
B-CV1801B-Preliminary-Datasheet-full-en.pdf
chapter: 3.9 RTC 3.12 8051 subsystem

> >
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
>
> Please mention the dependency here.

Thanks,I will fix it.

>
> >  .../bindings/mfd/sophgo,cv1800-subsys.yaml    | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/sophgo,cv1800=
-subsys.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys=
.yaml b/Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.yaml
> > new file mode 100644
> > index 000000000000..c2a071c8a2de
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/sophgo,cv1800-subsys.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/sophgo,cv1800-subsys.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800 SoC subsys controller
> > +
> > +maintainers:
> > +  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > +
> > +description:
> > +  The Sophgo CV1800 SoC subsys controller contains many functions
>
> What is "subsys"? Why is it in MFD directory? SoC components like
> system-controllers do not go to MFD.

This device has multiple different functions, because they have 8051 subsys=
tem,
so I named him "subsys". I will carefully consider and rename it.

>
> > +  for example, RTC and restart. In addition, CV1800 has an 8051
> > +  subsystem, which is configured through registers at this controller.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: sophgo,cv1800b-subsys
> > +      - const: syscon
> > +      - const: simple-mfd
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  rtc:
> > +    $ref: /schemas/rtc/sophgo,cv1800-rtc.yaml#
>
> Your patchset is not bisectable. What's more, you have dependency
> between patches, so bindings cannot go via separate trees: mfd and rtc.
> You need to make this *EXPLICIT* in the cover letter or patch changelog.

ok,I will fix it.

>
> I do not see any resources in MFD block, so why having it as separate
> node? What other devices you did not describe here? You mentioned
> restart and 8051, so where are they? Which driver implements them?
>

I'am sorry for that other drivers have not been implemented yet. I
will implement it
after rtc. They have the same address range, so I use mfd to describe them.

>
> Best regards,
> Krzysztof
>

Best regards,
Jingbao Qiu

