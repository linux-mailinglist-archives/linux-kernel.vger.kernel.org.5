Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459E0782BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjHUOXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235822AbjHUOXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:23:51 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE1EA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:23:48 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d6b0c2cca0aso3386997276.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692627828; x=1693232628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qI4t8SDVJMhXzDamC4q86X6ieBjYdmuT6UT0C+IJ2Og=;
        b=bS3lH48mYdBNX7MAw649CJx0NJABczQrfg8v+P2nTXm0EmwA6Fvw7NI3XcQLURinCQ
         NIrTj2+EVwXdQDrW9aD8GwmZOl6hAKX6QAyKguViuJh80M9yGN5MUs5OFZLrMWqM0SSv
         hq2ithUtqT4wULnTqR1i49+e7Dc/T7DgLkjKVnVLtCFTw7U3ZXNSGqWp/Cnkw6aVOdC/
         ziMwuECpNBQ5jY9otfSFJZPUXjagWLLE56LxmXsVlJacYFfINB/J7PpoO/ASKbGNhe37
         bcCwhIRm8SFx2vykm5Xq4Gt7GuIABQSTpj/pUVamPHoCcvoNDdBK1sXcHBsJJTKoME81
         I22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692627828; x=1693232628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qI4t8SDVJMhXzDamC4q86X6ieBjYdmuT6UT0C+IJ2Og=;
        b=Yvdq1OsxeDX/tVZQZu7I3cqmEvIyEBNdUlJcKdDDjzYVEG3h+SvnH+LhZKAT8F5nX6
         Z+0m+7M0jE8Mknpv19Vqd2XcOk23KJ6/nlYEHnwj9MOdLMv0wFZwiwk9UsEtYKAnC00u
         6caPjT+SV3bexZFtPkDyZ4yRtriwCIVZJQMBJwrxTZWTQWFyA8X+qWSDRy7ratsV/smv
         pWafPJ2Xe2pjh/xlaA7CaYpg+HpBhp09pwJ6okqOaN5Gp1vjdPBCIhWEDFyaHsYIDOYQ
         hYho+qewWfo+tCT5layhvmjp9vp+qp34bXc7GPmbDummdSFB33uaBUFHK/+P75jSEPjT
         tHWQ==
X-Gm-Message-State: AOJu0YxHuFgvnHywTsjZtlHxBGfpdKzI8oAQkIiklzuxxYFXYXhcwZ2M
        gxBRXobNLURPyRJZ46oOvF2N8zXju2XnKqIDhYlJkQ==
X-Google-Smtp-Source: AGHT+IG8w7sOTs96ZQbK783vPuu7KIpqKAevj7gF4qW1xaxthEWCfaFl/an/E9olSOG2iOL03miEu7a+d+VYztk6RPE=
X-Received: by 2002:a25:258a:0:b0:d21:ef87:c1c4 with SMTP id
 l132-20020a25258a000000b00d21ef87c1c4mr7280290ybl.33.1692627827942; Mon, 21
 Aug 2023 07:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-10-ulf.hansson@linaro.org> <20230719152426.qwc5qqewrfjsarlz@bogus>
 <CAPDyKFogrwFnz2ZuKE-mLrCQmTCQcrtjhhyzB4CnoVnxAXqKEg@mail.gmail.com>
 <20230721143728.GB1092306-robh@kernel.org> <CAPDyKFr9V6iPJhXXrv5RxgAE-YvXDboN5GP8E=q2VHnjs8cL5w@mail.gmail.com>
In-Reply-To: <CAPDyKFr9V6iPJhXXrv5RxgAE-YvXDboN5GP8E=q2VHnjs8cL5w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Aug 2023 16:23:11 +0200
Message-ID: <CAPDyKFq=WaR-=xO-OTLYRxN0QF_WtgCk4axMFO0kB4XWLbL=7g@mail.gmail.com>
Subject: Re: [PATCH v2 09/11] cpufreq: scmi: Add support to parse domain-id
 using #power-domain-cells
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 13:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 21 Jul 2023 at 16:37, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Jul 21, 2023 at 01:52:17PM +0200, Ulf Hansson wrote:
> > > On Wed, 19 Jul 2023 at 17:24, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On Thu, Jul 13, 2023 at 04:17:36PM +0200, Ulf Hansson wrote:
> > > > > The performance domain-id can be described in DT using the power-domains
> > > > > property or the clock property. The latter is already supported, so let's
> > > > > add support for the power-domains too.
> > > > >
> > > >
> > > > How is this supposed to work for the CPUs ? The CPU power domains are
> > > > generally PSCI on most of the platforms and the one using OSI explicitly
> > > > need to specify the details while ones using PC will not need to. Also they
> > > > can never be performance domains too. So I am not sure if I am following this
> > > > correctly.
> > >
> > > Your concerns are certainly correct, I completely forgot about this.
> > > We need to specify what power-domain index belongs to what, by using
> > > power-domain-names in DT. So a CPU node, that has both psci for power
> > > and scmi for performance would then typically look like this:
> > >
> > > power-domains = <&CPU_PD0>, <&scmi_dvfs 4>;
> > > power-domain-names = "psci", "scmi";
> >
> > That is completely backwards. Entries are named based on the consumer
> > side. The function of each clock or interrupt for example. Here your
> > entries are based on the provider which should be opaque to the
> > consumer.
>
> Okay, so you would rather prefer something along the lines of the below?
>
> power-domain-names = "power", "perf";
>
> The "psci" name is already part of the current cpus DT binding
> (Documentation/devicetree/bindings/arm/cpus.yaml), so then it looks
> like that deserves an update too. Right?

Rob, may I have your thoughts around this? Is this an acceptable way
forward? Please advise me on what power-domain-names I should use
then.

Or, if you are insisting on using the performance-domain bindings?

Kind regards
Uffe
