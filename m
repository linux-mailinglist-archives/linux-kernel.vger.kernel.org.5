Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2004075CA13
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 16:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjGUOdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 10:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjGUOdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 10:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EEAE68;
        Fri, 21 Jul 2023 07:33:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55BB061C5B;
        Fri, 21 Jul 2023 14:33:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A077DC433C9;
        Fri, 21 Jul 2023 14:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689949986;
        bh=9YgoooZ1+5ex0bT6wHIjCPICCL0FV+SDivmd0dBm1Yg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bymN+Iy39Hk04ez4RfAMumeKdmq9Wbus0j/aDF2biw6x+HBfPs7RncrNXgo92dbB1
         irqAjHtE44GXEowvyDSgO9oM/chPKotX9XrizhZbejy8RHIl/TXuigoHoDUyOyusVF
         zRgHzAJOgvnV7jtxHfp7wjYQjEaQW1cP90UUEccm++gpymgsewlyo4JTJACYHKwUZL
         8UDOm4ic94yqxJS5+qtvuSYsCCCnV5qIMEiJouh1BiikrAmIDr3cllyX1VqqGe4DUd
         8qQmu7xOKVRfXJvLfYdTJe2NgYtLgGYsmSxE7m810re6mzoV1RUuaRwQHtVYX4v3Xg
         EINKEe8TrapNg==
Received: (nullmailer pid 1099660 invoked by uid 1000);
        Fri, 21 Jul 2023 14:33:04 -0000
Date:   Fri, 21 Jul 2023 08:33:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
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
Subject: Re: [PATCH v2 08/11] dt-bindings: firmware: arm,scmi: Extend
 bindings for protocol@13
Message-ID: <20230721143304.GA1092306-robh@kernel.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
 <20230713141738.23970-9-ulf.hansson@linaro.org>
 <20230719151716.qhobfnclrjf4yqkg@bogus>
 <CAPDyKFpjMWOAbV+b2DcxDWqvRDQCbSC6Ti+KGGPWJoC4Ghp7=w@mail.gmail.com>
 <20230721115535.mx46dg56pxjnzbuv@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721115535.mx46dg56pxjnzbuv@bogus>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 12:55:35PM +0100, Sudeep Holla wrote:
> On Fri, Jul 21, 2023 at 01:42:43PM +0200, Ulf Hansson wrote:
> > On Wed, 19 Jul 2023 at 17:17, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > >
> > > On Thu, Jul 13, 2023 at 04:17:35PM +0200, Ulf Hansson wrote:
> > > > The protocol@13 node is describing the performance scaling option for the
> > > > ARM SCMI interface, as a clock provider. This is unnecessary limiting, as
> > > > performance scaling is in many cases not limited to switching a clock's
> > > > frequency.
> > > >
> > > > Therefore, let's extend the binding so the interface can be modelled as a
> > > > generic performance domaintoo. The common way to describe this, is to use
> > > > the "power-domain" DT bindings, so let's use that.
> > > >
> > >
> > > One thing I forgot to ask earlier is how we can manage different domain IDs
> > > for perf and power domains which is the case with current SCMI platforms as
> > > the spec never mandated or can ever mandate the perf and power domains IDs
> > > to match. They need not be same anyways.
> > 
> > Based upon what you describe above, I have modelled the perf-domain
> > and the power-domain as two separate power-domain providers.
> > 
> > A consumer device being hooked up to both domains, would specify the
> > domain IDs in the second power-domain-cell, along the lines of the
> > below. Then we would use power-domain-names to specify what each
> > power-domain represents.
> > 
> > power-domains = <&scmi_pd 2>, <&scmi_dvfs 4>;
> > power-domain-names = "power", "perf";
> >
> > I hope this makes it clearer!?
> 
> Yes it make is clear definitely, but it does change the definition of the
> generic binding of the "power-domains" property now. I am interesting in
> the feedback from the binding maintainers with respect to that. Or is it
> already present ? IIUC, the ones supported already are generally both
> power and performance providers. May be it doesn't matter much, just
> wanted to explicit ask and confirm those details.

I commented on v1.

Looks like abuse of "power-domains" to me, but nothing new really. 
Please define when to use a power domain vs. a perf domain and don't 
leave it up to the whims of the platform. Maybe perf domains was a 
mistake and they should be deprecated?

Rob
