Return-Path: <linux-kernel+bounces-2595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D486815F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9003A1C2102B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031544370;
	Sun, 17 Dec 2023 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuh3RPiQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8902F2A;
	Sun, 17 Dec 2023 13:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5918f11099dso1583599eaf.0;
        Sun, 17 Dec 2023 05:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702819011; x=1703423811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=43v36/wxQF9T3jsj2t8sjYdoiNr9q5A3vNTk2NP2+ik=;
        b=kuh3RPiQ14wUZAmk1WNVNDdgKyytjYldIRvPvMPPf6+pjlxlPmq7ENJQBWY689s18v
         QoF8mUGhrZZIqRR5Mhk/2N/wcO8yavC962ZWpnT72JGKaRBbiqGG3taYR+9E0rnbLGyZ
         y0U2Iu5X/ozNZ9bXTYzzpDhIWrT+Piit/UlLje6GYtPh8cx7iLAf+Cyewo2n2gqiWT/5
         0QpqwxQ4fTOzkP8LmH8iBQy+N21+wCHcE4zMDScMWVwz3qnIoRms/soQaCMbuiCSzThD
         cZyKtNtTsMxipY0izvkgvVukzOSCv/PcSgRX8vfZMawkqsJ4JCYG66XG75mXhs06NLp5
         AYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702819011; x=1703423811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=43v36/wxQF9T3jsj2t8sjYdoiNr9q5A3vNTk2NP2+ik=;
        b=LmIR6h6rapN/2aKSg9isWFvCfHOjRgYW1BoKd8GpAvuvMkqcuri/YIhVsSkquYZHvn
         porrxOdSeCYLf66gWTEVpyWvF/pRYPCNrabACfBlM7zWlGVuI+Ad2Scy4GAzSvWYKGpj
         MAOCWRZTm9UtAeKap+azs6xrX2kCt2lXIXGfcV7hfUnM3jisTfKOcbf4zrXoOTSNWwVU
         GE7bamEML0h3ntPsr67XweGIKt3+pOVd9w2aYo3dW39lQwVeybW5OinoSQQ7qf/wIv1q
         DHvcW8Ba2cAmYicLy4FGBxovtiS5hWoN6bIT3UBuNag0qHwxkZfrHHvLCVeA1Ivt6kBN
         KhCA==
X-Gm-Message-State: AOJu0YySamovOzSV1lWmO85k1E91hZc748wWprCz76HbQNkIamMjh3Dx
	6Es5jqMz6oXHmrz5bNMVjFmh+BxlCp3xTICYTYY=
X-Google-Smtp-Source: AGHT+IFPaSPm87V76Kx27E9+q4pqOpgn9y5sMFWkrnZ4gcDKVernhTdkthc9miDv1yKyHAUlPoqw6oDA+5TywHPuKgE=
X-Received: by 2002:a4a:1d86:0:b0:590:7013:af96 with SMTP id
 128-20020a4a1d86000000b005907013af96mr10326446oog.19.1702819010775; Sun, 17
 Dec 2023 05:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
 <20231217110952.78784-2-qiujingbao.dlmu@gmail.com> <20231217-wrist-flakily-db9974d8b515@spud>
In-Reply-To: <20231217-wrist-flakily-db9974d8b515@spud>
From: jingbao qiu <qiujingbao.dlmu@gmail.com>
Date: Sun, 17 Dec 2023 21:16:39 +0800
Message-ID: <CAJRtX8TQ02swRqzNfPHPrcS-MU=pBN_atjV2PFsAyJeNBF8kgA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
To: Conor Dooley <conor@kernel.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, chao.wei@sophgo.com, 
	unicorn_wang@outlook.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 8:26=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, Dec 17, 2023 at 07:09:50PM +0800, Jingbao Qiu wrote:
>
> > +  reg:
> > +    items:
> > +      - description: data register
> > +      - description: control register
>
> > +    rtc@5025000{
> > +      compatible =3D "sophgo,cv1800-rtc";
> > +      reg =3D <0x5025000 0x1000>, <0x5026000 0x1000>;
>
> Why are these two regions rather than just one, given they are located
> next to one another?
> Are they separate on one of the other devices in this family?
>
> Thanks,
> Conor.
>

I think there are two reasons, the first one is to distinguish
different logical ,
REG_ CTRL (base on 0x5025000) controls clock calibration, sleep,and other
functions, RTC_ CORE (base on 0x5026000) has basic RTC functionality,
The second is the maximum address used by RTC_CTRL (base on 0x5025000)
is 0x0ac,which is much smaller than 0x1000. Therefore, the datasheet divide=
s
it into two parts for introduction, and I also divide it into two
parts based on this
introduction.So do you suggest that I merge them together=EF=BC=9F

Best regards,
Jingbao Qiu






> > +      clocks =3D <&osc>;
> > +      interrupts =3D <17 IRQ_TYPE_LEVEL_HIGH>;
> > +    };
>

