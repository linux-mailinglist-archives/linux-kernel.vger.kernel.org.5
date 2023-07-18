Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C6B75710B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 02:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGRAqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 20:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGRAqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 20:46:03 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D290210E5;
        Mon, 17 Jul 2023 17:46:01 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-48159634694so1864814e0c.2;
        Mon, 17 Jul 2023 17:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689641161; x=1692233161;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2l3cSyrjXW2glLWWy50xQezOhIrGHIZF9/wpOtpT3iM=;
        b=jl6Q1T/UvfyGWSh5abi6PR7NY7TwYREiUdP6upkLK1hHlbD/Q+P7uHfvl+cL42JYLx
         4MwePqDz77I0H0V5PoHao3mV8GMHSlx6Vmh4Ykpm29Fm5U5VVO7AxF4sSL3KsYzTjX4/
         mbpP9rb663wlq6gkFHbHXfaRo9BjSvsr5APM2G/8iI0xzEYa9ewYFJvFtRlFPbH5oXIJ
         HLym89l7u6iTae916D945xgsryejXFdi5+9ytbm5Vi1GAycqaN3+d4tIAhRgkLMpQ8j2
         9LtoBsTGIgBoWY0slJr6FvQYl2Fr/kYEwFiwAS5WaVcSxT4BTvt7DTG/8XJhKent0fFH
         eYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689641161; x=1692233161;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2l3cSyrjXW2glLWWy50xQezOhIrGHIZF9/wpOtpT3iM=;
        b=YhpBpC4msTHEWYmvAwGBl6Q9ChyR2JpSO8bpuKCMjiyg0gArud5+ik949iJseakh0J
         pyNaiNNXwIbf7WmtEKWwiD4LKi1SY30yTkzHurSsHfOG8p5YeQC0R5SCCzuNL49TuYt9
         W5zmm46oySoBinAva29sO4PnKJgXYlseWIt5nfGlf+Zw7ouUi1TmM2UzJTKNDKmcP21o
         cDs28+318827BLsHac+SBYG7KxUkgx7t3jtrMCNAMDzNQhkPyVdKLtD/q4Nw5/qtG+6i
         7KUbaDZOaHF3JMZLCmQwh875ntxeLEcgVnhzL849ktDak1dEMljzQeNfrWmcxJZmTrFr
         ksPA==
X-Gm-Message-State: ABy/qLZmi9aeWthGZ8NKPqcpIzQmyQuFqVQ6YMpNivK58v9S/+KjvbbF
        cpF4Wx7oVF+BuYqBFytNCYr7o3h5eM99+sYVco3Ol54isjI=
X-Google-Smtp-Source: APBJJlHbga8/mCPPGYpoNLFPICB0dJUDdptCl+a2F2sIrBnJTs6imHkAqXAPrK0MZMc4ZXkvropP0wAxhst7rg2aS/k=
X-Received: by 2002:a1f:d184:0:b0:471:9190:fa09 with SMTP id
 i126-20020a1fd184000000b004719190fa09mr762999vkg.7.1689641160683; Mon, 17 Jul
 2023 17:46:00 -0700 (PDT)
MIME-Version: 1.0
From:   Randy Dunlap <rd.dunlab@gmail.com>
Date:   Mon, 17 Jul 2023 17:45:49 -0700
Message-ID: <CA+LWhsE+TUG5L9uPBiF324_madiHr86Kw27hazr88CFuPukYkg@mail.gmail.com>
Subject: Re: linux-next: Tree for Jul 13 (drivers/video/fbdev/ps3fb.c)
To:     lkml <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org
Cc:     sfr@canb.auug.org.au, Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,
On 7/14/23 13:46, Randy Dunlap wrote:
> Thomas,
>
> On 7/13/23 09:11, Randy Dunlap wrote:
>>
>>
>> On 7/12/23 19:37, Stephen Rothwell wrote:
>>> Hi all,
>>>
>
> I still see this build error on linux-next 20230714.

I still see this build error on linux-next 20230717.

>
>>> Changes since 20230712:
>>>
>>
>> on ppc64:
>>
>> In file included from ../include/linux/device.h:15,
>> from ../arch/powerpc/include/asm/io.h:22,
>> from ../include/linux/io.h:13,
>> from ../include/linux/irq.h:20,
>> from ../arch/powerpc/include/asm/hardirq.h:6,
>> from ../include/linux/hardirq.h:11,
>> from ../include/linux/interrupt.h:11,
>> from ../drivers/video/fbdev/ps3fb.c:25:
>> ../drivers/video/fbdev/ps3fb.c: In function 'ps3fb_probe':
>> ../drivers/video/fbdev/ps3fb.c:1172:40: error: 'struct fb_info' has no member named 'dev'
>> 1172 | dev_driver_string(info->dev), dev_name(info->dev),
>> | ^~
>> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>> 110 | _p_func(dev, fmt, ##__VA_ARGS__); \
>> | ^~~~~~~~~~~
>> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>> 1171 | dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>> | ^~~~~~~~
>> ../drivers/video/fbdev/ps3fb.c:1172:61: error: 'struct fb_info' has no member named 'dev'
>> 1172 | dev_driver_string(info->dev), dev_name(info->dev),
>> | ^~
>> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'

-- 
~Randy [using gmail temporarily while infradead is down]
