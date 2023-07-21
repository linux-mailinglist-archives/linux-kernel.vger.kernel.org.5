Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D3E75C61A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGULw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjGULwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:52:55 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE872130
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:52:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-cc7863e7b82so1721001276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689940373; x=1690545173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/fxuqcvjNlrKwMc4wwhYKznxhsZSVT5gN9Y+RioTAqk=;
        b=TQf3yhOwJAeHFWlt32JBzHWQnLL7uGsHRp/NFuL9RV1IWslYKWQzvKC+Pgv32QAUQ/
         6WywXBGQvWLLFkpLOE/b1g6TmiJcz9lxvobsasNcQSDA5zy/JFVZh+e0DVBEvwOEd6ei
         NoXSBSPeCIYUnyZr1T20mjcI1Z1acprCKzVZXGNYbixWl6TsZJs2eHql5pUZyIWHEpDn
         eSkM+8fAF0kylgHrqRqCNjYUuFW4CbLPxoI2oLj/jg5bOL+mVRXk9huJlLF2TBEfscTD
         ZUp4QLoxlIwXl0td94qpnsqnZ7wz+VEzmyCHgW6szkBoS+tS16+YJ81zl9sdPfZ5d3QH
         cdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689940373; x=1690545173;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fxuqcvjNlrKwMc4wwhYKznxhsZSVT5gN9Y+RioTAqk=;
        b=OKyROO4ZzZ5oM5vT8xaCb89Kd4W2iVEfbvAEL4MVExzbylQPFU84L9p89EHG1DKEXM
         cS4SDiThpZpRag8Yv+z1Opw+E0v1BE0wAwpwguxLP75WeWevLdVfkl+UZm5/wOYDBitr
         aNx1545yFdcP2Uje34ATRcK+qQ7eD6tUlAksBqgrPMxBcoXBiFtVf0DEn0YJaiW9yAeW
         rHphF1Skz6CEkQ6SZ+t6ZUN1vdd4c2bN/iljarG7fC+b4mws98IO1J0BV+7C919i0kqw
         f0Su5s2Du0IfL558gLsOS0ZfoyYkAR/7nG4RnhtGiILQBuF0X7oiXmK00sqzHNjTKKLM
         QGiw==
X-Gm-Message-State: ABy/qLZYnWIfhsqhNuvJuSt3gNle2ygOw1Bwz7gF4lB/11CalEwwYnLB
        YTkduDuI30JPvX9eOTdZCd+/cUXXkvkqOIY3xExJjw==
X-Google-Smtp-Source: APBJJlFDW96+XvHO2EbF9UNzQyoz1DeAL9nucDYLQwqTM4AdCdWWTNUS4XVJgKEnLsxd10UEdDoWlwtXPmYSjqcuTXw=
X-Received: by 2002:a25:8485:0:b0:c69:54aa:d441 with SMTP id
 v5-20020a258485000000b00c6954aad441mr1467980ybk.34.1689940373619; Fri, 21 Jul
 2023 04:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-10-ulf.hansson@linaro.org> <20230719152426.qwc5qqewrfjsarlz@bogus>
In-Reply-To: <20230719152426.qwc5qqewrfjsarlz@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Jul 2023 13:52:17 +0200
Message-ID: <CAPDyKFogrwFnz2ZuKE-mLrCQmTCQcrtjhhyzB4CnoVnxAXqKEg@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] cpufreq: scmi: Add support to parse domain-id
 using #power-domain-cells
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

On Wed, 19 Jul 2023 at 17:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jul 13, 2023 at 04:17:36PM +0200, Ulf Hansson wrote:
> > The performance domain-id can be described in DT using the power-domains
> > property or the clock property. The latter is already supported, so let's
> > add support for the power-domains too.
> >
>
> How is this supposed to work for the CPUs ? The CPU power domains are
> generally PSCI on most of the platforms and the one using OSI explicitly
> need to specify the details while ones using PC will not need to. Also they
> can never be performance domains too. So I am not sure if I am following this
> correctly.

Your concerns are certainly correct, I completely forgot about this.
We need to specify what power-domain index belongs to what, by using
power-domain-names in DT. So a CPU node, that has both psci for power
and scmi for performance would then typically look like this:

power-domains = <&CPU_PD0>, <&scmi_dvfs 4>;
power-domain-names = "psci", "scmi";

I will take care of this in the next version - and thanks a lot for
pointing this out!

Kind regards
Uffe
