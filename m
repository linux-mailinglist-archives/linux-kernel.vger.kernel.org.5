Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEF8752797
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235029AbjGMPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235026AbjGMPn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:43:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7431F2720
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 08:43:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B825261A05
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:43:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FC8C433C8;
        Thu, 13 Jul 2023 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689263030;
        bh=WoO+SG/dUwwvMX27Y4x9aJnZRBcKpyZjFBV5u+zOEzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJ8gtfJzRfo5NZDbAW7cOLe0g7iNZJQH6z5hJOboZDMnyzimClsd+tpF7C6l2qmKb
         VxZY+KTFpo7KQmXldMzon4NBvR/HJfllSsNb39j0Bvk0iCTSvPqo6DP0j2jYAdf3tR
         yLXalcfTZ/8+zKcenREVq3b7xO0VctCP4XnvGWq4OW95X7vKLpvbkK8DkdykDRdmK6
         2Un+0SIRijxNHNKzBXDbMA2YVOC/GxjTbTLE+2yXtFDsq0VwGCnLA//d6ceAM/YTI5
         NP5WTe9HvOcRKsQLKrNNF0OHTVlr3i2/lXDy6EylT+9DT95YKv9UUDIMvmJOVK2meF
         jlP6qnqcixOXA==
Date:   Thu, 13 Jul 2023 16:43:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: wcd934x: Update to use maple tree register cache
Message-ID: <20230713154346.GG968624@google.com>
References: <20230712-mfd-wcd934x-maple-v1-1-0d7aba4b0077@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712-mfd-wcd934x-maple-v1-1-0d7aba4b0077@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023, Mark Brown wrote:

> The maple tree register cache is based on a much more modern data structure
> than the rbtree cache and makes optimisation choices which are probably
> more appropriate for modern systems than those made by the rbtree cache. In
> v6.5 it has also acquired the ability to generate multi-register writes in
> sync operations, bringing performance up to parity with the rbtree cache
> there.
> 
> Update the wcd934x to use the more modern data structure.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> 
> Signed-off-by: Mark

Something going on with your helpers?

> ---
>  drivers/mfd/wcd934x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
