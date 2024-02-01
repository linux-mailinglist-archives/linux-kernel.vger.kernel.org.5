Return-Path: <linux-kernel+bounces-47436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B86844DE9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2091F2AB17
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A5A1FCC;
	Thu,  1 Feb 2024 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AlUUzhv3"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33551848;
	Thu,  1 Feb 2024 00:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747686; cv=none; b=r2d4tKDbA5Rfbw2U8QD/u+3wS15Vqoafswx/J5PfrnfZ6cqAgswQ551iNtQkDKdIgQS/Al/N0gqR3LELy8YOC6G6Q46mnTzdTNS40ADNe/wL4iHqEwtmuKiD77JOZ43MCpxysM+06uttixN5qG/xK03/T17TtJ+1NKEFcLQaYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747686; c=relaxed/simple;
	bh=vnbzCB39wVKvbch2Hy3sYEt0pT2wPAKWtE3Z1mkDHbM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAQoei38aPQ+OQtb0nlhFcWf53G1q7Uhw0e6sSBEEa7M+mL+s86CIaS+VfgF+y1cXA5Hwgn9iDtaZbznXTEAolOyG+WSbfnmsNkwHC3/pPrG/if64mETRNRKjPm1W9v83cwEqvaQ7TQv4ecmgF0plZPsngkbJiFBydhh2t/534U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AlUUzhv3; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc63dfe77caso311766276.3;
        Wed, 31 Jan 2024 16:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706747683; x=1707352483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbOOKe7bbu6zejjiRtLrCpqVPRgcPSroTLRi0QwxwOE=;
        b=AlUUzhv3HCyHBEj7PFOkxwFjizL9hgiQbian/h/e2YGNitZltGoRv+61M8p1TfAEtW
         ynC5Gy1EuoV0sgi09atkR1j/kWFd2K7GP85Tc7zCtWUmruIV9BCqOqmSKrpIaup2Effd
         vL6sJkdu+QlJ06WOPz1cJPZ2BvnMh8qJ6aClMMjzkM80El/nO3jjzjsQKDDAZ1CsDbTN
         k2xCPb8UhwiJcWC+5mhToOtzY06eRZ3c2JhwHXj84b4m0bZ+QBkssLUayvBf+GS0ihcR
         w5SL7Bx8GLk+6Q7d2wB/XapvVE5vDYcLo9ukC5cwhSgN65k7UePhOaC6teh4eJaaJvPe
         KWew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706747683; x=1707352483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbOOKe7bbu6zejjiRtLrCpqVPRgcPSroTLRi0QwxwOE=;
        b=w6IlOe9pvZyupojePmIlUOE5lXF0r8VSjlSmJvWwk/VsYdycmMTVPpBFewf68p9kgx
         ZI1rgn0QaeWv7durdMuj4l0n6tYcTw3vk547x37tem4rqs2HS8eOwuQyAtbkJ/bLJQKN
         k4fulxFw9LGYPLxqaqp+ZZxYDn+5k4o1fhBIEH5fYyucSdMqqdIe3VuhMlS8V7BzElY/
         vZNwVCBpdniRvwl0ZoxMkn6h3+IyVNdaLcdSRCx92J9ftdss03IoNISXBEK8YjcS4TX6
         Y++2UadAOyVN9En3PZY44VZBZfexe/7+5h/dotw13VvODTZNZ6XOjhe0SRBH6+Gy/tOU
         7m1g==
X-Gm-Message-State: AOJu0YwdIXGRkP52Ycx273bvJVQiNoMMirSShjoqPRayuv8QL9AxrlCg
	xqgQ/93Uaeea7v1tVTXes7W1EucQG7ADP63At05JBB49GXX+C35hk3287Xt33Li14ytmRBEyN0z
	MDJ2q5zeADqSRjDiOxnT0Zjwp0dfWbLsUbhpibg==
X-Google-Smtp-Source: AGHT+IHW7I0Dmnn7MtcxiiH7U7ZvvzGycmS1CNoDQRvXK4YxdTMfhWwkKV/OMla8SO9nrfOLDpc9O0P42dzA4R4kIxU=
X-Received: by 2002:a05:6902:1369:b0:dc2:252d:4773 with SMTP id
 bt9-20020a056902136900b00dc2252d4773mr3185212ybb.61.1706747683578; Wed, 31
 Jan 2024 16:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055526.2700452-1-ythsu0511@gmail.com> <20240131055526.2700452-2-ythsu0511@gmail.com>
 <20240131-eraser-given-8381a44f41a4@spud>
In-Reply-To: <20240131-eraser-given-8381a44f41a4@spud>
From: =?UTF-8?B?5b6Q5rC46KyE?= <ythsu0511@gmail.com>
Date: Thu, 1 Feb 2024 08:34:32 +0800
Message-ID: <CAE+7-j=uWxQhEVF4YhAGmyjrryzMxF2E9Qi6xgRVYwusmaZMMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: Add MPQ8785 voltage regulator device
To: Conor Dooley <conor@kernel.org>
Cc: jdelvare@suse.com, linux@roeck-us.net, corbet@lwn.net, 
	Delphine_CC_Chiu@wiwynn.com, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 11:41=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Wed, Jan 31, 2024 at 01:55:26PM +0800, Charles Hsu wrote:
> > Monolithic Power Systems, Inc. (MPS) synchronous step-down converter.
> >
> > Signed-off-by: Charles Hsu <ythsu0511@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/D=
ocumentation/devicetree/bindings/trivial-devices.yaml
> > index 79dcd92c4a43..088b23ed2ae6 100644
> > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > @@ -129,6 +129,8 @@ properties:
> >            - mps,mp2975
> >              # Monolithic Power Systems Inc. multi-phase hot-swap contr=
oller mp5990
> >            - mps,mp5990
> > +            # Monolithic Power Systems Inc. synchronous step-down conv=
erter mpq8785
> > +          - mps,mpq8785
>
> q sorts before 2, otherwise
Okay, I got it.
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Cheers,
> Conor.
>
> >              # Honeywell Humidicon HIH-6130 humidity/temperature sensor
> >            - honeywell,hi6130
> >              # IBM Common Form Factor Power Supply Versions (all versio=
ns)
> > --
> > 2.34.1
> >

