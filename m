Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA497827FF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbjHULdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjHULdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C408CDC;
        Mon, 21 Aug 2023 04:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CBB662F98;
        Mon, 21 Aug 2023 11:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD8AC433C8;
        Mon, 21 Aug 2023 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692617630;
        bh=9IvYOXT3Btszbaw0LWtcma1uuQppU1Uqs8OBdZboXHg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r8M1a0Z+MmNDBTOjBqbojBJouYk1IDipXklfq5yHGL0OTbn+n+G738louxVYPoqaU
         G2ztScGeht7rrkgBGd1UXt0VKHDkFmkei1YJJt4AK8Fl1s/KXr3NfXA1m/VScjDJi5
         9aBB/MqKu66atHXMlXRLcfk/OgHhWwcSkCR6boZS0ccIIVdgyD41rkJHEMMfpamlu3
         6/Am7cLin3Zx+mFQbVK0UNIwGAFSQVmGdetJSrp5d3wONr0jQT24+9SaHt+zUS4eos
         Z7Q2Tw65hfE0PGHXw8Wju1KGifwp+MUhP3pce+0rryQLi70Gtu3Lc45E5MFMJj9CuP
         FhduKLddES1BQ==
Date:   Mon, 21 Aug 2023 12:33:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: linux-next: manual merge of the coresight tree with the
 arm-perf, arm64 trees
Message-ID: <20230821113345.GD19469@willie-the-truck>
References: <20230821144030.52ab1357@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821144030.52ab1357@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Aug 21, 2023 at 02:40:30PM +1000, Stephen Rothwell wrote:
> Today's linux-next merge of the coresight tree got a conflict in:
> 
>   drivers/hwtracing/coresight/coresight-trbe.c
> 
> between commit:
> 
>   e926b8e9eb40 ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
> 
> from the arm-perf, arm64 trees and commit:
> 
>   39744738a67d ("coresight: trbe: Allocate platform data per device")
> 
> from the coresight tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc drivers/hwtracing/coresight/coresight-trbe.c
> index 9c59e2652b20,e20c1c6acc73..000000000000
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@@ -1244,6 -1254,10 +1254,21 @@@ static void arm_trbe_register_coresight
>   	if (!desc.name)
>   		goto cpu_clear;
>   
>  -	desc.pdata = coresight_get_platform_data(dev);
> ++	/*
> ++	 * TRBE coresight devices do not need regular connections
> ++	 * information, as the paths get built between all percpu
> ++	 * source and their respective percpu sink devices. Though
> ++	 * coresight_register() expect device connections via the
> ++	 * platform_data, which TRBE devices do not have. As they
> ++	 * are not real ACPI devices, coresight_get_platform_data()
> ++	 * ends up failing. Instead let's allocate a dummy zeroed
> ++	 * coresight_platform_data structure and assign that back
> ++	 * into the device for that purpose.
> ++	 */
> ++	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
> + 	if (IS_ERR(desc.pdata))
> + 		goto cpu_clear;

Although this is what I would've done too, I think there's a deeper
question as to whether the per-device pdata allocation is even needed [1].
So I'll drop the coresight/ changes from my tree(s) while this is worked
out.

Cheers,

Will

[1] https://lore.kernel.org/lkml/20230821112851.GC19469@willie-the-truck/T/#mc78e19ae31612a6b5947b83180ca64fd223c351e
