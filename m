Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E2A7BE4BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376757AbjJIPaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346605AbjJIP36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:29:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 285E4A6;
        Mon,  9 Oct 2023 08:29:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A2711FB;
        Mon,  9 Oct 2023 08:30:37 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 407F93F5A1;
        Mon,  9 Oct 2023 08:29:55 -0700 (PDT)
Date:   Mon, 9 Oct 2023 16:29:52 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/2] firmware: arm_scmi: Add qcom smc/hvc transport
 support
Message-ID: <20231009152952.dww3fgh5q7fqysps@bogus>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231006164206.40710-1-quic_nkela@quicinc.com>
 <20231006164206.40710-3-quic_nkela@quicinc.com>
 <20231009144744.yi44ljq4llaxjsb7@bogus>
 <e6d9fbbb-eb61-0736-aa7b-a5e5d1a91db1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d9fbbb-eb61-0736-aa7b-a5e5d1a91db1@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:59:08AM -0700, Nikunj Kela wrote:
> 
> On 10/9/2023 7:47 AM, Sudeep Holla wrote:
> > On Fri, Oct 06, 2023 at 09:42:06AM -0700, Nikunj Kela wrote:
> > > This change adds the support for SCMI message exchange on Qualcomm
> > > virtual platforms.
> > > 
> > > The hypervisor associates an object-id also known as capability-id
> > > with each smc/hvc doorbell object. The capability-id is used to
> > > identify the doorbell from the VM's capability namespace, similar
> > > to a file-descriptor.
> > > 
> > > The hypervisor, in addition to the function-id, expects the capability-id
> > > to be passed in x1 register when SMC/HVC call is invoked.
> > > 
> > > The capability-id is allocated by the hypervisor on bootup and is stored in
> > > the shmem region by the firmware before starting Linux.
> > > 
> > Since you are happy to move to signed value, I assume you are happy to loose
> > upper half of the range values ?
> > 
> > Anyways after Bjorn pointed out inconsistency, I am thinking of moving
> > all the values to unsigned long to work with both 32bit and 64bit.
> > 
> > Does the below delta on top of this patch works for you and makes sense?
> 
> This looks good to me. Will do some testing and float v6 with the changes
> you suggested below. Thanks
> 

Please refer or use the patch from [1] when reposting. I rebased on my
patch[2] that I posted few minutes back. I am trying to finalise the branch
and send PR in next couple of days, so please test and post sooner. Sorry
for the rush.

--
Regards,
Sudeep
[1] https://git.kernel.org/sudeep.holla/h/for-next/scmi/updates
[2] https://lore.kernel.org/r/20231009152049.1428872-1-sudeep.holla@arm.com
