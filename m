Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B4B7530B6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbjGNEuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjGNEuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:50:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6242D5F;
        Thu, 13 Jul 2023 21:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9388A616D1;
        Fri, 14 Jul 2023 04:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E998CC433C7;
        Fri, 14 Jul 2023 04:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689310249;
        bh=EcQVGwWcJPMYxthhMryajaVCcmz6AHwCcf1NupuDKag=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=PqKLZx74vek/k7fNDzHgHyawsDb7rqGJEP79fRXcwxTZBz68d8p5lzJNzHDVe8wKT
         Gg7/Fl2pGNt/+zOppdhDpNO6uSRwKUVCxApEKODxem54Ym9KFTQyM7BWBcqW1G+huK
         TX0C3Q5GEkEq1+zOgnGJv46D7fiUrXQ0uLbBvIj8XYX7PZ8Lne4m+NrgY3Q4kdd7LE
         sSNIm50wnH8GieelBGg/tC4cAQD03tA6BMxdyWEcdqESmKJ9pdDaXcdvifHrGPh26k
         AiVdOqiuINwuS2ylsZR8/LcsrQihKmZ7UxwaLMoC33bj7UMjYvcVe4lpxtkYYrtrHa
         QQPrkgVWH2SaQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7C613CE009E; Thu, 13 Jul 2023 21:50:43 -0700 (PDT)
Date:   Thu, 13 Jul 2023 21:50:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the rcu tree
Message-ID: <6f655ef5-b236-4683-92b0-da8b19e79eca@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230714144330.3c0a4074@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714144330.3c0a4074@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:43:30PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in net-next tree as a different commit
> (but the same patch):
> 
>   a2b38823280d ("rcu: Export rcu_request_urgent_qs_task()")
> 
> This is commit
> 
>   43a89baecfe2 ("rcu: Export rcu_request_urgent_qs_task()")
> 
> in the net-next tree.

The net-next tree needs it for BPF, correct?  So if you guys intend to
push it to mainline, I will be happy to drop if from -rcu.

Either way, please let me know!

							Thanx, Paul
