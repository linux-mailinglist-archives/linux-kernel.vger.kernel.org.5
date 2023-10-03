Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF17B63FE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbjJCIYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbjJCIX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:23:58 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCCDC9
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:23:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-578b4981526so390047a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696321405; x=1696926205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=thmnWGackJ2kyq9MtKqHyc87CEf9Q0TEhF2e90bIrDA=;
        b=LPH8u4/lLveFuwbih63P8nVkE9DDCv7sVF//AdO6Piuc41TaG+TaK6TrHFdqdGKJGt
         uFpOPICAdbc2+n7g5J6QBn9NUmdCXTdH+w4Up3ru5DoYDdZELsuTBNQXdldHxEc0Jg+o
         rmbsgD3Yl5mBL1GCvqz5hsLA77kFCUaqDAYlrN3BXLnTR6CESvG6FYB5x7uVanPKjkoa
         qItc92QXf98reNVxXDM7G9pQ39Zb+TavmejvFclAUXZgXQwGqBLUkBqStbL1dRUjc3Un
         JavF6XY9cP9M/wjYHByKkn/sR7gaOUeOflxwjYfR1jb3AHyrb31KoCev3EpOZD8fF4qn
         07Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696321405; x=1696926205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thmnWGackJ2kyq9MtKqHyc87CEf9Q0TEhF2e90bIrDA=;
        b=tfh2OaLpFpx+bYKjDvAeuUjjetvzTxHWrlOafv4TqCbnsAHSUO/HQbjYx2Cjh7CEOK
         hzDlVq4eOlUrt6IxKX64K18TFSsU4UPMceH2rm+qC+Q9rd2/pZ1O06PpT6D4kSGQJCTJ
         N/PA2wTY/QuvSxTfmNg0rYGG04zTULjjKDeVyqr8nXHo1estzYXO9yTwN94/GB/lDd0F
         RuNmScW3tl/ypVzxy9sLe83dyKAfoRQuoD/kuYSwTAKytCVbDJE7ymSGAf3w+Flc/YLZ
         3oj/bFUx08uQDWiCHVxIxTjBdgaSreDWvAJxBjEXPk4w8WQ77IewNcbk31Bi56NDZK8x
         W49w==
X-Gm-Message-State: AOJu0YyLjP3nqT+MSsEbr/A/Ha9DyDFir4qsZLsxqiuu/JGdNaUGmRFw
        1QaTsDjsgpdgdf49to6lpkeBCQ==
X-Google-Smtp-Source: AGHT+IGuKv0tqMz8b0543XZiDpuoC5Tfgl8jOlIiHvPuG4yQ/mq4Hmo9V5ohffrrUvqOSUSeg08hKA==
X-Received: by 2002:a05:6a20:dd9f:b0:156:851e:b167 with SMTP id kw31-20020a056a20dd9f00b00156851eb167mr10314153pzb.44.1696321405368;
        Tue, 03 Oct 2023 01:23:25 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id t7-20020a62ea07000000b006933b69f7afsm782412pfh.42.2023.10.03.01.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 01:23:24 -0700 (PDT)
Date:   Tue, 3 Oct 2023 13:53:22 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/9] OPP: Extend support for the opp-level beyond
 required-opps
Message-ID: <20231003082322.cmok766jxzftsgrg@vireshk-i7>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
 <20230925131715.138411-7-ulf.hansson@linaro.org>
 <CAPDyKFo+XCEtTSNqtA1SeajWo4tuRroA4GrRegta5TsqSGd4eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo+XCEtTSNqtA1SeajWo4tuRroA4GrRegta5TsqSGd4eQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-09-23, 15:33, Ulf Hansson wrote:
> On Mon, 25 Sept 2023 at 15:18, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > At this point the level (performance state) for an OPP is currently limited
> > to be requested for a device that is attached to a PM domain.  Moreover,
> > the device needs to have the so called required-opps assigned to it, which
> > are based upon OPP tables being described in DT.
> >
> > To extend the support beyond required-opps and DT, let's enable the level
> > to be set for all OPPs. More precisely, if the requested OPP has a valid
> > level let's try to request it through the device's optional PM domain, via
> > calling dev_pm_domain_set_performance_state().
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/opp/core.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 60dca60ac4af..afb73978cdcb 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -1107,6 +1107,22 @@ void _update_set_required_opps(struct opp_table *opp_table)
> >                 opp_table->set_required_opps = _opp_set_required_opps_generic;
> >  }
> >
> > +static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
> > +                         struct dev_pm_opp *opp)
> > +{
> > +       int ret = 0;
> > +
> > +       /* Request a new performance state through the device's PM domain. */
> > +       if (opp && opp->level) {
> > +               ret = dev_pm_domain_set_performance_state(dev, opp->level);
> > +               if (ret)
> > +                       dev_err(dev, "Failed to set performance state %u (%d)\n",
> > +                               opp->level, ret);
> > +       }
> 
> Okay, so reviewing my own code found a problem here. We need an "else"
> here, that should request the performance state to be set to 0.
> 
> I am not sending a new version at this point, but awaiting more feedback first.

I am looking to add below to this patch, is that okay with you ?

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 7b505316bb1c..a113e9caaa5a 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -1135,16 +1135,22 @@ void _update_set_required_opps(struct opp_table *opp_table)
 static int _set_opp_level(struct device *dev, struct opp_table *opp_table,
                          struct dev_pm_opp *opp)
 {
+       unsigned int level = 0;
        int ret = 0;

-       /* Request a new performance state through the device's PM domain. */
-       if (opp && opp->level) {
-               ret = dev_pm_domain_set_performance_state(dev, opp->level);
-               if (ret)
-                       dev_err(dev, "Failed to set performance state %u (%d)\n",
-                               opp->level, ret);
+       if (opp) {
+               if (!opp->level)
+                       return 0;
+
+               level = opp->level;
        }

+       /* Request a new performance state through the device's PM domain. */
+       ret = dev_pm_genpd_set_performance_state(dev, level);
+       if (ret)
+               dev_err(dev, "Failed to set performance state %u (%d)\n", level,
+                       ret);
+
        return ret;
 }

I am switching back to dev_pm_genpd_set_performance_state() as I won't be
applying the power domain changes. I will then push out a branch and you can
rebase your patches on top of it ? And then probably Sudeep or someone else can
apply everything ?

-- 
viresh
