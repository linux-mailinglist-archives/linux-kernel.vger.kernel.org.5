Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003177635C5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjGZMCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGZMB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:01:59 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B5DAA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:01:58 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bb29b9044dso2925400a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690372917; x=1690977717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twuF7CNt9sItgP2G+wun0ymCcO+4ADFhcc3cTlAhSLU=;
        b=L2pP1T66VUA97kTMIT7zDsbk+Sj1U4LKl+x+uma0vuTcHTwZhwha6pzsA2Uo21AkyM
         DTYRtPvoGZPTiNUjDj58nzV/gO1YXk/7YoxTrOYa3VFGs1SQdSLJ5FrNm6oPsVS27858
         1TaD1nsizPSLGY9xfJQATDGvg3g5QdzI1PLF9MMoB+hvq5UoVZ/5EOF72Sk0XXc4PzU5
         F4murQgk+c9gIxdKiBxrfHMEmu1J5d+z4lBn452m9DbU1if2+YJSoK9ArWRrM1mZaBOM
         P+4SdRKts30leJFnLldgzucZDJyVZtaH3qpw9LzWFXOEX+tYXai8yBb4q8pgE6Y7JhbJ
         HWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690372917; x=1690977717;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twuF7CNt9sItgP2G+wun0ymCcO+4ADFhcc3cTlAhSLU=;
        b=ETn3wJVugyT37oaz04nijpbmO0IvzfXTP06RVH/Z4hRHUNHPAcvei3bApekbOG53eo
         qYumz6DCzxxc3pqiC2961ynNoXgb6eKz8ll/n0TKxBT1DC5JkLKa588jFIPraOjHYJuX
         Ga799TSHa1b9o5VzMldWwhhFZHMadxQWQZOYJrvuwy+JHEFtntAV5df1qX44+lVkjouj
         kplURdWb0ek1H+t2P2zjesIb06VEZokJ9gRTkJ3n9T4ujaDfwm09nIS/Bt1GE9lcJhLx
         EYPWCX7FLiVtu5vOA0BnmZ0kWVU76MX4Sihaw9rzKYS+hYRndmlt9hbM1EcAfvnoyDWi
         mh4Q==
X-Gm-Message-State: ABy/qLZh+Yn3bp+lnkkzxMPSmDrW0HWlIXDev4Ihnsoel2CSjptMDT8m
        Q2vqL9XGLbjOoHmm0qEbcOihS/+xbwGGzSpGrsEg6Q==
X-Google-Smtp-Source: APBJJlHrtiForKK6WMD54JzL/emKsiGI0pIQtfmHcUV1rpcoTneVDZAEEvNz6C+KKim/FAU7rhxBywt5iJ7uVhquiFo=
X-Received: by 2002:a05:6358:6f1d:b0:134:61a5:7f05 with SMTP id
 r29-20020a0563586f1d00b0013461a57f05mr1664623rwn.10.1690372917492; Wed, 26
 Jul 2023 05:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-11-ulf.hansson@linaro.org> <ZLf4c7ejFBJLH7iN@e120937-lin>
 <20230719155920.iuu2ue2co535dfkx@bogus>
In-Reply-To: <20230719155920.iuu2ue2co535dfkx@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Jul 2023 14:01:21 +0200
Message-ID: <CAPDyKFqMXWshKRd-dcETa9SRWFF4w5MFrWBSVkMn80dHg0Cvjg@mail.gmail.com>
Subject: Re: [PATCH v2 10/11] firmware: arm_scmi: Add the SCMI performance domain
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 17:59, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jul 19, 2023 at 03:51:45PM +0100, Cristian Marussi wrote:
> > On Thu, Jul 13, 2023 at 04:17:37PM +0200, Ulf Hansson wrote:
>
> [...]
>
> > > +   scmi_pd_data = devm_kzalloc(dev, sizeof(*scmi_pd_data), GFP_KERNEL);
> > > +   if (!scmi_pd_data)
> > > +           return -ENOMEM;
> > > +
> > > +   domains = devm_kcalloc(dev, num_domains, sizeof(*domains), GFP_KERNEL);
> > > +   if (!domains)
> > > +           return -ENOMEM;
> > > +
> > > +   for (i = 0; i < num_domains; i++, scmi_pd++) {
> > > +           scmi_pd->info = perf_ops->domain_info_get(ph, i);
> >
> > So here you are grabbing all the performance domains exposed by the
> > platform via PERF protocol and then a few lines down below you are
> > registering them with pm_genpd_init(), but the list of domains obtained
> > from the platform will contain NOT only devices but also CPUs possibly,
> > already managed by the SCMI CPUFreq driver.
> >
>
> Agreed, I pointed out briefly in the previous patch I think. I am not sure
> how will that work if the performance and power domains are not 1-1 mapping
> or if they are CPUs then this might confusing ? Not sure but looks like
> we might be creating a spaghetti here :(.

I assume the discussions around the DT bindings are making it more
clear on how this should work. The scmi performance-domain and the
scmi power-domain are two separate providers.

>
> > In fact the SCMI CPUFreq driver, on his side, takes care to pick only
> > domains that are bound in the DT to a CPU (via scmi_cpu_domain_id DT
> > parsing) but here you are registering all domains with GenPD upfront.
> >
>
> +1
>
> > Is it not possible that, once registered, GenPD can decide, at some point
> > in the future, to try act on some of these domains associated with a CPU ?
>
> IIRC, all unused genpd are turned off right. It may not impact here but still
> super confusing as we will be creating power domains for the set of domains
> actually advertised as power domains by the firmware. This will add another
> set.
>
> > (like Clock framework does at the end of boot trying to disable unused
> >  clocks...not familiar with internals of GenPD, though)
> >
>
> Ah, I am reading too much serialised. Just agreed and wrote the same above.
>
> > > +           scmi_pd->domain_id = i;
> > > +           scmi_pd->perf_ops = perf_ops;
> > > +           scmi_pd->ph = ph;
> > > +           scmi_pd->genpd.name = scmi_pd->info->name;
> > > +           scmi_pd->genpd.flags = GENPD_FLAG_OPP_TABLE_FW;
> > > +           scmi_pd->genpd.set_performance_state = scmi_pd_set_perf_state;
> > > +
> > > +           ret = perf_ops->level_get(ph, i, &perf_level, false);
> > > +           if (ret) {
> > > +                   dev_dbg(dev, "Failed to get perf level for %s",
> > > +                            scmi_pd->genpd.name);
> > > +                   perf_level = 0;
> > > +           }
> > > +
> > > +           /* Let the perf level indicate the power-state too. */
> > > +           ret = pm_genpd_init(&scmi_pd->genpd, NULL, perf_level == 0);
> >
> > In SCMI world PERF levels should have nothing to do with the Power
> > state of a domain: you have the POWER protocol for that, so you should
> > not assume that perf level 0 means OFF, but you can use the POWER protocol
> > operation .state_get() to lookup the power state. (and you can grab both
> > perf and power ops from the same driver)
> >
> > The tricky part would be to match the PERF domain at hand with the
> > related POWER domain to query the state for, I suppose.
> >
>
> I wanted to ask the same. E.g. on juno, GPU has perf domain 2 and power domain
> 9. It would be good if we can how it would work there ? What is expected
> from the gpu driver in terms of managing perf and power ? Does it need
> to specify 2 power domains now and specify which is perf and which power in
> its bindings ?

Yes, correct.

Note that, we already have plenty of consumer devices/drivers that are
managing multiple PM domains. They use
dev_pm_domain_attach_by_id|name() to attach their devices to their
corresponding domain(s). In addition, they often use device_link_add()
to simplify runtime PM management.

That said, we should expect to see some boilerplate code in consumer
drivers that deals with this attaching/detaching of multiple PM
domains. That's a separate problem we may want to address later on. In
fact, it's already been discussed earlier at LKML (I can't find the
link right now).

[...]

Kind regards
Uffe
