Return-Path: <linux-kernel+bounces-157046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3894E8B0C14
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EABE6283291
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C23F15E5B0;
	Wed, 24 Apr 2024 14:11:11 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFAF1E4A9;
	Wed, 24 Apr 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967871; cv=none; b=HIKLb6Gm1ns2+fn//PEqFLUVw6Nq+Hqlj2oBWJ77M2AZvSkZFBMu2GYMc0q+pSBc703cjAdpQ6gEbMDvA4/K+UQQh1ZOxeDRnuj6XIhwwu+xidb0s5+i55DCaPWhaCkpmPB1nSCzt8UWsGwTOf5ppje9UKgTRBXFBvoSWt48N0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967871; c=relaxed/simple;
	bh=5dXN+mfZQ2ggrA6HoJ84WTeztZHlVMG+dLWiKYuZS5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nKyfTd4+ob6Wqlhzn7pl3SD24IDFgggARUK3ocG+6bls5FLJ6A9Qcyz5CnLuJUvHdfuq0nKfH6aVk1cFQvGCQoIGc+h2JZXVY8dFdJhIOqjnJVqNr5kxe0bK4L9cqWLz9qjN+HjKV//c3SsBlkI3s/bzfv6QZvmeewgxzZEbk7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-6181d032bf9so66381007b3.3;
        Wed, 24 Apr 2024 07:11:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713967866; x=1714572666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeKlI8nLud1SErjnDXdSOd+Bl2oByZHvcaJe+cPSXMQ=;
        b=OJ+2+qL74GmFAXd1SupoIc/P+bqMXTwmal60ZP/vvgYXgPDPrABAiy0tUIiAL2uJ1p
         cM1i9OeP71k48dMar2Cc3/kglrgyj/XtACS9J28cp+96yKozyGvY4wGyMnEJCBNXGqkQ
         kjsKDMTzKO5O5D8D6UUGeByCoJdESDhHT2w0Y9ilhEP1ylxfUjmAwbSa2HZ2s9j/IFdW
         JFQG8oQLzfS5RqhreYgvfJxhee4sdQFXZZOY5hvAYzQ/GrVJP23zWeoaa0HJFopkmsPb
         Wr2PXE1uz9ujQQBWhmSTA4PD1lYh0oM+CrpGySdASFl0FigHWLdK9OqiS/UpqPdzeNHW
         mBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxSdk6cuXHLgbt4McWSl4sCz35KOuBIqZfnenUYurdm6C9xvfS4dLaZtKhn235b/k+9G6Wsyik0zdS+sCKwGYuEPLOkwJ/Dg+1OJcjaWnmPmtRF3ecvFJNzFOBmVlJipdgRuUvBAqgLET4vIyXBt5dcHu+mjjeNYsoA7oDEV7heAIbEUvz3FvLUo3EahM1Q098xrsTMoOU+j9mzVHZ7HXDYAwGcUmmVYY81iUiCvAuyK40wZnSKG8kPXbVPNU3MhI=
X-Gm-Message-State: AOJu0YzE5VCEXQXA00D6KUT3I/PJeu+EL+lxSQfq9t4TQV5zKNtGCN8q
	1DjeNNgCUavZthaSe3fzFzgeVq76H3h1gcl9Kih2yiQlxWLuQOo2YiVCjmv9/gI=
X-Google-Smtp-Source: AGHT+IF11K1EoEd1+Osi4HIjzqxK3pfWam7GkqBGkKXXOYEQWxJON1iXhcStgI+8HE7C4rTEqyamNQ==
X-Received: by 2002:a05:690c:6f02:b0:61a:b568:a3cd with SMTP id jd2-20020a05690c6f0200b0061ab568a3cdmr2927910ywb.2.1713967866339;
        Wed, 24 Apr 2024 07:11:06 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id j7-20020a81ec07000000b00617e3ac0deesm3016381ywm.86.2024.04.24.07.11.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 07:11:05 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61b4cbb8834so43325337b3.0;
        Wed, 24 Apr 2024 07:11:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNScRrInzVuK324Jr0P7FoShoal7+Ps+PCOZ4KSvHh4wJAFD1grSX9MM8GBpNsLFV9RC+x+JOsSLiS3+RpwTToEhoJjg+0T1CtTmy3PLealhuNwGht886rOiWPj3J+4T5+4zY15jOSpZK8V9YPx50wfSJPsk5cU/Jk1m+9QEOJnE4eaK/xcsM/30LpuGlLxOGEbjpJLwqqfDHSnSk4vOMsNNDoqNm+jaVTyBlILnVhrWdIMH0kPmfIXKnevoEC+i0=
X-Received: by 2002:a25:9841:0:b0:de5:1f5f:3682 with SMTP id
 k1-20020a259841000000b00de51f5f3682mr2514179ybo.30.1713967865300; Wed, 24 Apr
 2024 07:11:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422105355.1622177-1-claudiu.beznea.uj@bp.renesas.com> <20240422105355.1622177-8-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240422105355.1622177-8-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 16:10:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWeLemK_o=DZU=MxQLK78OS-OeHiDm-eiG-Oir_wE3ejw@mail.gmail.com>
Message-ID: <CAMuHMdWeLemK_o=DZU=MxQLK78OS-OeHiDm-eiG-Oir_wE3ejw@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] clk: renesas: r9a08g045: Add support for power domains
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
> Instantiate power domains for the currently enabled IPs of R9A08G045 SoC.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v4:
> - dropped DEF_REG_CONF() specific to pwrdn functionality
> - dropped ddr, tzcddr, oftde_ddr domains as these were there due to
>   the pwrdn functionality
> - added wdt0 domain; this will not impact currently integrated
>   watchdog support
> - @Geert: I dropped your previous Rb tag due to the changes in v4

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

