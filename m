Return-Path: <linux-kernel+bounces-153635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7EE78AD0C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CD1D1F23033
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72800153827;
	Mon, 22 Apr 2024 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxWNbAbm"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26AA1153583;
	Mon, 22 Apr 2024 15:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799788; cv=none; b=W1lWODqleM85BzXKByzQKAAH4P/gWmmVO12EpBVdRBPVAZzAE2Gcvz+PNQGn7Wzuof5qKjSZPmdnUSjJtiQi+rHcZiV+Plux1tVCLuhO1f/gzrQziYEvOwN/luloLKi6+OLXnHUToFXrJ2mHU1LKGGQFrxBcrUpR82O6huboIPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799788; c=relaxed/simple;
	bh=Jv2S9yMzO8ppdharj3oJu7fflP9TsF4FXzRkWtvwn4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cuIWgpeLXUUuS+ZcgDu543mHNyIfhFa/IEDbgYE6FtIds/AWpzS48cOrcVOyYNGEKzNhg5VyQcR1d97aG+vuIph5d6rzY4J3cVEJjgKDEgWPCpGAjw/bE1ZhuIMj5AsieibTsmBEXfUWMdW1C+vK7o4XJlStXudeNa2SToX2MAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxWNbAbm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57211441361so740159a12.2;
        Mon, 22 Apr 2024 08:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713799785; x=1714404585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdHzDpUOFI2yT9VOMYqjnhUk7dvRzBFVEW3k0AD1FFc=;
        b=GxWNbAbmZMv0HzJYE+tK+WkJ4D3L6lBrL+79BI2U5S/rQV14q7IB6o9pMEzRHV2mLM
         gJ3e5uLeiQGDlBWdc7GgrnI/O6B8pVvPTnOzDmd0EOin/6SSyWdNlzpYR/OCwkPDF41P
         BVxbxLTDhSLxE62nfFCRFzGrpMhOb09tHFwot8/rAHZeu/RdFvV31Tn1z7+vzIHM/prR
         ZBpYBX877R3pKVthN/cD0MdaGMVwzG7eavS3Ux0XqRqFBHA2A4ussPytl3CnQLiXJgP0
         lB5Fh9TPjvop4+1nmhh7tuJsc01KuTuEUkuDgUq9Y0ultyuJFTnjvRqSQ1Q5HSHGlYa8
         /hBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713799785; x=1714404585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdHzDpUOFI2yT9VOMYqjnhUk7dvRzBFVEW3k0AD1FFc=;
        b=NSpM4LT3nYySoVwDAxKfxP8SxQidTKZPSKQ1TxvtRy2G/mew7BNQp1TRsyYSQBi0uf
         kRwIyedS60B+rUtHWfyAArUt5OnyiJQ1uH7EfuEyiSMlE6ZikBRfTMC59R8xcT9aER9H
         ULhy4FutHSBtk1Pim8WWlTYCTM4YvEVWF3dQo6v4wx2xGvujWlYsM7KyNKg4EBRlJSKS
         eEcfpteUO2AxolHkQ/uHmrrM1g0Qdu6VI1wedl4dM+FhERZMyh4M0sCGfbCX3iyf6rFs
         BvW2ay/XDTT5kcu8eSgIHSD8UQujXc9eiJ8ybfWNPyFPP/0OW2QCxgfVXFCz/Cve2hqn
         oy7w==
X-Forwarded-Encrypted: i=1; AJvYcCWHcroJ4U76m+lbIFr4XI7Lt4CyeTPRK4WYTsM80zjmO5q98onaVHw9VtESpfYuxBkk3egNq6BPdtLt00lG44VJWDj0FPIINZuufMq25V1fJ00JpTRmwjhysllhxjmUKvETGWkERpLeCcw9+BUZ56DBBDhqe8EjGqF99bS+gvMnVUZy5taSQQ==
X-Gm-Message-State: AOJu0YzKQOrQwfmJfWew7q0Q0DyYDO4bMtlYHmE/WOp4oEq5/JOTdY7k
	QSMhtJQhxRB/pfQSkP+K8bfoHM1YbyD03/DdfwYQH7RQ07kGob/2t+xon6ifM59zGHrrsLm6JXw
	VQ7gQwVHMYofmMx4ldLEzW7j+Cmg=
X-Google-Smtp-Source: AGHT+IEZSLvTMjCLgMLIcDN3ZiFuYxI1WCaTMm+8u32j5C+BSsg9XYh/rYSPPrOSNCVlhUOTvOvFeiIunFf2Jd0pNUY=
X-Received: by 2002:a17:906:3057:b0:a55:73c3:f818 with SMTP id
 d23-20020a170906305700b00a5573c3f818mr6423702ejd.14.1713799785368; Mon, 22
 Apr 2024 08:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
 <20240422133219.2710061-3-ria.freelander@gmail.com> <20240422-repackage-popper-8a062acf2610@spud>
In-Reply-To: <20240422-repackage-popper-8a062acf2610@spud>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Mon, 22 Apr 2024 18:31:56 +0300
Message-ID: <CAF1WSuy=zuTjDGEKGUtAb79J28FydYfuvB=OuR1yx5PtuPHz7A@mail.gmail.com>
Subject: Re: [PATCH v7 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
To: Conor Dooley <conor@kernel.org>
Cc: krzk@kernel.org, lkp@intel.com, vz@mleia.com, robh@kernel.org, 
	jcmvbkbc@gmail.com, nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, 
	corbet@lwn.net, ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, 
	Maarten.Brock@sttls.nl, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>, 
	Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 6:28=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Apr 22, 2024 at 04:32:14PM +0300, Konstantin Pugin wrote:
> > Add EXAR XR20M1172 UART compatible line into devicetree documentation.
>
> I thought I had already pointed out a need for the commit message to
> explain why this exar device belongs in this file. IIRC you said it was
> in the driver commit and cover letter, but it needs to go here too.
>
> Thanks,
> Conor.
>
> >
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> > Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yam=
l b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> > index 5dec15b7e7c3..c4bedf23368b 100644
> > --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> > +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> > @@ -12,6 +12,7 @@ maintainers:
> >  properties:
> >    compatible:
> >      enum:
> > +      - exar,xr20m1172
> >        - nxp,sc16is740
> >        - nxp,sc16is741
> >        - nxp,sc16is750
> > --
> > 2.34.1
> >

Okay, will add again (another v6 missed).

