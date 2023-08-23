Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5255786396
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238781AbjHWWuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238873AbjHWWuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:50:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AB81729
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:49:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-52a23227567so2188320a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692830986; x=1693435786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/EeXNKhqBXO7IPVESWoT55KNwrsbj/tEh9Y+87WaBI=;
        b=gzs5mAEkGXUytWxFZz+pyR1/fjSpNvv4HMVzAgXv8H2ztNWoZVd9SbFRKfaxcjmuq5
         HFBWxO0cBGxVHHr4lvvGZUNHxzh0jsUU4hA6mCYn/P6KRO+L6FxsasOhPiRG2/tPFqWS
         0PPQbgZegAIO5QQ2dvpPAxrkA4pnch3J9MmUkQ8Oq+xZIZ/2tTIDt77fSnnRWC9vpwHa
         VtDfVzYq9x1gh4R685WMTVWbDCT4eU9UTgMX+iCFo1pIwhc8T51xqiXFNefzQ4QR8o/O
         FEIcwiYr2NooF5pkIhX12BSs+n6eBqUyxzmG/Pq/ndoqabGPBiV2YGfAl1JRGqPWgVzN
         4XFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830986; x=1693435786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/EeXNKhqBXO7IPVESWoT55KNwrsbj/tEh9Y+87WaBI=;
        b=LlmeLG/orqmZrC0m2xggErQfkYAGnmbFGfeL9HE6ItOOxPo56Vr2LJtswCJi9GpZ9c
         s5h8gk7uLC9LNP/VBsK6yVEBZt2bnWlp1m3CudysQzAlvl19OJLFO5JT1NKibds0sq3X
         rTJzo9mjsnMoW9EVorajUN+zDtJSxDkwp/Rv9XTODQEczbUYL8q4oSF15hVf9YLgVu2p
         pyuRnEVTKD89L7vYF0qiXQON7RbOLrPskaodzzibaUN/RK7PmuXkSVIBaE8ZYGQYVdp/
         VdifUaupZUDDUT19HUrJ9kKtdBvCaZ43fpQXxM88ceW2rod2h4haPPdsHQSyKkWYKkJA
         H9rQ==
X-Gm-Message-State: AOJu0Yz60WVD3/8NgziiPVSs8j4ISN1joeiICK3c9chIiwRwC3/JrAvj
        XIHZifh3dIuio70ZThou3AXG9JMNP9z3iD87xPcQoA==
X-Google-Smtp-Source: AGHT+IH1DnSQglWmGj/1IEV7HE6yfaPV+1QyCpDQxCUHrVClp8GIKbfXHBJSoofYisi17IB9RgBgEsQoVzexc1Fy7Lk=
X-Received: by 2002:a05:6402:1610:b0:525:469a:fc38 with SMTP id
 f16-20020a056402161000b00525469afc38mr10357985edv.31.1692830985915; Wed, 23
 Aug 2023 15:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230822-strncpy-arch-x86-platform-uv-uv_nmi-v1-1-931f2943de0d@google.com>
 <CAHp75VeieNZ3+-2oq2yx36mJ0ERBkuF=f_uhAh8o0sFnHY6Wsg@mail.gmail.com>
In-Reply-To: <CAHp75VeieNZ3+-2oq2yx36mJ0ERBkuF=f_uhAh8o0sFnHY6Wsg@mail.gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 23 Aug 2023 15:49:34 -0700
Message-ID: <CAFhGd8q1UeaUC-Wm9+Jr=7KZLk-VUn+EsOPP0uc1sFk+cv_yoQ@mail.gmail.com>
Subject: Re: [PATCH] x86/platform/uv: refactor deprecated strcpy and strncpy
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 4:07=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Aug 23, 2023 at 1:32=E2=80=AFAM Justin Stitt <justinstitt@google.=
com> wrote:
> >
> > Both `strncpy` and `strcpy` are deprecated for use on NUL-terminated
> > destination strings [1].
> >
> > A suitable replacement is `strscpy` [2] due to the fact that it
> > guarantees NUL-termination on its destination buffer argument which is
> > _not_ the case for `strncpy` or `strcpy`!
> >
> > In this case, we can drop both the forced NUL-termination and the `... =
-1` from:
> > |       strncpy(arg, val, ACTION_LEN - 1);
> > as `strscpy` implicitly has this behavior.
>
> ...
>
> >         char arg[ACTION_LEN], *p;
> >
> >         /* (remove possible '\n') */
> > -       strncpy(arg, val, ACTION_LEN - 1);
> > -       arg[ACTION_LEN - 1] =3D '\0';
> > +       strscpy(arg, val, ACTION_LEN);
> >         p =3D strchr(arg, '\n');
> >         if (p)
> >                 *p =3D '\0';
>
> https://lore.kernel.org/all/202212091545310085328@zte.com.cn/
>
> ...
>
> > +               strscpy(uv_nmi_action, arg, strlen(uv_nmi_action));
>
> strlen() on the destination?!
>
> ...
>
> > -                       strncpy(uv_nmi_action, "dump", strlen(uv_nmi_ac=
tion));
> > +                       strscpy(uv_nmi_action, "dump", strlen(uv_nmi_ac=
tion));
>
> Again, this is weird.

This is a common pattern with `strxcpy` and `sizeof` if you `$ rg
"strncpy\(.*sizeof"`. Do you recommend I switch the strlen(dest) to
strlen(src)? I only kept as-is because that's what was there
originally and I assumed some greater purpose of it.

>
> --
> With Best Regards,
> Andy Shevchenko
