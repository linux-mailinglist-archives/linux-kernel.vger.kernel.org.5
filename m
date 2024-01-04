Return-Path: <linux-kernel+bounces-16514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52937823F8F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F75A1C203C0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 10:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7F520B39;
	Thu,  4 Jan 2024 10:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf9wynvq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DA820DCC;
	Thu,  4 Jan 2024 10:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6dc8a63cb4aso130372a34.1;
        Thu, 04 Jan 2024 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704364772; x=1704969572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwKVdXdW5gUlzbUYq6PKIihyslraOqeE1EIRqpwR3PA=;
        b=Yf9wynvqsAdGqioFJNUk1MzpcbBo7pJBU6CJEf0KZF856FXKQ7uVxZ5viKUmA1u6Wb
         qCR0miTS9ngA8yK0zaumbrmqPeM+Dd/Tz2jDt+YKyKxUtoV/h8DKVHVwIg60OuBXs/HB
         FuYrwh2auzzvp5wCTodyU/nmXBmbHdlpzBEjZ6qHKpSNCISpJog0oRdEIaadAQ2eXV7h
         7GwbeNiOcko4AXxHVnmZf7aJ+EqsfkG7wEJS8GPc24S6Sx/bwSWYEZf5E7csIscFwiDz
         Zs7ZeRryesGhytuFZN20eUHIDzccf6/A0Hc3dBxACUSMtSXKWZe3m5ljCNk9nA+YXcmk
         qBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704364772; x=1704969572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwKVdXdW5gUlzbUYq6PKIihyslraOqeE1EIRqpwR3PA=;
        b=JmKXBTjnWeVE982rix8MXRht4mY18qvAlUKdyuBIwU2M7+ZGKaL1Lb6cblN4HH11My
         zY8diQaKiavdN9yE6rs/7/Bz4sn1WTraBry9n5lCqsLJ8FPYUKjYI2D33VE5f1SstVTU
         s07uvaHsKV9G8zDRoAfXuxGsVdo7amoOGwN3EXsjXithZq9+CmDgkXGpRQMEmJYZFyQU
         I5skBNCOhASG613eJWFYPf5VIVJeZOxjjE0H9Tv2t8cZyaqAaV1gVIsh2v2rLVxb+s6i
         ii6Nge61OOetcYIJyg3IV8FsyUG+fPo6aLdah1RSqWvHILMU8VEroPkPvizzqr7sx8Eu
         E8Lg==
X-Gm-Message-State: AOJu0Yz0YTIke+upVxOQyDw4TskrfvSR/vAKo6FDmhzAdFfgsD4Xrrno
	ue6dXDo+yj/adTJPKyFalFpIbPAX3yaRRzb3EYg=
X-Google-Smtp-Source: AGHT+IEVSjSuH2lgDlz0NaGQ3mjNHk2iC9rRuFcFho0tC9gSl0WNd0vxcbLAGnARFo2saM3kDnpDOxVkKQIHQxhQ1d8=
X-Received: by 2002:a9d:6a10:0:b0:6dc:4d9e:12b4 with SMTP id
 g16-20020a9d6a10000000b006dc4d9e12b4mr114898otn.34.1704364771740; Thu, 04 Jan
 2024 02:39:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231229090643.116575-1-qiujingbao.dlmu@gmail.com>
 <20231229090643.116575-3-qiujingbao.dlmu@gmail.com> <bbc6ebbb-9ec2-48af-b57e-a4dcb531973f@linaro.org>
In-Reply-To: <bbc6ebbb-9ec2-48af-b57e-a4dcb531973f@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Thu, 4 Jan 2024 18:39:20 +0800
Message-ID: <CAJRtX8TOXjiDfcq+GOqo-nnVtTYtbRRdhpzin4izJW-PtUuBHw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] dt-bindings: power: sophgo: add Power-On-Reset/POR
 for Sophgo CV1800 series SoC.
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org, inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 4:37=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/12/2023 10:06, Jingbao Qiu wrote:
> > Add devicetree binding to describe the Power-On-Reset/POR for Sophgo CV=
1800 SoC.
>
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/su=
bmitting-patches.rst#L597
>
> Subject: Make it concise. It's way over the limit. Also, unnecessary
> full stop.
>
> This all applies to all your patches.
>

I will do that.

> >
>
> > Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > ---
>
> What changed here? Where is the changelog? Did you just ignore entire
> feedback from v3?

Actually, I separated the previous patches because there were issues
in various places.
I want to solve it bit by bit. Should I continue with the current
patch changes or return to
the previous patch?

>
> >  .../bindings/power/sophgo,cv1800-por.yaml     | 29 +++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/sophgo,cv18=
00-por.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/sophgo,cv1800-por.=
yaml b/Documentation/devicetree/bindings/power/sophgo,cv1800-por.yaml
> > new file mode 100644
> > index 000000000000..8706230a1cbc
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/sophgo,cv1800-por.yaml
> > @@ -0,0 +1,29 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/sophgo,cv1800-por.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Power-On-Reset/POR of the Sophgo CV1800 SoC
> > +
> > +maintainers:
> > +  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> > +
> > +description:
> > +  This hardware provides triggering and timing control
> > +  for chip power on, off, and reset.
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,cv1800-por
> > +
>
> Empty schema, drop entire file. You do not need it.
>

I will drop it.

Best regards,
Jingbao Qiu

> Best regards,
> Krzysztof
>

