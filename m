Return-Path: <linux-kernel+bounces-140720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5408A183A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 870EEB2608E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D59114005;
	Thu, 11 Apr 2024 15:08:52 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00FA134D1;
	Thu, 11 Apr 2024 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848131; cv=none; b=cmDpcTGJKfhMUK4XtqT6SjenzrHwKHwjNhgcKjj+BbuhHMWhejQdIQWuTqGiPeyVXtII2XCLo7qWTzmjojwo0BMoOOeE4/ChkUHdcykxs+/2gf0LCiAMsgKoBYPvovUmBgzeq1czjlGaVSRHU1QNSaMOaQMddxLSPiGMtvC4uEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848131; c=relaxed/simple;
	bh=oU5pCmDkLmmc1H+EyQIYHeeb2Fb2Jfhgrf2CdpJQj8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yh2aEpuJpZc+7/lVzOILT1zqrqvbHjqgIFADzPUj7I69Wa8i0La1GyYGuNKLiBXX/1oEb2cPOmRY2wkvuQEhfujpiEYqkNp1bxMpr9WFf2JCMFoUo+NBwhPDU2U/qshAnSl2kzPoP9meAC0a/wy6DsOQo46TidrGHBO4JogdE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5aa369179e1so3489509eaf.3;
        Thu, 11 Apr 2024 08:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712848128; x=1713452928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E9hehHCvMAi0CNOjOnNQIxMp+8eSHK8c3QluG1cpQEI=;
        b=hz4QGYuzWr2n2amu7D31TFJmxANeRJsYllIdIe35MWbW3CVLAqaqEm3UtlwO/nF73s
         sXV67kGbld3w8LKw3XZt3AHT7DRxUnW00w+0XbXpa8VFB7cfsNQGWHe9vDcy26v/jcQD
         Ap75NxllBOFQL0DXzKjVBKHgjDstk4sNGF55mwnSj4uaSVeU+p/6/zu964UntFd3KmgD
         RqkJwWFwlYLWvhA8Ul8DA/MgYpPKKRfkemk/lEoocJh4RxZzM9/A+NsCQrOd8olNabfC
         T2Mbv4+qEr6MDjXQED6T8fA90TIE83B2Gxysno2ffIhxZ5fHKs4/xe+tfrAt1f646RSu
         JUBg==
X-Forwarded-Encrypted: i=1; AJvYcCVU3iFdoXjT9koiwvAA6Sp/kGjdVymi6noVM0koO/OXA3RIvH7XIVX/HdxRqlggDr2+r4aQWykBZwMQPySYc2k97N2atT6zB4sc9pZqphrdw2s6N3ptk+o8ebXaXEA9m0wiS4QkvGkhzqB0oZl2eHXy8fZt2iPT7FIy2L65GRzOIkkOYvj/r2oN4En2NVxF5RREqJiRcTRM7R5riU6tXYExnm3DOGjc
X-Gm-Message-State: AOJu0YwqWU0rydjKUm9F4x/opKpce6fMKMmSKrENuLZE6Mjg8Uo7PMsV
	EpsKj8B3CXqzsWSk9OAaNZ8L+BFsTDYuBKPC6vcqyaUBhObf//YPUlLez8s9
X-Google-Smtp-Source: AGHT+IEJmf89EuiAaKtpLNEr9G1LONI/+H9TLXaQI+A+h7gS1EcDEb3mORpif3yGMOl9JUO9quNKYg==
X-Received: by 2002:a05:6820:1391:b0:5aa:3b8a:b491 with SMTP id i17-20020a056820139100b005aa3b8ab491mr6955693oow.4.1712848128089;
        Thu, 11 Apr 2024 08:08:48 -0700 (PDT)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id di12-20020a0568201e8c00b005a4bcb155basm352018oob.23.2024.04.11.08.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:08:47 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c5ee4ce695so795992b6e.0;
        Thu, 11 Apr 2024 08:08:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWga1MW07g+6xV7sR//DAQStXMyY8aX6RtrMyR8BRcIFROJBCdbMkZPaz4ixHRrn3sCUkbUiWFlxZ1R7dALvzcZ0LXZ27Rcjys37oV+XfSXQZa06FOUOWt5J2+FDoDIBPDmMlv3kbipyXrOxldeTBywZ0XLiW0JrX+vLNy/4mLCQWVDpUf4CUwTeD+z2Sxdmx1v4daR2p3f0PRRE2kpZc7twG9zntKZ
X-Received: by 2002:a05:6808:644:b0:3c5:eaaf:babe with SMTP id
 z4-20020a056808064400b003c5eaafbabemr5366936oih.7.1712848127440; Thu, 11 Apr
 2024 08:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410122657.2051132-1-claudiu.beznea.uj@bp.renesas.com> <20240410122657.2051132-9-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240410122657.2051132-9-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Apr 2024 17:08:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW4CEbR0K2OfADS1S834GyRwE45Squ2OY82nDqkPLPUVQ@mail.gmail.com>
Message-ID: <CAMuHMdW4CEbR0K2OfADS1S834GyRwE45Squ2OY82nDqkPLPUVQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] clk: renesas: rzg2l-cpg: Add suspend/resume
 support for power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2024 at 2:27=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> =
wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/G3S supports deep sleep states that it can reach with the help of the
> TF-A.
>
> RZ/G3S has a few power domains (e.g. GIC) that need to be always-on while
> Linux is running. These domains are initialized (and powered on) when
> clock driver is probed.
>
> As the TF-A takes control at the very last(suspend)/first(resume)
> phase of configuring the deep sleep state, it can do it's own settings on
> power domains.
>
> Thus, to restore the proper Linux state, add rzg2l_cpg_resume() which
> powers on the always-on domains and rzg2l_cpg_complete() which activates
> the power down mode for the IPs selected through CPG_PWRDN_IP{1, 2}.
>
> Along with it, added the suspend_check member to the RZ/G2L power domain
> data structure whose purpose is to checks if a domain can be powered off
> while the system is going to suspend. This is necessary for the serial
> console domain which needs to be powered on if no_console_suspend is
> available in bootargs.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>
> Changes in v3:
> - populate pd->suspend_check on rzg2l_cpg_attach_dev() for serial
>   console; due to this the rzg2l_pd_suspend_check_console() was moved
>   before rzg2l_cpg_attach_dev()
> - removed RZG2L_PD_F_CONSOLE define

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

