Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9183E7E1ABA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 08:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjKFHIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 02:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjKFHIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 02:08:37 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5125C6
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 23:08:33 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so2265515a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 05 Nov 2023 23:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699254513; x=1699859313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NzwW8HCXu7jJCUIIT/p7f93FKWO/SvOk8kwzUd6llhY=;
        b=FF29HPpOVSTF2LVxQCv2Rz/pn0BCeHTBpph0oJ7/+e75JgCtVt6nh8NlOc7HEyYuYM
         KMVLFIPta0mYij9qYz8IMQp06ezBFbdaF9pfPlnKe2o8dmrBEZwJjfEe2WzGZMMpTumt
         gIVkyA2IDQJxWUsxuCCs26kutrbJzenSc7Tfl+DE1b2y0mkOiR3qyKPOYDaZMXF82zh5
         ns0dITXp34i4YvuvOWxhds7sMe/RW/CR2FxnvpHOet767qJDY3SowxKWTrin4GsDM3sA
         TgH94IEDqCVo9gY33Wuv19hQhi9eVz8+rlDh4Oo6IGGSwNerlwiEOs7USXsVO23uTCdY
         gcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699254513; x=1699859313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzwW8HCXu7jJCUIIT/p7f93FKWO/SvOk8kwzUd6llhY=;
        b=oYzlBqqVnOe9NzsIPIA1Q2mwi0wWBmOL85A5CWflxPyYjIvXIwabrsNUr89akGTvWa
         aWGMjzlYXRAKgyaUd1zABJOzMKOJ7AiqDvX+xCNJ2d9+/VsZzaPBjIf5DdUJpb+cQcO6
         ifxcf7U1B7QP8GsAk2/m3QQLEa6I87R2++JJXlleyrFuCwo331a5Zugv+CV1tk5iMu7i
         tINNKjgZgVGs45h4GnT3kGTwHyNk3iXJSZm9BXjpk0eCRt+ZNDuCdhUXRV433a7Y050a
         yLOp3gL3iP9dmpaTreioqmr4ZHNPrM+92zhtdi95HotXwIY/QPuNg9LK0QlMjRj6i5Lu
         iFUw==
X-Gm-Message-State: AOJu0YyVnxd1pVJCxmUZCwkXPiCzYFS03gPQ7XSghJfn45Cli4KXxJdq
        CR2JFHxDeiVeMhuQpAiWbvIhJVOk+jNkMgD9xdc=
X-Google-Smtp-Source: AGHT+IHE6YWyPcaOvUDJuYeW1C+8+ROeIE8F1ND73845p0boxck/nR6U2UBGK7IxkIuirptr4Eqvqg==
X-Received: by 2002:a05:6a21:32aa:b0:15f:b5:bfee with SMTP id yt42-20020a056a2132aa00b0015f00b5bfeemr27189859pzb.5.1699254513203;
        Sun, 05 Nov 2023 23:08:33 -0800 (PST)
Received: from localhost ([122.172.82.6])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902a3c200b001c5f7e06256sm5328689plb.152.2023.11.05.23.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 23:08:32 -0800 (PST)
Date:   Mon, 6 Nov 2023 12:38:30 +0530
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
Message-ID: <20231106070830.7sd3ux3nvywpb54z@vireshk-i7>
References: <cover.1697710527.git.viresh.kumar@linaro.org>
 <f709e9e273004be43efe3a2854a7e7b51a777f99.1697710527.git.viresh.kumar@linaro.org>
 <CAPDyKFqbnsdT0nqKwQhai875CwwpW_vepr816fL+i8yLh=YQhw@mail.gmail.com>
 <20231025065458.z3klmhahrcqh6qyw@vireshk-i7>
 <CAPDyKFr4vdsKVYEx0aF5k_a1bTjp3NzMpNgaXDJOJrvujT7iRg@mail.gmail.com>
 <ZTkciw5AwufxQYnB@gerhold.net>
 <CAPDyKFq+zsoeF-4h5TfT4Z+S46a501_pUq8y2c1x==Tt6EKBGA@mail.gmail.com>
 <20231030102944.nrw4bta467zxes5c@vireshk-i7>
 <CAPDyKFrn97POKuNc3cMM9TOaw-f-ufLwYtUY8_L2w8+hzECWOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrn97POKuNc3cMM9TOaw-f-ufLwYtUY8_L2w8+hzECWOA@mail.gmail.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-11-23, 12:58, Ulf Hansson wrote:
> Are you saying that the OPP library should be capable of managing the
> parent-clock-rates too, when there is a new rate being requested for a
> clock that belongs to an OPP? To me, that sounds like replicating
> framework specific knowledge into the OPP library, no? Why do we want
> this?

I am surely not touching clocks or any other framework :)

> Unless I totally misunderstood your suggestion, I think it would be
> better if the OPP library remained simple and didn't run recursive
> calls, but instead relied on each framework to manage the aggregation
> and propagation to parents.

I see your point and agree with it.

Here is the problem and I am not very sure what's the way forward for this then:

- Devices can have other devices (like caches) or genpds mentioned via
  required-opps.

- Same is true for genpds, they can also have required-opps, which may or may not
  be other genpds.

- When OPP core is asked to set a device's OPP, it isn't only about performance
  level, but clk, level, regulator, bw, etc. And so a full call to
  dev_pm_opp_set_opp() is required.

- The OPP core is going to run the helper recursively only for required-opps and
  hence it won't affect clock or regulators.

- But it currently affects genpds as they are mentioned in required-opps.

- Skipping the recursive call to a parent genpd will require a special hack,
  maybe we should add it, I am just discussing it if we should or if there is
  another way around this.

-- 
viresh
