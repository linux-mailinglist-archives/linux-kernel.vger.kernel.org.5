Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF2D7A9750
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjIURWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjIURWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:22:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0666F4ED5;
        Thu, 21 Sep 2023 10:07:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AA9CB1684;
        Thu, 21 Sep 2023 06:30:08 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A7133F5A1;
        Thu, 21 Sep 2023 06:29:29 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:29:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/13] cpufreq: scmi: Drop redundant ifdef in
 scmi_cpufreq_probe()
Message-ID: <20230921132927.ca6qoewimwn2xzh5@bogus>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-8-ulf.hansson@linaro.org>
 <20230921111426.b2vp5hu7ssdtmz3n@bogus>
 <CAPDyKFqHBWtDioepsJuNHEa6ckwtuAOKBLx+LZEZctADTP--3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqHBWtDioepsJuNHEa6ckwtuAOKBLx+LZEZctADTP--3w@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 03:02:16PM +0200, Ulf Hansson wrote:
> On Thu, 21 Sept 2023 at 13:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Fri, Aug 25, 2023 at 01:26:27PM +0200, Ulf Hansson wrote:
> > > We have stubs for devm_of_clk_add_hw_provider(), so there should be no need
> > > to protect this with the '#ifdef CONFIG_COMMON_CLK'. Let's drop it to clean
> > > up the code a bit.
> > >
> >
> > No exactly. The stub is under !CONFIG_OF but we need it for !CONFIG_COMMON_CLK.
> > The original build issue reported for which I add this was CONFIG_OF=y &&
> > CONFIG_COMMON_CLK=n.
> >
> > It looks like it is still valid combo though I don't have a handy randconfig
> > to present to you. I prefer to drop this for now if that is OK with you.
> 
> Sure, it's perfectly fine to drop it. It's just a thing I stumbled
> over that isn't really needed in the $subject series!
> 

Thanks !

-- 
Regards,
Sudeep
