Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3F77ECB3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 00:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346731AbjHPWCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 18:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346702AbjHPWCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 18:02:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC810F2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 15:01:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63DAA61BB6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 22:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DCEC433C8;
        Wed, 16 Aug 2023 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692223318;
        bh=UUEYl5HxoSScFuWiDblQhxwz1ZMb/pQYtbWQP+cA2eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mzhhZBrdLkDYrFA8xJ72K20M7OC88H5TSa9hS2L0i5T6JJ0YIpbHlA0McRhYXzWn2
         8bDPQskKDcGnOwlpmAPrwmug7W2uRytVo3pM9VxGHL0LDzbfsfPI4iJxBSxnccOSh3
         CX1ZVXE6QR5x7LuNCfsd4fG54FtffTe/gNTqoY36ZRmc1uf5ROun6UvI15n+Te0TDC
         PJdqX1NfQRO9ZkoJR69B+GLh+KdUQnBfnpNCYxevZvO9yZ67HFBtj6C+qdhqGtPet3
         TTCG+Q24+sK5cUxckv0TMYlbGgWiMPoMx9gfKGH/mcNDVHi91n+jyLfAu/xvvK4wn9
         06+DaUJ0Ikw4Q==
Date:   Wed, 16 Aug 2023 15:01:56 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Keguang Zhang <keguang.zhang@gmail.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: ld.lld: error: version script assignment of 'LINUX_2.6' to
 symbol '__vdso_gettimeofday' failed: symbol not defined
Message-ID: <20230816220156.GA1408221@dev-arch.thelio-3990X>
References: <202308170532.zxFFv25c-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308170532.zxFFv25c-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:15:55AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4853c74bd7ab7fdb83f319bd9ace8a08c031e9b6
> commit: e738521a11f13e40af89f66527e59306c4169782 clocksource/drivers/loongson1: Move PWM timer to clocksource framework
> date:   8 weeks ago
> config: mips-randconfig-r012-20230817 (https://download.01.org/0day-ci/archive/20230817/202308170532.zxFFv25c-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170532.zxFFv25c-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308170532.zxFFv25c-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: version script assignment of 'LINUX_2.6' to symbol '__vdso_gettimeofday' failed: symbol not defined

I fail to see why the robot landed on this change as the cause of this
error but regardless, I have sent a patch to clear it up:

https://lore.kernel.org/20230816-mips-vdso-cond-export-__vdso_gettimeofday-v1-1-fe725254c782@kernel.org/

Cheers,
Nathan
