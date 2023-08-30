Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701778DF2E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbjH3TKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343815AbjH3RHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:07:42 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA47ED1;
        Wed, 30 Aug 2023 10:07:39 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58d9ba95c78so59707b3.1;
        Wed, 30 Aug 2023 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693415259; x=1694020059; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/QyLvyKuwxXiEnwad4bzg5BcAD0WhpvsEjjdvqhUEc=;
        b=mE0NarjX0htvdubq52tr2fSaCfRzgCY94f9mO8R3Hi4K0hrFkp25+m5GipUTBGoeKn
         aTMRRt1JvysTcLJ3K4mcfdk0vWF82z3tCozOPu20kGAdPUKkNUzzFNizByQgcqzrPXhW
         067ZswG2YrAgzhMjAJ6DVn7jwMzq+5zfb7ZZDdCQS8rYBivHM25KzI6Nx8HdiH1q0vVD
         1fgCw4wtDIut4VT0vJ+vS8uoAbOkd47pWqokOL2TJRaaO0RZ4vErlxn7PSA2f38LvJLS
         3BeANCJKUpLGFGHXTl00dBSpqKGlVFqoFaNOxXmuTg9tU6gDzjT2LypdvHms9WT4NBJn
         wMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693415259; x=1694020059;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/QyLvyKuwxXiEnwad4bzg5BcAD0WhpvsEjjdvqhUEc=;
        b=E1bKR23XrAyEpgJ2pP8QTtRqlgvLfyZ0+iZpcZsuEGFmcYahgvcx9HahTIfNSoibK9
         loEBDv24pNRSs9ZLMJap3rSuyy1cTB1cOpjJIMygVyAJOvXs3yQV7rEokJU454v9LjWq
         Ga7EmrESsYDe+/5dqqh+fZPxPfqVuFqIvvtJ9ceNV2sjTqx1d5rQsJOrHIKbaYSGerJq
         FnzPQt6FBHV/glEAh8pOSnLdNdu5Iew4891YLyRj9wpFI0ODJJtOUtj9netY8sCveprb
         2/x9Q1t/0j907FjnnFM38GgeW3/7caBgQzSO36wmBi8DNy0N7yFtq2dX3wBObyhL3Zuv
         HEQw==
X-Gm-Message-State: AOJu0YxN//Xe4szwjzFnhJHLTHlTnRuS9oXJ3HU1uxF+OUVfnGWsLKlG
        4eNP1akFblcsdbwSTqmurDudsYz0KzE=
X-Google-Smtp-Source: AGHT+IGb94m8s+MO6RY5T6Hp4RPsq0KRT6JAcybsCcXeVXx0rtM+D5yP25Z7yLuaZhpkCRvd0V6QcQ==
X-Received: by 2002:a81:4943:0:b0:584:6239:8f36 with SMTP id w64-20020a814943000000b0058462398f36mr2771728ywa.14.1693415258980;
        Wed, 30 Aug 2023 10:07:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i17-20020ac860d1000000b00405447ee5e8sm3811515qtm.55.2023.08.30.10.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 10:07:38 -0700 (PDT)
Message-ID: <95baa835-9940-a257-cf96-93c543aa389f@gmail.com>
Date:   Wed, 30 Aug 2023 10:07:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manuel Lauss <manuel.lauss@gmail.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20230828101149.146126827@linuxfoundation.org>
 <5b30ff73-46cb-1d1e-3823-f175dbfbd91b@roeck-us.net>
 <2023083014-barley-upscale-518e@gregkh>
 <64374066-4086-3e92-8650-ab1563350f0c@roeck-us.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <64374066-4086-3e92-8650-ab1563350f0c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Manuel,

On 8/30/23 09:01, Guenter Roeck wrote:
> On 8/30/23 03:52, Greg Kroah-Hartman wrote:
>> On Mon, Aug 28, 2023 at 09:42:11AM -0700, Guenter Roeck wrote:
>>> On 8/28/23 03:13, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 5.10.193 release.
>>>> There are 84 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
>>>> Anything received after that time might be too late.
>>>>
>>>
>>> FWIW, commit 619672bf2d04 ("MIPS: Alchemy: fix dbdma2") should be 
>>> reverted
>>> v5.10.y since it doesn't fix anything but breaks the build for 
>>> affected boards
>>> completely.
>>>
>>> arch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_source':
>>> arch/mips/alchemy/common/dbdma.c:632:14: error: 
>>> 'dma_default_coherent' undeclared
>>>
>>> There is no 'dma_default_coherent' in v5.10.y.
>>
>> But that was added in 5.10.185, from back in June.  What changed to
>> suddenly cause this to fail now?
>>
> 
> Nothing. I started to build this configuration and tracked down the
> problem after the build failure was reported by others. Sorry, I didn't
> initially realize that this is an old problem.

We could back port 6d4e9a8efe3d59f31367d79e970c2f328da139a4 ("driver 
core: lift dma_default_coherent into common code") but that won't work 
too well on 4.14 or 4.19. I believe it would be simpler to adjust the 
branches with this patch, Manuel does that work?

diff --git a/arch/mips/alchemy/common/dbdma.c 
b/arch/mips/alchemy/common/dbdma.c
index e9ee9ab90a0c..101cccfaf757 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
@@ -29,8 +29,6 @@
   *  675 Mass Ave, Cambridge, MA 02139, USA.
   *
   */
-
-#include <linux/dma-map-ops.h> /* for dma_default_coherent */
  #include <linux/init.h>
  #include <linux/kernel.h>
  #include <linux/slab.h>
@@ -38,6 +36,7 @@
  #include <linux/interrupt.h>
  #include <linux/export.h>
  #include <linux/syscore_ops.h>
+#include <asm/dma-coherence.h>
  #include <asm/mach-au1x00/au1000.h>
  #include <asm/mach-au1x00/au1xxx_dbdma.h>

@@ -626,10 +625,10 @@ u32 au1xxx_dbdma_put_source(u32 chanid, dma_addr_t 
buf, int nbytes, u32 flags)
         /*
          * There is an erratum on certain Au1200/Au1550 revisions that 
could
          * result in "stale" data being DMA'ed. It has to do with the snoop
-        * logic on the cache eviction buffer.  dma_default_coherent is set
-        * to false on these parts.
+        * logic on the cache eviction buffer.  coherentio is set
+        * to IO_COHERENCE_DISABLED on these parts.
          */
-       if (!dma_default_coherent)
+       if (coherentio == IO_COHERENCE_DISABLED)
                 dma_cache_wback_inv(KSEG0ADDR(buf), nbytes);
         dp->dscr_cmd0 |= DSCR_CMD0_V;   /* Let it rip */
         wmb(); /* drain writebuffer */
@@ -689,10 +688,10 @@ u32 au1xxx_dbdma_put_dest(u32 chanid, dma_addr_t 
buf, int nbytes, u32 flags)
         /*
          * There is an erratum on certain Au1200/Au1550 revisions that 
could
          * result in "stale" data being DMA'ed. It has to do with the snoop
-        * logic on the cache eviction buffer.  dma_default_coherent is set
-        * to false on these parts.
+        * logic on the cache eviction buffer.  coherentio is set
+        * to IO_COHERENCE_DISABLED on these parts.
          */
-       if (!dma_default_coherent)
+       if (coherentio == IO_COHERENCE_DISABLED)
                 dma_cache_inv(KSEG0ADDR(buf), nbytes);
         dp->dscr_cmd0 |= DSCR_CMD0_V;   /* Let it rip */
         wmb(); /* drain writebuffer */


-- 
Florian

