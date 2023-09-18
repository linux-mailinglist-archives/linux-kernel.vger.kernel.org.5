Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0677A4EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbjIRQUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjIRQU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:20:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81497EFB;
        Mon, 18 Sep 2023 09:17:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B51C433AB;
        Mon, 18 Sep 2023 13:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695044999;
        bh=VNgj3ibSIjeoHvbwHyjlxMIDlcI3vpbC0COb4xKHMOo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nCSQJE0UAVOTe05d26M1mSNVEPEi9P4p2t49urcIeD12JNgqwKoUpRGLqB0q246Oq
         iUCzop8GzTjWPYLQtRsO45rtdJn2oD493GXgd5uYgVp1J+cSyQlyOZs7+OBBjL502H
         vqJjyk6COfZvXF6Bu4puBBfxKyy+jjWujRnJ8ZyLplIldy1t2bNSDUrza43FDuTH5v
         gANAkPA6ClbFh88fhlhpjh8F+QEo1Ri2epiFY8M783Lfgbgwk+HZJrNiKJblvMdMrB
         wp2YPBLTFA7JNVRn9tLfHNqNWEaIqu4d3q2IubWyPr4ejK1SiQ70ulSchBwktHu5ZE
         Ha+WTOTY+ZmVg==
Message-ID: <9deaa260-7a15-502e-0159-2012d06c8d05@kernel.org>
Date:   Mon, 18 Sep 2023 15:49:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] tracing/timerlat: Hotplug support for the user-space
 interface
To:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <b619d9fd08a3bb47018cf40afa95783844a3c1fd.1694789910.git.bristot@kernel.org>
 <202309160854.SAw0rIUm-lkp@intel.com>
Content-Language: en-US, pt-BR, it-IT
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <202309160854.SAw0rIUm-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/23 02:21, kernel test robot wrote:
> Hi Daniel,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.6-rc1 next-20230915]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Bristot-de-Oliveira/tracing-timerlat-Hotplug-support-for-the-user-space-interface/20230915-230157
> base:   linus/master
> patch link:    https://lore.kernel.org/r/b619d9fd08a3bb47018cf40afa95783844a3c1fd.1694789910.git.bristot%40kernel.org
> patch subject: [PATCH] tracing/timerlat: Hotplug support for the user-space interface
> config: um-randconfig-002-20230916 (https://download.01.org/0day-ci/archive/20230916/202309160854.SAw0rIUm-lkp@intel.com/config)
> 

^^ The config has no timerlat and no hotplug...

compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230916/202309160854.SAw0rIUm-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202309160854.SAw0rIUm-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>>> kernel/trace/trace_osnoise.c:2125:13: warning: 'timerlat_rm_per_cpu_interface' defined but not used [-Wunused-function]
>     2125 | static void timerlat_rm_per_cpu_interface(long cpu) {};
>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> kernel/trace/trace_osnoise.c:2124:12: warning: 'timerlat_add_per_cpu_interface' defined but not used [-Wunused-function]
>     2124 | static int timerlat_add_per_cpu_interface(long cpu) { return 0; };
>          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

These functions are called when hotplug but no timerlat.... when no hotplug: defined but not used.

> 
> vim +/timerlat_rm_per_cpu_interface +2125 kernel/trace/trace_osnoise.c
> 
>   2112	
>   2113	static void timerlat_rm_per_cpu_interface(long cpu)
>   2114	{
>   2115		struct dentry *cpu_dir = per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->root;
>   2116	
>   2117		if (cpu_dir) {
>   2118			tracefs_remove(cpu_dir);
>   2119			per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->root = NULL;
>   2120			per_cpu_ptr(&osnoise_per_cpu_dir, cpu)->timerlat_fd = NULL;
>   2121		}
>   2122	}
>   2123	#else
>> 2124	static int timerlat_add_per_cpu_interface(long cpu) { return 0; };
>> 2125	static void timerlat_rm_per_cpu_interface(long cpu) {};
>   2126	#endif
>   2127	
> 

Fixing it.

-- Daniel
