Return-Path: <linux-kernel+bounces-129077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09752896470
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 367571C21EDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8E74EB3F;
	Wed,  3 Apr 2024 06:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b="WYnKe0dG"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDAC4AEEF
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712125007; cv=none; b=Gz2ah0ONzX8lNX6/BJICjuyzgsiJeO6CwqZeWX1rZgTs3GwOEXHY0HBqzRD/gHAzcI72OyQba6LtRjoHoHXhmMCi3Ee+6I6hu9YKRRLvUsxe3GBtoOCzLnpHe1woPz81iQg0uS29gmmY6YtxffDYUh+Sr3m/espdCk7lHC79wcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712125007; c=relaxed/simple;
	bh=kIy7qWFiBqN1u57DhH/gWej2UMvzk3eu0cayWgZ2JQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YOW0EVyOVI+f1jdOwTo6V8Zi53YaHUrFsJF3PFLPyY78ixSnum9gILz63xEPUputPcPJPuu8YB1ZdsQtP82fUz54hBRM/HmvOOPgAln7fbmHiM6wsGj0JTrXN0DSElmCFn4awbt99v8+u8UngZGob8ogHDMlWetPm0NdmXctTHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro; spf=pass smtp.mailfrom=shruggie.ro; dkim=pass (2048-bit key) header.d=shruggie-ro.20230601.gappssmtp.com header.i=@shruggie-ro.20230601.gappssmtp.com header.b=WYnKe0dG; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shruggie.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shruggie.ro
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513d23be0b6so6501625e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shruggie-ro.20230601.gappssmtp.com; s=20230601; t=1712125002; x=1712729802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUWOAlRew8Y9zlqvI12IsW4qhw1mXgmiBgk1qsYuJAE=;
        b=WYnKe0dGvTr9j6X5aXCcWIfdx2bUHfe74Jj6bJL7ZhwSMSMLFuRU7YifVtqiGayr22
         KRWYtxbZi/9tp5/AjRmH1p7LiG4OmN5ubZVp/WiNkZFXWUrKnBrJk8NsdwXAlwZXKV8N
         GI2iQlHDmFqA0KVpaG22dRYOUXejHjJBXEgjzerLPtnMrvksMxuOFfrClLOARj3YRbPg
         Y68Tu1U1Vo6FdqMBh5RJ4NtqSqfbuh+xDRgwJaMoHSb8KhSLoXN4eRb6MUl7rFr6MVkY
         c6uoys7i/MTqBZydngoJ0OaXRMAoM8frvu4+jR9V734i1WNJaLQDHSIfdGjHQxzftRKU
         r3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712125002; x=1712729802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUWOAlRew8Y9zlqvI12IsW4qhw1mXgmiBgk1qsYuJAE=;
        b=gHuQL77WFU3wXPjJrJo02MbMEBJMCa123gBqICVH8U8K9qBCAJwDiXBbkL2emPv7wS
         gSumW5YLIxVdowxrgrLApFHvvxpWKBIbWNzLWl1eThryuoptwBo0BxJCG3Z0VoSZ/5eI
         ZOr/TweIBx+TNHJHwdQpJE/thjk8vn6jOcm1t2mvgldEI5UuzhQzFjIP0FFRhQITfUP8
         5yxIu9y9M2FU6XhBj0FLnShAEHqvZktg6NiYdp7zYj47CZpEst6mv3INj6mANaKamKIL
         Fq6uHwduQe/K8ls3pUPNjc1lIRozrIY1inpAl3uv3KIOZZ+awgaIiviKTsUbAI6iyztI
         kb2A==
X-Gm-Message-State: AOJu0YyM93DXSgblis0NDBm/72GX1dg4ZurTWeNv2Z8TVvCjy/r9a7DG
	WGKzI56AI6ZMl5l46HxEmWCZDX9Cmgl+dxNmRQHQQhU+Mr4haeKGnjrKmhYatAGenEwxkHfUwJX
	tpdjrgWt54R/rowdHCKOcuUqToQVLAZ+MFGW5qw==
X-Google-Smtp-Source: AGHT+IHxy5L7IuAClTzOQvPqVmBmGzm4Jxd5dXHEawLJyCom6nIx29NzDwr6gHy4UOjn+UPEdfsKmGeIOhgk1vX2hCY=
X-Received: by 2002:a19:6a13:0:b0:516:a0a5:a444 with SMTP id
 u19-20020a196a13000000b00516a0a5a444mr8832014lfu.2.1712125002295; Tue, 02 Apr
 2024 23:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402105925.905144-1-alex@shruggie.ro> <20240402105925.905144-2-alex@shruggie.ro>
 <20240402-sheet-retread-025759b22faf@spud>
In-Reply-To: <20240402-sheet-retread-025759b22faf@spud>
From: Alexandru Ardelean <alex@shruggie.ro>
Date: Wed, 3 Apr 2024 09:16:31 +0300
Message-ID: <CAH3L5QooAXDYAxOdMkPrW1mx04ZgTv_kMU5VSAby9J3Hb_RFOg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: display: bridge: lt8912b: document
 'lontium,pn-swap' property
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, adrien.grassein@gmail.com, 
	andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	airlied@gmail.com, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com, 
	marius.muresan@mxt.ro, irina.muresan@mxt.ro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 9:06=E2=80=AFPM Conor Dooley <conor@kernel.org> wrot=
e:
>
> On Tue, Apr 02, 2024 at 01:59:25PM +0300, Alexandru Ardelean wrote:
> > On some HW designs, it's easier for the layout if the P/N pins are swap=
ped.
> > The driver currently has a DT property to do that.
>
> "currently", because 1/2 adds it. bindings patches should precede the
> driver patches in the series, so please swap the patches and remove this
> portion of the description.

ack;
i'll invert the order and remove this;

>
> >
> > This change documents the 'lontium,pn-swap' property.
> >
> > Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> > ---
> >  .../devicetree/bindings/display/bridge/lontium,lt8912b.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,l=
t8912b.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt89=
12b.yaml
> > index 2cef252157985..3a804926b288a 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.=
yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.=
yaml
> > @@ -24,6 +24,12 @@ properties:
> >      maxItems: 1
> >      description: GPIO connected to active high RESET pin.
> >
> > +  lontium,pn-swap:
> > +    description: Swap the polarities of the P/N pins in software.
> > +      On some HW designs, the layout is simplified if the P/N pins
> > +      are inverted.
>
> Please explain what configuration of a board would cause these to be
> swapped, rather than why someone might want to configure the board this
> way. I've got no idea what this hardware is actually doing, so this is
> being pulled out of a hat, but I'd expect something like "Some boards
> swap the polarity of the P/N pins, use this property to indicate this to
> software".

ack
if it's fine with you, i'll use your suggested description;

for a broader context, we were using a DSI-HDMI converter [1] from
SomLabs on a different (than SomLabs) board;
and we were not seeing anything on the HDMI-connected display;
as I understand it, some DSI-HDMI bridges support P/N auto-inversion;
this one doesn't AFAICT;
on this DSI-HDMI converter [1], we've noticed that the P/N pins were
inverted from the DSI to the chip (vs what we expected to see)
after changing the register value (for the P/N swap), it worked;
our conclusion was that, the design of the converter (board) was done
as-such, because it made the layout easier

[1] https://wiki.somlabs.com/index.php/SL-MIPI-LVDS-HDMI-CNV-11_Datasheet_a=
nd_Pinout

>
> > +    type: boolean
>
> The type here should be flag.

ack; i'll change the type

>
> Cheers,
> Conor.
>
> > +
> >    ports:
> >      $ref: /schemas/graph.yaml#/properties/ports
> >
> > --
> > 2.44.0
> >

