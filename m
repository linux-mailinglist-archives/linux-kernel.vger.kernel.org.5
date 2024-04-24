Return-Path: <linux-kernel+bounces-157083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCD78B0CA4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E682E1F22940
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E455515E810;
	Wed, 24 Apr 2024 14:34:04 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08451E511;
	Wed, 24 Apr 2024 14:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969244; cv=none; b=nwV2BG6UigyXdovXjpBrksAWydF5Rca6/Klxr1asQ+tCAsWi00N5iFt1ZXsUkTpZ+l2C2OWuc+BehuUeWOSmwR452sMLPZkWvUr6g3ht5HvrodqD8uWypz7DTu/eVmRNNdp2PF4e0Y42NU0ivr3SVm6UGhgsYVfRsQL/+EeGcaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969244; c=relaxed/simple;
	bh=VqOGJjRg28bc7eBQoexT89Jdg/lKWSrrtVGPjKj+334=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgHIr0OJ3hDF3d8A0NBtgp7tEUTNYLozjTJ5sShtm54iLUU5C0Oapc86RgBzRG3wZz9abo38uRJ1j/Vc0H9gVuw/P4YwBdC65rxTNk0ftpc0XFrI3P6xFjPNqiJ4z2p6VhixBsowezdEDjpeY3W5G7r/6o+LV14X2essWhAkgSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de55e876597so1682748276.1;
        Wed, 24 Apr 2024 07:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969240; x=1714574040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSe7bhwwM2b2w33Jw4XNWuzshIif1+7J1tm/9bS2R8A=;
        b=eVehSVkavLx1DlrnpXOgzLwO5zrCTLX+Csza9XIW40xYPPqInPIH6xJhgza4JeITH9
         m9VOtLfVn3m4pKVBdHLs7Fe9J4G2RFjkgpNCRyaEkofXBFtq/MjDqqs1N28+h0B6AVJk
         MUi9v2lRaRDGnkmpHaoXEWKOxk9mz28QCZOBKw6YM89DtTXc9lIk1+TIelqNRcJJ/10L
         eYQuMzH1IXHycYFUGlTv2KVrkqkqHU3G5/kjgVOJuZiZ2TVCJe2tn+uXSB/10qsRsxdz
         FSYVgc8NnVkDsAGqxp4jCWae6FdM3xCktU09UuIQ69WPKk4d3AtO07S9GlqdDwXtg6ZI
         5EAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSSogjsyP5FPpTxLOZPi4T+eCCUzmCBJZIbwtK8X9kNKV2wRGzGm+yumfmYW8h3gb56m5/4DnU3MFY0VSPc1tSa/k4G1q1my6VX56fwckzKmQN+0Pi5GU/tucJF1vbzF01mNhjMHYkjBvC3QVZGjRETA2v1E2FOlZdiGo1cVeCkKXJ7nOuzIBFoeMn1H30FUrCBcXub6H1Z035z9548pRSYw6BagTJ9dn46tz397e0z0AQuWkVzFduhXNEnQ/SqLw=
X-Gm-Message-State: AOJu0Yx5j3piqto8wwrJE2fPbNOIKrEAP7FpC+JuwnzXTM7xbkoT5w04
	CwhwJXabOfrIWy93a22JCGMv2U+zf+tUoSW3KsDbx+3XTzDSEcWIBw+XBoytVzk=
X-Google-Smtp-Source: AGHT+IEObBbN5M++ErhYwaDrkgrr0IpwEqoFf02RUCQvvbFUU/DBvvZ+TLfcj71hUZyJ9zFgRlIkHg==
X-Received: by 2002:a25:68c5:0:b0:de5:4a6d:96f9 with SMTP id d188-20020a2568c5000000b00de54a6d96f9mr2906664ybc.51.1713969240076;
        Wed, 24 Apr 2024 07:34:00 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id u15-20020a25840f000000b00de553cb23d7sm914886ybk.56.2024.04.24.07.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:33:59 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc236729a2bso6578423276.0;
        Wed, 24 Apr 2024 07:33:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWEB1+6dFOXn+/CBMmFfly8h/txC59WuMhZoR7LmmfogXpajrg3VcnTSrUZjt7aukFBY2lXnNYSpy/c3vrZYTCHuqFPAP2tqF6Z2mZlvJnB41XTJLjY294S48ZBmNkWwi9U06LEFKoZ316B7ZB5kh0Ft3uWwO+KWJMnDQEmkWfySOKo2WYy01VaxtNQjBteigr+y7OEolDVNT9hiK8/Uxc9w88AHJocZMfKgFoXpTuB5d0K8zoTXHdfj9ZEyKEX3Ks=
X-Received: by 2002:a25:b31b:0:b0:dcc:fea7:7f7b with SMTP id
 l27-20020a25b31b000000b00dccfea77f7bmr2825103ybj.11.1713969238504; Wed, 24
 Apr 2024 07:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 16:33:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXHhsdOgTiDdqMwAMvb-m_VBqOcTRPURx_upc2AtmBTfA@mail.gmail.com>
Message-ID: <CAMuHMdXHhsdOgTiDdqMwAMvb-m_VBqOcTRPURx_upc2AtmBTfA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] clk: renesas: rzg2l: Add support for power domains
To: ulf.hansson@linaro.org
Cc: Claudiu <claudiu.beznea@tuxon.dev>, mturquette@baylibre.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

On Mon, Apr 22, 2024 at 12:54=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Series adds support for power domains on rzg2l driver.
>
> RZ/G2L kind of devices support a functionality called MSTOP (module
> stop/standby). According to hardware manual the module could be switch
> to standby after its clocks are disabled. The reverse order of operation
> should be done when enabling a module (get the module out of standby,
> enable its clocks etc).
>
> In [1] the MSTOP settings were implemented by adding code in driver
> to attach the MSTOP state to the IP clocks. But it has been proposed
> to implement it as power domain. The result is this series.
>
> The DT bindings were updated with power domain IDs (plain integers
> that matches the DT with driver data structures). The current DT
> bindings were updated with module IDs for the modules listed in tables
> with name "Registers for Module Standby Mode" (see HW manual) exception
> being RZ/G3S where, due to the power down functionality, the DDR,
> TZCDDR, OTFDE_DDR were also added.
>
> Domain IDs were added to all SoC specific bindings.
>
> Thank you,
> Claudiu Beznea
>
> Changes in v4:
> - dropped the pwrdn functionality until it is better understanded
> - dropped patch "clk: renesas: rzg2l-cpg: Add suspend/resume
>   support for power domains" from v3; this will be replaced
>   by propertly calling device_set_wakup_path() in serial console
>   driver
> - instantiated the watchdog domain in r8a08g045 clock driver; this
>   allow applying r9a08g045 clock patch w/o affecting watchdog and later,
>   after all good with watchdog patches series at [2], only patch
>   "arm64: dts: renesas: r9a08g045: Update #power-domain-cells =3D <1>"
>   will need to be applied

Are you happy with this series?  I would like to queue patches 1-7 in
renesas-clk for v6.10 (i.e. this week).

Thank you!

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

