Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA1E7BA2FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjJEPuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbjJEPtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:49:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2FE6A39F;
        Thu,  5 Oct 2023 08:08:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 20D53C15;
        Thu,  5 Oct 2023 08:09:03 -0700 (PDT)
Received: from bogus (unknown [10.57.93.106])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A4563F5A1;
        Thu,  5 Oct 2023 08:08:21 -0700 (PDT)
Date:   Thu, 5 Oct 2023 16:06:49 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] firmware: arm_scmi: Add generic OPP support to the
 SCMI performance domain
Message-ID: <20231005150649.p6viyorcucq2irsi@bogus>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
 <20230925131715.138411-10-ulf.hansson@linaro.org>
 <20230929162522.zjoh5d2tqspzm3nc@bogus>
 <20231003082133.xyu46szs3jfm6fks@vireshk-i7>
 <20231003112647.bbqwnre5bzijw5sg@bogus>
 <20231004050806.sba3ogq76yiylrro@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004050806.sba3ogq76yiylrro@vireshk-i7>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 10:38:06AM +0530, Viresh Kumar wrote:
> On 03-10-23, 12:26, Sudeep Holla wrote:
> > On Tue, Oct 03, 2023 at 01:51:33PM +0530, Viresh Kumar wrote:
> > > On 29-09-23, 17:25, Sudeep Holla wrote:
> > > > On Mon, Sep 25, 2023 at 03:17:15PM +0200, Ulf Hansson wrote:
> > > > > To allow a consumer driver to use the OPP library to scale the performance
> > > > > for its device, let's dynamically add the OPP table when the device gets
> > > > > attached to its SCMI performance domain.
> > > > >
> > > > 
> > > > The SCMI changes(patches 7-9) look fine to me. Rafael was fine with genpd
> > > > changes, Viresh if you are OK with OPP changes I can take it via SCMI as
> > > > there are some dependent patches as Ulf has pointed out in the cover letter.
> > > 
> > > I would like to take OPP patches via my tree as there are some changes in my
> > > tree and I plan to add some more changes on top of this. I can give an immutable
> > > branch though.
> > >
> > 
> > Works for me. Please do share it once you have it ready.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git opp/pm-domain-scmi
> 

Thanks, I wasn't expecting these patches in the branch, but if you are
aware off and are fine with it, I have no objections.

	dt-bindings: opp: opp-v2-kryo-cpu: Allow opp-peak-kBps
	OPP: debugfs: Fix warning with W=1 builds
	OPP: Remove doc style comments for internal routines
	OPP: Add dev_pm_opp_find_level_floor()

-- 
Regards,
Sudeep
