Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD08577BD64
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjHNPrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjHNPre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:47:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F3210E3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:47:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08EA6634DE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:47:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AA0C433C7;
        Mon, 14 Aug 2023 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692028052;
        bh=t1R8otRM3E6EZ1Itt7NVpdWmmwTSamBHRUIDFtKrf0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q/ndevMRJb5n5ncJkJ3CYnQYNdkZV0xZH25Y/IgZp7pjuX9n8HoAGDXd76z9630mC
         uAYYgjI8Eiwzx48ahKOAc1kGVfLcLQPBDUz11ZkPEIrnIVRuaYk9S28lA3/NIBaayn
         R0sbNwHn2V5H/zFmRe8gMiMqeY5Uu89wbSM9Vl5cgsErf2Xg4zylY4zS6nP/JOk3/f
         ciVqZp+KUbnJ5pVVyk1cEZUmxRq+z+1ShDl46yOsW9HRQa8FqFbk9C3BOk87+8WNP1
         mAfwj1+ZvWWZIpUaHe02+FKGB0J0oANBaHDrtFV5jlkjq/H83j+SzrSLI02pdtUYKg
         8PCWesEzXvi1Q==
Date:   Mon, 14 Aug 2023 08:47:30 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Xu <peterx@redhat.com>, lkp@intel.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: Cannot find symbol for section 69: .text.arch_max_swapfile_size.
Message-ID: <20230814154730.GA3072@dev-arch.thelio-3990X>
References: <202308120906.Efohswpa-lkp@intel.com>
 <ZNpKaiweCbf9i5QS@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNpKaiweCbf9i5QS@x1n>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:38:18AM -0400, Peter Xu wrote:
> On Sat, Aug 12, 2023 at 09:11:33AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   190bf7b14b0cf3df19c059061be032bd8994a597
> > commit: be45a4902c7caa717fee6b2f671e59b396ed395c mm/swap: cache maximum swapfile size when init swap
> > date:   11 months ago
> > config: mips-randconfig-r014-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120906.Efohswpa-lkp@intel.com/config)
> > compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> > reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120906.Efohswpa-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202308120906.Efohswpa-lkp@intel.com/
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> Cannot find symbol for section 69: .text.arch_max_swapfile_size.
> >    mm/swapfile.o: failed
> 
> Hmm.. I don't really know what's the issue here, neither can I reproduce
> this locally - the cross build seems to all work with the reproducer and I
> can see mm/swapfile.o correctly generated.

This is https://github.com/ClangBuiltLinux/linux/issues/1830 and
https://github.com/ClangBuiltLinux/linux/issues/981, which is a bug in
recordmcount with regards to section symbols that occurs when building
with clang's integrated assembler. It happens when the there are only
weak symbols in a .text section, which occurs more often with MIPS due
to LD_DEAD_CODE_DATA_ELIMINATION implying -ffunction-sections (i.e., any
__weak symbol will trigger this) and I can see this randconfig setting
it.

Unfortunately, the robot seems to have tripped over this a lot over the
weekend :/ Intel folks, can this type of warning please be added to your
filter for at least MIPS + LD_DEAD_CODE_DATA_ELIMINATION so that people
don't get bothered?

https://lore.kernel.org/202308121810.APAJIBxn-lkp@intel.com/
https://lore.kernel.org/202308121535.otQuZept-lkp@intel.com/
https://lore.kernel.org/202308121810.APAJIBxn-lkp@intel.com/
https://lore.kernel.org/202308121246.0TYkHC1K-lkp@intel.com/
https://lore.kernel.org/202308120553.IRzzfaXL-lkp@intel.com/
https://lore.kernel.org/202308111956.QRc8XJVr-lkp@intel.com/

Cheers,
Nathan
