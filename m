Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437F9779D32
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 07:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjHLFFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 01:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjHLFFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 01:05:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B61C2722
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 22:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=c2iuoYe0ChXvkvyXb5E3lU4SlO0MOHp/8fYvbvUgDG4=; b=S5Wir3l12FZ9CAQbd4yMmJnnKE
        wl6b1gWXRnEdUiMH+PIQ34g4SxkWSnG4AJurZLgzZZHBMKQjUwSQIqRV4fecooxi5fUrIzWoTDwqy
        6BHgc3+Ne6ggScD6m23fwIo9h5ZPLWdvEbbaf2ASqPB0CTVLSO4P8+k5aowoh8mkREtckDOHyOtYX
        hSqxXVWKQ8D5tD8oGa6LmZgHoTztyt3uQDYaPE50K9CpVmRodvT5cMRKUK3IyrSQM5M2e3xLBUOHF
        ivvtdd7oaFU/wstaJ4iW2g07ZsLa9PFPo1SoJPOBUBO3qpZCEicrXnHPBZiLOSDsAALXUbvbNLlYY
        pZEJ75zw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qUgk7-00Cf4q-12;
        Sat, 12 Aug 2023 05:00:51 +0000
Message-ID: <6f04c64a-48d5-a7b5-f3ec-89f8b3db030b@infradead.org>
Date:   Fri, 11 Aug 2023 22:00:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: hostaudio_kern.c:undefined reference to `unregister_sound_mixer'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
References: <202308121029.peTEFwvG-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202308121029.peTEFwvG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi robot,

On 8/11/23 20:05, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   190bf7b14b0cf3df19c059061be032bd8994a597
> commit: 0bbadafdc49d11a1836e5946f517d18cceaea6c8 um: allow disabling NO_IOMEM
> date:   2 years, 2 months ago
> config: um-randconfig-r025-20230812 (https://download.01.org/0day-ci/archive/20230812/202308121029.peTEFwvG-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20230812/202308121029.peTEFwvG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202308121029.peTEFwvG-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    ld: warning: net/bpfilter/bpfilter_umh_blob.o: missing .note.GNU-stack section implies executable stack
>    ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>    /usr/bin/ld: warning: net/bpfilter/bpfilter_umh_blob.o: missing .note.GNU-stack section implies executable stack
>    /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>    /usr/bin/ld: warning: .tmp_vmlinux.kallsyms1 has a LOAD segment with RWX permissions
>    /usr/bin/ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_cleanup_module':
>>> hostaudio_kern.c:(.exit.text+0x1c): undefined reference to `unregister_sound_mixer'
>>> /usr/bin/ld: hostaudio_kern.c:(.exit.text+0x2b): undefined reference to `unregister_sound_dsp'
>    /usr/bin/ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_init_module':
>>> hostaudio_kern.c:(.init.text+0xb1): undefined reference to `register_sound_dsp'
>>> /usr/bin/ld: hostaudio_kern.c:(.init.text+0x11f): undefined reference to `register_sound_mixer'
>>> /usr/bin/ld: hostaudio_kern.c:(.init.text+0x186): undefined reference to `unregister_sound_dsp'
>    collect2: error: ld returned 1 exit status
> 
> Kconfig warnings: (for reference only)
>    WARNING: unmet direct dependencies detected for LOCKDEP
>    Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y] && (FRAME_POINTER [=n] || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
>    Selected by [y]:
>    - DEBUG_LOCK_ALLOC [=y] && DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=y]
> 

Fix for this was sent on 2023 Aug 01:
  https://lore.kernel.org/all/20230802051500.13271-1-rdunlap@infradead.org/


-- 
~Randy
