Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF68F790ACB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 06:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbjICEcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 00:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjICEco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 00:32:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E6ACC5;
        Sat,  2 Sep 2023 21:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=NGaWMFB3Js4EqhYK2Uby5E6+yUktsZoYj36TrbJ23CA=; b=lnv7ObQpRtY1SmqbbcrDPSQCFL
        SA+4DB/IiUr975FYtyZ/uYk73koGLdRT3Q82kADmZsnb8CAsz9+bPlgSXbgjIQBl0VuiWkV1OhBF9
        Bt4rpp0n+ec+C/pF+EhIBraqJgcH4mMrrtnXZEjYjkpEffZF57COeJjr7AJMHXxD14dYV1OiMlZs/
        ++DWISF96fvux5AImdTA4VFxhQ7weq+7xjJZNaKHyOXJPBrmEejQ5GLVUwe3Ry7nqyRfWUa5nrKHA
        3rFLx5K2cruua3li1ZymROb6b5uoyJPhOTzUUXh0wMrW5hi+cfA8Jnac9Hw4Hq1Spg/tuX6LWmRhY
        ml2R0JHw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qcemr-0025EH-1L;
        Sun, 03 Sep 2023 04:32:37 +0000
Message-ID: <e566266a-f6f8-bad2-884d-22c394be52be@infradead.org>
Date:   Sat, 2 Sep 2023 21:32:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: ld.lld: error: undefined symbol: sysfs_format_mac
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        David Thompson <davthompson@nvidia.com>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Shravan Kumar Ramani <shravankr@nvidia.com>
References: <202309031058.JvwNDBKt-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202309031058.JvwNDBKt-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/2/23 19:39, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   92901222f83d988617aee37680cb29e1a743b5e4
> commit: 7e38a7422f128e7d7ba24b444e957d585dbb272f mlxbf-bootctl: Support sysfs entries for MFG fields
> date:   10 days ago
> config: arm64-randconfig-r024-20230902 (https://download.01.org/0day-ci/archive/20230903/202309031058.JvwNDBKt-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230903/202309031058.JvwNDBKt-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309031058.JvwNDBKt-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: sysfs_format_mac
>    >>> referenced by xarray.c

I don't see what xarray.c has to do with this.

This happens when CONFIG_NET is not enabled.

>    >>>               vmlinux.o:(oob_mac_show)
> 

-- 
~Randy
