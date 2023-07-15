Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FD7754887
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 14:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGOMgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjGOMgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 08:36:18 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8782835BD
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 05:36:17 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-579e212668fso41030877b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689424575; x=1692016575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpJ+fMs1IOI6v0cEM4uyI8KOLiMJF74uY2KcNd4wMZA=;
        b=XRMoaDrV9xzJt4GcRI1SJzWMqAqfQA7QdP2W1NH2uC3lt3rejwhCKHSgpCRazRFdh7
         mcXHP9x0UHQvwQJ2KjkqJ12ycfiTd9KUvfFGtDiEeqGTAzso0TyOCdJEe815KubpJZUi
         GlPWyDx82A66bpwH2qgE5RuFkAizPrWoOSDkNcoad4hKENo86O9rw6xEcPKqE6aQRK+F
         jXVGAT4HqggzQSS1YWQ6KNqN3Zr1pm4W6oqLX5kjDjjskgIjW1NTLjk9uvPBuXyMCQX6
         zzGQoS9nmP57tFybZKXMH3ueVehgWX7mN5+kaJucRdKNp8qIdOKFc0zKimegh6MUQIcQ
         uoGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689424575; x=1692016575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpJ+fMs1IOI6v0cEM4uyI8KOLiMJF74uY2KcNd4wMZA=;
        b=CZjWcO9pi9xiJynqS0eIh6rkorQU0RtcrW7x07kUDN7To1HaXo7lytTdhps0FFyYc5
         Sw3hpbIRypgvWfsIAK3ajOWJoRnuCeuqMeU6TSjX358iOvqMQ/Xa84Q5I4M37ok+Qx6/
         DeegV905t+XOVxYoN0R7zfDYJCrCAW8ELdJs5vGaPNnq6Kur0HjHuzcWUod4G5NBlpod
         wTjNpzJzJFLY2XSSnh0zY0YEU9mI9ewSd3puo2ma7zrDM5v/GFJZy0JkC4lC9gW5Kvnv
         bqTFqvd98qwrj0FHCkHFGIw64CvyBmQnL9zIeCBPazsTBIcXg+FedJKaHliZryauMy7i
         VvOg==
X-Gm-Message-State: ABy/qLYAyqOPExLmBx0exCvRnCd2XjtGJ2aJ25CR8xtGytK3tTJEJA7a
        EjMtcpjRfFah26QPFCvr2vWsRsEc57zGqgU0n71Siw==
X-Google-Smtp-Source: APBJJlGDF63mhRSyH4p9VTQc6rjgrJyCAVzT5nfkkrOuEPVRsn5X+Iw3TWaDpHP8YQbCm0sO287AOirXsFnAaHBT3r0=
X-Received: by 2002:a0d:e649:0:b0:57a:15c0:2f5b with SMTP id
 p70-20020a0de649000000b0057a15c02f5bmr6283853ywe.8.1689424575647; Sat, 15 Jul
 2023 05:36:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230607124628.157465-1-ulf.hansson@linaro.org>
 <20230607124628.157465-10-ulf.hansson@linaro.org> <20230614230044.GA3019052-robh@kernel.org>
 <CAPDyKFoDQ12yUB-3f_V222kcUivP_NUcvcM+8s7CraLaBy7tBQ@mail.gmail.com> <CAL_Jsq+GMA62hey6+KYMmVSWsDEkGfD0B=0V9AbdmRqdE6VW1g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+GMA62hey6+KYMmVSWsDEkGfD0B=0V9AbdmRqdE6VW1g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Sat, 15 Jul 2023 14:35:38 +0200
Message-ID: <CAPDyKFrk92v-d63L8vKyyaVv4LQfG74otWx+LUYLo12m-Norgw@mail.gmail.com>
Subject: Re: [PATCH 09/16] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jul 2023 at 19:15, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 15, 2023 at 3:11=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Thu, 15 Jun 2023 at 01:00, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Jun 07, 2023 at 02:46:21PM +0200, Ulf Hansson wrote:
> > > > The protocol@13 node is describing the performance scaling option f=
or the
> > > > ARM SCMI interface, as a clock provider. This is unnecessary limiti=
ng, as
> > > > performance scaling is in many cases not limited to switching a clo=
ck's
> > > > frequency.
> > > >
> > > > Therefore, let's extend the binding so the interface can be modelle=
d as a
> > > > generic "performance domain" too. The common way to describe this, =
is to
> > > > use the "power-domain" bindings, so let's use that.
> > >
> > > What's wrong with the performance-domain binding?
> >
> > In my opinion I think the performance-domain binding is superfluous.
> > We already have plenty of power-domains that do performance scaling
> > too - and they stick with the power-domain binding, as it's
> > sufficient.
>
> IMO, power-domains should be for power islands which can be power
> gated. I know they are abused though. Of course, when things are
> hidden in firmware, you don't really know. A power-domain could be
> just a clock or a clock could be multiple physical clocks.

I would also like to point out that it's perfectly possible that a
power-domain can be a combination of a "power-island" and a
performance-domain. In fact we have those cases already (Qcom, Tegra).

>
> > That said, I would rather follow the defacto standard that has been
> > used for many years in the kernel. Do you have a preference that we
> > should stick to?
>
> If power-domains are sufficient, then why do we have
> performance-domains? We need clear rules for when to use what.

Well, I think we invented the performance-domains bindings, especially
with CPUs in mind. So far, that's the only use-case too (Mediatek,
Apple). Even if I think the power-domains bindings would have worked
fine for these cases too, maybe we should limit the
performance-domains binding to be used for CPUs?

Anyway, for the more generic use-case, I think the power-domains DT
binding is better to stick with (it's what we have used for many years
by now), as it provides us with the flexibility of hooking up an
opp-table to the power-domain, allowing us to make the domain
"performance-capable" too.

Kind regards
Uffe
