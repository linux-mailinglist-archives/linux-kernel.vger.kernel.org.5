Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB4A75731F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 07:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjGRFY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 01:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGRFYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 01:24:24 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843BA1B4;
        Mon, 17 Jul 2023 22:24:23 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-56661fe27cbso3357976eaf.3;
        Mon, 17 Jul 2023 22:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689657863; x=1692249863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dnjYiL+P/K0sOilY3BcyTijfvnwbF/zuRsmlT3Sdj7M=;
        b=GhjQ8+Znf8xgCYTOPwrvPXsG/hO5f/Q2l31JLWjKAAxFeENLSOFl+Gg/meRIVcWwPY
         WMtcDUx+Q5IOcQIaj7IaJA7sp3VtwunceJNi6gv6GfzqMK0MyhdWATANFGnosaGk7/9L
         KQ5IzUUSG4dm9Zf3g09FTGTKnZJRcUkhM5XZxsUhybx1qsjkfL5EJE0FRRNzWb+at4GT
         PME88Di2PKyuYdEPIEF15B/bFGj4tgtvvOX7NJvEfgEQZxW6SZbIH9NzNXiG6pfwFSCO
         Q6oBsHYeUaW8rqpu6vXQM0K6C2qk5QFX/WkHIictf8rUv4Riwiq71SGVn7jda+rtzdbb
         +cPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689657863; x=1692249863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dnjYiL+P/K0sOilY3BcyTijfvnwbF/zuRsmlT3Sdj7M=;
        b=FtZrKnTD9umHcxhZUZNOmFiv/4BLG5Jvw8uUSGzbbvNG4kmm+IS4JldR1WgaUKIhhb
         sBkgNGI7fi1bNJKUmCH9EA8QE8TZK+BZ6WY5KEO9QWXCHLFj7PVtEcWgrm9xcx7Gj9qW
         oXbNp5ELAFCMSdPXRa8YPCXIMhN0h6/WHeS4phAQYwoRSegmF1yp6HrRhmPWuoM6UkhK
         duWNYfp6/0Tk80Uu2iMINkUl5nHLpTofoSVL3fgRwVCPhQsYWaVVxORRc4I7lFCyJUsk
         OiKnJyX5L7K0+8uvHm5szRbmPSiJH8T2b+xitNEu3P2NbOt+FBHCuZQZPJOx5qsY+dbN
         I6LA==
X-Gm-Message-State: ABy/qLaQ4HrAXMduUi2eJak241fkoieme3tazapSNdr8/sEFZ7KAHFu4
        nD+OeKqjzSISVz2ZGfhrlw8=
X-Google-Smtp-Source: APBJJlFV0tmQu+2m2ZbuY7wtK7PjpKTT29CsCqSheEv01DgD1vjRHs1Os4zbpj/crev1odDaJOLamQ==
X-Received: by 2002:a05:6358:7f10:b0:134:e964:134c with SMTP id p16-20020a0563587f1000b00134e964134cmr12194494rwn.11.1689657862719;
        Mon, 17 Jul 2023 22:24:22 -0700 (PDT)
Received: from ?IPV6:2601:1c2:980:9ec0::2764? ([2601:1c2:980:9ec0::2764])
        by smtp.gmail.com with ESMTPSA id e2-20020aa78242000000b006833bcc95b0sm648452pfn.115.2023.07.17.22.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 22:24:22 -0700 (PDT)
Message-ID: <84f0bdbc-09d1-ae4f-79ce-0d54c3410f18@gmail.com>
Date:   Mon, 17 Jul 2023 22:24:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: Tree for Jul 18 (drivers/video/fbdev/ps3fb.c)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>
References: <20230718135733.0f1789a4@canb.auug.org.au>
From:   Randy Dunlap <rd.dunlab@gmail.com>
In-Reply-To: <20230718135733.0f1789a4@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 7/17/23 20:57, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230717:
> 

I'm still seeing build errors on PPC64 for ps3fb.c:

In file included from ../include/linux/device.h:15,
                 from ../arch/powerpc/include/asm/io.h:22,
                 from ../include/linux/io.h:13,
                 from ../include/linux/irq.h:20,
                 from ../arch/powerpc/include/asm/hardirq.h:6,
                 from ../include/linux/hardirq.h:11,
                 from ../include/linux/interrupt.h:11,
                 from ../drivers/video/fbdev/ps3fb.c:25:
../drivers/video/fbdev/ps3fb.c: In function 'ps3fb_probe':
../drivers/video/fbdev/ps3fb.c:1172:40: error: 'struct fb_info' has no member named 'dev'
 1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
      |                                        ^~
../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
      |                                     ^~~~~~~~~~~
../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
 1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
      |         ^~~~~~~~
../drivers/video/fbdev/ps3fb.c:1172:61: error: 'struct fb_info' has no member named 'dev'
 1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
      |                                                             ^~
../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
  110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
      |                                     ^~~~~~~~~~~
../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
 1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
      |         ^~~~~~~~

-- 
~Randy

