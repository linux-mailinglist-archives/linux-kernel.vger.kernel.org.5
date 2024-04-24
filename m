Return-Path: <linux-kernel+bounces-157045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1277D8B0C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43912881BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD5D15E209;
	Wed, 24 Apr 2024 14:10:16 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3603215B996;
	Wed, 24 Apr 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967816; cv=none; b=gY55RXd1Dr8zYJhyCtK8okBcMiVITpkxeFkkWrW22+rjQOn+SbhxpPUscp9lOKyo0QmtS9J4KyqEiI4zfBzSYL3hDXT+oOT5jccRQ0DqNvUwvo+wJMpnIAZfBEUwfKjQYusTOOeZNtUnzE44Y9Szxq719NL99etzY2yDAMF8000=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967816; c=relaxed/simple;
	bh=Y1w31Rvu7zBBDZYiN3Jt/FzqaSd5eiNVxkPtDrQGkuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j45/JTXkndJlMf7bZor4DrNTeD73P0heQ7GZ6IsmnXotgJ6Slh/pWczKIgfwhjb33A2RN4DpU6QayvLsMgz33HrGL98zMYLoJEZ1KSzlEFV96a2bFbUsytFaYqMYtDlJW9fsa6TzB9AdDTPDgp2m4A/WroIoKxxxbHoeqm+xFlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-618769020bcso74340767b3.3;
        Wed, 24 Apr 2024 07:10:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967811; x=1714572611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79YnAJzLJZsMvO3vMIQ39gqtdUV3uOsjN0bO7lVXx38=;
        b=bk9zC0YTFdhSHsgBCO9mu9NJsGRiKW6ve6k+CaeP0XxDOkjMyjeWk53rtJxXRMjarj
         YZ1HR8cGALt9E2DECAmlJsFIDfRhy2kVTck+9ha8fy6iUw4432KWb34XP5k1/nrKdcAY
         bnDgY7hU0SosG1V2gWYQ9ayNKUNt/mglRIc1utt0zIS6A+qLfC7qmwA09u4yjgpabZND
         dtISjLVPa4wtMIWDGPMfLdWxmbQdCqQccDnuaJPsMBRCFJOW2EamSftM3S3NmisvnL5w
         o/gFWvhBdcdVCUPtQpyxctRhHNgDliqb+nE+9/RcoimxmCkWK5RfmXhTZxvF6jv+0Ajc
         CCLg==
X-Forwarded-Encrypted: i=1; AJvYcCWWV+vQ1lTPPVWZfhXj9aQRfn5n+tvePAU2qI8uJGYs21D2fxbt3tqhV5qi4epm+MSqx0kxnHBZsxuPG4U+afKqc+oiHUmH/i7nfJ5auWO+nL5tTiE6c/ikRa9HaORw2bHTO6YWjK1EI54MXt0hcuDa+1hsDBSsJnVWhMRZ/JwiAiEqOEkDPTgty2yEtDWg229ea3KKm+e+c5GNgRXSVsG2ZcBBM593vWzK0gVdugBzPQv9MiQNykh9g6871msJtxw=
X-Gm-Message-State: AOJu0YwsKONd8tyiLADEwHnzzUMlUvuk4Lp+RKmrnVwa1bEZbYqCfp2r
	4NAx0nsfupaX87SRJHMtjwsCmG3Ur2jIdAVCoLpDb2tbTuXpdp1tST5t3DB4HU8=
X-Google-Smtp-Source: AGHT+IFWinzHs9h6qxtyF2O3jVZq90sj0NBcIEE35Tmtd8wkjFUiebXvanqDn8L0m2k4qg71zliT8A==
X-Received: by 2002:a05:690c:6383:b0:618:8b98:f274 with SMTP id hp3-20020a05690c638300b006188b98f274mr2675124ywb.45.1713967811550;
        Wed, 24 Apr 2024 07:10:11 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id i126-20020a0dc684000000b006158165c606sm3034546ywd.136.2024.04.24.07.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:10:11 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso6484214276.1;
        Wed, 24 Apr 2024 07:10:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqqws/wsi2+Fxc+gN2AoBIoIUTfQHxPONIyZognaqInZQefmcu89XA3eJ5RwzrKAaG9n55iVRcxHT4jdocvlvWPMWyXrJysda9EuY5oxepSp6Cnzxcq9jEG29lfJzhXTQXTSkSgPNP4cbKnPB/FwvckwDNm+ZHqtzcoaMok2taoJBJ4kAqN1KLRMSuNANOHBV+PgXl1t656QfjDzjaEbtqIBvJHNFM9+2Y2TGU4NtfHj5lFDmuv6jzR9hrlevHnJ0=
X-Received: by 2002:a5b:c4c:0:b0:dcd:3a37:bdb1 with SMTP id
 d12-20020a5b0c4c000000b00dcd3a37bdb1mr2648998ybr.44.1713967811000; Wed, 24
 Apr 2024 07:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com> <20240422105355.1622177-7-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240422105355.1622177-7-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 16:09:58 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXvcRRmCSFB9tM81CjsgyhJ=48WShpqw0cxT7aA=EYNGw@mail.gmail.com>
Message-ID: <CAMuHMdXvcRRmCSFB9tM81CjsgyhJ=48WShpqw0cxT7aA=EYNGw@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] clk: renesas: rzg2l: Extend power domain support
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, ulf.hansson@linaro.org, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 12:54=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
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
> The MSTOP was implemented through power domains. Platform-specific clock
> drivers will register an array of type
> struct rzg2l_cpg_pm_domain_init_data, which will be used to instantiate
> properly the power domains.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v2:

s/v2/v4/

> - dropped the pwrdn functionality until it is better understanded;
>   at the same time kept the code ready for pwrd being added by keeping
>   struct rzg2l_cpg_pm_domain_conf, DEF_REG_CONF(); please let me know
>   if you prefer otherwise
> - @Geert, @Ulf: I dropped your previous Rb tags due to dropping pwrdn

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

