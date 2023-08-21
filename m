Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BBD782BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjHUOd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjHUOd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:33:28 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BB2E3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:33:26 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d712d86eb96so3130126276.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692628405; x=1693233205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVf6fM0iJ2iIkGIz1YOTaiRR1OthdLkPvJ97HGCmhgA=;
        b=O0mLKFdREezoY2/1oR2MOzof4eSxczj6uQdNs2otCl3toxWc5nmFXkEyCfAIVQwIPE
         hezvo5QD6eADUgHlL3Wq9G+YHn2FLk652AW4Lnl60Or0i9E78llV2EN0bplGBYERVniD
         Q7eeaxX9BOOtEvPDQcn67qKQtorseu+NmUEJGhUlFPstw2CZxEJ2Dqiz8xdVPSx5Rt6f
         8zsSzcezeQrcid7n/tkOrY9K4dK3PpCdBCgsJZ7I59YeP4FyRlJjwft/dmV2OsmQ/chv
         TWd7SheQ/+Qr03dqIFb11o/hAAuqdezONokX1wwtokLq1z8MYwSqCYrX9h07LIswzCpN
         ei1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692628405; x=1693233205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVf6fM0iJ2iIkGIz1YOTaiRR1OthdLkPvJ97HGCmhgA=;
        b=aT2zzDr7L/74zZXFox+mxpdqYZzQWJK2wD1uCbg5dG/qtU1q252pINpBCBXgw9e7lK
         ImXZxp3BkWjI+d+v2cM9TbUa94JgcNzxxM7uw+r55CPV9thsoK6lcPMugIlIC5gcHD0Q
         lGpqxPZL9oEp2EIfxXKVoLQ/iKYDvbEvapZH751lFnuZALD9A4ySzLRQGPzDLWduL+I0
         +K6VbB7VSPYaJ/k8ZkzjAvjth7R0eCX8/Rxt9nuVEWCX7oLkqg5UglyV+BcHK9dMelaW
         IDyfj2RA6t/r4BoY8624BwiUzogcbYF3cKBFd1Y0EXEWn9qQzbbvOoqB22Qt3pFZgQAn
         5sFw==
X-Gm-Message-State: AOJu0YxXXaonzdvLCWWXUErcbVz1nZ0T/RnjYQOFpwTz+rB4cQ4ULBe4
        QOtvVlqvXSeMphIk/9nnHVo95ynslap18dArWrhuyw==
X-Google-Smtp-Source: AGHT+IF8pqtgsDod4AcLNDd7B46cZvClFs4sWgkMxAtQQuCt9OO664LsbLksG7aBhJow6s/DU6WNo/6kzskR+zV3X2k=
X-Received: by 2002:a25:bcc7:0:b0:d74:66aa:a277 with SMTP id
 l7-20020a25bcc7000000b00d7466aaa277mr6691513ybm.65.1692628405501; Mon, 21 Aug
 2023 07:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-9-ulf.hansson@linaro.org> <20230719151716.qhobfnclrjf4yqkg@bogus>
 <CAPDyKFpjMWOAbV+b2DcxDWqvRDQCbSC6Ti+KGGPWJoC4Ghp7=w@mail.gmail.com>
 <20230721115535.mx46dg56pxjnzbuv@bogus> <20230721143304.GA1092306-robh@kernel.org>
 <20230721183817.34lgb42nlnsvqx4s@bogus> <CAPDyKFqsaz=hruktv+sPQz-ttOtWa9O_Jvp2iLnpxQqX2r7yBQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqsaz=hruktv+sPQz-ttOtWa9O_Jvp2iLnpxQqX2r7yBQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 21 Aug 2023 16:32:49 +0200
Message-ID: <CAPDyKFr5pJR5+PrSrWEA_hZmureacxuT-T5OxitdFs2AXoRUyg@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
To:     Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 at 13:12, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 21 Jul 2023 at 20:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Jul 21, 2023 at 08:33:04AM -0600, Rob Herring wrote:
> > > On Fri, Jul 21, 2023 at 12:55:35PM +0100, Sudeep Holla wrote:
> > > > On Fri, Jul 21, 2023 at 01:42:43PM +0200, Ulf Hansson wrote:
> > > > > On Wed, 19 Jul 2023 at 17:17, Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
> > > > > >
> > > > > > On Thu, Jul 13, 2023 at 04:17:35PM +0200, Ulf Hansson wrote:
> > > > > > > The protocol@13 node is describing the performance scaling op=
tion for the
> > > > > > > ARM SCMI interface, as a clock provider. This is unnecessary =
limiting, as
> > > > > > > performance scaling is in many cases not limited to switching=
 a clock's
> > > > > > > frequency.
> > > > > > >
> > > > > > > Therefore, let's extend the binding so the interface can be m=
odelled as a
> > > > > > > generic performance domaintoo. The common way to describe thi=
s, is to use
> > > > > > > the "power-domain" DT bindings, so let's use that.
> > > > > > >
> > > > > >
> > > > > > One thing I forgot to ask earlier is how we can manage differen=
t domain IDs
> > > > > > for perf and power domains which is the case with current SCMI =
platforms as
> > > > > > the spec never mandated or can ever mandate the perf and power =
domains IDs
> > > > > > to match. They need not be same anyways.
> > > > >
> > > > > Based upon what you describe above, I have modelled the perf-doma=
in
> > > > > and the power-domain as two separate power-domain providers.
> > > > >
> > > > > A consumer device being hooked up to both domains, would specify =
the
> > > > > domain IDs in the second power-domain-cell, along the lines of th=
e
> > > > > below. Then we would use power-domain-names to specify what each
> > > > > power-domain represents.
> > > > >
> > > > > power-domains =3D <&scmi_pd 2>, <&scmi_dvfs 4>;
> > > > > power-domain-names =3D "power", "perf";
> > > > >
> > > > > I hope this makes it clearer!?
> > > >
> > > > Yes it make is clear definitely, but it does change the definition =
of the
> > > > generic binding of the "power-domains" property now. I am interesti=
ng in
> > > > the feedback from the binding maintainers with respect to that. Or =
is it
> > > > already present ? IIUC, the ones supported already are generally bo=
th
> > > > power and performance providers. May be it doesn't matter much, jus=
t
> > > > wanted to explicit ask and confirm those details.
> > >
> > > I commented on v1.
> > >
> > > Looks like abuse of "power-domains" to me, but nothing new really.
> > > Please define when to use a power domain vs. a perf domain and don't
> > > leave it up to the whims of the platform. Maybe perf domains was a
> > > mistake and they should be deprecated?
> > >
> >
> > Just a thought here, instead of deprecating it I was thinking if possib=
le
> > to keep the power-domains and performance-domains separate and just ext=
end
> > the genpd to handle the latter. There by we are not mixing up and creat=
ing
> > confusions that need more specific definitions in the binding(which is =
not
> > a big deal) but platforms getting it wrong inspite of that is a big pro=
blem.
> > Keep it separate makes it more aligned to the hardware and doesn't dilu=
te
> > the definitions and probably avoids any possible mistakes due to that.
> >
> > Sorry Ulf I am just not yet convinced to mix them up yet =F0=9F=98=89 a=
nd wish you
> > don't convince me to. Let me know why the above suggestion won't work.
>
> The main point I think we need to consider too, is that on some
> platforms, the power-domain and the performance-domain are managed
> together by the FW. It is not really two separate things and hence it
> would not quite be correct to describe it as two different types of
> providers in DT.
>
> If we should follow your suggestion above, to use the
> performance-domain bindings, then I think we need an additional new
> binding to cover the above mentioned case too. This would lead us into
> having one binding for the power-domain, another for the
> performance-domain and a third for the power+performance-domain.
>
> In my opinion this sounds quite like a mess. I would rather keep using
> the power-domain bindings for all these cases. Of course, it's a bit
> of a stretch too, but I think it should be less confusing in the end,
> assuming we extend/clarify the description of the power-domain
> bindings, of course.
>
> Did that convince you? :-)

Sudeep, Rob,

Can we try to conclude on the way forward?

Is it acceptable to keep using the power-domain bindings (with some
clarifications) for performance domains or should we start moving to
the performance-domain bindings?

If moving to the performance-domain binding, should we start migrating
existing users of the power-domain binding too - or what is your take
on this?

Kind regards
Uffe
