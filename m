Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF48F7E124A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 06:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjKEFFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 01:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKEFFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 01:05:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35363AB
        for <linux-kernel@vger.kernel.org>; Sat,  4 Nov 2023 22:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=nqh/E/M7gaUfXW6TpmObDF77CKyqneRgS6memCYVkpY=; b=yk5obik6qlfGXstH9wHc+DzxAQ
        NbY2FvItiTpCZLZFBBcZ4lwEFffC1hN8W1Zfg4vK2eCSjrB6Wsi1KO5FTGFypjYsZqxpNDzORv+L7
        8xjsojHmUHDByQ3f+aeiiI0AfvISbCe+T+xYV72L+vn2lxj4lBWHulYleZnR4amdpy0kjMU2SxcEg
        sxBfe49toPvcjS1OBUX+G/EeBTWE5ybvejGSPpxfLMkSkxpA7U/o/wPNxXC1pE0h63QUDTx3cuhH2
        KkydlAK2zS+Y/7O5P6LIJGL8sMBwymUFRbK7KJvYbEG0Al4QnMIPW4hj+Bcfw9Ad76ivnIG9UtrHc
        bYkwD9iA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qzVJg-00EQkl-1u;
        Sun, 05 Nov 2023 05:04:56 +0000
Message-ID: <f2863503-ee88-4e00-841f-0d4b428069ee@infradead.org>
Date:   Sat, 4 Nov 2023 22:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ERROR: start_text address is c000000000000900, should be
 c000000000000200
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202310070419.BcA2fDgk-lkp@intel.com>
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202310070419.BcA2fDgk-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi robot,

On 10/6/23 13:41, kernel test robot wrote:
> Hi Randy,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   af95dc6fdc25e616051d0234aad638e15c02ec8f
> commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: use stdout for error messages
> date:   2 years, 2 months ago
> config: powerpc64-buildonly-randconfig-r003-20211118 (https://download.01.org/0day-ci/archive/20231007/202310070419.BcA2fDgk-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231007/202310070419.BcA2fDgk-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310070419.BcA2fDgk-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: start_text address is c000000000000900, should be c000000000000200
>    ERROR: try to enable LD_HEAD_STUB_CATCH config option
>    ERROR: see comments in arch/powerpc/tools/head_check.sh

This build error also happens when the referenced commit is reverted.
I.e., that patch has nothing to do with this build problem -- only where
it is reported.

-- 
~Randy
