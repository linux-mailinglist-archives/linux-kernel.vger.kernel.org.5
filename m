Return-Path: <linux-kernel+bounces-24884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A4C82C436
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C87F1B21756
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8463717540;
	Fri, 12 Jan 2024 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKkRoJNr"
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E717C78;
	Fri, 12 Jan 2024 17:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-20503dc09adso4122939fac.2;
        Fri, 12 Jan 2024 09:06:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705079175; x=1705683975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxDmPbTUZ80+lOlOzGwr67WCJ4FJvPU58qXtdfRO14Y=;
        b=kKkRoJNryBvbESNylrTjr9EYEcGkzSFvFwMduSgYT8/ESpx3kn63h+SlN16hQnecse
         4a8YKxUguGWa+zKXK7RILw7p/+anwtaJMOxxF+I39ogqX9Cf4TC7HJiCUNmCkB1WuX9B
         4NdJYpi3sgzClQi/3nQIAq9PTv8OF3YBOGOWvsJEmJ2yg107pAkPJQfh1wroRmr0dXRH
         JmxJqSu7g8llUMs6B8immYJZHUDopr1Ydvh5l2xYsUulfwIKxVKt+rWRFnx5ZtGs8haO
         svDKlmDiN0xITtz1RBH4FjERsObz6/+3U3lRdfK3JJVJVr6MzMFdAV7HzLkIYrRhTpgj
         4mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705079175; x=1705683975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxDmPbTUZ80+lOlOzGwr67WCJ4FJvPU58qXtdfRO14Y=;
        b=nP8Wms2qhMbMpTrT3jwCTPZGiOSD55oBo8hwl3CHWeLZmoQoFcbToR8iXRPFQJKigx
         fbcSTLXTatsDYHJtYaqJX90TI2MdSSrJdtBZqzlN1rAUYX9f/24fktqu8CAqw7ciQmoA
         kVIBBRiy1+J76xUOVam6AX9MaS/FKqRdBe7u6svFL680FprDrg4mHUV/AOgTBUvMJ5RL
         Ykt9wc0hOEsmfR0H+tFYP1pYlKFTtxE3rne8iBrJl2cm3LleT7JESPWksIuAVDWNQSsh
         C2XGp1w7t/rtJvOwXQrTdQWnMPkjDT6EUzb+9QOYddX2tYhpXmmE+AcVSc56n9UrpuFj
         00sA==
X-Gm-Message-State: AOJu0YyhP26p9SwCbDIUi5pBUSS8KAJ920X4o1jdx7XoBsicBvlJtOfj
	dr5n2iu7Gjz9Gse9nf0KG0d8v7kFSifQDXM7ggo=
X-Google-Smtp-Source: AGHT+IHJs7Sb6cRG8FtEN2BTrbb3u51J7kM7B9co7sQh7KIPYGKioMWBlt7G2jC3jaUY9GU6LXslcm+q7S40rx3lBCA=
X-Received: by 2002:a05:6871:413:b0:203:743e:ba22 with SMTP id
 d19-20020a056871041300b00203743eba22mr1879464oag.89.1705079175449; Fri, 12
 Jan 2024 09:06:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112142621.13525-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240112142621.13525-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <TYCPR01MB112699FAB53E6E4647893516B866F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB112699FAB53E6E4647893516B866F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 12 Jan 2024 17:05:48 +0000
Message-ID: <CA+V-a8smkiub9ACDsqxv0z8yF_iLVEXG2OHwS7iJ+tmsdmTQ6g@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missing
 port pins P19 to P28
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Biju,

Thank you for the review.

On Fri, Jan 12, 2024 at 2:31=E2=80=AFPM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
>
> Hi Prabhakar,
>
> > -----Original Message-----
> > From: Prabhakar <prabhakar.csengg@gmail.com>
> > Sent: Friday, January 12, 2024 2:26 PM
> > Subject: [PATCH v4 3/4] pinctrl: renesas: pinctrl-rzg2l: Add the missin=
g
> > port pins P19 to P28
> >
<snip>
> >
> > +/**
> > + * struct rzg2l_variable_pin_cfg - pin data cfg
> > + * @cfg: port pin configuration
> > + * @port: port number
> > + * @pin: port pin
> > + */
> > +struct rzg2l_variable_pin_cfg {
> > +     u32 cfg:20;
> > +     u8 port:5;
>
>  u32 ??
This is done based on the feedback provided previously by Geert [0].

> > +     u8 pin:5;
>
>  u32 ??
>
ditto.

[0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/2023120113=
1551.201503-3-prabhakar.mahadev-lad.rj@bp.renesas.com/#25625118

Cheers,
Prabhakar

