Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FB379FEB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236529AbjINIpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236586AbjINIpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:45:03 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD871FDA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:44:57 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1d63d38c74fso113015fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681097; x=1695285897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o96uUOD+Z0F+AtC8Emho1/iqXBWRbLXaU2PsUtMV/nY=;
        b=PrFF04Y3hGjI17wfpII9y9SLwHAg1rbvbjG7KutgEAvkEwE4VnoMGsQo5t7Tc5nLp+
         U0YaJc93Oj3RnFJ6xTXGop8VSvnSNLWex2C6Zx3hFCJNUzuRGxOkSvgpswtBZ85Nn6E2
         bit+Yuuixg5IuqVlT9PKFihJZLAcikPblswF95PYLU+3qV238sI4tpNN+Jl8Mkp1a7J4
         m4N2lnSBeM1Ku0+DVQJdKm0MX5enLitjIGYvrc3/JfL3WJ9lZLDyCLsUhC71JAyQjdyE
         bT+adjVDqo+hcH6piX6d9WImJRVzdwEe88kp9YNHhZHlTyFfU/38zQdZB31+A6tz/UNC
         3ylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681097; x=1695285897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o96uUOD+Z0F+AtC8Emho1/iqXBWRbLXaU2PsUtMV/nY=;
        b=veMam9lvVMEVwGcykIc5nI4SbTlJ9TLzUZSSwz0pFHJM2EnACkkZKdd6tjotskKDjT
         CPU3gi+1Kapfenih5PXdNSpDyA+++vV5be0a6htL+r6le+AIwBKBV2V/aB0U4HlSduxy
         KLffMvGekeyBbwTu3Gc+3dPghx0WLx0vksYllCeU3BQlzV7eVryfiB00cHIjOQy9a7xb
         8bdslWZ9w+x6MKfg05NQIgpk6bdvNHlRn2aJ4R1tpBQs4vAUDw1odoKoKxp4iGU4JN1T
         ugkHjwAe44PnLuiqlzAysMIz69I6KPYFTfT6YQSth1FbJa4INBgqVfBfmcUnFzsnjzVK
         wC6w==
X-Gm-Message-State: AOJu0YwLbFXyPaq3Rczt0jTlBJgUL2Iu3iwPBTA6LnQu0iCGFI/qNoWE
        +VKQDogmdlg5rXfbQuEcAEFDKVTQw9pHeTE60bE=
X-Google-Smtp-Source: AGHT+IEQuGqc7Eoh8cDiVzHch87jNXb9OuNflQeceTbgn+4H+oVdcj1tUNCAVKgApvFRkc2TBMfhRRdrbT+7pGDSbic=
X-Received: by 2002:a05:6870:7014:b0:1d2:4b4c:eb11 with SMTP id
 u20-20020a056870701400b001d24b4ceb11mr5190411oae.32.1694681096961; Thu, 14
 Sep 2023 01:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230913180111.85397-1-hdegoede@redhat.com> <CAHp75VdTO2=2a_7tqH72tji=UWhmjNpaO+tE8sq+ufdjY6+Low@mail.gmail.com>
In-Reply-To: <CAHp75VdTO2=2a_7tqH72tji=UWhmjNpaO+tE8sq+ufdjY6+Low@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Sep 2023 11:44:20 +0300
Message-ID: <CAHp75Vfe3xBuG91=XdZ4zXhfhz4KDwCL9xonSyoH8PuqUgO-+Q@mail.gmail.com>
Subject: Re: [PATCH v2] x86/platform/uv: Rework NMI "action" modparam handling
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Justin Ernst <justin.ernst@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:42=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Sep 13, 2023 at 9:01=E2=80=AFPM Hans de Goede <hdegoede@redhat.co=
m> wrote:

...

> > -       pr_err("UV: Invalid NMI action:%s, valid actions are:\n", arg);
> > +       pr_err("UV: Invalid NMI action:%s, valid actions are:\n", val);
>
> As mentioned previously the val may or may not have a new line in it.
> I dunno about comma removal, but a new line presence can be easily checke=
d.
>
> Either way it's not so critical, hence removing comma. or replacing it
> by '-' (dash) may be enough.

Or even

       pr_err("UV: Invalid NMI action:%s --> valid actions are:\n", val);


--=20
With Best Regards,
Andy Shevchenko
