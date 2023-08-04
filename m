Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFAE76F810
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 04:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjHDCrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 22:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHDCrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 22:47:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF62115
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 19:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=JaupRiRZL7sWovtTbIIjp9tJEbdN6Kag0rAPEx659Uo=; b=Y5af28A44d7DrVy3cxzlsfPpY2
        briOHPZxylViHK9Y9cwlhKT5aU6HvyG8wSekaYw3BkV3daCw4ZYceZ3K025wtLleF27ABPn2/TndU
        VXmJQrOsEvz30iePPC8ljKvo5QPoJ1OrzbS+oWjknS8Lw4/5e9EQSgAS/XbikM/BU5gnNLgBpAt76
        39xUGxOloiZwOjSS8vj+zH8un33jSiwF/K6zp0reW/LCrorq3+2ZqqwTVCTpCq39xoblBUc0NmYI0
        4LWQJmK2so8FnUI3JL3ba4TSZPPCxuwKbwOKAFN++JrPgvH6uMFhuPQDbJHL01n80MggCOFPxQIIF
        Uky4mNgg==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qRkqN-00BPZj-39;
        Fri, 04 Aug 2023 02:47:12 +0000
Message-ID: <b43e642d-8aa1-fb8a-6bff-86039a06d57b@infradead.org>
Date:   Thu, 3 Aug 2023 19:47:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: drivers/gpu/drm/bridge/samsung-dsim.c link error
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>
Cc:     Aleksandr Nogikh <nogikh@google.com>, l.stach@pengutronix.de,
        inki.dae@samsung.com, jagan@amarulasolutions.com,
        m.szyprowski@samsung.com, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, dvyukov@google.com
References: <20230803144227.2187749-1-nogikh@google.com>
 <CAHCN7x+8Qq6w0eRC0NwBfhgS7XH7fmmPr9xwhR54rWFNY37Ugg@mail.gmail.com>
 <9e77ccc3-07db-f1fe-ef99-981852d4772b@infradead.org>
 <CAHCN7xKG=8ygSi8st31fe+t3Mn+k-7VUHKixFCZUuuDLOX8-kQ@mail.gmail.com>
 <d8a57aee-bb8a-dc5a-7c4f-b8a293d37bec@infradead.org>
 <CAHCN7xKnRAmKh60dAtVaxz-dQtjzhBNtS0aN2swmddfo5FAD-Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAHCN7xKnRAmKh60dAtVaxz-dQtjzhBNtS0aN2swmddfo5FAD-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 19:42, Adam Ford wrote:
> On Thu, Aug 3, 2023 at 9:37 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 8/3/23 19:26, Adam Ford wrote:
>>> On Thu, Aug 3, 2023 at 9:01 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>> Hi--
>>>>
>>>> On 8/3/23 08:24, Adam Ford wrote:
>>>>> On Thu, Aug 3, 2023 at 9:42 AM Aleksandr Nogikh <nogikh@google.com> wrote:
>>>>>>
>>>>>> Hello,
>>>>>>
>>>>>> We've been seing the following linker error on arm64 syzbot instances:
>>>>>>
>>>>>> ld.lld: error: undefined symbol: phy_mipi_dphy_get_default_config_for_hsclk
>>>>>>>>> referenced by samsung-dsim.c:731 (drivers/gpu/drm/bridge/samsung-dsim.c:731)
>>>>>>>>>               drivers/gpu/drm/bridge/samsung-dsim.o:(samsung_dsim_init) in archive vmlinux.a
>>>>>>
>>>>>> Steps to reproduce on the latest linux-next:
>>>>>>
>>>>>> $ git checkout next-20230803
>>>>>> $ wget -O '.config' 'https://raw.githubusercontent.com/google/syzkaller/master/dashboard/config/linux/upstream-arm64-kasan.config'
>>>>>> $ make CC=clang ARCH=arm64 LD=ld.lld CROSS_COMPILE=aarch64-linux-gnu- olddefconfig
>>>>>>
>>>>>> This also prints:
>>>>>>
>>>>>> WARNING: unmet direct dependencies detected for GENERIC_PHY_MIPI_DPHY
>>>>>>   Depends on [n]: GENERIC_PHY [=n]
>>>>>>   Selected by [y]:
>>>>>>   - DRM_NWL_MIPI_DSI [=y] && DRM_BRIDGE [=y] && DRM [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]
>>>>>>   - DRM_SAMSUNG_DSIM [=y] && DRM [=y] && DRM_BRIDGE [=y] && COMMON_CLK [=y] && OF [=y] && HAS_IOMEM [=y]
>>>>>>
>>>>>> $ make CC=clang ARCH=arm64 LD=ld.lld CROSS_COMPILE=aarch64-linux-gnu- -j$(nproc)
>>>>>>
>>>>>> The kernel should have still compiled fine even despite the message above, right?
>>>>
>>>> No. See drivers/Makefile:
>>>> obj-$(CONFIG_GENERIC_PHY)       += phy/
>>>>
>>>> so the drivers/phy/ subdir is only built when CONFIG_GENERIC_PHY is set,
>>>> but it's not set.
>>>>
>>>>>> Could you please take a look?
>>>>>
>>>>> GENERIC_PHY_MIPI_DPHY was enabled to use
>>>>> phy_mipi_dphy_get_default_config() which takes in the pixel clock,
>>>>> bits-per-pixel, number of lanes and phy structure.  It applies a bunch
>>>>> of math based on the info passed and fills in the structure, but that
>>>>> function itself doesn't appear to be referencing phy code, so it's
>>>>> likely safe.
>>>>>
>>>>> I think this can be resolved by enabling GENERIC_PHY.  I just checked
>>>>> linux-next and when I built the arm64 defconfig, it enables
>>>>> GENERIC_PHY=y, so I don't think this is an issue.  I also checked the
>>>>
>>>> defconfig doesn't matter in this case. The .config that was provided has:
>>>> # CONFIG_GENERIC_PHY is not set
>>>> CONFIG_GENERIC_PHY_MIPI_DPHY=y
>>>>
>>>
>>> Where/how was the .config generated?
>>>
>>
>> Aleksandr posted a link to the config file above.
> 
> I get that, but I am not sure how this was generated.
> 

Nor am I. Alexsandr can hopefully tell us.

>>
>>> Are you building linux-next or something else?  The .config file
>>> generated when I build the arm64 defconfig  show both enabled:
>>
>> linux-next.
>>
>>
>>> $ grep GENERIC_PHY .config
>>> CONFIG_GENERIC_PHY=y
>>> CONFIG_GENERIC_PHY_MIPI_DPHY=y
>>>
>>
>> Yes, this is not a defconfig file.
> 
> I know, but it is a .config file that is generated from make defconfig
> ARCH=arm64
>>

Not necessarily. It could be generated by 'make randconfig'.

>>>
>>>> but yes, selecting GENERIC_PHY (needed in 3 places) does fix the warnings
>>>> and build error.  2 instance in drm/bridge/Kconfig and one in
>>>> drm/bridge/cadence/Kconfig (found by inspection).
>>>>
>>>>
>>>>
>>>>> multi_v7_defconfig for ARM and it also sets GENERIC_PHY=y for 32-bit
>>>>> ARM people using some of the Exynos boards.
>>>>>
>>>>> I don't know what version of Linux you're trying to build, but I can't
>>>>> replicate your issue.
>>>>
>>>> I had no problem replicating the kconfig warnings and build error.
>>>
>>> If you can replicate the problem, I'd suggest submitting a patch.
>>
>> Sure, I'll do that.
> 
> Great!  thanks.
> 
> adam
>>
>> --
>> ~Randy

-- 
~Randy
