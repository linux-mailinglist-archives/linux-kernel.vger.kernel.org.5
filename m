Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA967FF6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345541AbjK3QrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjK3QrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:47:24 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C110DB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:47:30 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50bccc2e3efso1350350e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701362849; x=1701967649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/82G/0nOOPB91Vse2y9ZbjxwVgoVjZManIXPaj11EM=;
        b=WqXgrbrrVPdmiJPrd1NVu5MbXFlxBaBbVajmssKdhg8AvIbHISrS6KqZB0gmIS+O/R
         pl0l5kFlRpNx5ePJhIdUav7Enu/gJ9ACgCP9x0nqRZLyROYMAJt3K/6o/EMperXnuvy2
         v06rd/mjMXKBse2/+FhgZYH6/IYBcDgzqbSoCE354AfBoQlHEyMFyZpDdKfYEoNjG9ti
         1IWbz8ywQaSHx2n2gWjqOeF55UR5x2+dXkMI8tz/rohywOoAGmI9hXrYViULrOaXSKzc
         jaLuRD2aPPw640WmY0SRxpHrKJqbAnWoNdXCH3bz+NXIgNno2InpyhD99fDgVqwkC2Q2
         1vOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701362849; x=1701967649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/82G/0nOOPB91Vse2y9ZbjxwVgoVjZManIXPaj11EM=;
        b=d3sdcHeHa4SR2OUHFtXS5+jzsf9dJ0DkRUv6yTPKvNEUqrfLH1aJ1+6EAQte/4U418
         hGYS6e6gOxRRKaJApprBCpake+luWUamaHgzDW8603rgtQJV1weCWLWbZ/QdklZd3+W7
         ssElqVQFYVIIZCbJBWIY+lSDMA6tZuPx8nBwhEB1IkhvXdelXeFKKTP2T4SvhqompoO1
         SXX+KSjGBkrepM2gRuFAYWcATF7HOuYeh22/hitxFxvrDt7K59nWAxD06Tyav95YMG3i
         sFZ6rzUDeAM08JVwkSyytPiDcQhhyTShVtJnD8/eCdUMZslUN7yojcMWZI6GEN6DuCGB
         ESDg==
X-Gm-Message-State: AOJu0YwAUSFUBXZONEVQrBBCZmnA+I14PXDEnoR+xZbZ3eJVXHfGlw4z
        pvRmOz99+dcPDQo1uKqCqx2/zRxzP+AYteJ7ig==
X-Google-Smtp-Source: AGHT+IGLPBVZJOS/Jke7bXTISdoyJyrRkafqEyCjKNQvAMm8y1CjQ+2BHczmett0DFBwuMdodEnKYLWP67gfzuggx48=
X-Received: by 2002:a05:6512:453:b0:50a:9f28:5efe with SMTP id
 y19-20020a056512045300b0050a9f285efemr12837lfk.19.1701362848097; Thu, 30 Nov
 2023 08:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20231130155213.1407-1-bp@alien8.de> <20231130160903.GJZWizn+dPaaViFVKN@fat_crate.local>
 <CAMzpN2j5xYq0YCzXxU8srha=1um0JSWMM2YWkUG-qFA891xVHQ@mail.gmail.com>
In-Reply-To: <CAMzpN2j5xYq0YCzXxU8srha=1um0JSWMM2YWkUG-qFA891xVHQ@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 30 Nov 2023 11:47:16 -0500
Message-ID: <CAMzpN2hPCwuR9ydEKybJSTvzeATYq1ovaMVM7Z1S8GCXpeyjmA@mail.gmail.com>
Subject: Re: [PATCH] x86/ia32: State that IA32 emulation is disabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nik.borisov@suse.com>
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

On Thu, Nov 30, 2023 at 11:42=E2=80=AFAM Brian Gerst <brgerst@gmail.com> wr=
ote:
>
> On Thu, Nov 30, 2023 at 11:09=E2=80=AFAM Borislav Petkov <bp@alien8.de> w=
rote:
> >
> > On Thu, Nov 30, 2023 at 04:52:13PM +0100, Borislav Petkov wrote:
> > > +static inline bool ia32_enabled_verbose(void)
> > > +{
> > > +#ifdef CONFIG_IA32_EMULATION
> > > +     pr_notice_once("32-bit emulation disabled. You can reenable wit=
h ia32_emulation=3Don\n");
> > > +#endif
> > > +     return ia32_enabled();
> > > +}
> >
> > As Nik rightfully points out offlist, this should rather be something
> > like:
> >
> > ---
> >         bool enabled =3D ia32_enabled();
> >
> > #ifdef CONFIG_IA32_EMULATION
> >         if (!enabled)
> >                 pr_notice_once("32-bit emulation disabled. You can reen=
able with ia32_emulation=3Don\n");
> > #endif
> >
> >         return enabled;
>
> The #ifdef isn't necessary, as ia32_enabled() will always return false
> in that case.

Scratch that, I misread it.  If compat is disabled at build time you
don't want the message to appear, or at least would want a different
message.

Brian Gerst
