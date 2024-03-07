Return-Path: <linux-kernel+bounces-95298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EA0874BEA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 217511F22BE4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB10A83CBB;
	Thu,  7 Mar 2024 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5OjH+qj"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8743483CAE;
	Thu,  7 Mar 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805886; cv=none; b=i9GxfsQoUxq0SYKF8QuREdkiHkZlkYAz7xR2+xhi13SG0vjjM8lFRFXtiBRUzeBBR26QrfqA41aI7Ec5OIXa5JMosapu82D5d0MIwEbw/qS2ybrat+bNd2hD98ZHhfI2OuA2g+soha0UC2kFxB0wgPKGUofPApBZ4I1+u3C8qqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805886; c=relaxed/simple;
	bh=WFjNa3nUa2rzuGy55gpq6ZUiWUDbWKyxNSUl2tjShI0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5yKbwTiPA15fTEmc8tz+IzXDofp6CRS5QQcf91LK1sebkY6chunjVXJ9/WC6HFpz1VnyXe5OvX5DHjaUmGmqKAt8DwSwPxadsArnSKEyfQGdscwA5T3YgNeMaya0QYwYeO4BMt8Ktaki3998fKvrIBlEF2jv54CxKnh9Rp9Y90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5OjH+qj; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e4f7c0e723so287083a34.3;
        Thu, 07 Mar 2024 02:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709805883; x=1710410683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xx95w56RGEnqgt7Xz0ZlhIHC5BxWGFuvJi0FDnmldPs=;
        b=X5OjH+qj48KqrUjGuJGbc/nPmvb54TweHsuY1oRqkGHjsYkcoQ+jAsViqRFs6Fi1EK
         HzpruZbBBvxegeDvg9+2rBbV+9MgdQ5NRnb7Ix50TPOUPSS9T8Q9kZbdeY7F434dYBta
         V0Pp6gwQ1PPvju82ZEuCY9bpXfUHzNCoIAfG9Bv5Gr0IDt8MQ7TD3i2oUsi57MSjqi5q
         bBaW3/NrFHAdHlzMawHYs7H14bJq/lBrEWC/5waIabuETTWqzgXmrvx7+yDw9/AYXpSz
         NYIZGHkC1czwuGUB8Uaoo/3mg6LNwfekey+eJfPjTaN4N7q46N4B9yY2feTDGRaZmC8k
         qwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709805883; x=1710410683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xx95w56RGEnqgt7Xz0ZlhIHC5BxWGFuvJi0FDnmldPs=;
        b=PN8oalcxHhHlX/SPBDS1ZLCrpcCpy8lETGQXtsfS+N1YxYDGOJT0bHuBfX4+2uKoXQ
         JgPXPohrMROkhbuwzvRwj/XPz82F/BdoTnpD9eAPzT3VSgIyCPb4Pgou6FujaOOw7ZAi
         WgIv2WxmiyLMiPlpBCOxAGzz5d6zCu/ig6h38FklJSEA+9M0PSvncFPPZ72aBxbAKJvb
         9Frfav0kUi4s3VeCJpFlqe0BWiyXJa+RMnP9QOjiJpuB9uovR379i8Ild9Bs9sELqMP3
         nqrC0uoGdaobZIROgoYblC4i9NzN/Howi2tDPnv5+wuCU2U0fsyp5oM8jYpoVoBJrLv3
         5WIg==
X-Forwarded-Encrypted: i=1; AJvYcCUjTNE2MFk/OW6h7PTu0PDSe+lib4bSCRZ5K/PYbeRHqlPJzQCwYlFBE04dNwxieGGn2rjskXifu6nOgQQuSemDgGbglronm0b2S+J5U28cjrictwg2Myrvw05P9IF0u+EW/pR/AMYE8pjinGOadtqOg/UZRgwYS6E2JrpKzrB8xZmIRN8=
X-Gm-Message-State: AOJu0Yw9v8zuJyz/BslNMc8R2Ru9F18gV9OGEAdsPrQX9Z5MpyaBBYzO
	Hum/iBOUjU5d9TdGC06PYyqimr33bdIGQMdD1irDYhP8BCh4KXAli21EPx7hW5FhVNnKT892dRR
	yzczFTNyyOeW5w25KoD3LIIab1tU=
X-Google-Smtp-Source: AGHT+IGVD3wzaX3Yt+FvOko++C+SVpoj1sdjPBxPgVYX2N06XjupwxcD0RKYjgL/jX1N4ZEi5q0aWnVeEtCsn4tGWZY=
X-Received: by 2002:a05:6870:1c7:b0:220:cf76:a9b7 with SMTP id
 n7-20020a05687001c700b00220cf76a9b7mr8692531oad.44.1709805883490; Thu, 07 Mar
 2024 02:04:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306201045.1475-1-justin.swartz@risingedge.co.za> <20240306201045.1475-2-justin.swartz@risingedge.co.za>
In-Reply-To: <20240306201045.1475-2-justin.swartz@risingedge.co.za>
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date: Thu, 7 Mar 2024 11:04:31 +0100
Message-ID: <CAMhs-H9WyQZsvEvCfUcZ0_eU8--EzxEmaxR50wdRFDGP3E64ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mips: dts: ralink: mt7621: add serial1 and serial2 nodes
To: Justin Swartz <justin.swartz@risingedge.co.za>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mips@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Justin,

On Wed, Mar 6, 2024 at 9:11=E2=80=AFPM Justin Swartz
<justin.swartz@risingedge.co.za> wrote:
>
> Add serial1 and serial2 nodes to define the existence of
> UART1 and UART2.
>
> Signed-off-by: Justin Swartz <justin.swartz@risingedge.co.za>
> ---
>  arch/mips/boot/dts/ralink/mt7621.dtsi | 38 +++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/r=
alink/mt7621.dtsi
> index dca415fdd..2069249c8 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -128,6 +128,44 @@ serial0: serial@c00 {
>                         pinctrl-0 =3D <&uart1_pins>;
>                 };
>
> +               serial1: serial@d00 {
> +                       status =3D "disabled";
> +
> +                       compatible =3D "ns16550a";
> +                       reg =3D <0xd00 0x100>;
> +
> +                       clocks =3D <&sysc MT7621_CLK_UART2>;
> +
> +                       interrupt-parent =3D <&gic>;
> +                       interrupts =3D <GIC_SHARED 27 IRQ_TYPE_LEVEL_HIGH=
>;
> +
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       no-loopback-test;
> +
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&uart2_pins>;
> +               };
> +
> +               serial2: serial@e00 {
> +                       status =3D "disabled";
> +
> +                       compatible =3D "ns16550a";
> +                       reg =3D <0xe00 0x100>;
> +
> +                       clocks =3D <&sysc MT7621_CLK_UART3>;
> +
> +                       interrupt-parent =3D <&gic>;
> +                       interrupts =3D <GIC_SHARED 28 IRQ_TYPE_LEVEL_HIGH=
>;
> +
> +                       reg-shift =3D <2>;
> +                       reg-io-width =3D <4>;
> +                       no-loopback-test;
> +
> +                       pinctrl-names =3D "default";
> +                       pinctrl-0 =3D <&uart3_pins>;
> +               };
> +

Please follow the preferred order for properties described in dts
coding style [0]. I know that there is some mess around the properties
order in some nodes with the current dtsi file but we did not have
coding style before and now we have it, so I think we should follow it
at least for new additions.

Best regards,
    Sergio Paracuellos

[0]: https://docs.kernel.org/devicetree/bindings/dts-coding-style.html

