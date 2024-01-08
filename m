Return-Path: <linux-kernel+bounces-19229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8927826A07
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 614501F24619
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD22D310;
	Mon,  8 Jan 2024 09:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGF1z/cP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D036E570;
	Mon,  8 Jan 2024 09:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-203fbbff863so811423fac.0;
        Mon, 08 Jan 2024 01:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704704458; x=1705309258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x03s0Nq9cwAwPbt6pv42AapG0mpdoAOSeTQvOKXgJlg=;
        b=HGF1z/cPjET/JdnQhnRvpiPAvotUvFKV/QoQFpI6dugqCctyUVYFYzQo48DOKyyZfP
         9b+BQZmoudgwL/e+FbWegmGm4NqsfqURALynd1hliKJ6GV2kC5H3n/3Olsdv71riIYgp
         7tMI+k9aW7G4Hyv+V2hnwl5dsCcKEXrCrhPoAPyppAopxiSHmHCDrAb5VPEdGesjJClH
         T3gkoRV37yN7Kwf342CWJW6lfDkkw41MdQcfHBuw2VTJonnm94uw/T6daTG9On0TrNqj
         8cisBsusfgTcRLNjtzOBmhJ+knhP5DzqPP83O3kD3UyUi3Qc6JpGlg+8pBJn8edT+uxN
         7jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704704458; x=1705309258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x03s0Nq9cwAwPbt6pv42AapG0mpdoAOSeTQvOKXgJlg=;
        b=m2LxI9k+HtQHO5h9ME/qEEP60iDPvKWmoLGIzASdt62fes+imP6fbkRP2Df1VCpR/b
         oVH6C953G/NOV5CMOf222UawEjg6JigyCqKLeBfjY6S2TizXffCTvmv0nxuApK0e1GWP
         qVtWynqU+CjmY6Mr9bzrJYFruN79435uw6ojGFMmGCKzvHjFl9YdL0z1y8kklxR0cF8Z
         hdQboBpqixATUmpYcb8HjkHRwWhkJJ0lwMapIZZ5Udisj3A2LG2OjLPPkMEVLo+X9wRk
         MxmkU+XR/bVtDbfKEuUjqTHg7O6MdtJ/4Td6k3MjFRKWw33GqgHOWVDGdIMocqOZMvQU
         Z3dg==
X-Gm-Message-State: AOJu0YyHYqAmm+0abz36JoxWEd6tQKzUaveZLeEhmS41GcKpC6vGBi9y
	3dS+2Gz4RYHUIGFTaAhDFxXuuVLSFJ3SKRT5kqI=
X-Google-Smtp-Source: AGHT+IHmG6KWX9uUyZCYmnkN+k7bcgd//qb+PsvwCeZ7z5dYp+ozm+adj414ul9TgKRmRJhIPcx/j2zSyY2lwqZPuHw=
X-Received: by 2002:a05:6870:9c8a:b0:203:b571:ab63 with SMTP id
 pq10-20020a0568709c8a00b00203b571ab63mr2431614oab.47.1704704457984; Mon, 08
 Jan 2024 01:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com> <93695e92-233d-460c-a6bd-882b30f1dea8@linaro.org>
In-Reply-To: <93695e92-233d-460c-a6bd-882b30f1dea8@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 8 Jan 2024 17:00:47 +0800
Message-ID: <CAJRtX8T-88x=AeRhOVJP=1ccvOZa-nS4cDEjpSykTxFMRupKZg@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] dt-bindings: riscv: sophgo: add RTC for CV1800
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 4:02=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 08:22, Jingbao Qiu wrote:
> > Real Time Clock (RTC) is an independently powered module
> > within the chip, which includes a 32KHz oscillator and
> > a Power On Reset/POR submodule. It can be used for time
> > display and timed alarm generation.
> >
> > Power On Reset/POR submodule only using register resources
> > so it should be empty. The 32KHz oscillator only provides
> > pulses for RTC in hardware.
> >
> >
> > Changes since v4:
> > - remove POR dt-bindings because it empty
> > - remove MFD dt-bindings because SoC does
> >   not have MFDs
> > - add syscon attribute to share registers
> >   with POR
> >
> > v4: https://lore.kernel.org/all/20231229090643.116575-1-qiujingbao.dlmu=
@gmail.com/
> >
> > Changes since v3:
> > - temporarily not submitting RTC driver code
> >   waiting for communication with IC designer
>
> Hm, why?
>
> We do not need bindings if nothing matches to them. If this binding is
> for other upstream open-source project, please provide references.
>
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree=
/bindings/submitting-patches.rst#L61
>

Hi!

There is a function in the RTC driver code used to calibrate the
clock, which is define in the datasheet.
However, Alexandre Belloni raised concerns that clock calibration
should be done using GPS or similar
methods, rather than using other clock sources. I think what he said
makes sense. So it is necessary
to communicate with IC designers.

link: https://lore.kernel.org/all/202312271350242a208426@mail.local/

Best regards,
Jingbao Qiu

