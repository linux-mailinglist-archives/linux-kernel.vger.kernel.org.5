Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3F7D6926
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbjJYKmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234935AbjJYKlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:41:47 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6342115
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:41:03 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6cd1918afb2so3324908a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698230462; x=1698835262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uoKCVJuSp1gaNURdshaMYFoNVzJG6iYu6RxzVx/iCgY=;
        b=oFO4hFxBq8vb3sq3psqzjJmjVHzm+nMo3upTEcl/U1xy2Gz7FQGrvIYKEBctj9UeRs
         GIYR5DMs8+pjxcCymCFd0UZ7thZXKkjqBxww10Mfb+Tz1meJln/z3mcyx56nDTFnOzK2
         RjreUKVuIC1L0d/N+J9VQBiX6iCE894z0ugj6tSg+7ZFIji5GgTQ1Zrh6SzO/uwl/4hg
         YKnHzssx5tmEwdV1oG/jjSeuh0k550vHGf/234mB4SYh9afSTQoKXWXdvDOBv06SfDK0
         HnDKuhgnznLKoXNfUWB4pbHjOgZtvYnFiB3k1NENTum/kiw/clzUyo/0VVoCC2GvZvjg
         qM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698230462; x=1698835262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uoKCVJuSp1gaNURdshaMYFoNVzJG6iYu6RxzVx/iCgY=;
        b=HDFFe3RaBdQnA63iHOZRBnaOx63hz+9v80Dcax0OQPTQDD+F85DeNfjD6N/v4Xqlrf
         gWdYtxhNbLwsG5TgbOKnvXofIRO/7U3y3PSzUzHqgd4QoN4+xa0riHIM+IFMqSqIyxZd
         PMAEMZQZSneFWv6/S9MPFP54UQSW0cHXIbiuccwOJsiLU8ouhlkakOI3bn4FLiOG/gCq
         IFULUJd3IHY1vWkQ/FyvWhPZ2Eao2Sp18YuBUR9wTUQIWM4eJ5h7iJ0HhUexq4MbcYOH
         BVhH2LR5IqEp642T7uokPnvVYHbf1VuyNa+XJhD4BnPWaJnOczQ3DYS3veUOXNdrJD3v
         Aedg==
X-Gm-Message-State: AOJu0YyCt1dL6+IkgWamJPY8QicoBQBZeL30M0FMfIGx17IhFQ9oGXHq
        pGmKdCXMP5IRd1x3eRn3D6bJUFrMqHbZcEI5GhU9Yw==
X-Google-Smtp-Source: AGHT+IGlW7jfW/1ewUIAHnqsfNyKdcZq4kW3Vdnn9SrBJ4R26nqtrZXTntBFkTqE7P6WTMpdcWA024nw6f8Q7LNr1fk=
X-Received: by 2002:a05:6830:43a6:b0:6ce:29cd:b663 with SMTP id
 s38-20020a05683043a600b006ce29cdb663mr16885481otv.8.1698230462249; Wed, 25
 Oct 2023 03:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1697710527.git.viresh.kumar@linaro.org> <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com> <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
In-Reply-To: <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 Oct 2023 12:40:26 +0200
Message-ID: <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 08:55, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 19-10-23, 13:16, Ulf Hansson wrote:
> > On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > > +static int _link_required_opps(struct dev_pm_opp *opp, struct opp_table *opp_table,
> > >                                struct opp_table *required_table, int index)
> > >  {
> > >         struct device_node *np;
> > > @@ -314,6 +314,25 @@ static int _link_required_opps(struct dev_pm_opp *opp,
> > >                 return -ENODEV;
> > >         }
> > >
> > > +       /*
> > > +        * There are two genpd (as required-opp) cases that we need to handle,
> > > +        * devices with a single genpd and ones with multiple genpds.
> > > +        *
> > > +        * The single genpd case requires special handling as we need to use the
> > > +        * same `dev` structure (instead of a virtual one provided by genpd
> > > +        * core) for setting the performance state. Lets treat this as a case
> > > +        * where the OPP's level is directly available without required genpd
> > > +        * link in the DT.
> > > +        *
> > > +        * Just update the `level` with the right value, which
> > > +        * dev_pm_opp_set_opp() will take care of in the normal path itself.
> > > +        */
> > > +       if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
> > > +           !opp_table->genpd_virt_devs) {
> > > +               if (!WARN_ON(opp->level))
> >
> > Hmm. Doesn't this introduce an unnecessary limitation?
> >
> > An opp node that has a required-opps phande, may have "opp-hz",
> > "opp-microvolt", etc. Why would we not allow the "opp-level" to be
> > used too?
>
> Coming back to this, why would we ever want a device to have "opp-level" and
> "required-opp" (set to genpd's table) ? That would mean we will call:
>
> dev_pm_domain_set_performance_state() twice to set different level values.

Yes - and that would be weird, especially since the PM domain (genpd)
is already managing the aggregation and propagation to parent domains.

I guess I got a bit confused by the commit message for patch2/2, where
it sounded like you were striving towards introducing recursive calls
to set OPPs. Having a closer look, I realize that isn't the case,
which I think makes sense.

>
> And so it should be safe to force that if required-opp table is set to a genpd,
> then opp-level shouldn't be set. Maybe we should fail in that case, which isn't
> happening currently.

Yes, it seems better to fail earlier during the OF parsing of the
required-opps or when adding an OPP dynamically. In that way, the
WARN_ON above could be removed.

That said, sorry for the noise and either way, feel free to add (for
$subject patch):

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
