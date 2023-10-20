Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE5B7D0E07
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377156AbjJTK5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377161AbjJTK5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:57:20 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA4B171A
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:57:01 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-581edcde26cso363645eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697799421; x=1698404221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Imp0xFQ/yJOyVxr8PrpKhW4JYo+eLZzmDsYbFLZ1k+s=;
        b=pkonPC9ijxgQN1day7EynnL1wLxfp5i3PeQGzUJN4TzXkS3VO4RpM2L1OYNgPiMQwN
         ntr+NYeHhcOZsSLpTWQru+zL+uiXM8p/hzYrTDWuYWDJD5r/f2Onutpf/927mGH3Oram
         TyZO7LhBHdpNPtBx00in+HUWvamtWv+f9NyCXv2wci6mfYEziixr4Bi8hCY0L5Pq6FW+
         SahjlpEG0yiG+IYH3b+DFv2dRVBeP9U2JME+LZghab9WcMslgS63j1i1GqO3g2E2zmy9
         u+R13NC0vt8ggZKzaRF9KcwglVS2Ev2BP57a1WAR4Sr8ziKMEgaknL9uC35+oRVJniJf
         kACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697799421; x=1698404221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Imp0xFQ/yJOyVxr8PrpKhW4JYo+eLZzmDsYbFLZ1k+s=;
        b=t4Zqg3jcavnnlM1bCyIcFUsldsUFKnp1Ba5xLBySGOZN7FwVHT7mrhwcMWMe5mQru4
         ZaegybO3vIavpq1rTwf+hUTTf7F0ZKQUhZxm7j8FepYwoDSOZ87njWMMSFDCPJgdDiKe
         eqIvg4pIr8VEchIfJFnWA8la7SDd++6MLC8HO7OnlDMvLNFwFOAPdKLe4dz1SC521yPj
         3s6cqpqcv2UXf4tV6LOOiYhNgzWni+9zKJXAAPE0U3GmMWfLeDVVSXrxYsT1Ud0ZoUtk
         FnWUQ4JOyr5ZlqH4VjOa3rZ4cKzYK5GU9X6ERctWVGX5nnYBhx25GnFdY+v9DxT1lPzP
         VoYw==
X-Gm-Message-State: AOJu0YwlXk/7mspTHF3NwQPestr+qWI81xlb/CpRonRbmBGyheIRQr0p
        lbslCsXAXiawCrul6GjwxqxZvA==
X-Google-Smtp-Source: AGHT+IHYs5oHxV9O6RTWOkoCgJ3Ns6RIJb90WoP5gupKEBXm8shVWTvh8uPxzSZxiZ3cds5frUpvBg==
X-Received: by 2002:a05:6358:50cc:b0:157:a791:53cc with SMTP id m12-20020a05635850cc00b00157a79153ccmr1362170rwm.32.1697799420917;
        Fri, 20 Oct 2023 03:57:00 -0700 (PDT)
Received: from localhost ([122.172.80.14])
        by smtp.gmail.com with ESMTPSA id k25-20020aa79739000000b006884844dfcdsm1263112pfg.55.2023.10.20.03.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 03:57:00 -0700 (PDT)
Date:   Fri, 20 Oct 2023 16:26:58 +0530
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
Message-ID: <20231020105658.4zjfuiawwyrtnssu@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231020034547.suggwoefx5kauek4@vireshk-i7>
 <CAPDyKFqMA9=qdz4L3Oqj0zRQmSj0bxrF1RzZu-pBcuj9__GSRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqMA9=qdz4L3Oqj0zRQmSj0bxrF1RzZu-pBcuj9__GSRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-10-23, 12:02, Ulf Hansson wrote:
> For the single PM domain case, consumer drivers are often not able to
> use dev_pm_opp_set_config(). That's because the PM domain has already
> been attached from some of the generic buses, through
> dev_pm_domain_attach().
> 
> In this case, as dev_pm_opp_set_config() ends up trying to attach
> again, via dev_pm_domain_attach_by_name() it would receive
> "ERR_PTR(-EEXIST)".
> 
> Or maybe I didn't quite understand your point?

So the thing is that I _really_ want to call dev_pm_opp_set_opp() for
each OPP we want to configure, primary or required. For example, the
required OPP may want to do more than just performance state and we
aren't touching them right now.

Now, in order to call dev_pm_opp_set_opp() for any device, we need a
device pointer and an OPP table associated with it.

I can take care of it for the multi genpd case as there are extra
device structures (which we get from dev_pm_domain_attach_by_name()),
but there is no clean way out for single PM domain devices, unless
they also call dev_pm_opp_set_config() to get a virtual structure.

This is why I had to get this hackish code in place to make it work
with the recursive calls to dev_pm_opp_set_opp(), where I could just
reuse the opp-level thing for the primary device.

How do you suggest we take care of this now ?

-- 
viresh
