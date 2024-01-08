Return-Path: <linux-kernel+bounces-19253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232D4826A5B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB8F11F22B43
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A221170E;
	Mon,  8 Jan 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnBkJzYy"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F7DE570;
	Mon,  8 Jan 2024 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6dbd445f395so921764a34.2;
        Mon, 08 Jan 2024 01:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704705117; x=1705309917; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PKFUpiPpL3BLTuFv/VPd+EtUxI7pJ2kAwWfiOd5Vkb0=;
        b=MnBkJzYypGU7P6OUV/pULVfCGFTPz4pCDm0UY/MWGCFUe8oEDm3T0ajlymGi/ANwC4
         uGOtVbrOUoFMQ2qtyfXd9XBjDeh9LF0WV1WYcbd81b3Q2yuZSiFajONQrX0wkV2pDXB8
         fhi+qKrkQ8NFCCDoVU5Rqnn3EnKxZctAwg/z+FbFuXx1WxfcTu6byj+/E1XmT7WZ1sYn
         8ObLQh+OdiEGA+56iomUzIMqEedgRypDF2Ko+GnjEKOpQSFteA2oaQk6jWIy7S8afwfW
         Z+m/npOZYVo0cG1v92s1q2CGe+bJr4tRSnbmm+o7lWorhkLOXfvQzYIibHcVD5+SGPxR
         Dp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705117; x=1705309917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKFUpiPpL3BLTuFv/VPd+EtUxI7pJ2kAwWfiOd5Vkb0=;
        b=pzJSSwB2FJNHX1fNruuwCTmBTS6tI52YsgGFdvBv3b0ArtUxWBI7AL/tKuPZZAB3R4
         3VbcLr+8m2C3S5oZNZJ7xbN4mS3enjnesiVtFMLg4LGC3NL2xCUJnOvas7LoYdk4IoFu
         0CVKiT94NJ4zloe5BoOzV0/1jVx6iSIxZMGSvxJSKVmNRO+pRD936l4mwpCQtBXmBuQB
         bxymiNepPfvIGJLYQ8baC/aiJ++2AGGUI2mDxR/1nQCT/w2oa1jAwI92pYrw6SyI4Hrv
         /n9ijmYmtOjFDtnIrHIKCRxuss9IMgeNfwBte8fnnn+Xjy+1XwTJkTfOcHtIKW7XrRsV
         dFWQ==
X-Gm-Message-State: AOJu0YxZXUA1U2hfmBPXFKzuB9dYNV98lTQ2yTFmVg1b2223D/F0Wswl
	E3yPCdEHjwsZ7j9XnnTctrkSmGhyT0rDRZ4kZzQ=
X-Google-Smtp-Source: AGHT+IHn6yvGBl4B4SqRFua8cF7MkdRCNv2yRTCYFxb0q0fyGTBNqwhF+GpxirP255tCsBrm9tWHdHuSJxnNcknM1UY=
X-Received: by 2002:a05:6870:4185:b0:204:827:670e with SMTP id
 y5-20020a056870418500b002040827670emr3125137oac.74.1704705117128; Mon, 08 Jan
 2024 01:11:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
 <93695e92-233d-460c-a6bd-882b30f1dea8@linaro.org> <CAJRtX8T-88x=AeRhOVJP=1ccvOZa-nS4cDEjpSykTxFMRupKZg@mail.gmail.com>
 <7af6c688-3d3e-4cd5-bbd6-4ca323d7edde@linaro.org>
In-Reply-To: <7af6c688-3d3e-4cd5-bbd6-4ca323d7edde@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 8 Jan 2024 17:11:46 +0800
Message-ID: <CAJRtX8QzDQjMCqXw9BnWPFt5FT3qr9=95F1rpwz_795AF9oSAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] dt-bindings: riscv: sophgo: add RTC for CV1800
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 5:06=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 10:00, Jingbao Qiu wrote:
> > On Mon, Jan 8, 2024 at 4:02=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 08/01/2024 08:22, Jingbao Qiu wrote:
> >>> Real Time Clock (RTC) is an independently powered module
> >>> within the chip, which includes a 32KHz oscillator and
> >>> a Power On Reset/POR submodule. It can be used for time
> >>> display and timed alarm generation.
> >>>
> >>> Power On Reset/POR submodule only using register resources
> >>> so it should be empty. The 32KHz oscillator only provides
> >>> pulses for RTC in hardware.
> >>>
> >>>
> >>> Changes since v4:
> >>> - remove POR dt-bindings because it empty
> >>> - remove MFD dt-bindings because SoC does
> >>>   not have MFDs
> >>> - add syscon attribute to share registers
> >>>   with POR
> >>>
> >>> v4: https://lore.kernel.org/all/20231229090643.116575-1-qiujingbao.dl=
mu@gmail.com/
> >>>
> >>> Changes since v3:
> >>> - temporarily not submitting RTC driver code
> >>>   waiting for communication with IC designer
> >>
> >> Hm, why?
> >>
> >> We do not need bindings if nothing matches to them. If this binding is
> >> for other upstream open-source project, please provide references.
> >>
> >> See also:
> >> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicet=
ree/bindings/submitting-patches.rst#L61
> >>
> >
> > Hi!
> >
> > There is a function in the RTC driver code used to calibrate the
> > clock, which is define in the datasheet.
> > However, Alexandre Belloni raised concerns that clock calibration
> > should be done using GPS or similar
> > methods, rather than using other clock sources. I think what he said
> > makes sense. So it is necessary
> > to communicate with IC designers.
> >
> > link: https://lore.kernel.org/all/202312271350242a208426@mail.local/
>
> Sure, this I get, but why sending bindings alone? There is no user of the=
m.
>

Thank you for your patient reply.
May I ask if this user refers to driver code or DTS?

Best regards,
Jingbao Qiu

