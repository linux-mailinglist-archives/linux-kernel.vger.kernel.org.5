Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59E77C9115
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 00:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjJMW5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 18:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMW5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 18:57:21 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0FCBB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 15:57:19 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-4527d65354bso1244207137.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697237839; x=1697842639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6wPwnmETenw6MmBk8K6nY/876otg8xGa1r8lksqWFBc=;
        b=R1//LzMzLKPsUvAlnDcBcG/qOgiKfnUNJoCjk88FFoqB/d6paLYE+Xz2MFvdFcg/QL
         WyJIA8oCZiwcR2CucLYrutT/OPCKHaDX3i39FkkTjLBAEGr9MjMKit5jS6bRLWb3vYhC
         N7AOiIaRHbCFujVbQ9r1O8x0a1jqjaiqZSG20H95bUJYSTwDlo31YvXUZ+11AeQKfQcr
         YI+TTd29+QpAQcfTVX/BP2oaRhuagB+s/9l8WIKtVcsdtYtPe12umNLeCPfJKVA+HTQy
         2QHdszF1kgVKwqFA7eEhB1pSxqp6LObUGK5UKWDfgqJSqFiKrMxjWaZMi9vfivEO+mz3
         GTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697237839; x=1697842639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wPwnmETenw6MmBk8K6nY/876otg8xGa1r8lksqWFBc=;
        b=CPdmdJrgeZF71yWU4eKZ+8Yvp7hybiOnrkdLymU8OHXdMltqeaVXQKdwTfVByJ0Jrg
         h47bmSdwK4y1fSF8EO3n6hvMSKXfBsmbG2ak7v+jpRKqtzSAvalB+maYK+iZkmV/JrvF
         vIO9IaDcKX23QzmdDyfDQDSb3TooU6hBlUdCTb7fmf70ZZ++TGN4RYkir1kQ+kProScz
         8h3Fao3Ny2ymBqVN5tkS01EJ6XOjEGD9AYXJliORDyF4e9JOFj5y+jSvLzHqPeyGw7R9
         YUiKk7CzLzs7DqfcYB5I8Ka6X/DJrsz31lkTOh2TCqqjvyI5QNLBpdm8VVfpoFIxPnwb
         pAzg==
X-Gm-Message-State: AOJu0Yx4Ctrb8sblMGc9yyLSBcL48xKDXZ7AfAu7UlwC2T1TADw1Z17T
        Bl06ounF+zfQ1R2zi4ASkgCUbg==
X-Google-Smtp-Source: AGHT+IEm521axeEFcZNtZSTDXsrzq0pBe+Wjc+fnqpTA3yy2QUWHpG+Ba3EbnGKWa7HD0w1qKfSdyg==
X-Received: by 2002:a67:ce81:0:b0:454:607d:196f with SMTP id c1-20020a67ce81000000b00454607d196fmr29124394vse.20.1697237838405;
        Fri, 13 Oct 2023 15:57:18 -0700 (PDT)
Received: from fedora (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id g13-20020a056102244d00b00450fc8d2c76sm540643vss.28.2023.10.13.15.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 15:57:17 -0700 (PDT)
Date:   Fri, 13 Oct 2023 18:57:15 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee@kernel.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] counter: fix, improvements and stm32 timer events
 support
Message-ID: <ZSnLSwsr7RxLdPie@fedora>
References: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fFNMSGoF3fO7Sh+E"
Content-Disposition: inline
In-Reply-To: <20230922143920.3144249-1-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fFNMSGoF3fO7Sh+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2023 at 04:39:14PM +0200, Fabrice Gasnier wrote:
> This series combines some fix and improvements to the counter interface,
> found while stm32 timer counter driver developements.
> It also introduces a new tool that can be used for testing.
>=20
> Then, it improves the stm32 timer counter driver by introducing new signa=
ls,
> e.g. counting frequency, and missing channels.
> It also adds support for interrupt based events using the chrdev interfac=
e.
> Two event types are added in this series: overflows and capture.
>=20
> Up to now, stm32 timer counter driver focused mainly on quadrature
> encoder feature. With this series, all timer instances can be enabled
> for simple counting (with overflow and capture events).

Hi Fabrice,

Would you give a brief summary of the possible configurations we can
have for these devices. For example, the existing driver supports a
quadrature counting mode where Channel 1 and Channel 2 serve as A and B
inputs; I also see that another mode is a simple tally counter with the
internal clock serving as the input. How do Channel 3 and Channel 4 fit
in here?

If you list out all the possible arrangements, I think it'll help me
understand how the signals match up with each particular mode.

Thanks,

William Breathitt Gray

>=20
> Changes in v2:
> - counter fix and improvement patch applied, hence dropped in v2 series
> - mfd patch applied, hence dropped in v2 series
> - revisit watch events tool (mainly command line interface)
> - add one patch to rename STM32 Timer counter
> - various review comments from v1
>=20
> Fabrice Gasnier (6):
>   tools/counter: add a flexible watch events tool
>   counter: stm32-timer-cnt: rename quadrature signal
>   counter: stm32-timer-cnt: rename counter
>   counter: stm32-timer-cnt: introduce clock signal
>   counter: stm32-timer-cnt: populate capture channels and check encoder
>   counter: stm32-timer-cnt: add support for events
>=20
>  drivers/counter/stm32-timer-cnt.c    | 558 ++++++++++++++++++++++++++-
>  include/linux/mfd/stm32-timers.h     |  15 +
>  tools/counter/Build                  |   1 +
>  tools/counter/Makefile               |  12 +-
>  tools/counter/counter_watch_events.c | 368 ++++++++++++++++++
>  5 files changed, 934 insertions(+), 20 deletions(-)
>  create mode 100644 tools/counter/counter_watch_events.c
>=20
> --=20
> 2.25.1
>=20

--fFNMSGoF3fO7Sh+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZSnLSwAKCRC1SFbKvhIj
KzirAQDCyH9zW+B+KquLIfRNSk5vcmFjucDHtM60OcOVpFTebgEAxPZD+Cu+RmK1
WYaD1a0bSMAQ1xu3JYrlOIxW+sxb5QM=
=QW5W
-----END PGP SIGNATURE-----

--fFNMSGoF3fO7Sh+E--
