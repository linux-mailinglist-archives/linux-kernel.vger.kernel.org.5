Return-Path: <linux-kernel+bounces-92536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3E98721D1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C34E2B23CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D986AE2;
	Tue,  5 Mar 2024 14:45:17 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACD28663A;
	Tue,  5 Mar 2024 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649916; cv=none; b=W6rU1OV/9xTf4vWoynKus+vDYGJEWZnCCbAt+Xu1QBVBY7Uu+2G5K6cyGZNCNlyhQJLNwWzvogx7GhZFbEvKWdgyyqeLdrSif0csCz9OmEHlrKrmqzvqbEWX+arIcb+/ogIPo7GxjH3ZBxO+rMNpOOjoiPSTKFSMPnCSB5LLgF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649916; c=relaxed/simple;
	bh=tetQCxG8iPLLeYy5u22XyaGe6rMdgCMO7OFx8pAFHyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LXV2Ozq+aQ4m2aJWRAamDLOngCH3SJvvnJhA1Ik7TFNhMIhhhRlcNDfB+HGDpxm/IedHGGFkP9Dqa/nWZb4SAWiBI0fhA2SZnKzVFoS/hAmHJXLRtQauNnyf03h+Gc/A4HDx+kXdErOxKu3MK0OpWdEufsdOeqVK9WGUeZLEKN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6087396e405so55074917b3.0;
        Tue, 05 Mar 2024 06:45:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649913; x=1710254713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i6CwydHdc4za10aM3u8vcYxRtgXXdjZlKPLkkrrifs=;
        b=HVBTgNVQjDsv+3ITkjy19c329XBPsWSIANZajwn988IwbqmKlusOmr7LDBTLwCzDDH
         ptJtyiOZC96plA+gKvbU/jerszX79EzJzcv9YrfBmwwn2V+LlT8NmBKYSIMFGXactFIH
         d0KebV4ZNuyKvr1moeqdPbRQw+D4v85jKvdcrepjdrmBtotlmyywZN4DFWotOTERII5P
         HhITtxDYcNlpxBHtXD77voG1lA3vS0UJLv4heMhXyyEtobV3p8J1XjnYCcq3hmga/t/r
         rppb2MHnPz9EdsdnOPmjVmbR348ZNk6sU7LJ2zS7Urls2RIpyzd5zMmukROKVrWoX2W5
         MCaA==
X-Forwarded-Encrypted: i=1; AJvYcCUyHTe3E/mlUTXb5OgWrTNx22vfmCa7r4xRqcKJMxBZAyht1gJhATPYrpmHjmeqh9NDmLlbMhJRD7M1QJl1XK0g4i/XXXDC884MQF4A+sXmgjFh72+QTOgN0O19YCHlWEApL7LmT0IytZ7LFWWxVy/z5BD2aK0XqEDXzd3YXk11vppqfw==
X-Gm-Message-State: AOJu0Ywiy9epuI16FWLtYrl2Sh9Cj7s20jq81vqEY5rQQrP1sECw9T7V
	cE2lUG7lr81cVP4d0p4SieAkNTPnwdKQLeeR1DpYzxyhRpH0PUCL6AF47rW/pkQ=
X-Google-Smtp-Source: AGHT+IH2uJ0PB5iGWa3Pxy8t4zIKB0Bssu9oR5KhruM+s+08ReQDS50EYAC9a8nhanR2J7oB4pzi6g==
X-Received: by 2002:a25:bfd0:0:b0:dcd:9a9b:8d7e with SMTP id q16-20020a25bfd0000000b00dcd9a9b8d7emr1907695ybm.9.1709649913115;
        Tue, 05 Mar 2024 06:45:13 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id e72-20020a25694b000000b00dc701e0bdbcsm2755061ybc.44.2024.03.05.06.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 06:45:11 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6087396e405so55074577b3.0;
        Tue, 05 Mar 2024 06:45:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRL+SNdr8xdyNvwp7D+nFHxRex0CEYwGjXqoLdnxqRAXkmlheqVB3h10ThpVzorTNOL2VPd+cBbalXyTarhCg+wuoaRujQRZu6qpGc4DWVCi4umleTO9Rog0/xEjcsTMMCGC1ndpIFOcTj5fHYs3ZaLlX7jSK+QWrMoD9ZAGTWCtFWoQ==
X-Received: by 2002:a25:aa85:0:b0:dc6:cf8e:8f97 with SMTP id
 t5-20020a25aa85000000b00dc6cf8e8f97mr2212248ybi.27.1709649911607; Tue, 05 Mar
 2024 06:45:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213144638.341509-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240213144638.341509-1-krzysztof.kozlowski@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 5 Mar 2024 15:44:59 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWw0dteXO2jw4cwGvzKcL6vmnb96C=qgPgUqNDMtF6X0Q@mail.gmail.com>
Message-ID: <CAMuHMdWw0dteXO2jw4cwGvzKcL6vmnb96C=qgPgUqNDMtF6X0Q@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: starfive: replace underscores in node names
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof

On Tue, Feb 13, 2024 at 3:48=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> Underscores should not be used in node names (dtc with W=3D2 warns about
> them), so replace them with hyphens.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for your patch, which is now commit f03606470886e781 ("riscv:
dts: starfive: replace underscores in node names") in v6.8-rc6.

This causes e.g. BeagleV Starlight to hang during boot without any
output.  Booting with "earlycon" reveals:

    dw-apb-uart 12440000.serial: error -EINVAL: clock rate not defined
    dw-apb-uart: probe of 12440000.serial failed with error -22

and indeed, p->uartclk =3D 0.

> --- a/arch/riscv/boot/dts/starfive/jh7100.dtsi
> +++ b/arch/riscv/boot/dts/starfive/jh7100.dtsi
> @@ -113,28 +113,28 @@ cpu_crit {
>                 };
>         };
>
> -       osc_sys: osc_sys {
> +       osc_sys: osc-sys {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0>;
>                 /* This value must be overridden by the board */
>                 clock-frequency =3D <0>;
>         };
>
> -       osc_aud: osc_aud {
> +       osc_aud: osc-aud {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0>;
>                 /* This value must be overridden by the board */
>                 clock-frequency =3D <0>;
>         };
>
> -       gmac_rmii_ref: gmac_rmii_ref {
> +       gmac_rmii_ref: gmac-rmii-ref {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0>;
>                 /* Should be overridden by the board when needed */
>                 clock-frequency =3D <0>;
>         };
>
> -       gmac_gr_mii_rxclk: gmac_gr_mii_rxclk {
> +       gmac_gr_mii_rxclk: gmac-gr-mii-rxclk {
>                 compatible =3D "fixed-clock";
>                 #clock-cells =3D <0>;
>                 /* Should be overridden by the board when needed */

The clock driver relies on the clock names, which are (in the absence
of clock-output-names properties) identical to the actual node names:

drivers/clk/starfive/clk-starfive-jh7100.c:    parents[i].fw_name =3D "osc_=
sys";
drivers/clk/starfive/clk-starfive-jh7100.c:    parents[i].fw_name =3D "osc_=
aud";
drivers/clk/starfive/clk-starfive-jh7100.c:    parents[i].fw_name =3D
"gmac_rmii_ref";
drivers/clk/starfive/clk-starfive-jh7100.c:    parents[i].fw_name =3D
"gmac_gr_mii_rxclk";

Hence these clocks can no longer be found, and all children have a
zero clock rate, causing the breakage.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

