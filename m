Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7106D7D0E27
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377017AbjJTLJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376945AbjJTLJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:09:51 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFC4119
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:09:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5a7d9d357faso7215177b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697800189; x=1698404989; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ar9JWuEzTg4nm/OuetjJgNewztnGTgqrst37S6ZFCQ=;
        b=efksqlHRQYmnm1fGTWhS97xSeSSUQfnOkQBMNMXjnyIXAbtD4z5F/NITbpS575M2wu
         AG7Pk0uC/VXIV0mNVBW7WtZFRYDQAFKoFSX/Yh/GYE/5I8grkJt8QC4yRgVtP+m5+Hoz
         YOpcW4ICx686I7XXfJLEpWKZReJKzP9mGRBXjgTqixOnkDL6AFfKSjK+qYequq5ox+wM
         ZZWEZQ7dBpZq9nSXk5Lrzg0WsOXNSFEH+IiQb8RmMb/FzDDN6oDrYKMpcewHz7qewrEo
         Rv4/JIlqff6DC0H+MGj3JH+Srj7yq6QCBM7mAMlbfrMhao9SgIUbmbwYwxfYiAOWvV76
         +hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697800189; x=1698404989;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Ar9JWuEzTg4nm/OuetjJgNewztnGTgqrst37S6ZFCQ=;
        b=iQ0iBqdqsmOH4GEy7nEI0X5B9iCiWUjkdVXeoZRBndy+UNoGpNmJA9ILlNhRUoVXqx
         mIopJSdMy7Gv9eFy5/WF04MApd/3XgqJRDF0usEDCL36IKofxO0I4kY8BGWoFnkL54X8
         CkaLzYLuGNJkYlYXkhInH6U+rNR+0yEC+L/rxLZduq7Wi9MFYt0fo7Hj3G9Xa2mRTbcT
         0xdYZZItO9VxUJJjupGsDIkxeHHz1NGj6sQHZEXhcCrjc/CLnpHAfEF0DrhxSt0j+e/T
         842aa4yfwY2ZOmmH4y4E1FRnNpVhwAZtChQfqaRNSyF4Y2R+dulKJ8DXvnFAvmLm7whG
         +m4g==
X-Gm-Message-State: AOJu0Yxk5enlwCsbdd7uHe8Kmnmdboru/n6cciW9HpKXXwYAc6y3vf13
        czQHXdj4PLrmBBuklYAPWnbUPpgN7MiKQdMkps8zOw==
X-Google-Smtp-Source: AGHT+IHZbfimyskJ/HRBlAXmMseRUx3DjcRk2vI7+ZsVh55aqty8c1QiJ2FDVH6hvepbUT/6A0n8JGmj3DyqO8nY2jw=
X-Received: by 2002:a5b:64d:0:b0:d9a:f0e8:480 with SMTP id o13-20020a5b064d000000b00d9af0e80480mr1156584ybq.65.1697800189328;
 Fri, 20 Oct 2023 04:09:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697710527.git.viresh.kumar@linaro.org> <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231020034547.suggwoefx5kauek4@vireshk-i7> <CAPDyKFqMA9=qdz4L3Oqj0zRQmSj0bxrF1RzZu-pBcuj9__GSRw@mail.gmail.com>
 <20231020105658.4zjfuiawwyrtnssu@vireshk-i7>
In-Reply-To: <20231020105658.4zjfuiawwyrtnssu@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 20 Oct 2023 13:09:13 +0200
Message-ID: <CAPDyKFqKVFO-p8Amu8aD7i0tT2dtpJw5rbDVxxhjOpaTYY=ZzA@mail.gmail.com>
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 at 12:57, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 20-10-23, 12:02, Ulf Hansson wrote:
> > For the single PM domain case, consumer drivers are often not able to
> > use dev_pm_opp_set_config(). That's because the PM domain has already
> > been attached from some of the generic buses, through
> > dev_pm_domain_attach().
> >
> > In this case, as dev_pm_opp_set_config() ends up trying to attach
> > again, via dev_pm_domain_attach_by_name() it would receive
> > "ERR_PTR(-EEXIST)".
> >
> > Or maybe I didn't quite understand your point?
>
> So the thing is that I _really_ want to call dev_pm_opp_set_opp() for
> each OPP we want to configure, primary or required. For example, the
> required OPP may want to do more than just performance state and we
> aren't touching them right now.

I understand - and it makes perfect sense to me too!

>
> Now, in order to call dev_pm_opp_set_opp() for any device, we need a
> device pointer and an OPP table associated with it.
>
> I can take care of it for the multi genpd case as there are extra
> device structures (which we get from dev_pm_domain_attach_by_name()),
> but there is no clean way out for single PM domain devices, unless
> they also call dev_pm_opp_set_config() to get a virtual structure.
>
> This is why I had to get this hackish code in place to make it work
> with the recursive calls to dev_pm_opp_set_opp(), where I could just
> reuse the opp-level thing for the primary device.
>
> How do you suggest we take care of this now ?

Honestly, I don't know yet. But I am certainly willing to help. Allow
me to have a closer look and see if I can propose a way forward.

Kind regards
Uffe
