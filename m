Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7E77D4AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJXIv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjJXIvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:51:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D62110;
        Tue, 24 Oct 2023 01:51:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-408382da7f0so34818945e9.0;
        Tue, 24 Oct 2023 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698137481; x=1698742281; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AeBNyWOSZJ4kGFSxFtfrCpSWWHWhFOJFGqG73cu2x9o=;
        b=P2m0Tz/n+KLlaaPmPUPS2SLROWU+/o5pG1KlcmsrSV8Zhom7X2LaSZmXr8Z19pBJfy
         VU1uokbe49Oxns1u/l8nPoGu3P6kAmeC++9NoqH08W0XS0YlB6eVYYuo2prV0UvR0MVD
         GNGjaxyc+QQr2llvnrTi6J2XeRW2iqZIzdA12mn1hg04CAyKJY0ML4nZYXfWz8tqiwHH
         ggP8+/SA707OJ/mUOji/oJwofHl+AORWSBEsMB0RFD9fI/0+yvgaKcPEVWj4KOMGB/Bl
         2LrIf+2E3UNCAGFNMxl0SN0LWjbjX2R80pX96UKzNTZmrg5tvZT0YXIqJGKaxn2rT2So
         myrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137481; x=1698742281;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeBNyWOSZJ4kGFSxFtfrCpSWWHWhFOJFGqG73cu2x9o=;
        b=sSPW4Rkq40OcZ5QHJ2iPQN12QBHx+xMcnXLqx+t65QetDRwD84k7uLWZRJ9ajAZPWN
         aNBIAlF5Ej1fsZAczH53Af621QhDnPsuNwVW5F4rPZxRBKqvrOw0ihWD6ER9JoowLnvv
         gDjyeBzTaTv8+7avBXszi+HozewRD8e4Cp3/Zhgn0nqO2Y1YvKo0RSN3b2isysbV2vH6
         q4QlZHBKyRmAYGL49T81iMRP+gFXeoaH/Fj744KFWGimpstYbDNDbO0B+FpDFNvcPpwb
         v93aLtSldVamO16iKMTWtyCq01LGLog6I6XebF0UyE98zcvF99YB7eJmquUTbVHLBtYT
         CVfA==
X-Gm-Message-State: AOJu0YyH/O4tP8XCejU+BTWztsobw2zfwg9k0qB5vDuz1ftjTmdGw4KN
        bTlS5sdTVtvTsmfRaNbRvJI=
X-Google-Smtp-Source: AGHT+IE9w6D63XEl5hV9qFn78ltfdOdyg1FtcX+URY3X/3j2HmjScxhbqOllBeM708t69ULHBZJXfQ==
X-Received: by 2002:a05:600c:3d87:b0:3fe:1232:93fa with SMTP id bi7-20020a05600c3d8700b003fe123293famr9195220wmb.22.1698137481203;
        Tue, 24 Oct 2023 01:51:21 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id i18-20020a05600c481200b00407b93d8085sm15948043wmo.27.2023.10.24.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:51:20 -0700 (PDT)
Date:   Tue, 24 Oct 2023 09:51:19 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/196] 6.1.60-rc1 review
Message-ID: <ZTeFh0eCFm-F4A1s@debian>
References: <20231023104828.488041585@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 23, 2023 at 12:54:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.60 release.
> There are 196 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.

Build test (gcc version 13.2.1 20230827):
mips: 52 configs -> no failure
arm: 100 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/5361
[2]. https://openqa.qa.codethink.co.uk/tests/5363
[3]. https://openqa.qa.codethink.co.uk/tests/5372

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
