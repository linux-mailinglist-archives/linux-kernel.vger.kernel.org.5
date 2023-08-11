Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629C0779360
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236009AbjHKPly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235983AbjHKPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115E82712
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D14365F0B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A79CC433CD;
        Fri, 11 Aug 2023 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691768504;
        bh=2qhfenVezoKkqMAFTTrxuE/5s2D48IKGWRzFGDyIrm8=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bOxnrufrd0m+KM4fEhHDtsntagCkMfFZJKComu4GKKRQP43N4PTHfidnH+gZ5Wt6y
         KaFuksv5Ty2TCcoM83899bmqZabg3/cGRHfRXCwMAYEkwxiFfYWooguWjr8xUrfum3
         bOWKqLJ8cqCs8TcN9KTREhFq6hPJB725yZlN4cYqPfg4YS7Xd5aYaIhsOjE+oW704x
         gCxUKL/MJhowsm/v68E9q0amBNVfskUxFxDe75fxGs6++vNYB2GvDWzcdir72Joytx
         fw4eKMBt/YD3sYAz8v37PdcaxZpM41dnmzNWMHp/5xY1uhGlAbjNUTETlHQdjD7g5m
         nh+JwCpLn7HnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A5A02CE0593; Fri, 11 Aug 2023 08:41:43 -0700 (PDT)
Date:   Fri, 11 Aug 2023 08:41:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: {standard input}:1727: Error: operand out of range (-132 is not
 between -128 and 127)
Message-ID: <416679c9-96b3-4114-bba3-473e647c4c2d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202308111233.rbf5C0JD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308111233.rbf5C0JD-lkp@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 01:02:12PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   25aa0bebba72b318e71fe205bfd1236550cc9534
> commit: a6889becb05394255c80b62103677e3b095726a9 refscale: Add tests using SLAB_TYPESAFE_BY_RCU
> date:   7 months ago
> config: arc-randconfig-r006-20230811 (https://download.01.org/0day-ci/archive/20230811/202308111233.rbf5C0JD-lkp@intel.com/config)
> compiler: arceb-elf-gcc (GCC) 12.3.0
> reproduce: (https://download.01.org/0day-ci/archive/20230811/202308111233.rbf5C0JD-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308111233.rbf5C0JD-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    {standard input}: Assembler messages:
> >> {standard input}:1727: Error: operand out of range (-132 is not between -128 and 127)

I am not seeing any inline assembly in that patch, so I have to suspect
a bug in arch code or the compiler backend for arc.

Or is there something that I am missing here?

							Thanx, Paul
