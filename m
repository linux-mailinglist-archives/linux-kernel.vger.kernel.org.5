Return-Path: <linux-kernel+bounces-19642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121AB827030
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02A6BB223FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D8845945;
	Mon,  8 Jan 2024 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IG/C9/Hn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CE345947;
	Mon,  8 Jan 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-598699c0f1eso165438eaf.2;
        Mon, 08 Jan 2024 05:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704721682; x=1705326482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AwnXjHz9QhC6YpmyZGK0fpH1dHMBCL/ovpNQY0IYB4Y=;
        b=IG/C9/HnB1b+uesAZLCB7VYhiPC+gzyYqjJPTUeKepJ9zm/56RpXv5/R3CLFNtc6Lj
         EZcWCM7QSJ3BjlwCEEQBkmpWudJcGfLwkRGMS+2cXFx0M13bYYi14O5Q7b8KnDKTxRec
         iDbSipK2wv/YX3OlxjahBYlVSZo4XFEK7rfDr9AIfekOLapYBcuLSmMypAo0QyQsyj8a
         NVu59Sv+zjTHPP2TVX2tmK8zBSYvYKPw5OcqIRt9U1j8nHSpvVYK8mYelOMqAKxmzDPk
         5JsnGvNk2fFwyFqRUWYHV0U+iSZcdcXZTtaNnYFeey3qG6lHg3SDKOD/YOkFWU8gC4nb
         uW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721682; x=1705326482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwnXjHz9QhC6YpmyZGK0fpH1dHMBCL/ovpNQY0IYB4Y=;
        b=RkHuyPfxdl7rmGAW/AKCgeQpUZKNm/5HYBFLqgEppXx+k9H93HfgA9czAzKAY7D0R/
         2cgCPjrWyJNoY7awhFygFYIMWN1YQoIyXxa4VjgnUvXIGzTmEGMb7cRiVdRFpkwqYKO/
         JfoIDpgJpg6pIwec7k9BWESCloolZiLLd/FkEIwhmrERT7+phQsTWt+tP6gllM5kplqv
         CMZ1Pnsis2AvuhBfxHfzelBga0b2rFkbCOnaOWcTermI7/NzM4nn5pIEXyWOiL3K6t5e
         POpJv0vVIWOwUCRN7WNZwKJoJbVnpfJbBQiOFJTt9wMyOQ7bGlHKqCg+beAGA1eIZk36
         /TkQ==
X-Gm-Message-State: AOJu0YyU4OgqYfMrnai6AhH4Sy8ol+P+Yu/D8RPn27J8Ff59YlBlywto
	MXjpE8y6kzRo09o5pMfA2Byceh/Hn2grSUWbvJs=
X-Google-Smtp-Source: AGHT+IG4fkhvNGr0kFehqgZRY2cEgCpzZfvxzd9lVUBUIEj3Bfz6dLwJH27oAX5TWQ4Re9/+ycyyf0c4su0r7DTgoUg=
X-Received: by 2002:a4a:5ec3:0:b0:591:c16b:eb29 with SMTP id
 h186-20020a4a5ec3000000b00591c16beb29mr2077817oob.13.1704721682084; Mon, 08
 Jan 2024 05:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108072253.30183-1-qiujingbao.dlmu@gmail.com>
 <20240108072253.30183-2-qiujingbao.dlmu@gmail.com> <cd4c5c26-fef9-44d8-a2fe-1cff0fc6fd03@linaro.org>
 <CAJRtX8TcXrP8aqr3ejvtDGR5Y-ogbLkvJvJkLh_MzpnK7wgLGw@mail.gmail.com> <7ceb8f61-6929-4ca0-83e0-c6534241ca5a@linaro.org>
In-Reply-To: <7ceb8f61-6929-4ca0-83e0-c6534241ca5a@linaro.org>
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Date: Mon, 8 Jan 2024 21:47:51 +0800
Message-ID: <CAJRtX8QSoS72rUj7vu3CLgthfneG-RudUygcZEsw-sBFKw99tw@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
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
> On 08/01/2024 10:10, Jingbao Qiu wrote:
> > On Mon, Jan 8, 2024 at 4:04=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 08/01/2024 08:22, Jingbao Qiu wrote:
> >>> Add RTC devicetree binding for Sophgo CV1800 SoC.
> >>>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> >>> ---
> >>>  .../bindings/rtc/sophgo,cv1800-rtc.yaml       | 56 +++++++++++++++++=
++
> >>>  1 file changed, 56 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/rtc/sophgo,cv18=
00-rtc.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.=
yaml b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
> >>> new file mode 100644
> >>> index 000000000000..01a926cb5c81
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/rtc/sophgo,cv1800-rtc.yaml
> >>> @@ -0,0 +1,56 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/rtc/sophgo,cv1800-rtc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: Real Time Clock of the Sophgo CV1800 SoC
> >>> +
> >>> +allOf:
> >>> +  - $ref: rtc.yaml#
> >>
> >> Why the allOf has moved?
> >
> > Hi,
> > Do you mean allof should be under maintainers? Or other meanings.
>
> Yes and the patch which got my review had it correctly placed.
>

Thank you for your reply. I will adjust their order.

> >
> >>
> >>> +
> >>> +maintainers:
> >>> +  - Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> >>> +
> >>> +description:
> >>> +  Real Time Clock (RTC) is an independently powered module
> >>> +  within the chip, which includes a 32KHz oscillator and a
> >>> +  Power On Reset/POR submodule. It can be used for time display
> >>> +  and timed alarm generation. In addition, the hardware state
> >>> +  machine provides triggering and timing control for chip
> >>> +  power on, off, and reset.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    items:
> >>> +      - const: sophgo,cv1800-rtc
> >>> +      - const: syscon
> >>
> >> Why is this syscon? Description does not explain this.
> >
> > Because the driver of the submodule POR in RTC only requires register
> > address and range to work, according to what you said, it is only a com=
patible
> > attribute and does not need to be a child node.
>
> What child node has anything to do with syscon? Anyway I don't
> understand that.
>
> >
> > So I wrote the following in the changelog.
> >
> > - add syscon attribute to share registers
> >   with POR
>
> Where is this syscon attribute? Please point me to specific line in DTS
> and in the driver.

I will explain in the next version of DTS.
Thank you again for your patient reply.

Best regards,
Jingbao Qiu

