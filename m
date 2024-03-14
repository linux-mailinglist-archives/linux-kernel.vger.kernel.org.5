Return-Path: <linux-kernel+bounces-103539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE1587C0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 583FD1F22676
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EA07351A;
	Thu, 14 Mar 2024 16:00:13 +0000 (UTC)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3373175;
	Thu, 14 Mar 2024 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710432012; cv=none; b=UybkOyjWcy3JIddgqNEUu+JnXD8TuD6micuFuh2vkgjZLlre4QUEGoMq1lwytM5q+L56pHk++TS3nTk6Siy3g+7Kn5l7MThIigcSlSd+i+MRt3AtEaDdS1ENbw6ssmQ2HUkqrATbpoNPZlBCR6eN6zWc1/hYVFdxCke1ervE+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710432012; c=relaxed/simple;
	bh=4MUJISf/nr3TQ7HYo25BQMIjZKwgigLAprdQ4CQYZPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7amMo2ymt8ksd5KcWxLOd3uNOp9HQLLcDazw5WsvckNHWrqqtfraRFpJ4QUBKtilTF6WU1+LqxO0gCJA7/tSW0aEtHkiaBuBufc5I+93EyOfG0GEMLwbNYuiJTiDIswrPk6WIn8o9I8GktAov7StrSbu4CpKBk4jXj0bavftdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-60cd800f396so432287b3.3;
        Thu, 14 Mar 2024 09:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710432010; x=1711036810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LvyikbsPyaYu0i7gDH1hFPWOgCXnbU21LKOtMlZYSeE=;
        b=F2u9Duo/1FIdD08n2fafF/uf3E3nNBE3rn7+jz+Y6WyZjx2fVOIUYhDXDrE1IKyBs5
         WWrA0T+4RA5QvHVvH/DfIpOjY0Ph34/ebupLgIWyFinB5iyMC61Nw2fZ5jYOlvOidPdy
         hZaHt/LvUSSeTk+WUUeRqr/SJNAOH16ojQc1ApFwvftHC66BkjFqmH4XjKAdknp31UeN
         vFJVs9ir8JSNBouv9orG/PoYy02SnUB3sRxH/kYiPTGn+Mq9c1cBN4Q5WFhjyJjAd/IF
         GJRWgbCUJYKQBWd9DJc82tiE4hcGuKDuREBJJWH9g2OV1Wl432XVB2mvP+5nnnUlXkRx
         V4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVAHAOseeypOz8M6oO8dPrR3JAOKV6J0eLz0P56SjeAsSBqy0fMfjivu26CWKt7Gm5dgVt2fOo6KCfDNehIO0LJIpi8KItKXjwWKNMc4X9CdFEzTO9DeNCJ+fG5JMI7vUVnaNTiyNTPwOMlgB+vMcx2tQvc/BC0WtvIM+Dfp6BEBbEXtQfbDMIVnTTlvwmJLYx5aRDmM40aRpccILvd+MS0og0LQbpU
X-Gm-Message-State: AOJu0YyYHS7SdRowVXy2LBEZeBY3rSAdcSsr+Kva8zRinyN7T2qU6fef
	eNkDBJT8Mur2a6yt9Esz3w/MFPB0TdhzKSmW0iul5QNhCkz45moD5KVlJPIG4ZU=
X-Google-Smtp-Source: AGHT+IGJ+U6I+T8jelm8OEwQ4ca57MvLsRiknF8m6gllG7/VjfK/NTWd0VmvhAjumpkoiP5vAjjP0Q==
X-Received: by 2002:a81:834c:0:b0:607:cb4e:eb41 with SMTP id t73-20020a81834c000000b00607cb4eeb41mr2213971ywf.35.1710432009562;
        Thu, 14 Mar 2024 09:00:09 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id ev19-20020a05690c2f1300b006098a21f7ebsm314679ywb.135.2024.03.14.09.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 09:00:09 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso875300276.2;
        Thu, 14 Mar 2024 09:00:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5ZBv1YjElNXtm0A9c16RVKsmjHX4Kf0uxBeQoquf1BeJnTpFf44KamU5OG4LcYurOjU+JXwwa9OC3zrr8U6ZCGkhIGmYsrTa1mp4FMD4j/qGl+S3GNlz4Exs4u1JVC/5vJ9XG74xXcpI2UGRc3WGtAcFAG/u0Drihe6N2Xcfqlar2FNl3gM18hQ1xvqnBACOvSjef1WjqhSa+jLMJ2BP2zvuxWfQN
X-Received: by 2002:a25:e812:0:b0:dcc:2da:e44e with SMTP id
 k18-20020a25e812000000b00dcc02dae44emr1957249ybd.61.1710432008795; Thu, 14
 Mar 2024 09:00:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307140728.190184-1-claudiu.beznea.uj@bp.renesas.com> <20240307140728.190184-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240307140728.190184-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 16:59:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUzAG7dOfrz+xFdmV3inBGZnyc=faJ_Vbj-NEjzMnV12A@mail.gmail.com>
Message-ID: <CAMuHMdUzAG7dOfrz+xFdmV3inBGZnyc=faJ_Vbj-NEjzMnV12A@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] clk: renesas: rzg2l: Extend power domain support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Mar 7, 2024 at 3:07=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/{G2L, V2L, G3S}-based CPG versions have support for saving extra
> power when clocks are disabled by activating module standby. This is done
> through MSTOP-specific registers that are part of CPG. Each individual
> module has one or more bits associated with one MSTOP register (see table
> "Registers for Module Standby Mode" from HW manuals). Hardware manual
> associates modules' clocks with one or more MSTOP bits. There are 3
> mappings available (identified by researching RZ/G2L, RZ/G3S, RZ/V2L HW
> manuals):
>
> case 1: N clocks mapped to N MSTOP bits (with N=3D{0, ..., X})
> case 2: N clocks mapped to 1 MSTOP bit  (with N=3D{0, ..., X})
> case 3: N clocks mapped to M MSTOP bits (with N=3D{0, ..., X}, M=3D{0, ..=
, Y})
>
> Case 3 has been currently identified on RZ/V2L for the VCPL4 module.
>
> To cover all three cases, the individual platform drivers will provide to
> clock driver MSTOP register offset and associated bits in this register
> as a bitmask and the clock driver will apply this bitmask to proper
> MSTOP register.
>
> Apart from MSTOP support, RZ/G3S can save more power by powering down the
> individual IPs (after MSTOP has been set) if proper bits in
> CPG_PWRDN_IP{1,2} registers are set.
>
> The MSTOP and IP power down support were implemented through power
> domains. Platform-specific clock drivers will register an array of
> type struct rzg2l_cpg_pm_domain_init_data, which will be used to
> instantiate properly the power domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:
> - called pm_genpd_init() with proper value for is_off argument
> - fixed typos
> - used flexible array for struct rzg2l_cpg_pm_domains::domains member
> - moved genpd member of struct rzg2l_cpg_pd at the beginning of struct
> - didn't initialize the parent variable in rzg2l_cpg_add_pm_domains()
>   as it is already initialized in the for block from
>   rzg2l_cpg_add_pm_domains() and that initialization should be enough
> - dropped RZG2L_PD_F_PARENT flag
> - used datasheet naming for all MSTOP registers
> - added all MSTOP registers to rzg2l-cpg.h
> - reworked the code that initializes the register offset and bits for dom=
ains
> - dropped MSTOP*(), PWRDN*() macros and introduced struct rzg2l_cpg_reg_c=
onf
>   and DEF_REG_CONF() for domain description
> - constified the 1st argument of rzg2l_cpg_pm_domain_xlate()
> - used dev instead of priv->dev where possible
> - dropped RZG2L_PD_F_PARENT
> - added RZG2L_PD_F_NONE for better description of domains in platform
>   specific clock drivers

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

