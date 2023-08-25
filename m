Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D99788314
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbjHYJJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236983AbjHYJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:09:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714881BCD;
        Fri, 25 Aug 2023 02:09:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so5994195e9.3;
        Fri, 25 Aug 2023 02:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692954552; x=1693559352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BlCKPb+gS/u8b2HNdafG02mmprfB5qP1z6F3xKmLKkc=;
        b=lyxwtosEE9udg9BUrGOeVC9n09rQIpZ8DTt9AoyUcY0b5Y92IIfHnNqAQWvxCwHxUk
         yVrNgSxXiRXv8tV43Qc9zyreubVDqRmDxm3E8xJzP85ZcDsSEAV/X3qd87sp4IhUfb2X
         JGlJ6IVHSnujSpAqjcacuvrwewTPdYrbjkl5vGLIjGKax3BZwfoNZXhHR5V1GK9PhT0c
         UZ09uZS7xA465aBMkiTjuFLBXKjlqUrZq77MfVntfSZ1+YRT6sI3G+U4tDoHGP+T+bR+
         5a2455/WmeoV9X6ZsZ9SRNgAMOeQB1ARBkld5qdl+2qbg066TzG7FLYOT7YoqYJC+O1Y
         LePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692954552; x=1693559352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlCKPb+gS/u8b2HNdafG02mmprfB5qP1z6F3xKmLKkc=;
        b=At1RLplda5VBHKGp0cPlI2+zL5qXv73irqDoSPPUDHJOdFy3Rra66So41NXj1tgQPv
         MPwrefe2bArq2UcjW1T2CIJR/kRBxulp/zUe0m++NFYeLYkG6XHleBhrv+mJVsQnEEmD
         tjakT3yW726+e2A+jlHvNDKCRJWch+BwBjGGLAoUYecj7jhLho6c3JgFv+kZC0bJLnLf
         Pj8NHZM6x6FfSQP6Tr9YT5mNv0KSNiUdYCtPg/2Dp1MZ9EdrW1tmLNnO1NjsJf4AYDYt
         ocsLEKdI/f8ceqibwvSmViO9vjCgZzYJgdKCPAa1ErNpZAIQW62iGTjvh8OYx3Dm0EKz
         8lHQ==
X-Gm-Message-State: AOJu0YxyWhJxmyfsRK3C4resy/Akt2kXZ/pkpiAVHby3/pewD5AnSUGi
        JYHU9hCEKK5r8cb0Yoh3uAg=
X-Google-Smtp-Source: AGHT+IEEvUTNIeIpX92kaNzNg6zFx0Ysh39VmTXqvkAAIcYoZFcL0Lm/wke4qo/TJ3e3dEM4nes60A==
X-Received: by 2002:a05:600c:2248:b0:3fe:2bb1:11ba with SMTP id a8-20020a05600c224800b003fe2bb111bamr14300392wmm.27.1692954551583;
        Fri, 25 Aug 2023 02:09:11 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id p18-20020a5d4e12000000b00317731a6e07sm1612026wrt.62.2023.08.25.02.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 02:09:11 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:09:09 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/139] 5.15.128-rc1 review
Message-ID: <ZOhvtS9fxHHLpZW3@debian>
References: <20230824145023.559380953@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824145023.559380953@linuxfoundation.org>
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

On Thu, Aug 24, 2023 at 04:48:43PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.128 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:49:55 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.3.1 20230625):
mips: 62 configs -> no failure
arm: 99 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/4793
[2]. https://openqa.qa.codethink.co.uk/tests/4794
[3]. https://openqa.qa.codethink.co.uk/tests/4784

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
