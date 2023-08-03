Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A8F76F602
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 01:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjHCXKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 19:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjHCXKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 19:10:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C239B2688
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 16:10:41 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe463420fbso2530137e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691104238; x=1691709038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7CU+4ogxT9uR42r0NRv5uT6sXzmNe9Dw70+5jbyuXU=;
        b=WuddFivMd15lSSGjJwJsLpVvJrQoPfaasw4xO+4U0HRuiypFFD6Nr0mRNNLOzX/q62
         HZA9A8Jm2exDe5X3nU1kUjq1FcjZFdZjBId/cSGtOvbPA1QNMk3C63Q8AaJ/hBHDkMF4
         RVfeJyd4r2R8VsTlb+vg9yrH29Od2W0Q6i7b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691104238; x=1691709038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7CU+4ogxT9uR42r0NRv5uT6sXzmNe9Dw70+5jbyuXU=;
        b=fjcn9ZNDtdId4zjwA73vSqVwV8D6Pe3YcyREDlzJ417E+U2Ru5Vu/vPoWqqdWB2Pqp
         oSn6yfHsnCJdqt5yfANnaIB444mBLPv5ro3bVVJn8hCDVwPON2mGRKYxOTX+Cbxj/5Rk
         h8cc8yQvEh3GGcZ9g/gbDpZ5YC6ENcy/tZKIqzaG9c1+bS4MfMFQ+DQG4QinCD6mOOOM
         WrtZA4fcdOoIOKjcO8iZVzaFWzvRfZGHYGkBCj3KRJ3B6QvGpOdnIzoqyrtAeixlgdjZ
         BzP9l890vUkdJ9ElFghsU9ZBSaBEXkEcLaPtswYgf4bjU4ziBG1EfJy4G6MAgoufsAD8
         wNmw==
X-Gm-Message-State: AOJu0YwQtFQqpAnDquMFwMZrrMYZ1nXDbCfGZ51Up9XroXFL9q8B4j8y
        7/xh3IcIpW9iioJaDhrOuSdO7TCbca7WkSuv3AvpqA==
X-Google-Smtp-Source: AGHT+IFMO8rxCTzEn0bmHMA4o07zN0APoxrAgk9K3ffQnavetBdwUQaJauXLigsa0DWlO4RUJQFkjA==
X-Received: by 2002:a05:6512:5d6:b0:4fd:d1df:9bda with SMTP id o22-20020a05651205d600b004fdd1df9bdamr29944lfo.42.1691104237826;
        Thu, 03 Aug 2023 16:10:37 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id v12-20020a056402184c00b0051de20c59d7sm412839edy.15.2023.08.03.16.10.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 16:10:36 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5195a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 16:10:36 -0700 (PDT)
X-Received: by 2002:a50:9ec5:0:b0:522:cc9c:f5a4 with SMTP id
 a63-20020a509ec5000000b00522cc9cf5a4mr27783edf.4.1691104236616; Thu, 03 Aug
 2023 16:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230731091754.1.I501ab68cb926ee33a7c87e063d207abf09b9943c@changeid>
 <ZMkBY7K3Dn04YQ65@dhcp22.suse.cz> <CAD=FV=V5hx7Zy-XMB=sPYcD_h-iP5VknmEoJwvw3Akd_1wDnRw@mail.gmail.com>
 <ZMkkNpYcaYPAMj0Z@dhcp22.suse.cz> <CAD=FV=Ujmyq-1GAvNJsrp=mj_Vg=9b6fmfMfkHq3+8ZQ5KiaRw@mail.gmail.com>
 <ZMoFWK0uGdneJYVc@dhcp22.suse.cz> <CAD=FV=XQMH8sun7XCXJNjOC7tP1yt8=mt1NG3f8Xm9-x5TJFsA@mail.gmail.com>
 <ZMthXBpLzbbysTe5@alley> <ZMtliXUFGptYKEra@dhcp22.suse.cz>
In-Reply-To: <ZMtliXUFGptYKEra@dhcp22.suse.cz>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 3 Aug 2023 16:10:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFwBO-haMTFyZZbPqf-B0HHQ_aPqiaoVXPK-cQX3pnUg@mail.gmail.com>
Message-ID: <CAD=FV=UFwBO-haMTFyZZbPqf-B0HHQ_aPqiaoVXPK-cQX3pnUg@mail.gmail.com>
Subject: Re: [PATCH] watchdog/hardlockup: Avoid large stack frames in watchdog_hardlockup_check()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 3, 2023 at 1:30=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrote=
:
>
> On Thu 03-08-23 10:12:12, Petr Mladek wrote:
> > On Wed 2023-08-02 07:12:29, Doug Anderson wrote:
> > > Hi,
> > >
> > > On Wed, Aug 2, 2023 at 12:27=E2=80=AFAM Michal Hocko <mhocko@suse.com=
> wrote:
> > > >
> > > > On Tue 01-08-23 08:41:49, Doug Anderson wrote:
> > > > [...]
> > > > > Ah, I see what you mean. The one issue I have with your solution =
is
> > > > > that the ordering of the stack crawls is less ideal in the "dump =
all"
> > > > > case when cpu !=3D this_cpu. We really want to see the stack craw=
l of
> > > > > the locked up CPU first and _then_ see the stack crawls of other =
CPUs.
> > > > > With your solution the locked up CPU will be interspersed with al=
l the
> > > > > others and will be harder to find in the output (you've got to ma=
tch
> > > > > it up with the "Watchdog detected hard LOCKUP on cpu N" message).
> > > > > While that's probably not a huge deal, it's nicer to make the out=
put
> > > > > easy to understand for someone trying to parse it...
> > > >
> > > > Is it worth to waste memory for this arguably nicer output? Identif=
ying
> > > > the stack of the locked up CPU is trivial.
> > >
> > > I guess it's debatable, but as someone who has spent time staring at
> > > trawling through reports generated like this, I'd say "yes", it's
> > > super helpful in understanding the problem to have the hung CPU first=
.
> > > Putting the memory usage in perspective:
> >
> > nmi_trigger_cpumask_backtrace() has its own copy of the cpu mask.
> > What about changing the @exclude_self parameter to @exclude_cpu
> > and do:
> >
> >       if (exclude_cpu >=3D 0)
> >               cpumask_clear_cpu(exclude_cpu, to_cpumask(backtrace_mask)=
);
> >
> >
> > It would require changing also arch_trigger_cpumask_backtrace() to
> >
> >       void arch_trigger_cpumask_backtrace(const struct cpumask *mask,
> >                                   int exclude_cpu);
> >
> > but it looks doable.
>
> Yes, but sparc is doing its own thing so it would require changing that
> as well. But this looks reasonable as well.

OK. I've tried a v3 with that:

https://lore.kernel.org/r/20230803160649.v3.2.I501ab68cb926ee33a7c87e063d20=
7abf09b9943c@changeid

-Doug
