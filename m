Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315DC7DB81D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbjJ3K3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3K3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:29:50 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45A39E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:29:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6b2018a11efso4265331b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698661787; x=1699266587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ903xeVy9AHTb8iQsfsuNGoJuliVwNflrg4mGwSUpg=;
        b=XaXwNxN5BAKfgACkpsi8UODdwRRu9pCDTCeDqeBNCs16ikE4nibXbbzGR2a1ht4Eh4
         coJZZNURbMVzXGkjKGULTAA/1Az7UZtNWcK4a296hDJiHxP9NhdmorvuoI183MHe0LU9
         TufSd2MfPxdAZKvu6fB872VUS73lTNUiJGeLMV3dzzxporuokW9LGPY2WRiXU2U6pMvV
         AQWVDRg/mBP+hHAs7h3ggIRXzKs0pUcCA0uji+1R1ktmJi461F08qTQwoI8x55UDPoU4
         tC5DfSHom1TofIxcHEO8u/0djqALtDg/8dj22m591zQWW2ZsPJ6nYQOc0ZPZHZ4Afz9+
         0rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698661787; x=1699266587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ903xeVy9AHTb8iQsfsuNGoJuliVwNflrg4mGwSUpg=;
        b=HrcOxdxFInqxjTYGi8Z5fJCpOEGkzPMH2uEcxKhl2D2yloPORrhSqMR4uXGZG4FyyW
         Yk63aTyfeGFJdCjpUC4LNTISoIMoBeyBj0BITVQIAOAKlFCicTYMtXl+15L9qtRTsWAL
         a6FHG0tQZkAS/DN0B65dLLWxfdWxIfD126ppPjfUzUaa43E//p5pW17oRBIeot+7PJg3
         2nDx6abxGD1nORzQMG6AuYcHFQSSYbADa44Jvd6Zu1zCFlpquLZGN/gJT8kxIfrAELE+
         85eMaivRTEUz4uvw1mE9ghAmP0S9idh6h/YPsRB4tgza+/uT2NJkBCogdj0H9CCnX9T3
         c37w==
X-Gm-Message-State: AOJu0YyORl6ZMnuPVx+lkZxK9BaH1qhLk9Fi6jh715JCY3MvQbVyLlSR
        dvPdcGGbZfzaBUba1SoQ98qAeg==
X-Google-Smtp-Source: AGHT+IEIkqkVLiCDQVtENyPWVuu+h7nL9aLn3AM3oh8xYNImGe5nqy1fuDl53jyeHebKXVRznc0WIQ==
X-Received: by 2002:a05:6a20:914a:b0:13f:9cee:ff42 with SMTP id x10-20020a056a20914a00b0013f9ceeff42mr11931773pzc.41.1698661787428;
        Mon, 30 Oct 2023 03:29:47 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id e26-20020a62aa1a000000b006c003d9897bsm5628756pff.138.2023.10.30.03.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 03:29:46 -0700 (PDT)
Date:   Mon, 30 Oct 2023 15:59:44 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
Message-ID: <20231030102944.nrw4bta467zxes5c@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
 <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
 <ZTkciw5AwufxQYnB@gerhold.net>
 <CAPDyKFq+zsoeF-4h5TfT4Z+S46a501_pUq8y2c1x==Tt6EKBGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFq+zsoeF-4h5TfT4Z+S46a501_pUq8y2c1x==Tt6EKBGA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-10-23, 11:53, Ulf Hansson wrote:
> On Wed, 25 Oct 2023 at 15:49, Stephan Gerhold <stephan@gerhold.net> wrote:
> >  2. The OPP WARNing triggers with both variants because it just checks
> >     if "required-opps" has a single entry. I guess we need extra checks
> >     to exclude the "parent genpd" case compared to the "OPP" case.
> >
> >         [    1.116244] WARNING: CPU: 2 PID: 36 at drivers/opp/of.c:331 _link_required_opps+0x180/0x1cc
> >         [    1.125897] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> >         [    1.146887] pc : _link_required_opps+0x180/0x1cc
> >         [    1.146902] lr : _link_required_opps+0xdc/0x1cc
> >         [    1.276408] Call trace:
> >         [    1.283519]  _link_required_opps+0x180/0x1cc
> >         [    1.285779]  _of_add_table_indexed+0x61c/0xd40
> >         [    1.290292]  dev_pm_opp_of_add_table+0x10/0x18
> >         [    1.294546]  of_genpd_add_provider_simple+0x80/0x160
> >         [    1.298974]  cpr_probe+0x6a0/0x97c
> >         [    1.304092]  platform_probe+0x64/0xbc
> >
> > It does seem to work correctly, with and without this patch. So I guess
> > another option might be to simply silence this WARN_ON(). :')
> 
> Oh, thanks for pointing this out! This case haven't crossed my mind yet!
> 
> Allow me to think a bit more about it. I will get back to you again
> with a suggestion soon, unless Viresh comes back first. :-)

I have resent the series now.

Stephan, please give it a try again. Thanks.

Regarding this case where a genpd's table points to a parent genpd's table via
the required-opps, it is a bit tricky to solve and the only way around that I
could think of is that someone needs to call dev_pm_opp_set_config() with the
right device pointer, with that we won't hit the warning anymore and things will
work as expected.

In this case the OPP core needs to call dev_pm_domain_set_performance_state()
for device and then its genpd. We need the right device pointers :(

Ulf, also another important thing here is that maybe we would want the genpd
core to not propagate the voting anymore to the parent genpd's ? The
dev_pm_opp_set_opp() call is better placed at handling all things and not just
the performance state, like clk, regulator, bandwidth and so the recursion
should happen at OPP level only. For now my series shouldn't break anything,
just that we will try to set performance state twice for the parent genpd, the
second call should silently return as the target state should be equal to
current state.

-- 
viresh
