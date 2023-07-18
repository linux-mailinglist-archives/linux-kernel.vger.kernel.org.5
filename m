Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F0E7581DA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGRQPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjGRQPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:15:18 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C43FE0;
        Tue, 18 Jul 2023 09:15:18 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-666e3b15370so4305837b3a.0;
        Tue, 18 Jul 2023 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689696917; x=1692288917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Na1N69oGSFxdRjjEQS9A1nDY6v0D8diedcdZ35e5WcM=;
        b=nMRD3rJUi6U8jz3ZNN70bMZlnHnFExyIvu7PL2U08n7xmhZRD2Uxp3TBUHEKvJ022I
         D/NCip+bMpmnWyYN8xP1yAXupduOJLvtz/Rl2MRIPpcwJlFurHpiqewlg8Y0pgDZorti
         jFNtGE0OVDY/DYOa+x7p5AsNCcWDkDlwKiAGygPI3HqOX+2pRknd0W+olS7ugFUTUGqG
         ARLUmIld50DGpS/GhxTLk4RRzN90t90GmEA+4aU8rIpS08lsWow1AZkqAj3iXUE0HaPU
         8EALiVUtGerXVNeBwsPPBeY1afnVqipHBuYQEUc3rOcmy7Exbo2m5cbrjJN5FAMX7FhV
         /xvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689696917; x=1692288917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Na1N69oGSFxdRjjEQS9A1nDY6v0D8diedcdZ35e5WcM=;
        b=OfLEhBQpqAmqRdqn+bfYatScXx4AMM9MsEhxVC+KoRRo531SdPMHiw074KiAC2DVbE
         HvXO5Q4q3oQnJ/5fjx/LG9xdi6Y2Mhr+89+JCfr13uofQc9fEHdRbDci1epU0Imfsv9O
         epgVV5NFxorWujLV+y7I4DB2wGzYdq50moRNM1R2yV+us/cBOPArL/dvp0uWggeZvuLi
         +WX86UnhJj6JzzAKel5S/4jXPa+WJqlXaC/Cpqd+iXey/pHD/kX0fueewbh3wJ6G2rUg
         7bL9FxVwm39PibEC6vZLCyrJB59lXyI1mCYtcAqXtn+5zNlbrN3bAAXWIzIG4NmLnRZv
         pCIg==
X-Gm-Message-State: ABy/qLZvSJPhqAPHwoUJT17BZov+Ozt2fILWHQqtu0SiyTV8K2dZCRjT
        7HPkvLjkZKck53NZ1vFqbsg=
X-Google-Smtp-Source: APBJJlGDZgvnQDrQyjvF2Kc+/Eo1CpJR0XBffNwdVBMhPEbrYP8yTMy9F+vHwnEHtA4wvSI4YnvWtA==
X-Received: by 2002:a17:903:50b:b0:1b7:c166:f197 with SMTP id jn11-20020a170903050b00b001b7c166f197mr2151693plb.29.1689696917397;
        Tue, 18 Jul 2023 09:15:17 -0700 (PDT)
Received: from ?IPV6:2601:1c2:980:9ec0::2764? ([2601:1c2:980:9ec0::2764])
        by smtp.gmail.com with ESMTPSA id iw10-20020a170903044a00b001b9be3b94d3sm2069605plb.140.2023.07.18.09.15.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 09:15:17 -0700 (PDT)
Message-ID: <d9616a67-23e8-118f-dc0a-7ed4afd4bffd@gmail.com>
Date:   Tue, 18 Jul 2023 09:15:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Tree for Jul 13 (drivers/video/fbdev/ps3fb.c)
Content-Language: en-US
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Geoff Levand <geoff@infradead.org>
References: <20230713123710.5d7d81e4@canb.auug.org.au>
 <ccc63065-2976-88ef-1211-731330bf2866@infradead.org>
 <ZLYHtVuS7AElXcCb@debian.me> <874jm1jv9m.fsf@mail.lhotse>
From:   Randy Dunlap <rd.dunlab@gmail.com>
In-Reply-To: <874jm1jv9m.fsf@mail.lhotse>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 04:48, Michael Ellerman wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>> On Thu, Jul 13, 2023 at 09:11:10AM -0700, Randy Dunlap wrote:
>>> on ppc64:
>>>
>>> In file included from ../include/linux/device.h:15,
>>>                  from ../arch/powerpc/include/asm/io.h:22,
>>>                  from ../include/linux/io.h:13,
>>>                  from ../include/linux/irq.h:20,
>>>                  from ../arch/powerpc/include/asm/hardirq.h:6,
>>>                  from ../include/linux/hardirq.h:11,
>>>                  from ../include/linux/interrupt.h:11,
>>>                  from ../drivers/video/fbdev/ps3fb.c:25:
>>> ../drivers/video/fbdev/ps3fb.c: In function 'ps3fb_probe':
>>> ../drivers/video/fbdev/ps3fb.c:1172:40: error: 'struct fb_info' has no member named 'dev'
>>>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>>>       |                                        ^~
>>> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>>>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>>>       |                                     ^~~~~~~~~~~
>>> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>>>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>>>       |         ^~~~~~~~
>>> ../drivers/video/fbdev/ps3fb.c:1172:61: error: 'struct fb_info' has no member named 'dev'
>>>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>>>       |                                                             ^~
>>> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>>>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>>>       |                                     ^~~~~~~~~~~
>>> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>>>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>>>       |         ^~~~~~~~
>>>
>>>
>>
>> Hmm, there is no response from Thomas yet. I guess we should go with
>> reverting bdb616479eff419, right? Regardless, I'm adding this build regression
>> to regzbot so that parties involved are aware of it:
>>
>> #regzbot ^introduced: bdb616479eff419
>> #regzbot title: build regression in PS3 framebuffer
> 
> Does regzbot track issues in linux-next?
> 
> They're not really regressions because they're not in a release yet.
> 
> Anyway I don't see where bdb616479eff419 comes from.
> 
> The issue was introduced by:
> 
>   701d2054fa31 fbdev: Make support for userspace interfaces configurable
> 
> The driver seems to only use info->dev in that one dev_info() line,
> which seems purely cosmetic, so I think it could just be removed, eg:
> 
> diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
> index d4abcf8aff75..a304a39d712b 100644
> --- a/drivers/video/fbdev/ps3fb.c
> +++ b/drivers/video/fbdev/ps3fb.c
> @@ -1168,8 +1168,7 @@ static int ps3fb_probe(struct ps3_system_bus_device *dev)
>  
>  	ps3_system_bus_set_drvdata(dev, info);
>  
> -	dev_info(info->device, "%s %s, using %u KiB of video memory\n",
> -		 dev_driver_string(info->dev), dev_name(info->dev),
> +	dev_info(info->device, "using %u KiB of video memory\n",
>  		 info->fix.smem_len >> 10);
>  
>  	task = kthread_run(ps3fbd, info, DEVICE_NAME);


Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

-- 
~Randy
