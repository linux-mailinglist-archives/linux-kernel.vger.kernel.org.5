Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E37C6B03
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjJLKY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 06:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbjJLKYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 06:24:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB9A114
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 03:24:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33593C433C8;
        Thu, 12 Oct 2023 10:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697106276;
        bh=0Ljt2/e3et0ja/EIacPM8+PVdZSTtxr6HVLa0adWuRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ezl8LIgv/hwXINeaG2HyDxNbNKzV7PAKOAn13rz6rHGAMMb1vn+AjsCpUHB6kULoc
         JQKqKBBQBsnFQOOKmJQuSBWSuJHJSrLVwoJ+oNxd493jMdxkFw4Umt4oumm+F+MI4G
         I1MguCsBXItmVTZYQQnHIRYZgWY9fWdVLPd3tRNU1OZxaBk1sMo6RTG6wSAFmsmg63
         t2PBMVvRzi3GYyhaKznQFmFt91OveyfoqGwXxOHvM1seGwg01MwWcNxIYTgSEfp31r
         RPVvBI7ldeMmFTnakAe9KIp2B84aFmjRIHhrqlnkHwezMa46d/GSX8m9VsgnEKcHHY
         mcAMfSRnpc8aQ==
Date:   Thu, 12 Oct 2023 11:24:32 +0100
From:   Lee Jones <lee@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Shawn Anastasio <sanastasio@raptorengineering.com>,
        devicetree@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        Timothy Pearson <tpearson@raptorengineering.com>,
        linux-kernel@vger.kernel.org,
        Georgy Yakovlev <Georgy.Yakovlev@sony.com>
Subject: Re: [PATCH 3/3] mfd: sie-cronos-cpld: Add driver for SIE cronos CPLD
Message-ID: <20231012102432.GG8314@google.com>
References: <2e9763cb4fa258fe11769a4ff1544d96c536a4a2.1696285339.git.sanastasio@raptorengineering.com>
 <202310050807.eDZkgFy5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202310050807.eDZkgFy5-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2023, kernel test robot wrote:

> Hi Shawn,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on lee-mfd/for-mfd-next]
> [also build test WARNING on robh/for-next linus/master v6.6-rc4 next-20231004]
> [cannot apply to lee-leds/for-leds-next lee-mfd/for-mfd-fixes]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Shawn-Anastasio/dt-bindings-mfd-sie-cronos-cpld-Add-initial-DT-binding/20231003-073243
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git for-mfd-next
> patch link:    https://lore.kernel.org/r/2e9763cb4fa258fe11769a4ff1544d96c536a4a2.1696285339.git.sanastasio%40raptorengineering.com
> patch subject: [PATCH 3/3] mfd: sie-cronos-cpld: Add driver for SIE cronos CPLD
> config: i386-randconfig-063-20231005 (https://download.01.org/0day-ci/archive/20231005/202310050807.eDZkgFy5-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310050807.eDZkgFy5-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310050807.eDZkgFy5-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/mfd/sie-cronos-cpld.c:509:34: warning: 'cronos_cpld_dt_ids' defined but not used [-Wunused-const-variable=]
>      509 | static const struct of_device_id cronos_cpld_dt_ids[] = {
>          |                                  ^~~~~~~~~~~~~~~~~~
> 
> 
> vim +/cronos_cpld_dt_ids +509 drivers/mfd/sie-cronos-cpld.c
> 
>    508	
>  > 509	static const struct of_device_id cronos_cpld_dt_ids[] = {
>    510		{ .compatible = "sie,cronos-cpld", },
>    511		{ }
>    512	};
>    513	MODULE_DEVICE_TABLE(of, cronos_cpld_dt_ids);
>    514	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

Removing from my queue until this is fixed.

-- 
Lee Jones [李琼斯]
