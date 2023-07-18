Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C44758585
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 21:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjGRT0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 15:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGRT0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 15:26:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC201992;
        Tue, 18 Jul 2023 12:26:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CF78616E1;
        Tue, 18 Jul 2023 19:26:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63CAC433C7;
        Tue, 18 Jul 2023 19:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689708400;
        bh=4L+ddEAbeJgqxtXEa7jtsoqEIjOZNcXsmm10kARcsx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvxSW1oaaZkNnjh5vGJ6g/g5O048ARht2f2qjXlBvH3g3D/LIGXFmb/a3/Tv9GeBA
         dryIkVAp/fybjL79uvuN5shCyiTPLhT2sMf2g0SV/2jeL31BfD2NQDW0J5oKKYX2Ef
         bPofI77x55YjH3ZvdoiyHSwX0SOpvnms98wGyq4Kp+LvXmp3Yk+TkZkO6pa+XdzGIT
         FRgVxdQ6y4brcg1jsyxbAQ8vygpKFyCBfX4StdTBjOwHb4dvVW+IXhEwQmThzt7038
         i8M+qGpwH7xOFqdiNB8QgUeB1J7g3GgxrNozvXsscXy4UMlE6AZmmEL2BpyTTthDBJ
         BE8CrlFpWTT/w==
Date:   Tue, 18 Jul 2023 12:30:04 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] firmware: arm_scmi: Add qcom hvc/shmem transport
Message-ID: <rum7gnnouoz2irn57taxn4j2aajkxf6em6ft6u4w3rxwsym2su@acgczsnl2huz>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230718160833.36397-3-quic_nkela@quicinc.com>
 <xkw36iwjb47q7spf6qle5x3kcmx6fv7or6cwhlpkuvihn3xmt2@qhrhtug4htp2>
 <5c76250b-4415-950e-6aab-7ccbdc6ca83a@quicinc.com>
 <6uelwa7fpzbw757rbb2j3u4ogagypdzyqj5mykyhlkkkvrnfin@ttonjpfn7nxc>
 <d2d01794-ef13-07f9-7695-b56b58cc01ac@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2d01794-ef13-07f9-7695-b56b58cc01ac@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 12:10:16PM -0700, Nikunj Kela wrote:
> 
> On 7/18/2023 12:07 PM, Bjorn Andersson wrote:
> > On Tue, Jul 18, 2023 at 11:53:24AM -0700, Nikunj Kela wrote:
> > > On 7/18/2023 11:29 AM, Bjorn Andersson wrote:
> > > > On Tue, Jul 18, 2023 at 09:08:33AM -0700, Nikunj Kela wrote:
> > > > > diff --git a/drivers/firmware/arm_scmi/qcom_hvc.c b/drivers/firmware/arm_scmi/qcom_hvc.c
> > [..]
[..]
> > > > > +#ifdef CONFIG_ARM64
> > > > > +	cap_id = readq((void *)(scmi_info->shmem) + size +
> > > > > +		       sizeof(unsigned long));
> > > > > +#else
> > > > > +	cap_id = readl((void *)(scmi_info->shmem) + size +
> > > > > +		       sizeof(unsigned long));
> > > > > +#endif
> > > > Please don't make the in-memory representation depend on architecture
> > > > specific data types. Quite likely you didn't compile test one of these
> > > > variants?
> > > > 
> > > > Just define the in-memory representation as u32 + u64.
> > > I tested this for ARM64, I didn't test it for 32bit since Hypervisor doesn't
> > > support it currently. In future, it may add 32 bit support too.
> > I'd not be surprised if the capability id is 64 bit on a 32-bit machine
> > as well, it's not really a property of the architecture.
> 
> on 32bit machine, you will have to use SMC32 convention. lt will mean that
> the parameters can only be 32 bit long. If you keep cap-id 64 bit in 32bit
> machines, then it has to be passed in two parameters. Are you suggesting, I
> make this driver dependent on ARM64 and only care about 64 bit for now?
> 

I'm suggesting that the calling convention is one thing and the
in-memory format for passing the information to the driver is a
different thing.

Keep the arguments passed in memory architecture-independent (i.e. make
it u64).

If you're saying that the calling convention would be different on a
32-bit system, then you are also saying that your driver _is_ 64-bit
specific. Please confirm what the size of your capability id would be in
such a system and make sure the Kconfig and/or the code, reflects
reality.

Thanks,
Bjorn
