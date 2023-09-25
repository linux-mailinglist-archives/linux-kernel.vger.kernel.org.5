Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBC57AD4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjIYJj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIYJj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:39:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83F9A9C;
        Mon, 25 Sep 2023 02:39:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71DDCDA7;
        Mon, 25 Sep 2023 02:40:27 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BC4FE3F5A1;
        Mon, 25 Sep 2023 02:39:47 -0700 (PDT)
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
Subject: Re: [PATCH v3 00/13] arm_scmi/cpufreq: Add generic performance scaling support
Date:   Mon, 25 Sep 2023 10:39:45 +0100
Message-ID: <169563470105.3833803.2257916927365455980.b4-ty@arm.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
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

On Fri, 25 Aug 2023 13:26:20 +0200, Ulf Hansson wrote:
> Changes in v3:
> 	- Re-based upon the for-next/scmi/updates branch.
> 	- Re-ordered some of the patches in the series, to eas review.
> 	- Added some new DT doc patches in the series, according to comments.
> 	- Fixed other comments, see version history for each patch.
> 
> Changes in v2:
> 	- Split up the series, to get the basic support in place as the first
> 	step. The part that remains is the integration with the OPP library, to
> 	allow consumer drivers to change performance level using the OPP lib.
> 	- Re-based on top v6.5-rc1.
> 	- Other changes will be described for each patch.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[01/13] firmware: arm_scmi: Extend perf protocol ops to get number of domains
        https://git.kernel.org/sudeep.holla/c/e9090e70e618
[02/13] firmware: arm_scmi: Extend perf protocol ops to get information of a domain
        https://git.kernel.org/sudeep.holla/c/3d99ed60721b
[03/13] cpufreq: scmi: Prepare to move OF parsing of domain-id to cpufreq
        https://git.kernel.org/sudeep.holla/c/e336baa4193e
[04/13] firmware: arm_scmi: Align perf ops to use domain-id as in-parameter
        https://git.kernel.org/sudeep.holla/c/39dfa5b9e1f0
[05/13] firmware: arm_scmi: Drop redundant ->device_domain_id() from perf ops
        https://git.kernel.org/sudeep.holla/c/9b578d83629e
[06/13] cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
        https://git.kernel.org/sudeep.holla/c/4f1f0bc8ed16
[08/13] dt-bindings: arm: cpus: Add a power-domain-name for a performance-domain
        https://git.kernel.org/sudeep.holla/c/6e429adc60b1
[09/13] dt-bindings: firmware: arm,scmi: Extend bindings for protocol@13
        https://git.kernel.org/sudeep.holla/c/e11c480b6df1
[10/13] dt-bindings: power: Clarify performance capabilities of power-domains
        https://git.kernel.org/sudeep.holla/c/0ead1f3e158c
[11/13] cpufreq: scmi: Add support to parse domain-id using #power-domain-cells
        https://git.kernel.org/sudeep.holla/c/92b2028b00ff
[12/13] PM: domains: Allow genpd providers to manage OPP tables directly by its FW
        https://git.kernel.org/sudeep.holla/c/3dd91515ef43

--
Regards,
Sudeep

