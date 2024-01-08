Return-Path: <linux-kernel+bounces-19637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AF882701D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A412840B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BE644C83;
	Mon,  8 Jan 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxlna0Vg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3502A44C93;
	Mon,  8 Jan 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6dc83674972so1294136a34.1;
        Mon, 08 Jan 2024 05:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704721379; x=1705326179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZaZLsQ9xPdwJhp6Soa9sCQk7s8AanM4FovM1Duez9I=;
        b=Yxlna0Vg5ztB/60I6eMIxIBXyJ8c0ynoCk+6o2h6ZmN7eghq5+zTHI+I/DGjeha0he
         9yllAhTjOAW5WUqOTbcpfOIG6e0D3mIIAMOZfnn5pJuxkbku2VQ4fF6u0JmiQdnF4948
         57CxFBL+YP0Z59iMudydVHXACbiuqTfckpPnzUqi8WOEWYf36e+rFtna/zEdxKH00YYY
         fFu9U5816nlCtVmTV5fhroNAiiMbD9y9tkbf/QsIkIV91iBK+v0MyjuKncjfpVS+oxXH
         kXDmPCZiOa0MTVhBdtpRU2zwBbicW8GHsf1AxaIOLfSkxHSwavigLIxEd7EpyPrpMxUv
         iLQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721379; x=1705326179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZaZLsQ9xPdwJhp6Soa9sCQk7s8AanM4FovM1Duez9I=;
        b=sihyOcxALbKPtdWUG+ahRpDwDiyxIyNdTgYOd0gSuPDdBDzbPXjoPwcENve4RCsP4Z
         fwM2KngNixyHCB3gFRCB5guTaYelIDio1+HKwjE7jLbw5iSddXddtuybRN3rh2Gp8kJu
         2w6/jExQ0kEED7qzRkU7U0Etx7ku23dBU9cKm8786Sa7tokfUWQWwwFEprB8dJ3ME5Qc
         zCbwu4szDTlWyHOjC6JrZnmn7j+JFsTiz2O8cenOKtmEMKSZLAmQMpoTqObS4PmHvSaF
         kjUB9EdpqExop2LxYYUqtp2TZXAUNiJvmfP8MK9RixeMTY5SOQQAoLX06zqqEop0efpT
         8WfQ==
X-Gm-Message-State: AOJu0YxwqX2k3X3iOfCFZJ/36nF5GfzGkcrfZSpFDt8larH4Xg9J4kCr
	bf6GZrm6ScTiP7f61oDlhFZXQGWYcVArUfoVIMw=
X-Google-Smtp-Source: AGHT+IHp/xKG5HRDGjO3c9rS0oHUhSZaq6qoglQNoHDKNe/2C0jWMX+MCmT72+b7U8cHjfIKlF8vj8appUmYBfxy2FA=
X-Received: by 2002:a05:6871:647:b0:205:d083:75a8 with SMTP id
 x7-20020a056871064700b00205d08375a8mr4842508oan.31.1704721378734; Mon, 08 Jan
 2024 05:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
 <93695e92-233d-460c-a6bd-882b30f1dea8@linaro.org> <CAJRtX8T-88x=AeRhOVJP=1ccvOZa-nS4cDEjpSykTxFMRupKZg@mail.gmail.com>
 <7af6c688-3d3e-4cd5-bbd6-4ca323d7edde@linaro.org> <CAJRtX8QzDQjMCqXw9BnWPFt5FT3qr9=95F1rpwz_795AF9oSAA@mail.gmail.com>
 <c4d1a68a-815f-4585-b600-9b2e049791c9@linaro.org>
In-Reply-To: <c4d1a68a-815f-4585-b600-9b2e049791c9@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 8 Jan 2024 21:42:47 +0800
Message-ID: <CAJRtX8TTtPJkfQXSCiwLrFon8SFpyS0Hxi_Pc9Wro=fk66W8Tg@mail.gmail.com>
Subject: Re: [PATCH v5 0/1] dt-bindings: riscv: sophgo: add RTC for CV1800
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 5:28=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 08/01/2024 10:11, Jingbao Qiu wrote:
> > On Mon, Jan 8, 2024 at 5:06=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 08/01/2024 10:00, Jingbao Qiu wrote:
> >>> On Mon, Jan 8, 2024 at 4:02=E2=80=AFPM Krzysztof Kozlowski
> >>> <krzysztof.kozlowski@linaro.org> wrote:
> >>>>
> >>>> On 08/01/2024 08:22, Jingbao Qiu wrote:
> >>>>> Real Time Clock (RTC) is an independently powered module
> >>>>> within the chip, which includes a 32KHz oscillator and
> >>>>> a Power On Reset/POR submodule. It can be used for time
> >>>>> display and timed alarm generation.
> >>>>>
> >>>>> Power On Reset/POR submodule only using register resources
> >>>>> so it should be empty. The 32KHz oscillator only provides
> >>>>> pulses for RTC in hardware.
> >>>>>
> >>>>>
> >>>>> Changes since v4:
> >>>>> - remove POR dt-bindings because it empty
> >>>>> - remove MFD dt-bindings because SoC does
> >>>>>   not have MFDs
> >>>>> - add syscon attribute to share registers
> >>>>>   with POR
> >>>>>
> >>>>> v4: https://lore.kernel.org/all/20231229090643.116575-1-qiujingbao.=
dlmu@gmail.com/
> >>>>>
> >>>>> Changes since v3:
> >>>>> - temporarily not submitting RTC driver code
> >>>>>   waiting for communication with IC designer
> >>>>
> >>>> Hm, why?
> >>>>
> >>>> We do not need bindings if nothing matches to them. If this binding =
is
> >>>> for other upstream open-source project, please provide references.
> >>>>
> >>>> See also:
> >>>> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devic=
etree/bindings/submitting-patches.rst#L61
> >>>>
> >>>
> >>> Hi!
> >>>
> >>> There is a function in the RTC driver code used to calibrate the
> >>> clock, which is define in the datasheet.
> >>> However, Alexandre Belloni raised concerns that clock calibration
> >>> should be done using GPS or similar
> >>> methods, rather than using other clock sources. I think what he said
> >>> makes sense. So it is necessary
> >>> to communicate with IC designers.
> >>>
> >>> link: https://lore.kernel.org/all/202312271350242a208426@mail.local/
> >>
> >> Sure, this I get, but why sending bindings alone? There is no user of =
them.
> >>
> >
> > Thank you for your patient reply.
> > May I ask if this user refers to driver code or DTS?
>
> Anything. Any user.
>

Thank you for your suggestion. I will include DTS or all of it in the
next version.

Best regards,
Jingbao Qiu

