Return-Path: <linux-kernel+bounces-117136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B461A88A7C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0233E326DF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FC013CAAB;
	Mon, 25 Mar 2024 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EBswOZdo"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D513BACC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372797; cv=none; b=tJyYkWc5bKGPhuMiJWVzynZ2Bl1kIb9CwboT+vNPfyEw2ohiXAQgLDetygAcLLJyfonsesL3Ht4/BlTnzLkEjCUzf8TS6KN/IxGxiMZ79y5Cra/fc3Rdscan6MaM4qjG/n3fe04bDJ6Pl0xFk4X+wSLg41K2/tOXcHqMoPm5LR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372797; c=relaxed/simple;
	bh=T0UhGD46y7GnmjcpACpO9YkO2PsWjjjy6i5a75FohHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rZdwLiZa7HpcRmQoEK84tc7Ck7ppXLn3W7tuEhwtW4K978MuxB6USeULHuBADZuc/HQlnwJstl5o47tPbo4473kLSqKE2lVG8et0kLLkZZmYFepGpEye0Lj5kxGSOiqEWQJqO4J/pZKRYAGKtVw2RK0rqewMSkRBOH5v+bGYDGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EBswOZdo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc73148611so4731033276.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 06:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372794; x=1711977594; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yxBqMV2tXP1EFJC3ffAea+Nlp68o2kbIX/WBGOrDI24=;
        b=EBswOZdoXYXiAgsTBQJ0rKDwO4neaTATSCscl4tXH23JK6Y1rcM97BjBO/vIcyz/yD
         BjrwdtUpfzVepNKG/N4n+R2Tmn22Nw6G783FFvEzHzxJCFYyvTTnFFe9QDsJAulDqCKu
         1bmwuk3s5Bl87G1K9QeSYouBhGUBp7XmXsuQlg1y9PuIACdYsoIjaU7a4Xn2e2s7WTga
         5/zsGXO/8lWlovqTNT7xGFuS+vxBcoV5RZor5f63yz4J29mk1R1BDVN7EDV91V5/4NFw
         SeLogAkHyA9fhfa+TO96j6aljBhcJeZraJmJEpExV8Yr+2dr3rrGxJFLlPJ5AttsfgD9
         GbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372794; x=1711977594;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yxBqMV2tXP1EFJC3ffAea+Nlp68o2kbIX/WBGOrDI24=;
        b=bGov/l+IdsIAtOFeDMuBicJK3SheTpGXDsTnr7BoIVTTJjPrAdMCiL/32FZGaD4l4z
         xwhnHClausJJnADbpu6mQv8VgA8PNmHkcyenmWAXX/wUjNLP9mJ+tzcv4uttWh5hSn0e
         GMlmERqROuqAkfZGIU5K5DES23JgUrSy3djE7HGmCMX05IUfCLYagUnJvU5oHkhWLHSI
         1VZFm7qTzO1xNdPN0v1fQvYGuu9gpdy/WuShF1xXHIjZxJYa7wCLIsmz4QdLl2plRIuW
         3ZnKVeurUcdHfT7Ji/jgiXxansS+tO3U4K2giP33D9ar+YBwuom56p/ifTAntC76F8FP
         1PXA==
X-Forwarded-Encrypted: i=1; AJvYcCWerlF7Zw7Fh/ZxgbzQL6426hIX7hbWZ3DgY8S2yF2PZvmcNH2Ydho2J+LsNnQD+o22HkWkIAc3KY0MQPbd5CrhoeZurQ44lvbJSUrL
X-Gm-Message-State: AOJu0YzdLFVbiPvUKgu40d4B4T61ff0WpN2fXaaPoHfm1GBob1rAXcaN
	zfeSi+gxoh7qMrWvmOfpaPX7Ky8/aog8gmE0acopDev6+Zs58N4QcBdL4mlM94wNyvWnPOA/9n+
	RzoJ99NeGPIgbWTDakIbSEuvOpihu8hoJDvXocA==
X-Google-Smtp-Source: AGHT+IGHYRk03A+ebdrgDqCegMS+TQhHjy1L3Fp6OrAoZ21JkL2vjd7xmwf3RER4jqhhXfsQH0CLxSd+Wsa60dSp6/U=
X-Received: by 2002:a05:6902:3ce:b0:dce:53c9:4d9f with SMTP id
 g14-20020a05690203ce00b00dce53c94d9fmr5372283ybs.58.1711372794518; Mon, 25
 Mar 2024 06:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324214329.29988-1-wafgo01@gmail.com> <20240324214329.29988-4-wafgo01@gmail.com>
In-Reply-To: <20240324214329.29988-4-wafgo01@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:19:18 +0100
Message-ID: <CAPDyKFoSB3+jqw+cmc7x6NMSV9tegK=c-nUjC2pXiYFUzjEM4w@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3 support
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Chester Lin <chester62515@gmail.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, 
	Gregor Herburger <gregor.herburger@ew.tq-group.com>, Marek Vasut <marex@denx.de>, 
	Marco Felsch <m.felsch@pengutronix.de>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
	Matthias Schiffer <matthias.schiffer@tq-group.com>, 
	Stefan Wahren <stefan.wahren@chargebyte.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Yannic Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 24 Mar 2024 at 22:44, Wadim Mueller <wafgo01@gmail.com> wrote:
>
> Add a compatible string for the SDHC binding of NXP S32G3 platforms. Here
> we use "nxp,s32g2-usdhc" as fallback since the s32g2-usdhc
> driver works also on S32G3 platforms.
>
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 82eb7a24c857..466e7157308a 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -90,6 +90,9 @@ properties:
>            - enum:
>                - fsl,imxrt1170-usdhc
>            - const: fsl,imxrt1050-usdhc
> +      - items:
> +          - const: nxp,s32g3-usdhc
> +          - const: nxp,s32g2-usdhc
>
>    reg:
>      maxItems: 1
> --
> 2.25.1
>

