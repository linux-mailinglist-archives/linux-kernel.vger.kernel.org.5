Return-Path: <linux-kernel+bounces-107500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2E387FD59
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E3B283618
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A2F7F498;
	Tue, 19 Mar 2024 12:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="XDfc9lPR"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB207F486
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710850053; cv=none; b=uuk4SmCWmjS1rRj05EQwRieBRpRs12nbXdHSdrIjkhU4aW/DjZUKFSrEqPs/Rsgw0lAefBWAmCiWlehCoLgmtvuQwVXowhrgg5gjI6jzW/CYNH7bZYXwovozELcj5VQo2r7kFFqpUt/CMUDfWFi1XBTMl25IL05v3m2bDNBfjmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710850053; c=relaxed/simple;
	bh=GChbCays4BH4ubocYsYyR4dSDch4TnJ+QJ+nvoABbAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tYF40YUpl/FCJsN8DGn+y1cfQGdXKUHo6w8IAdfC4XRKFCUpJ8kLBNRix5vDGX2yecazayi8JlOK51iqZPR2DCFZlKgg8ixBaFtbesBWYkmvnNTeJYdSAUVB0Hf22oNZnWYo30vWVOzzZit8PK0QgyePcnnizq/raAUarOH0msE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=XDfc9lPR; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-60a0a1bd04eso57301087b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1710850050; x=1711454850; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rX6FqjYsTmcxI0CafXHHy/zN0bbe59i8Tv6Xmz/oP5o=;
        b=XDfc9lPRkPXNSE2YtbXONwBIVVBXuwOEbz5XOt0JuWFaZ2va+NUwsmDusZco1pDRZ0
         gcfVWVPGQgHxVM0F49k9qUKryKoT/HRf+/mo+cUmnkoNYpq/+TYAlp4UWcQMP6aDXgKV
         c1xT41F9Uiicc5iEivFdvUTZ5asxPywmsZWpD//VKqnfTO34RIzY87qxQzVXlwNB2Q5s
         Yoofdl+ckPGU+U7sB6mfbdACrUR1JE9nr/Pz0T2wrn0d8mrs69c9MWSGYFGKnxBTRkzc
         NC39A1XiT5P+4+l08PwWMTn7s+FdTtyvpJ2SJgz5vBkDNYMFACIvsSPywGm+e6OH22TI
         v/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710850050; x=1711454850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rX6FqjYsTmcxI0CafXHHy/zN0bbe59i8Tv6Xmz/oP5o=;
        b=MoEUozdrIiFkvMftHMOxMysHpCb5kyEwrMBl7shPfPOprQ3BKsMc3dVo8ppNCNPUly
         ULEJGTL41Y5vWBbaR7ENe1lBRuzVS3f1gMILitoMYO67H9ivRFqq9GZQ+y5kK130j4zt
         bwKrReyq8A6qgSHwXkMTubaDEIvKW5UCz1n/xGZaSMZCXB4h+udVwNswmW/g1bSvMKL0
         DnzymNYC61EZ8TcwGgs5f7c5lnTwSOoZN4ToZIgNERkzayDpfBDkQ+757sKVKL+k0qot
         0P7+qSe7cVX+v7kjWv3WOkEW8MsnHYOR3Rg9Lidwe75DtJ42VFslelHykCfq4dBnBDCF
         yf5w==
X-Forwarded-Encrypted: i=1; AJvYcCU6dVgYPd3WRI9tDSgPl9E3o2ygc2d3Qq3dUDZlw2NUvPhlyC8jJYWtCd+B5iNeVubWvDhe62vuMCCu4Ibc+h6tHXcQFJNpplTQhtD/
X-Gm-Message-State: AOJu0YzA+gvwpni1iELKCqieICVigqKskrJ3/HUZHnYI/y/ZSw3FliUO
	VT60vaI2W3PPvHFWJ0br625ezh0HyRd4RKBvAo9abel9jyhXlUWvli6uG3sY60QKRTrWftUjZdI
	cYILy2rdc/uxRNYmha/26KVDyuilzruK9qW05JQ==
X-Google-Smtp-Source: AGHT+IHkYff9gRI+3nLTBu1WnjFBfTr5P64pcgUIFGI3+AFUIKdvd9tDcb3D2bv2DngJjhntPBwBd3qzjCQN4J1A6p8=
X-Received: by 2002:a05:690c:2a8d:b0:610:e1df:a2fe with SMTP id
 ek13-20020a05690c2a8d00b00610e1dfa2femr1616124ywb.0.1710850050588; Tue, 19
 Mar 2024 05:07:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318-rp1-cfe-v1-0-ac6d960ff22d@ideasonboard.com>
 <20240318-rp1-cfe-v1-2-ac6d960ff22d@ideasonboard.com> <eb854c43-1e92-4c19-bfd3-1bde94924319@linaro.org>
 <f97faeb9-8a6b-47c6-9317-daca88257802@ideasonboard.com> <30430e0e-70de-4831-97ad-974e350a2e54@ideasonboard.com>
 <5ca1d005-1beb-47ec-943a-9358ae3c6704@linaro.org>
In-Reply-To: <5ca1d005-1beb-47ec-943a-9358ae3c6704@linaro.org>
From: Naushir Patuck <naush@raspberrypi.com>
Date: Tue, 19 Mar 2024 12:06:54 +0000
Message-ID: <CAEmqJPp7uGYe993L+ujth2mfRy66s8-S9FNxPY7vwkrboDq9yg@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: media: Add bindings for raspberrypi,rp1-cfe
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 19 Mar 2024 at 09:32, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 19/03/2024 08:00, Tomi Valkeinen wrote:
> > On 19/03/2024 08:48, Tomi Valkeinen wrote:
> >> On 19/03/2024 08:23, Krzysztof Kozlowski wrote:
> >>> On 18/03/2024 16:49, Tomi Valkeinen wrote:
> >>>> Add DT bindings for raspberrypi,rp1-cfe.
> >>>>
> >>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> >>>> ---
> >>>>   .../bindings/media/raspberrypi,rp1-cfe.yaml        | 103
> >>>> +++++++++++++++++++++
> >>>>   1 file changed, 103 insertions(+)
> >>>>
> >>>> diff --git
> >>>> a/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
> >>>> b/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
> >>>> new file mode 100644
> >>>> index 000000000000..7b2beeaaab0e
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
> >>>> @@ -0,0 +1,103 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/media/raspberrypi,rp1-cfe.yaml#
> >>>
> >>> Use compatible as filename.
> >>
> >> Ah, indeed. I changed the compatible quite late, adding the "rpi5" as
> >> versioning, and missed changing the file name.
> >>
> >> I'll rename.
> >
> > Actually, maybe it's better to have two compatibles,
> > "raspberrypi,rp1-cfe" as the generic one, and "raspberrypi,rpi5-rp1-cfe"
> > (or something similar) for RaspberryPi 5.
> >
> > And I'm not sure if the "rp1" part is relevant there, would
> > "raspberrypi,cfe" be just as fine? Naush?
>
> See writing bindings. Compatibles should be SoC specific. In some cases
> generic fallbacks make sense, in some note. But don't just choose
> "generic fallback" because you want. Provide rationale.

If the compatible is SoC specific, I suppose "raspberrypi,rp1-cfe"
would be the correct string.

Naush

>
> Best regards,
> Krzysztof
>

