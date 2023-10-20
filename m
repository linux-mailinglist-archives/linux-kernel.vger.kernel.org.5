Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B16C7D0718
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 05:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346920AbjJTDp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 23:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbjJTDpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 23:45:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C311A4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:45:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-565334377d0so290232a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 20:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697773550; x=1698378350; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inKXka09GwXcWLXC5wnAFP5z0I1SlJNRWhr0zXVlA4w=;
        b=nMFzUO8GJPUxlWfnnfyVKJ2OjtkDwUzYZuP6cUMr/kskyDCeQE5fGfHO0gZwXmh/Up
         FdWQrhME9g5XnAOlPQ3hfmRJPQS/WIsnzaEo9rzDz1uwxM6/dBUKRMnFEbQGg4iGAhnA
         tEegiSHXzgtAP+anVCt9IX/tKz9fR3GFuBt1zLrlXUM6nmGIx2ZnYc5KH1rJO8wDMleq
         uECT0EHYUi1lQSIyWZ6I2esfnWodX19ire//91PEC+9av/z+3TdNGjztB5lUFwd2E2sh
         m5Z6jrVGp12Rue3/t9WJnQVy9C2wbgSoGfuWUa1zhQKnL7qp/pPEyow/asrgRoPCoz/Z
         +DHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697773550; x=1698378350;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inKXka09GwXcWLXC5wnAFP5z0I1SlJNRWhr0zXVlA4w=;
        b=H95ebugCI8MATWVzPmR1BXxOzTzs44M9Ij6NIPt0xXZlCGGCs8N+84Ws886HEWwkZx
         IkcI1fwnMZix+coXmf7famj7FaR5HwWA6/g6pKx5tqzwKv+h39+LoCtJd6GC/8zOb9U8
         p+sz4Fp/UcqIDAWHHkFm+gpJYlqcy+w4IUjICF/loSiGa86+/iGW3Yq6lBTAp9//gNT3
         EhQk2sZSag77G6vWNOR08RLblO0eNZ0osiSiLTQyEN86Rzry+FPuWwOvoavlZoCkQAsF
         +XdOIfNjwrqBiKX/Au7lrMANfTR1HsyjdiJEGrOpKaiJresUNoFUcSc9Pk4ItSw4sbSK
         5RBg==
X-Gm-Message-State: AOJu0Yzk36CZokrbLOkqhfjFIiNV6IsQ0lnCFduQt3rD0hAtR5Eu2ohi
        uupBj15QfFuO4kOgxrZEXirdIQ==
X-Google-Smtp-Source: AGHT+IFLqq6A5TEOm9H3AEg7NXKuXWHV5R1rN1TZ5MBgrwz272O50/PVEFWUkhthVZi2jBl6wZIwfg==
X-Received: by 2002:a05:6a20:1450:b0:17b:992c:7653 with SMTP id a16-20020a056a20145000b0017b992c7653mr813092pzi.7.1697773549739;
        Thu, 19 Oct 2023 20:45:49 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id j70-20020a638b49000000b005b44ac59b7bsm500574pge.70.2023.10.19.20.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 20:45:49 -0700 (PDT)
Date:   Fri, 20 Oct 2023 09:15:47 +0530
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
Message-ID: <20231020034547.suggwoefx5kauek4@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-23, 13:16, Ulf Hansson wrote:
> On Thu, 19 Oct 2023 at 12:22, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +       /*
> > +        * There are two genpd (as required-opp) cases that we need to handle,
> > +        * devices with a single genpd and ones with multiple genpds.
> > +        *
> > +        * The single genpd case requires special handling as we need to use the
> > +        * same `dev` structure (instead of a virtual one provided by genpd
> > +        * core) for setting the performance state. Lets treat this as a case
> > +        * where the OPP's level is directly available without required genpd
> > +        * link in the DT.
> > +        *
> > +        * Just update the `level` with the right value, which
> > +        * dev_pm_opp_set_opp() will take care of in the normal path itself.
> > +        */
> > +       if (required_table->is_genpd && opp_table->required_opp_count == 1 &&
> > +           !opp_table->genpd_virt_devs) {
> > +               if (!WARN_ON(opp->level))
> 
> Hmm. Doesn't this introduce an unnecessary limitation?
> 
> An opp node that has a required-opps phande, may have "opp-hz",
> "opp-microvolt", etc. Why would we not allow the "opp-level" to be
> used too?

Such platforms need to call dev_pm_opp_set_config() with genpd names
and it should all work just fine. The point is that we can't use the
same `dev` pointer with another OPP table, i.e. device's dev pointer
for the genpd's table here.

-- 
viresh
