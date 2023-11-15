Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572717EC629
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344096AbjKOOqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344238AbjKOOqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:46:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA231B3;
        Wed, 15 Nov 2023 06:46:04 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6803566072F6;
        Wed, 15 Nov 2023 14:46:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700059563;
        bh=SysEHQyfnDl2ED6yEuD/ZWURaU47ZbaPWA3AZzp3zCU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l1TITT5hAZpW8tHUZnZdSzdJPAzIaOspip8Wsbds8NnwpadodZgJv2VFzRso4KS0o
         HB2g+EKaRIDWxmAsn56WIecMVN4rF6mm75zr43ZOjq0EVW0CfG1GQvSx7S74zfYmCP
         LUuPpKZaBS0o9A+ow8WojcipY6Uau/37wmvFSbXDGVxlIObHPDZ+FYNmSXX+kHkFCe
         2iL87MNv3OfavWKBRJE8mrpDQ1cto5ETHcTtRSx1mS4eIL03PknrAGzb3U2bvVnGNQ
         BvNBaik3KqhQmQ0MAZVw299c316P16p0gWGhsDE8qe1dzbCdqn9NqVGGEx/hJjyWl5
         iP/J1L/AcOBEw==
Message-ID: <8e40838f-1a72-4167-8ff5-0ca1584e0246@collabora.com>
Date:   Wed, 15 Nov 2023 15:45:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: Add support for device tree thermal zones
 consumers
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, daniel.lezcano@linaro.org,
        rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        wenst@chromium.org
References: <20231114131514.89031-1-angelogioacchino.delregno@collabora.com>
 <202311152230.nzJVHaeG-lkp@intel.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <202311152230.nzJVHaeG-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/11/23 15:37, kernel test robot ha scritto:
> Hi AngeloGioacchino,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on rafael-pm/thermal]
> [also build test ERROR on linus/master v6.7-rc1 next-20231115]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/AngeloGioacchino-Del-Regno/thermal-Add-support-for-device-tree-thermal-zones-consumers/20231114-211656
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
> patch link:    https://lore.kernel.org/r/20231114131514.89031-1-angelogioacchino.delregno%40collabora.com
> patch subject: [PATCH] thermal: Add support for device tree thermal zones consumers
> config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20231115/202311152230.nzJVHaeG-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231115/202311152230.nzJVHaeG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202311152230.nzJVHaeG-lkp@intel.com/

..snip..

> 
> 
> vim +282 include/linux/thermal.h
> 
>     280	

That's right, I forgot to add "static inline" :-)

Fixing and sending a v2.

>     281	struct thermal_zone_device *thermal_of_get_zone_by_index(struct device *dev, int index)
>   > 282	{
>     283		return ERR_PTR(-EOPNOTSUPP);
>     284	}
>     285	
>     286	struct thermal_zone_device *thermal_of_get_zone(struct device *dev, const char *name)
>   > 287	{
>     288		return ERR_PTR(-EOPNOTSUPP);
>     289	}
>     290	#endif
>     291	
> 



