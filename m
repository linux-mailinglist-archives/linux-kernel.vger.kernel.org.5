Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B377E026E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjKCL7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 07:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjKCL7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 07:59:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB6CD48
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 04:59:03 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-da41acaea52so1211582276.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699012743; x=1699617543; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zvso5yHREiVwxjCHbrYyDil+XqHPe3XS0+4PTOkM2qI=;
        b=hubobDWHSQG3TH/0+hzipaVhvcLIZTEBXdTqPFRvddWhXKNuO1905HuK3lP2kgJpdl
         3JQJ3tUCX+V9WcZg+2dnoxbN7Bk+c7fGSeGitawfTNYNmIIfKV8h3y6KOAKOjkOjfLFo
         cdTmNg1zq4IWeUffZ9F8MfnIbYepk5T0V7biBUFZ5gcqLjZfx9M1SYdwSTe+L10vNITR
         3cRakD+Uhb51XHWn/IuKxkb+rqaSN2egyByAb3EA7Sb5z2uVWCCRFn6iKnzvTClFwIG8
         6yeVSy5ePQf94EmEkVg9EQuI+E1rmoT2tu5mvl6S9dFS0iWrvt7dNRuK5F/AcBoWtanD
         uFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699012743; x=1699617543;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvso5yHREiVwxjCHbrYyDil+XqHPe3XS0+4PTOkM2qI=;
        b=UXJxOczh7WSeP8YAE9uatfO3eBC9ZwiEqU2ZyWnfBr2Djqw3qUNXH4kByQRYKvikZA
         34CMY06++r3ziUuN76Mb9a7ivyEn3043i7jO/7gG3QiIG+ZfJngR2QTEgLAe1ASlqbz2
         qi7zncl9jCm+L874D0EiVOcKnlFg/17+HXXgFtnNbFVnyaOzjbFGrxwfBUIctN6UaqZm
         eePTIa2fs0oCuuByYAb/V/LLjiweekfSo5tlZ+SvjEfsX10vA/NTCtDQygpVG9+ENmJF
         uISNn8nj61uju9YBKuaUi9uzGZ/CXYMEnkyNwqIMcqQDSeZueTtDxZ6q3PubncD3RoEe
         J+yw==
X-Gm-Message-State: AOJu0YxJzhwowelOx5g8wY0RuTkyzhaf4SCBYsknRxAsbYCss+GHV9Bb
        NIp76odvqhCMqfVfHU7nYu6QZFrS/dyICjcqPs3u1Q==
X-Google-Smtp-Source: AGHT+IFSD/qkngXLUXcqDqwoE0FkLiw5mf758D+BXCEqBIspX23Cv09fe3PgFzm3+Mnc0nGBHKOHiyCX8VJjHb8fZyg=
X-Received: by 2002:a25:7407:0:b0:da0:39ed:3ebb with SMTP id
 p7-20020a257407000000b00da039ed3ebbmr20712012ybc.3.1699012743083; Fri, 03 Nov
 2023 04:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697710527.git.viresh.kumar@linaro.org> <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7> <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
 <ZTkciw5AwufxQYnB@gerhold.net> <CAPDyKFq+zsoeF-4h5TfT4Z+S46a501_pUq8y2c1x==Tt6EKBGA@mail.gmail.com>
 <20231030102944.nrw4bta467zxes5c@vireshk-i7>
In-Reply-To: <20231030102944.nrw4bta467zxes5c@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 3 Nov 2023 12:58:26 +0100
Message-ID: <CAPDyKFrn97POKuNc3cMM9TOaw-f-ufLwYtUY8_L2w8+hzECWOA@mail.gmail.com>
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 11:29, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 26-10-23, 11:53, Ulf Hansson wrote:
> > On Wed, 25 Oct 2023 at 15:49, Stephan Gerhold <stephan@gerhold.net> wrote:
> > >  2. The OPP WARNing triggers with both variants because it just checks
> > >     if "required-opps" has a single entry. I guess we need extra checks
> > >     to exclude the "parent genpd" case compared to the "OPP" case.
> > >
> > >         [    1.116244] WARNING: CPU: 2 PID: 36 at drivers/opp/of.c:331 _link_required_opps+0x180/0x1cc
> > >         [    1.125897] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> > >         [    1.146887] pc : _link_required_opps+0x180/0x1cc
> > >         [    1.146902] lr : _link_required_opps+0xdc/0x1cc
> > >         [    1.276408] Call trace:
> > >         [    1.283519]  _link_required_opps+0x180/0x1cc
> > >         [    1.285779]  _of_add_table_indexed+0x61c/0xd40
> > >         [    1.290292]  dev_pm_opp_of_add_table+0x10/0x18
> > >         [    1.294546]  of_genpd_add_provider_simple+0x80/0x160
> > >         [    1.298974]  cpr_probe+0x6a0/0x97c
> > >         [    1.304092]  platform_probe+0x64/0xbc
> > >
> > > It does seem to work correctly, with and without this patch. So I guess
> > > another option might be to simply silence this WARN_ON(). :')
> >
> > Oh, thanks for pointing this out! This case haven't crossed my mind yet!
> >
> > Allow me to think a bit more about it. I will get back to you again
> > with a suggestion soon, unless Viresh comes back first. :-)
>
> I have resent the series now.
>
> Stephan, please give it a try again. Thanks.
>
> Regarding this case where a genpd's table points to a parent genpd's table via
> the required-opps, it is a bit tricky to solve and the only way around that I
> could think of is that someone needs to call dev_pm_opp_set_config() with the
> right device pointer, with that we won't hit the warning anymore and things will
> work as expected.
>
> In this case the OPP core needs to call dev_pm_domain_set_performance_state()
> for device and then its genpd. We need the right device pointers :(
>
> Ulf, also another important thing here is that maybe we would want the genpd
> core to not propagate the voting anymore to the parent genpd's ? The
> dev_pm_opp_set_opp() call is better placed at handling all things and not just
> the performance state, like clk, regulator, bandwidth and so the recursion
> should happen at OPP level only.

Are you saying that the OPP library should be capable of managing the
parent-clock-rates too, when there is a new rate being requested for a
clock that belongs to an OPP? To me, that sounds like replicating
framework specific knowledge into the OPP library, no? Why do we want
this?

Unless I totally misunderstood your suggestion, I think it would be
better if the OPP library remained simple and didn't run recursive
calls, but instead relied on each framework to manage the aggregation
and propagation to parents.

> For now my series shouldn't break anything,
> just that we will try to set performance state twice for the parent genpd, the
> second call should silently return as the target state should be equal to
> current state.
>
> --
> viresh

Kind regards
Uffe
