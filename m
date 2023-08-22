Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC5F7848C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjHVRwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjHVRwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:52:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C922B173F;
        Tue, 22 Aug 2023 10:52:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C1CE6527E;
        Tue, 22 Aug 2023 17:52:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F70C433C7;
        Tue, 22 Aug 2023 17:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692726762;
        bh=uhhr78tPqKkbVdc+z8OkwhftYf4Z18DNBs/6Goiz8tM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jFXBY9GFsiE62u3KTT0RqGOjx26MhwnWoKpYeSpBdCIy/39/svRzLPt0URnio+1g4
         TRUDd44tQd1dppPrHVnYl6a6R492bhVZzwM7Gqze5URiFwq/UEB/pxkkpUK6+X4k+A
         Wn5JpVNiItAMsdojU7DyWELEyEyPXMgr8nhTAFKtKTcCdjD3FVp4z7uDXKlYkadu1U
         CL0bNEeOaYApJgWkUJR4vxxosu8t/7HnCHx1xK43i82Px6lloY8ZHMWySg+KEi6VEi
         3NmLCmgF3ElOTmcxphx9Hv29HXmykoFSGEM66LQcUnoaFrKd6hf1Gfp4FLP692ILf9
         dMCcG8MDkHBCg==
Received: (nullmailer pid 434239 invoked by uid 1000);
        Tue, 22 Aug 2023 17:52:40 -0000
Date:   Tue, 22 Aug 2023 12:52:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kernel test robot <lkp@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Move of_skipped_node_table within #ifdef
 CONFIG_OF_ADDRESS
Message-ID: <169272675882.434161.14523907768877263863.robh@kernel.org>
References: <73dea4f4b389359a8beadbc77b00eb26853f9ab5.1692691032.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73dea4f4b389359a8beadbc77b00eb26853f9ab5.1692691032.git.viresh.kumar@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Aug 2023 13:27:22 +0530, Viresh Kumar wrote:
> The `struct of_skipped_node_table` is used only when CONFIG_OF_ADDRESS
> is defined, move it within the #ifdef/#endif to avoid warnings on
> configurations where CONFIG_OF_ADDRESS isn't defined.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308212037.YopffWSU-lkp@intel.com/
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/of/platform.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Applied, thanks!

