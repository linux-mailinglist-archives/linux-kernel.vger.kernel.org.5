Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C88780FDA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378431AbjHRQGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378363AbjHRQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC24E42;
        Fri, 18 Aug 2023 09:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 048E161E1E;
        Fri, 18 Aug 2023 16:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF042C433CD;
        Fri, 18 Aug 2023 16:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692374781;
        bh=0SQjjJQckXirGa7ysbQ98/Hd2KbW8FsPEysht4DJ/jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bxSGqpjjfKgelks8ldEDDmfNJ3lyQl9mVYlM/cR234YGlxcXror1INI9q3KUrZ//+
         aid32/046lVrF+m+TBWYJC2hyGMqMLAgAhTtTG6m3Bk6VAJs25jPJE6f13K258YhLp
         U3mn5sJ7+GpVAxuW3cgF4kFKjSOiH6SQN8HvEXy0kEgRQOwtIi4fA8P2FJ8DJv9Jet
         ohar580H491oWblRXNavfs/9McQ9Gb9djmTGA+UkZe3czHNiEjygVMNfVDkQlkQwyp
         HLnU93EVNsFnHp546Jfgck3eeBcm71OevNRopq062UeI24uiylFRExHee6PKQzDyjS
         YjZb1iqKaEV8g==
Date:   Fri, 18 Aug 2023 17:06:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     suzuki.poulose@arm.com, robin.murphy@arm.com,
        ilkka@os.amperecomputing.com, catalin.marinas@arm.com,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        treding@nvidia.com, jonathanh@nvidia.com, vsethi@nvidia.com,
        rwiley@nvidia.com, efunsten@nvidia.com
Subject: Re: [PATCH v5] perf: arm_cspmu: Separate Arm and vendor module
Message-ID: <20230818160614.GB16119@willie-the-truck>
References: <20230705104745.52255-1-bwicaksono@nvidia.com>
 <20230818160536.GA16119@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818160536.GA16119@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 05:05:36PM +0100, Will Deacon wrote:
> On Wed, Jul 05, 2023 at 05:47:45AM -0500, Besar Wicaksono wrote:
> > Arm Coresight PMU driver consists of main standard code and
> > vendor backend code. Both are currently built as a single module.
> > This patch adds vendor registration API to separate the two to
> > keep things modular. The main driver requests each known backend
> > module during initialization and defer device binding process.
> > The backend module then registers an init callback to the main
> > driver and continue the device driver binding process.
> > 
> > Signed-off-by: Besar Wicaksono <bwicaksono@nvidia.com>
> > ---
> > 
> > Changes from v4:
> >  * Fix warning reported by kernel test robot
> > v4: https://lore.kernel.org/linux-arm-kernel/20230620041438.32514-1-bwicaksono@nvidia.com/T/#u
> 
> Do you plan to send a v5 addressing Suzuki's comments? This series is
> blocking the Ampere work from Ilkka.

s/v5/v6/ !

Will
