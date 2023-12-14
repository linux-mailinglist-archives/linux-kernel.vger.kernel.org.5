Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BB3813A06
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjLNSeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNSeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:34:00 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D74CF;
        Thu, 14 Dec 2023 10:34:04 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BEIXumW081352;
        Thu, 14 Dec 2023 12:33:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702578836;
        bh=gh6wsVmxg2mdw23YLINnnRtb54FDmZeh9eGm3PU2HB8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YNRAxn6N8nGXxxOZzwgnuKtKiw2T6hSJ14VYlNlUpn73iGLpOcfmsCfx2d2ucouKd
         h+rLRG0rAqYezA4BzQ3qd8t6ET4xMQtwCnrbj3hiJziU1GSZ1D6Aj8vRDDtq4f6Wb+
         w4dzAA/6pWnEr/jLBzrFHSb8pjbl1DHhM/Ru+Xbc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BEIXuYT020753
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Dec 2023 12:33:56 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 14
 Dec 2023 12:33:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 14 Dec 2023 12:33:56 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BEIXuDU063957;
        Thu, 14 Dec 2023 12:33:56 -0600
Date:   Thu, 14 Dec 2023 12:33:56 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Andrew Davis <afd@ti.com>
CC:     Vaishnav Achath <vaishnav.a@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 2/3] arm64: dts: ti: Introduce J722S family of SoCs
Message-ID: <20231214183356.hi5d6cuqmqltiy6i@footnote>
References: <20231213124930.3012-1-vaishnav.a@ti.com>
 <20231213124930.3012-3-vaishnav.a@ti.com>
 <20231213202705.6tspycl5qicb6gwd@germproof>
 <08eccba2-41df-91e7-c1e5-e03190402c23@ti.com>
 <20231214122713.qx7as6grpvlq3ylw@stoic>
 <f2bc6c68-742a-4a21-956e-91ee0933dd96@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f2bc6c68-742a-4a21-956e-91ee0933dd96@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:43-20231214, Andrew Davis wrote:
> On 12/14/23 6:27 AM, Nishanth Menon wrote:
> > On 14:07-20231214, Vaishnav Achath wrote:
> > [..]
> > > > Trim this down to what is different from AM62P?
> > > > 
> > > 
> > > Thanks for the review, I will trim this down in next revision, but the above is
> > > just a summary of the main features of this SoC, pointing to AM62P feature set
> > > here seems confusing to me. why does a new user/developer using J722S need to be
> > > aware of the existence of AM62P to just understand a high level summary about
> > > this device?
> > 
> > Since this is a reuse device. Helps with review and focus on deltas.
> > 
> > [...]
> > 
> > > > > +	l2_0: l2-cache0 {
> > > > > +		compatible = "cache";
> > > > > +		cache-unified;
> > > > > +		cache-level = <2>;
> > > > > +		cache-size = <0x80000>;
> > > > > +		cache-line-size = <64>;
> > > > > +		cache-sets = <512>;
> > > > > +	};
> > > > 
> > > > ^^ this is a duplication of am62p5.dtsi? what about the spins with
> > > > different CPUs enabled?
> > > > 
> > > 
> > > Yes it is a duplicate, as of now we are not aware of plan for spins with cores
> > > disabled, so just followed the pattern followed for other Jacinto devices
> > > (J721e, J7200, J721s2, J784s4).
> > 
> > None of the devices have been as close a reuse device as this has been.
> 
> I'd argue J721e and J7200 are more similar in terms of reuse. It was a
> mistake to model them as simple super/subsets of each other, only causes
> confusion later. Let's keep at least this top level file, we will end up
> using it more as more features/deltas are enabled/found.
> 

yes, we do need a top level dtsi for the SoC. just minimize the amount
of duplication.

[...]
> > > 
> > > [    7.492406] platform 79000000.r5f: configured R5F for remoteproc mode
> > > [    7.499887] platform 79000000.r5f: device does not have reserved memory
> > > regions, ret = -22
> > > [    7.508271] k3_r5_rproc bus@f0000:bus@4000000:r5fss@79000000: reserved memory
> > > init failed, ret = -22
> > > [    7.517549] remoteproc remoteproc0: releasing 79000000.r5f
> > > [    7.523338] k3_r5_rproc bus@f0000:bus@4000000:r5fss@79000000:
> > > k3_r5_cluster_rproc_init failed, ret = -22
> > > [    7.532993] k3_r5_rproc: probe of bus@f0000:bus@4000000:r5fss@79000000 failed
> > > with error -22
> > 
> > Yes, and the approach should rather be to disable the remote procs in
> > the board or at the SoC dtsi in a consistent manner. I had previously
> > suggested to do that SoC level (which means at am62p dtsi) since the remoteprocs have direct
> > dependency on how the memory layouts are partitioned in board.dts - but
> > i had asked folks working on remote procs to do that consistently across
> > SoCs. I don't see that having been done so far.
> > 
> 
> I fixed this for a couple SoCs way back last year (7e48b665100ee), seems
> folks kept adding mailboxes/rprocs un-disabled in the base .dtbi for
> new SoCs anyway :( This needs fixed in AM62p .dtsi first, then these
> disables can be removed from here.
> 

Yes, hence blocking it from here on. Cleanup, then add.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
