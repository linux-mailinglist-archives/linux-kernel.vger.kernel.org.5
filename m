Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFC07D696A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjJYKsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjJYKsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:48:15 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD516A3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:48:13 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-692c02adeefso4451795b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698230893; x=1698835693; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucyvmypzRWKXaw2KCmPDs3/ttcZLG0HVnAvEwAPFzTE=;
        b=L7eNDkYlsLkf6Fe00FrdSdoNMOO8cdii5WAj+8r7Bog4c3a93/ptCZZ0bjGjttp/nN
         RmFzM/NeTksb+kxfgBE7l1M86fKv7WvRWK2JQaS+FbkHuejNpu1JLvafa/dvtXKsK0oY
         joAEO/TpM6FPRE+OEo5yZgYbiUUZ6Dhm+ETL1Px9+foKZFYivaYfbG1M4q5BBI+3ccLJ
         NTqQrslcJ6HVKhgYWXTDoonkpBzfzRKVxLnJ7o6TqdXZFSkrpl8az4I6N0IZVG8KR2gv
         DXQVens7HmqqAIgPy239dtiMPG1e+j3dJq+zKplsG8Pr+RW5lzy6ugRbgC+DEnjlEYZl
         vkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698230893; x=1698835693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucyvmypzRWKXaw2KCmPDs3/ttcZLG0HVnAvEwAPFzTE=;
        b=m+D9xiFVr9nM5IchunaTsTrg5AhA/nn5D8OHU6jJ1p2bgdB6FHJEFQD49dWqARtdX8
         GZ0PHMzN2vLTgKnVHTNHi9iBySTvAR0nf5Qlkgy1Aqg2VHxb0IiTqxeShm2SMVkcMvCM
         DRkRMOwWgX14V6AXAhfUbSLzR2Jy1LpuwFmcmijZIeu+9RR/iOPXRmigGGUUrcTT7WGU
         4wqkqgtwd6+6t8l8RlgwcaJolM4+q/I16EpQw7UYSMnrabRkjA0xNNS8J1uPNU0WMmtV
         NIJrY5yjxt9oFOjeBvNfrvRU+53vMhxJfVF9R53cC3nnujkL5MKhr2o5o6KliGaHt903
         2DRA==
X-Gm-Message-State: AOJu0YzJYydrbfRLPCYdh/rACBj6IZJrf8PSISMJhSJF5vKZfbUtnnBL
        hqqMkCu9ukEwCZ+ZL3I/QSfULw==
X-Google-Smtp-Source: AGHT+IHQW0HxR8+Aje2Th3RFiifKUkwDJ1Is+qfsdlOGHXXQwskp771O+cVur9WHS/Mhan6K19LRvA==
X-Received: by 2002:a05:6a20:918b:b0:16b:abad:87c5 with SMTP id v11-20020a056a20918b00b0016babad87c5mr5789222pzd.10.1698230893058;
        Wed, 25 Oct 2023 03:48:13 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id 23-20020a630f57000000b0059cc2f1b7basm8387031pgp.11.2023.10.25.03.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:48:11 -0700 (PDT)
Date:   Wed, 25 Oct 2023 16:18:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] OPP: Use _set_opp_level() for single genpd case
Message-ID: <20231025104809.qw5vk3liuffgtqk3@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
 <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-10-23, 12:40, Ulf Hansson wrote:
> On Wed, 25 Oct 2023 at 08:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > On 19-10-23, 13:16, Ulf Hansson wrote:
> > > On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > > +       if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
> > > > +           !opp_table->genpd_virt_devs) {
> > > > +               if (!WARN_ON(opp->level))
> > >
> > > Hmm. Doesn't this introduce an unnecessary limitation?
> > >
> > > An opp node that has a required-opps phande, may have "opp-hz",
> > > "opp-microvolt", etc. Why would we not allow the "opp-level" to be
> > > used too?
> >
> > Coming back to this, why would we ever want a device to have "opp-level" and
> > "required-opp" (set to genpd's table) ? That would mean we will call:
> >
> > dev_pm_domain_set_performance_state() twice to set different level values.
> 
> Yes - and that would be weird, especially since the PM domain (genpd)
> is already managing the aggregation and propagation to parent domains.
> 
> I guess I got a bit confused by the commit message for patch2/2, where
> it sounded like you were striving towards introducing recursive calls
> to set OPPs. Having a closer look, I realize that isn't the case,
> which I think makes sense.
> 
> >
> > And so it should be safe to force that if required-opp table is set to a genpd,
> > then opp-level shouldn't be set. Maybe we should fail in that case, which isn't
> > happening currently.
> 
> Yes, it seems better to fail earlier during the OF parsing of the
> required-opps or when adding an OPP dynamically. In that way, the
> WARN_ON above could be removed.

For now I will leave the WARN as is, will reconsider if it makes more
sense to fail and return early. And send a separate patch for that.

> That said, sorry for the noise and either way, feel free to add (for
> $subject patch):
> 
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks.

-- 
viresh
