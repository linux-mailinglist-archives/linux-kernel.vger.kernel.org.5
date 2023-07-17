Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B26756FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjGQWjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjGQWjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:39:53 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 25D9EFF;
        Mon, 17 Jul 2023 15:39:52 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.01,211,1684767600"; 
   d="scan'208";a="173217089"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 18 Jul 2023 07:39:51 +0900
Received: from [10.226.92.22] (unknown [10.226.92.22])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 212B9400D4D3;
        Tue, 18 Jul 2023 07:39:45 +0900 (JST)
Message-ID: <9da5f8cb-5ed0-1854-0a0a-252794e01ce3@bp.renesas.com>
Date:   Mon, 17 Jul 2023 23:39:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230717201547.359923764@linuxfoundation.org>
From:   Paul Barker <paul.barker.ct@bp.renesas.com>
In-Reply-To: <20230717201547.359923764@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 17/07/2023 21:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Building i386_defconfig in my Yocto Project environment (with gcc 13) fails:

| /.../kernel/workqueue.c: In function 'get_work_pwq':
| /.../kernel/workqueue.c:706:24: error: cast to pointer from integer of 
different size [-Werror=int-to-pointer-cast]
|   706 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
|       |                        ^
| /.../kernel/workqueue.c: In function 'get_work_pool':
| /.../kernel/workqueue.c:734:25: error: cast to pointer from integer of 
different size [-Werror=int-to-pointer-cast]
|   734 |                 return ((struct pool_workqueue *)
|       |                         ^
| /.../kernel/workqueue.c: In function 'get_work_pool_id':
| /.../kernel/workqueue.c:756:25: error: cast to pointer from integer of 
different size [-Werror=int-to-pointer-cast]
|   756 |                 return ((struct pool_workqueue *)
|       |                         ^

Cherry-picking afa4bb778e48d79e4a642ed41e3b4e0de7489a6c from mainline 
fixes the build for me.

Thanks,
Paul
