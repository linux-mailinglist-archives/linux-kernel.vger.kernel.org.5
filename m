Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B11755B05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjGQFyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGQFyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:54:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1016CE48
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 22:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CCAB60F2F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 05:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66070C433C8;
        Mon, 17 Jul 2023 05:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689573286;
        bh=yYhsTT28XBUnEe+NxFlVluHfifgm46GUjE65XLytZUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDqDTZ0f3Uwji5llR4koUFtLEeRiTpdGdrpt6ggtcD6n2Ivyy8hzth5HuirOgZ9E1
         z+icHaGn58K5x8f/VUkmX3BEALbgFr+0Jl+5IpuYNRVjP1HJOs+KSsm8LWGG/BMc7b
         Tuxi3TlNGEnOfhhGC8q3KAwG+Oe6vx/z+L5WEqSq/O55HWygvJX6/g+t4NChIkimCt
         TMjJvrMn441E4BgJbEoJd0aO4Gp6kpwxc/0Sb7D0t7LV+xGLX6xOamcJXSRy8j2cx7
         aOq4dcOreNh9240PDzJgZBgx8sXChorZ1A8SdGa4GbAzBo+ydQ50MZtN+0RSytZbn2
         dzFTJ+BMqTrmQ==
Date:   Mon, 17 Jul 2023 08:54:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     hanyu001@208suo.com
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] myri10ge: Prefer unsigned int to bare use of unsigned
Message-ID: <20230717055442.GE9461@unreal>
References: <tencent_3CB61C1D0FF3B148608B138A6CA1C3414B08@qq.com>
 <3854a4d7352831a6ae3732c0ef356f99@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3854a4d7352831a6ae3732c0ef356f99@208suo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 10:39:41AM +0800, hanyu001@208suo.com wrote:
> This patch fixes the checkpatch.pl warning:
> 
> ./drivers/net/ethernet/myricom/myri10ge/myri10ge.c:629: WARNING: Prefer
> 'unsigned int' to bare use of 'unsigned'
> 
> Signed-off-by: maqimei <2433033762@qq.com>
> ---
>  drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for the patch, but unfortunately netdev doesn't take pure cleanup
patches.

Thanks
