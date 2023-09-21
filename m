Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7D27A9E38
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjIUT6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjIUT6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:58:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20E0346DC2;
        Thu, 21 Sep 2023 10:13:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A79BB15BF;
        Thu, 21 Sep 2023 04:15:07 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0599D3F5A1;
        Thu, 21 Sep 2023 04:14:28 -0700 (PDT)
Date:   Thu, 21 Sep 2023 12:14:26 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 07/13] cpufreq: scmi: Drop redundant ifdef in
 scmi_cpufreq_probe()
Message-ID: <20230921111426.b2vp5hu7ssdtmz3n@bogus>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
 <20230825112633.236607-8-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825112633.236607-8-ulf.hansson@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 01:26:27PM +0200, Ulf Hansson wrote:
> We have stubs for devm_of_clk_add_hw_provider(), so there should be no need
> to protect this with the '#ifdef CONFIG_COMMON_CLK'. Let's drop it to clean
> up the code a bit.
>

No exactly. The stub is under !CONFIG_OF but we need it for !CONFIG_COMMON_CLK.
The original build issue reported for which I add this was CONFIG_OF=y &&
CONFIG_COMMON_CLK=n.

It looks like it is still valid combo though I don't have a handy randconfig
to present to you. I prefer to drop this for now if that is OK with you.

-- 
Regards,
Sudeep
