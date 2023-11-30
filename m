Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2887FFC58
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376673AbjK3URd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbjK3URT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:17:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 381591BC6;
        Thu, 30 Nov 2023 12:16:59 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB9321042;
        Thu, 30 Nov 2023 12:17:45 -0800 (PST)
Received: from bogus (unknown [10.57.42.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9D1F3F73F;
        Thu, 30 Nov 2023 12:16:56 -0800 (PST)
Date:   Thu, 30 Nov 2023 20:14:54 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sibi Sankar <quic_sibis@quicinc.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_mdtipton@quicinc.com, linux-arm-kernel@lists.infradead.org,
        quic_asartor@quicinc.com, quic_lingutla@quicinc.com
Subject: Re: [PATCH 2/3] firmware: arm_scmi: Fix freq/power truncation in the
 perf protocol
Message-ID: <20231130201454.jhh72rmrf6bumw2x@bogus>
References: <20231129065748.19871-1-quic_sibis@quicinc.com>
 <20231129065748.19871-3-quic_sibis@quicinc.com>
 <ZWh6cuApg-sRbA2s@bogus>
 <ZWiE5nM83TZd3drT@pluto>
 <ZWiUqGJ8FaA1GBjm@bogus>
 <ZWi3iN3HDc92eMFO@pluto>
 <c8e1adbf-a63e-5a6f-9b4a-e68a2af67779@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8e1adbf-a63e-5a6f-9b4a-e68a2af67779@quicinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 01:02:25AM +0530, Sibi Sankar wrote:
>
> On 11/30/23 21:55, Cristian Marussi wrote:
> >
> > Ah right
> >
> >     freq *= dom->multi_fact;
> >
> > does the trick..but cannot this by itself (under unplausibl conds)
> > overflow and does not fit into a u32 mult_factor ?
> >
> >   dom_info->mult_factor =
> >   	(dom_info->sustained_freq_khz * 1000UL)
>
> wouldn't having the 1000UL ensure that we don't truncate though?

Correct but the point was mult_factor itself can be >= 2^32

> Anyway will drop the patch when I re-spin the series.
>

Are you re-spining just to change 24 to 32 in PATCH 3/3, if so no need.
I have already applied 1 and 3 here[1]. Just waiting for the builder
results to confirm it

--
Regards,
Sudeep

[1] https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi/updates
