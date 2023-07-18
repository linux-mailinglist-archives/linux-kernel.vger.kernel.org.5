Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC03757255
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGRDck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjGRDcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:32:13 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCF3D1;
        Mon, 17 Jul 2023 20:32:11 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-67ef5af0ce8so5328069b3a.2;
        Mon, 17 Jul 2023 20:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689651130; x=1692243130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsCgfp2s3CRfk6nv+x0Mk0r1Oznh1MYu4hj6PzpztDM=;
        b=ZEPFLg7rh5L4b7krkym5Ya+3jpyqEqMmL/f2boSjPTpbBG26VM+k7464Jo5583X0SD
         a1Hw0wjSHGPNytPVL9TwTmmRBuq54jqOx6viOG/XyfQinG8Bjmw5k9NRMeQwdVcqYJuw
         +Lm5xtcuXeY9RnnUpmW1s1zhsxPisZtikjU9KUPopAYpCiR82uGhq4dgb81vUAKKYm5x
         rDIpRedktdlIfSkhJkVC7cTqJoWL1XbBorpIdJ9NtHJXVyiU17Nn/QlU9ya6Ad6aEYVA
         Rx4Fffm3aba7pO1PPklVrsRr1dy1uTyApY745rTX/ZTXC7zxlXgsm+ya1+HKpNg50sMF
         bhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689651130; x=1692243130;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qsCgfp2s3CRfk6nv+x0Mk0r1Oznh1MYu4hj6PzpztDM=;
        b=MK42jZQ10ailQBw7FJ8/KP+dLM0dAw+UMiMlU8PqtOAh5LKdeUWZN49eWFf3V+vDKN
         qsr65hj8adqNT+OTmeXNwXEzUORIg5gazdlAELWPIUorPidJQX9j9lRZptK6eZncdGhO
         Y5KzUIfK6ykdCyRAAvpCx/PKPy2dcZSjs9a32791Q9Z4JW0ItEsCqnhB8mHkJChVJ5IW
         AgKGJWIUD9ZzVe/zm4iVp07eQxLTRilxQ+eigi4UzQ4sWUtEGFK66dpwTg0fdn6AcRTk
         Nxis4ed/AVMn+iqsk47tnNwHRY1W22fj0dJrSCbhqy85s8zNlvA6CH8dkFL1G5pZSQIH
         uViQ==
X-Gm-Message-State: ABy/qLZfs1RyKe1muBfOc+kKzNNIMaHOo60CQnU9qmDFZZkq8tEtTYmC
        PUxQJwy53IBW5TbdvbxxPxdLpSqEF02/3u9F
X-Google-Smtp-Source: APBJJlFAwDoW4yADO2Pjd04stMQf1iujcnSKviiNjIZ3895AEfrruDatfQyAiKeDtImLL7XYcqiTtg==
X-Received: by 2002:a05:6a21:7883:b0:133:215e:746d with SMTP id bf3-20020a056a21788300b00133215e746dmr17816681pzc.41.1689651130509;
        Mon, 17 Jul 2023 20:32:10 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id j14-20020a170902758e00b001b9be2e2b3esm584344pll.277.2023.07.17.20.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:32:10 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5ED5E834F19C; Tue, 18 Jul 2023 10:32:05 +0700 (WIB)
Date:   Tue, 18 Jul 2023 10:32:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: linux-next: Tree for Jul 13 (drivers/video/fbdev/ps3fb.c)
Message-ID: <ZLYHtVuS7AElXcCb@debian.me>
References: <20230713123710.5d7d81e4@canb.auug.org.au>
 <ccc63065-2976-88ef-1211-731330bf2866@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ccc63065-2976-88ef-1211-731330bf2866@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 09:11:10AM -0700, Randy Dunlap wrote:
> 
> 
> On 7/12/23 19:37, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20230712:
> > 
> 
> on ppc64:
> 
> In file included from ../include/linux/device.h:15,
>                  from ../arch/powerpc/include/asm/io.h:22,
>                  from ../include/linux/io.h:13,
>                  from ../include/linux/irq.h:20,
>                  from ../arch/powerpc/include/asm/hardirq.h:6,
>                  from ../include/linux/hardirq.h:11,
>                  from ../include/linux/interrupt.h:11,
>                  from ../drivers/video/fbdev/ps3fb.c:25:
> ../drivers/video/fbdev/ps3fb.c: In function 'ps3fb_probe':
> ../drivers/video/fbdev/ps3fb.c:1172:40: error: 'struct fb_info' has no member named 'dev'
>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>       |                                        ^~
> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                                     ^~~~~~~~~~~
> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>       |         ^~~~~~~~
> ../drivers/video/fbdev/ps3fb.c:1172:61: error: 'struct fb_info' has no member named 'dev'
>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>       |                                                             ^~
> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                                     ^~~~~~~~~~~
> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>       |         ^~~~~~~~
> 
> 

Hmm, there is no response from Thomas yet. I guess we should go with
reverting bdb616479eff419, right? Regardless, I'm adding this build regression
to regzbot so that parties involved are aware of it:

#regzbot ^introduced: bdb616479eff419
#regzbot title: build regression in PS3 framebuffer

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
