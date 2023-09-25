Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB5C7ADE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 20:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjIYSQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 14:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjIYSQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 14:16:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608AD103;
        Mon, 25 Sep 2023 11:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=BKLraxw+2cT6Y1DNrlWQPp9jaHszQHQqGz00lrO3DWs=; b=WY3k3i7SsxkjKjTCxuOxR3+/SV
        v05dJNNqoLtu50Yt6ROa5S1jMLxqBwYvCU/cex79wucm7LUem3++XIkXOOvIUl4BZ0o74YxXtvA/v
        Cr4KaWmxiHp+gQZesQxZbJNs4yYPjqWE4KU39EqQAurpa91Ka+Behmm6YlJ8u/mu3rniBizz2SO9l
        SCvLJ1cVVXhlLFRHVfgjQmSpigPm6fjDyOOuNwaj72lehYBZMymFqwmY8hlVlWfaKO5d+HPDG6UPr
        6Mw29QgSTcYIXSmYDHvdrBMpYLxfSLSJFZ9sBh43DOWAd3Kq2NmBrM+OJ+9jVNZhZtQuOuTZe59nw
        iUY8aEHw==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkq7f-00EoSA-1w;
        Mon, 25 Sep 2023 18:15:55 +0000
Message-ID: <f905a3ad-0259-4dae-8071-d3371b49f0c8@infradead.org>
Date:   Mon, 25 Sep 2023 11:15:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:undefined reference
 to `fb_io_read'
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-fbdev@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <202309130632.LS04CPWu-lkp@intel.com>
 <feadd6a5-0f56-4575-9891-3a7d88e69e64@infradead.org>
 <CAMuHMdVRyaq5xT+2GGREHS95Nm86wHmmU0cE_qR5-eza1vMExw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdVRyaq5xT+2GGREHS95Nm86wHmmU0cE_qR5-eza1vMExw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/23 00:32, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Wed, Sep 13, 2023 at 7:13 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 9/12/23 15:42, kernel test robot wrote:
>>> FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
>>> commit: 5f86367006c6a0662faaf36f753f437afe42fb63 fbdev/sh7760fb: Use fbdev I/O helpers
>>> date:   6 weeks ago
>>> config: sh-randconfig-r012-20230913 (https://download.01.org/0day-ci/archive/20230913/202309130632.LS04CPWu-lkp@intel.com/config)
>>> compiler: sh4-linux-gcc (GCC) 13.2.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309130632.LS04CPWu-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202309130632.LS04CPWu-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
>>>    sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
>>>    sh4-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
>>>    sh4-linux-ld: sh7760fb.c:(.text+0x39c): undefined reference to `fb_alloc_cmap'
>>>    sh4-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
>>>    sh4-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
>>>    sh4-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
>>>    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
>>>    sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
>>>    sh4-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
>>>    sh4-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
>>>>> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
>>>>> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
>>>    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
>>>    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
>>>    sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
>>
>> The problem is CONFIG_FB=m and CONFIG_FB_SH7760=y.
>>
>> This can be fixed by this simple change ... if it's correct.
>>
>> or this Kconfig entry can be made into a tristate, but that may not
>> help with booting a system.
> 
> What kind of problem do you foresee? Users could still configure it builtin
> when needed.

I was hoping that someone who is familiar with this particular h/w
could respond, but I agree with you:  I don't know of any reason to
restrict this driver to builtin only.

> I see no reason to restrict this to builtin.
> The driver already has all MODULE_*() boilerplate.
> 
>> --- a/drivers/video/fbdev/Kconfig
>> +++ b/drivers/video/fbdev/Kconfig
>> @@ -1762,7 +1762,7 @@ config FB_COBALT
>>
>>  config FB_SH7760
>>         bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
>> -       depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
>> +       depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
>>                 || CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
>>         select FB_IOMEM_HELPERS
>>         help
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

-- 
~Randy
