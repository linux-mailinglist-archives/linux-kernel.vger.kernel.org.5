Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F74B803C80
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjLDSM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDSM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:12:26 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF191B4;
        Mon,  4 Dec 2023 10:12:32 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58ceabd7cdeso2886343eaf.3;
        Mon, 04 Dec 2023 10:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701713552; x=1702318352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be0ZogmXWjyNCUnYEc6/k4S4gqJjfHZoxi6an2eBP4w=;
        b=Mysn4YBcXy5a/Gljr3CbJzSNPpVCqVPC3/4LUH/IBBiJk6wtFKZ904Ztx8896To5VS
         Qg1sawLZDCRh2Rtdmz2bhKX1+0ooNyVnVXJbClxxEha8zWg5D8L0Y9+ggsHdiQ25WuRS
         sk9XpNm9OT2uzjxk3SqE8b89CM0mM94cK/zH4iw1E6OLcNCa2umxYkmpX1WJw6lUzITq
         oNRcqb6YPgocKe7YZA/XMy5NT1XlCgh5wzjf+n5TB0RTTKc08oNBh7m/IIQDdP/UZiq3
         StJ48xrZgfNd3cV+R4R9a1XOsJAwY4YCU4PC9xLeEKRe1E1q3HXwnUDqMOA09SuHA8Cy
         2c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701713552; x=1702318352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Be0ZogmXWjyNCUnYEc6/k4S4gqJjfHZoxi6an2eBP4w=;
        b=lEP33tvhpyG2fQspe86wYMDuiDVfsFE0iD9VtybZ2/65mJNjAA09NtHNKNjfLRzdUD
         yTL90OREUiQvQwDRA5qyNGJ8hHPI7Ma2SU7hWSjQXbkY8l3MHNODyzBSA0py5Iofv4Qv
         uZ9CSe+H6s8sCCrLUUvJZi46Ydojr6K4Pf27F9AkqLoQoB/gSH3Oep+VlOTGZXXHinjP
         T7qlHZr7N+W3JOyYGUaN8cXOC5At+HgqdIvDH4LMtXadwF+LIZAcvDekaLgRyezOrJNG
         aZM5/Bj+/dGMac00MeBNaOYqZ25MkqBnp0oO6VhTX8ieC6wUaCD9ZNq8rqiivRF4qG8z
         Fg0w==
X-Gm-Message-State: AOJu0YyPO12eAfmQA8WvL908UPBaxSQPerozcJ3U2fw1SvUSCh5FZXlm
        V5EphpgtDJYUW/eJD1o3rhBt5OP/GVa+ohDLv3o=
X-Google-Smtp-Source: AGHT+IEo/v04uit+NqPsJPFvQ4QJ4Byz54ZYjIz0w4BaTkdkZSk1wERugeLXeDpdfXBLqggfENkj6AbOID8cLEtkKyw=
X-Received: by 2002:a05:6870:d207:b0:1fa:dae2:8406 with SMTP id
 g7-20020a056870d20700b001fadae28406mr4513257oac.0.1701713552007; Mon, 04 Dec
 2023 10:12:32 -0800 (PST)
MIME-Version: 1.0
References: <20231204180603.470421-1-gnstark@salutedevices.com> <20231204180603.470421-2-gnstark@salutedevices.com>
In-Reply-To: <20231204180603.470421-2-gnstark@salutedevices.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Dec 2023 20:11:55 +0200
Message-ID: <CAHp75Vc=GAnzwhWQTifLzw8OA7Lb35hrJCDxK-RkgZnX8JmfOg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] devm-helpers: introduce devm_mutex_init
To:     George Stark <gnstark@salutedevices.com>
Cc:     pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        hdegoede@redhat.com, mazziesaccount@gmail.com, jic23@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@salutedevices.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 8:07=E2=80=AFPM George Stark <gnstark@salutedevices.=
com> wrote:
>
> Using of devm API leads to certain order of releasing resources.
> So all dependent resources which are not devm-wrapped should be deleted
> with respect to devm-release order. Mutex is one of such objects that
> often is bound to other resources and has no own devm wrapping.
> Since mutex_destroy() actually does nothing in non-debug builds
> frequently calling mutex_destroy() is just ignored which is safe for now
> but wrong formally and can lead to a problem if mutex_destroy() is
> extended so introduce devm_mutex_init().

...

Do you need to include mutex.h?

...

> +/**
> + * devm_mutex_init - Resource-managed mutex initialization
> + * @dev:       Device which lifetime work is bound to
> + * @lock:      Pointer to a mutex
> + *
> + * Initialize mutex which is automatically destroyed when driver is deta=
ched.

the driver

Have you run scripts/kernel-doc -v -Wall -none ... against this file?
I'm pretty sure it will complain.

> + */


--=20
With Best Regards,
Andy Shevchenko
