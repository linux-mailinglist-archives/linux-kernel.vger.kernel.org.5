Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7205B763500
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233733AbjGZLb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjGZLb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:31:56 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97869F3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:31:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-57045429f76so78190277b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690371115; x=1690975915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jLv11qpOMr7y6l1HWpJ5VrwcHkwmRcTE/5uBkJt0Km0=;
        b=MkxNnvIpJkOmEk7n2jttHGuxqb5Oe+I9GZebdZVY8SsA8BUr2h2S3gwx0/jwtPeExC
         eAExJkepuM6OhTmiLDNJdmep9oGFZpTA4E2M/9P/5OrFiFP1TKXmFdTYQKzdbCJXXR3u
         JGXFyrLAksjRgzQRqbQi2oprebgFA6fiszIZyYkQY1HsVCk4asTJpJMRFMKGJQLvyMV8
         QX7Pl/y3mDHq9WgeJJ+uZbPIpkK2S+YGTTQesbhDYXRRXCkgxJicREw3iubEJA2RbUyE
         w8Pa0GsjAmHqgvc96Z/E2uoIdsTNVWZnaihpwvi5+qVGbTu2faTtcKPorTwIr3te3JOg
         HqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690371115; x=1690975915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLv11qpOMr7y6l1HWpJ5VrwcHkwmRcTE/5uBkJt0Km0=;
        b=lJRylWtTagAswjov09MwHw38xe+NVred/tjwCCZAl+GzoCZt9dr46rm/gNUrrc4CAV
         qMCTeMXDqrZRmwJrHRYNYCkPsAgHZZg5f6xBXbURgubrE4YUCjekw5qMKQ0E3DJb5YjO
         0yi+C1wL4u6IspIXB+X9RdMPN+IE6emeyxwVaUbLpjvFEraGzgzSqtnHGM1wNhq/JrBQ
         aJj5kow6ANp7SPexN84LK0xnDMy3vLIzw++ra0H6vt7xA5zRMYpt2EwHUCD5hVcspPh5
         D2J70lupN6LTyXMS51LeiqvZjHw+9scj9ZQ3Fop37JKeBk1w1qlp6FqqmKDT4sxeBEEI
         1EQA==
X-Gm-Message-State: ABy/qLZMMvITwadhzyTWnrbslzjyJS2iijQtN1JlHIBH2vcyuyr0k/O4
        PMu40nDeTV01pzDVCcGHWE5WifpiUmqbm6Vr2VFpoA==
X-Google-Smtp-Source: APBJJlGCRFajfKQn9z6tzkQD4evt9uCaBCCq73lhqACV/XJdk0Ot20nld0e0VPgml5GXvLyxxSULQHK6xXMJYBDR4/g=
X-Received: by 2002:a81:66c4:0:b0:583:a418:c3fc with SMTP id
 a187-20020a8166c4000000b00583a418c3fcmr1895070ywc.23.1690371114731; Wed, 26
 Jul 2023 04:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-10-ulf.hansson@linaro.org> <20230719152426.qwc5qqewrfjsarlz@bogus>
 <CAPDyKFogrwFnz2ZuKE-mLrCQmTCQcrtjhhyzB4CnoVnxAXqKEg@mail.gmail.com> <20230721115917.lescikl75kmeqkw4@bogus>
In-Reply-To: <20230721115917.lescikl75kmeqkw4@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 26 Jul 2023 13:31:19 +0200
Message-ID: <CAPDyKFr6oduyihOd7u6UW3RJAJr=a3mT8Dw9GtryhK4+SRK_wg@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jul 2023 at 13:59, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Fri, Jul 21, 2023 at 01:52:17PM +0200, Ulf Hansson wrote:
> > On Wed, 19 Jul 2023 at 17:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Jul 13, 2023 at 04:17:36PM +0200, Ulf Hansson wrote:
> > > > The performance domain-id can be described in DT using the power-domains
> > > > property or the clock property. The latter is already supported, so let's
> > > > add support for the power-domains too.
> > > >
> > >
> > > How is this supposed to work for the CPUs ? The CPU power domains are
> > > generally PSCI on most of the platforms and the one using OSI explicitly
> > > need to specify the details while ones using PC will not need to. Also they
> > > can never be performance domains too. So I am not sure if I am following this
> > > correctly.
> >
> > Your concerns are certainly correct, I completely forgot about this.
> > We need to specify what power-domain index belongs to what, by using
> > power-domain-names in DT. So a CPU node, that has both psci for power
> > and scmi for performance would then typically look like this:
> >
> > power-domains = <&CPU_PD0>, <&scmi_dvfs 4>;
> > power-domain-names = "psci", "scmi";
> >
> > I will take care of this in the next version - and thanks a lot for
> > pointing this out!
>
>
> Yes something like this will work. Just curious will this impact the idle
> paths ? By that I mean will the presence of additional domains add more
> work or will they be skipped as early as possible with just one additional
> check ?

Unless I misunderstand your concern, I don't think there is any impact
on the idle path whatsoever. This should be entirely orthogonal.

The scmi-cpufreq driver should only have to care about the
scmi-performance domain, while the cpuidle-psci driver cares only
about psci.

Did that make sense?

Kind regards
Uffe
