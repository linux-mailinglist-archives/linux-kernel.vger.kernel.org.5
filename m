Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB47B7AAA5B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjIVHfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbjIVHfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:35:19 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415F4180;
        Fri, 22 Sep 2023 00:35:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50306b2920dso2454516e87.0;
        Fri, 22 Sep 2023 00:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695368111; x=1695972911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Oy45YenucE8oRMKm/eENUEeL+y1T17GqDbCULn2o6w=;
        b=kCJB5/uJApp1HQbJX9yrZWnH4+Y0f06Dgi0qZZdGl5GDOR5CeueLszfWH1AIW6hzUh
         eNGd61Ly1AouRJsCi8x3tsnclvmNOqhTe2/yp/SBOzjryJXAou7ou87ZJYfsvnkKHDkL
         6ogm7KXj2QxHLuckgEMYtdQ+cOfbkv28/A8k8PMpi+ClX+qu4cmlgLWiGMFxNlIl9aFB
         h/651N4VnFrRi1D/1AfS7J7xxWq7JF8AWDnnlK0s2d54kfQm6sOjjf0OaajH3BhWtiod
         YqycDxiH46hc3FVhpMlhLSuxj0Dj35AeOTjmt4db+0He3Zik//oPmD4pXgxED9hhsrtv
         4jaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695368111; x=1695972911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Oy45YenucE8oRMKm/eENUEeL+y1T17GqDbCULn2o6w=;
        b=BlEGnoLENWhdrwNhe5HfISvid0Tyo4ekzYcCWBh0kfoOsOd1ZIBzvKqbi24JSym7FE
         Y4pCmQOYldhlwtXGW0G+EIgwOgYajqcgvUXmNtxHQ+Tq3W56Sok+kkeGLe7Xj+K5kZoz
         Bljm73t0VhZai3jR3f5fpMrMy+x7DFHd/mCAkkAa+QNfsx0YdHpcMu4wtu3pLyHSVMry
         nK+6n/yJSr1YG4NpK116gY27IBXvs5bfzLXk63T66PtY0kftaYGrfXRlvvp8wSl0LnDI
         Bj0MSBbxaCr7vWdI/5wrdMF8fYEzZwAUbaSFzE6NxXc3wmG9mk7XF/XEUPv7tVf/fLJN
         uAAA==
X-Gm-Message-State: AOJu0Ywh1ztjyn7AwN3r+9CKNZO1qPW0aTGB9oPB7RGcmPcDa5qNiFOv
        VHUln7u5Nndg8btgCLQotXXWq2RdBdOwCl61Ggk=
X-Google-Smtp-Source: AGHT+IEIp99taTTtcP+/DJGM8A2PpWPZTtlPf5EWevOYjrp3rT6lM19S9mupjgbMwAL4NLoj/nlIbRC9Einl/zcS2wU=
X-Received: by 2002:a05:6512:110d:b0:501:bf37:1fb3 with SMTP id
 l13-20020a056512110d00b00501bf371fb3mr703965lfg.24.1695368111204; Fri, 22 Sep
 2023 00:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <JH0PR04MB7072A4B6946EAEEB1EB8B0BE8AF6A@JH0PR04MB7072.apcprd04.prod.outlook.com>
 <8734zfx2bo.fsf@jogness.linutronix.de>
In-Reply-To: <8734zfx2bo.fsf@jogness.linutronix.de>
From:   Enlin Mu <enlinmu@gmail.com>
Date:   Fri, 22 Sep 2023 15:34:44 +0800
Message-ID: <CAAfh-jOnirbUjUYDhWqqUe8kPL=1FcDdZoSax5R-nGwO1CO60g@mail.gmail.com>
Subject: Re: [PATCH] printk: add cpu id information to printk() output
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Enlin Mu <enlin.mu@outlook.com>, pmladek@suse.com,
        rostedt@goodmis.org, senozhatsky@chromium.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        enlin.mu@unisoc.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John Ogness <john.ogness@linutronix.de> =E4=BA=8E2023=E5=B9=B49=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=BA=94 16:34=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2023-09-15, Enlin Mu <enlin.mu@outlook.com> wrote:
> > Sometimes we want to print cpu id of printk() messages to consoles
> >
> > diff --git a/include/linux/threads.h b/include/linux/threads.h
> > index c34173e6c5f1..6700bd9a174f 100644
> > --- a/include/linux/threads.h
> > +++ b/include/linux/threads.h
> > @@ -34,6 +34,9 @@
> >  #define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
> >       (sizeof(long) > 4 ? 4 * 1024 * 1024 : PID_MAX_DEFAULT))
> >
> > +#define CPU_ID_SHIFT 23
> > +#define CPU_ID_MASK  0xff800000
>
> This only supports 256 CPUs. I think it doesn't make sense to try to
> squish CPU and Task IDs into 32 bits.
>
> What about introducing a caller_id option to always only print the CPU
> ID? Or do you really need Task _and_ CPU?
Yes, I need it.
For SOC manufacturer, sometimes cpu is not stable, we need some debug
tools for this exceptions.
When an exception occurs, we may not be able to detect it in a timely
manner, but through Task _and_ CPU, we can roughly locate the CPU at
the time of the exception.

Thanks

Enlin

>
> John Ogness
