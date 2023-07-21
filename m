Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5340875C604
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGULnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjGULnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:43:22 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFBF2130
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:43:20 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-c84fd44593aso1693744276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689939799; x=1690544599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tvcjtZ3fAd3T86N+Nc8tchF47bEM+Sgqc4f9Howik4k=;
        b=EGiXyHnd1GNRAWNyIwBe7+h+QQH8y8Js9qx1hsQU5of8F097niky+LG8agfSm1GrUi
         F2XkHmx2OkZ6atX5nIZr4BTXS+UC6HQ25TpIMh93GzjixPXyK5wBJDN9cw3bD/d8v6ks
         Fq88y5xF26mRLX99GReYUvQ4SaNHFrgaAHl9Exr08UyQNHtHTcZ3yFppkI+2LiZu7Rnz
         eRQry1U7RCB4EpSfGcEcii8/Q873kRzPKtw8pb6TZPsHqeqwmW0VZXTICHOLFG9MQ/fL
         E3jLMTsYdhGeCIU4A6Kf+kJEr2BDz6aUPbFeF1HUtRQ6Vfa4iysKXwP99wv9tEisv6OL
         YPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689939799; x=1690544599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvcjtZ3fAd3T86N+Nc8tchF47bEM+Sgqc4f9Howik4k=;
        b=a0JdV0skFi3CyJJZD/QFP23hAjF7HUZxFXHQQD/o1KDDU7flkarWKhMqxE6Nb/k5j3
         N63xrvlj9CfJw/BUM6aAn3ISqIdlLSX6aWMDWUQToR6qwjaW6YniW8JYYrI9pKf1/BVf
         Qn8WYUV5+iGHP+upQv/xRZ/pDYhZWvEudQ6YJBp/+aYTIp7dNAs5aaW00jOuYKbeBxPD
         brW6IaFTIwzL9uvsLRglLrZxxG5M1Nzwjccja3/votBGz1jQFW5280SjzpXqaEcDu/FR
         SewAD3+hn9KsunZ8kx9QGrQfaHyU5001d7My3+qt9/Ze0ilGrVLp6BJJ6+bot4bwsrpF
         cZ6g==
X-Gm-Message-State: ABy/qLZfnP4s09QVbopR+xgP47VaHVmHtRbdlK8vX9Vt8+BFTZzp7NEg
        ALIGJj5tgIS+9h5nakquYOQCG6oeetmIZ7EGNYDK3w==
X-Google-Smtp-Source: APBJJlFPb7ZDiFwJLnxRjnHw9dSjFURtIzcegAQZLbf1Dz5nanwXdCowrdXXGTz31+c2EVpePD22NKlUaRVJD2Y75Sk=
X-Received: by 2002:a25:dbc1:0:b0:c11:6638:af3e with SMTP id
 g184-20020a25dbc1000000b00c116638af3emr1389589ybf.45.1689939799341; Fri, 21
 Jul 2023 04:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-9-ulf.hansson@linaro.org> <20230719151716.qhobfnclrjf4yqkg@bogus>
In-Reply-To: <20230719151716.qhobfnclrjf4yqkg@bogus>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Jul 2023 13:42:43 +0200
Message-ID: <CAPDyKFpjMWOAbV+b2DcxDWqvRDQCbSC6Ti+KGGPWJoC4Ghp7=w@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] dt-bindings: firmware: arm,scmi: Extend bindings
 for protocol@13
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 17:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Jul 13, 2023 at 04:17:35PM +0200, Ulf Hansson wrote:
> > The protocol@13 node is describing the performance scaling option for the
> > ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
> > performance scaling is in many cases not limited to switching a clock's
> > frequency.
> >
> > Therefore, let's extend the binding so the interface can be modelled as a
> > generic performance domaintoo. The common way to describe this, is to use
> > the "power-domain" DT bindings, so let's use that.
> >
>
> One thing I forgot to ask earlier is how we can manage different domain IDs
> for perf and power domains which is the case with current SCMI platforms as
> the spec never mandated or can ever mandate the perf and power domains IDs
> to match. They need not be same anyways.

Based upon what you describe above, I have modelled the perf-domain
and the power-domain as two separate power-domain providers.

A consumer device being hooked up to both domains, would specify the
domain IDs in the second power-domain-cell, along the lines of the
below. Then we would use power-domain-names to specify what each
power-domain represents.

power-domains = <&scmi_pd 2>, <&scmi_dvfs 4>;
power-domain-names = "power", "perf";

I hope this makes it clearer!?

Kind regards
Uffe
