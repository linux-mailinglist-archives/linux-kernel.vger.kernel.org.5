Return-Path: <linux-kernel+bounces-84229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 430CC86A3D4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC535284ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9741955E4E;
	Tue, 27 Feb 2024 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJfvlPZh"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F755C2E;
	Tue, 27 Feb 2024 23:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709077021; cv=none; b=bJn8PxX+GtfpXXDESo8kqcdXG1iFpVyLUO5hqbtsSspFTpy2iYC0o70WIO42OnDE1qfzaZVWlKu57GJ4+cey+GiVAFXSe4DlJ7seoK7oA2w8xUZq+PpcfdBdfTxuV+rcP6Po67DoBHQ3XljG5kyOgDzh8Eagc/fInmJkH9uYh6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709077021; c=relaxed/simple;
	bh=+3LADi/Ys1QHxDQK+19JLMGeT7XuVMRoaQYxauWMSo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJL3t/gMHznbVprqKA6ie+EiwDjjI0g1mJ9gLoJ+bmGBK7gMc/w6GZ7NTqLARDxr60FEjaQWyHDAZquYcycn5S/k6laPeS+ULUFJw9cK3IuXgJF8Huep0YGMqGKeXzMpFqxWlJfY4bahkNpUNgnCyjXJSvHb1L94HM5XTlbAwJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJfvlPZh; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7da6e831972so1160407241.3;
        Tue, 27 Feb 2024 15:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709077019; x=1709681819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izOwouqjolzSDT2Ugrc5QNARqSQIPvW3rUMcIvHb1Zw=;
        b=bJfvlPZhR8T7w7y4j9hPBhv3ikuyEzGJVT6o00P7dpEoXKLAxbZ9W9bW52gL+lpX2q
         M2Ftpk7YvbDFHCd6YGgG4VM0IdQk6x2fywx6Nx322lasdmagds3mMLZ8kMa2VaXDFWYF
         /Va6vYw2UJ8fEneCty+EGmYrAeIxSTqcCVrdt7B8OtbSPBMhas6tVAPZWAHFjAr1jYfJ
         hccZ9E16O6qQ5qnf86b8TEJtAMthHXMh8cxifyjy2QkAGQxzo2mayk2U4HzHwPeNp44F
         NzD2ENZpfg2W4sf9C9XiiRLpS0jaBKQpl5RmUG446/8cU5TZhkgJ2Mha2QhjCIbh2Ofw
         8UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709077019; x=1709681819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izOwouqjolzSDT2Ugrc5QNARqSQIPvW3rUMcIvHb1Zw=;
        b=fk9wY4edN/GkjuFGiDh8mjNXiZQF3VEz+67SouEGhhzg6xzXEkvtavQK8PFSXhQtnM
         dprLuDO7/yLhXNwPtxs6IFQDRWJrLVJcUCzLF0rGmqQ5LjFPy/e8/yT0vjZ1oHOj7On5
         4Ttx6rmVcY86ms+JEefXp+ydvtY7wwPiSs60r/ujCqJOrTIkj+GYLqsjYyK3A3fZaU/N
         kCoqPy6aMX5G0VX1+PghB8JBBO45wuoSc+kGW6IzIy0vvBNOJo+n7N5Da0EjFFp3Xktj
         M+Cqx3ECAoueMDkv4Ggp51V/QVm7balor9qndoB50Qy15oAnN3pyHUMYf8SGoNdKqj9I
         AJEg==
X-Forwarded-Encrypted: i=1; AJvYcCVMHo9dV9KmH2KNyNx5/K7ritSunH6OFO3xlVUA0nvbIahQOOy0REql4cD1YKX377cqbSLpJv2Q9qUU2gEFuJUs9uKV6dI3bpr54VSGMCwE3XXDufXsSBBWNOnA5+VKOIehvfDLrquE7Eumm6RHThNwiYqssKDMQPjTQXONjPARlzpOD0PqvS+0b91g
X-Gm-Message-State: AOJu0YybBLTDJ5XPBJEuS6qAtO0EXjKsFXToD07GYS7Ry73hvE0yp2Y0
	Z+r/0egRFoPNdzijzaUSJPG/whxEaxn+NMaazGys51jHrkmOVnF11lIe9lmLNcpkuEcVYVNJwFo
	KsUP8INS9LtZtMVYnOr8YcxpBDNk=
X-Google-Smtp-Source: AGHT+IG5tj1LsMcpDG9iJEqK1HR12sjOqFfSwr7GKb5SIAMFu3P7P9OuFFklHYJ/zhy5KgMtgEWiE8Mv1Vsf7dmmfb0=
X-Received: by 2002:a1f:c842:0:b0:4c7:b048:bb9c with SMTP id
 y63-20020a1fc842000000b004c7b048bb9cmr7245066vkf.15.1709077018687; Tue, 27
 Feb 2024 15:36:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227220930.213703-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240227233310.GB1002886@ragnatech.se>
In-Reply-To: <20240227233310.GB1002886@ragnatech.se>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 27 Feb 2024 23:36:08 +0000
Message-ID: <CA+V-a8vEZjO7DPA+61rWkjN5TF-CoBEOauhF_AQs+JkFErCZLA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: soc: renesas: renesas-soc: Add pattern for gray-hawk
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

Thank you for the review.

On Tue, Feb 27, 2024 at 11:33=E2=80=AFPM Niklas S=C3=B6derlund
<niklas.soderlund@ragnatech.se> wrote:
>
> Hi Prabhakar,
>
> Thanks for your work.
>
> On 2024-02-27 22:09:30 +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add pattern for Renesas Gray Hawk Single board (based on R-Car V4M SoC)
> > to fix the below dtbs_check issue:
> >
> > arch/arm64/boot/dts/renesas/r8a779h0-gray-hawk-single.dtb: /: compatibl=
e:0: 'anyOf' conditional failed, one must be fixed:
> > 4695 'renesas,gray-hawk-single' does not match '^renesas,(emev2|r(7s|8a=
|9a)[a-z0-9]+|rcar|rmobile|rz[a-z0-9]*|sh(7[a-z0-9]+)?|mobile)-[a-z0-9-]+$'
> > 4696 'renesas,gray-hawk-single' does not match '^renesas,(condor|falcon=
|gr-peach|salvator|sk-rz|smar(c(2)?)?|spider|white-hawk)(.*)?$'
> > 4697 'renesas,gray-hawk-single' does not match '^renesas,(can|cpg|dmac|=
du|(g)?ether(avb)?|gpio|hscif|(r)?i[i2]c|imr|intc|ipmmu|irqc|jpu|mmcif|msio=
f|mtu2|pci(e)?|pfc|pwm|[rq]spi|rcar_sound|sata|scif[ab]*|sdhi|thermal|tmu|t=
pu|usb(2|hs)?|vin|xhci)-[a-z0-9-]+$'
> > 4698 'renesas,gray-hawk-single' does not match '^renesas,(d|s)?bsc(3)?-=
(r8a73a4|r8a7740|sh73a0)$'
> > 4699 'renesas,gray-hawk-single' does not match '^renesas,em-(gio|sti|ua=
rt)$'
> > 4700 'renesas,gray-hawk-single' does not match '^renesas,fsi2-(r8a7740|=
sh73a0)$'
> > 4701 'renesas,gray-hawk-single' does not match '^renesas,hspi-r8a777[89=
]$'
> > 4702 'renesas,gray-hawk-single' does not match '^renesas,sysc-(r8a73a4|=
r8a7740|rmobile|sh73a0)$'
> > 4703 'renesas,gray-hawk-single' is not one of ['renesas,imr-lx4', 'rene=
sas,mtu2-r7s72100']
> > 4704 'renesas,gray-hawk-single' is not one of ['renesas,smp-sram']
> > 4705 'renesas,gray-hawk-single' does not match '^(?!renesas,.+-.+).+$'
> > 4706 from schema $id: http://devicetree.org/schemas/soc/renesas/renesas=
-soc.yaml#
>
> The change is correct, but I don't think you need to phrase the commit
> message as fixing an error. This change extends renesas-soc.yaml with
> support for gray-hawk.
>
Aha I see, I wasn't aware gray-hawk was added after renesas-soc.yaml
was introduced. I'll reword the commit description and send a v2.

Cheers,
Prabhakar

> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas-soc.=
yaml b/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
> > index a5fcd471983d..5ddd31f30f26 100644
> > --- a/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
> > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas-soc.yaml
> > @@ -37,7 +37,7 @@ properties:
> >        anyOf:
> >          # Preferred naming style for compatibles of SoC components
> >          - pattern: "^renesas,(emev2|r(7s|8a|9a)[a-z0-9]+|rcar|rmobile|=
rz[a-z0-9]*|sh(7[a-z0-9]+)?|mobile)-[a-z0-9-]+$"
> > -        - pattern: "^renesas,(condor|falcon|gr-peach|salvator|sk-rz|sm=
ar(c(2)?)?|spider|white-hawk)(.*)?$"
> > +        - pattern: "^renesas,(condor|falcon|gr-peach|gray-hawk|salvato=
r|sk-rz|smar(c(2)?)?|spider|white-hawk)(.*)?$"
> >
> >          # Legacy compatibles
> >          #
> > --
> > 2.34.1
> >
>
> --
> Kind Regards,
> Niklas S=C3=B6derlund

