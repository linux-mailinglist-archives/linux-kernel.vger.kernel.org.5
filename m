Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFF77AD4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjIYJlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIYJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:41:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB3CC10F;
        Mon, 25 Sep 2023 02:41:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68406DA7;
        Mon, 25 Sep 2023 02:41:50 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A952C3F5A1;
        Mon, 25 Sep 2023 02:41:10 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/13] pmdomain: arm: Add the SCMI performance domain
Date:   Mon, 25 Sep 2023 10:41:07 +0100
Message-ID: <169563463048.3833401.860707683474729214.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919121605.7304-1-ulf.hansson@linaro.org>
References: <20230919121605.7304-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 14:16:05 +0200, Ulf Hansson wrote:
> To enable support for performance scaling (DVFS) for generic devices with
> the SCMI performance protocol, let's add an SCMI performance domain. This
> is being modelled as a genpd provider, with support for performance scaling
> through genpd's ->set_performance_state() callback.
> 
> Note that, this adds the initial support that allows consumer drivers for
> attached devices, to vote for a new performance state via calling the
> dev_pm_genpd_set_performance_state(). However, this should be avoided as
> it's in most cases preferred to use the OPP library to vote for a new OPP
> instead. The support using the OPP library isn't part of this change, but
> needs to be implemented from subsequent changes.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[13/13] pmdomain: arm: Add the SCMI performance domain
        https://git.kernel.org/sudeep.holla/c/2af23ceb8624
--
Regards,
Sudeep

