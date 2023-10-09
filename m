Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C577BE9BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378174AbjJISjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378087AbjJISjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:39:08 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2CE9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=u7Mt6gxRcunuNffKT3Q+uY/sMVS+mgj8T6rNkHpVN0U=; b=B6a71+pPymETTBBzg4iZ67F34w
        kgjcK8n/1bbbShUR185ZYH2FSKLFBrgnioL4Jnri7uH4aM7wnloORaCBf0oxfRc/1P6dTVXmVyzZ4
        AGp6J7IYUq4LR4ZF/Fc9Haj4kyOmO+6vKwJ9kLJawBeIc7PgsfD3HU9zGqGWo/wChW6ZUywrWULt9
        VamCHrLfegKISpPFNEfDF2ulecNLqoPETIle646qrjjZMMRAe2ZXPL6khRVs/pViv9WvkCh4uzIhB
        vpvXL5NyJtpaQq1XkOP9kVa9BKLTp6MgxqrCMJdflx0iIwe3mG0FRYn7fI+XG72aEN5lbC6QuRuzF
        aIgnJCbA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qpv9j-00BPQm-1V;
        Mon, 09 Oct 2023 18:39:03 +0000
Message-ID: <3010dc8a-18a0-4f8e-9b9b-f5b16c7ff052@infradead.org>
Date:   Mon, 9 Oct 2023 11:39:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel/fork.c:1134: warning: Function parameter or member 'mm'
 not described in 'set_mm_exe_file'
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202310100237.RjecPfNo-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202310100237.RjecPfNo-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 11:30, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
> commit: b1fbfcb4a20949df08dd995927cdc5ad220c128d kbuild: make single target builds even faster
> date:   3 years, 11 months ago
> config: openrisc-allnoconfig (https://download.01.org/0day-ci/archive/20231010/202310100237.RjecPfNo-lkp@intel.com/config)
> compiler: or1k-linux-gcc (GCC) 12.3.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310100237.RjecPfNo-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310100237.RjecPfNo-lkp@intel.com/
> 

Fixes for kernel/fork.c are here:
  https://lore.kernel.org/all/20230824193644.3029141-1-willy@infradead.org/

are should be in the docs-next tree (I guess).

> All warnings (new ones prefixed by >>):
> 
>>> kernel/fork.c:1134: warning: Function parameter or member 'mm' not described in 'set_mm_exe_file'
>>> kernel/fork.c:1134: warning: Function parameter or member 'new_exe_file' not described in 'set_mm_exe_file'
>>> kernel/fork.c:1158: warning: Function parameter or member 'mm' not described in 'get_mm_exe_file'
>>> kernel/fork.c:1178: warning: Function parameter or member 'task' not described in 'get_task_exe_file'
>>> kernel/fork.c:1203: warning: Function parameter or member 'task' not described in 'get_task_mm'
> --


-- 
~Randy
