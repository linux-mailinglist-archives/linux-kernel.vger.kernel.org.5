Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E8A7853B4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 11:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjHWJUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 05:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235423AbjHWJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 05:16:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475F819A1;
        Wed, 23 Aug 2023 01:54:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c3df710bdso2728115f8f.1;
        Wed, 23 Aug 2023 01:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692780888; x=1693385688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BswGZjQLEAdts40JO7B/IE0p4jIiLic8b6XiJmbSSU8=;
        b=fSDE82jP59sJAPSRXKdVYg+WN0BbOPfp5i6NmlFjJHRaIR2z8gNl1IglMyTOPoxE27
         Vt+0l+NBoMOv86vUwP/7EoYCQms98lAL1tRcuBiQ4QTYcnx9dVMaZjCaWj+14ZshJNbH
         uucTDRizEa5zYS8htbqqor/8rJZwTyGU32tZ9NPQtgdODGCfleKYL2HtVC9fzFYtgnl0
         9iqGKmAmP6/tqCb9O/E+Y11GziSbDd2FraZgxDYPlXsyWgGj2CSX1mcWZy5HYOvfLDPH
         +vVrkcLFEKn8Wx9HDs8jJKVZ3pHarNx1ufz6NqtIzsltmt4m4wZTXEAtwvx43opoHh6e
         wY2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780888; x=1693385688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BswGZjQLEAdts40JO7B/IE0p4jIiLic8b6XiJmbSSU8=;
        b=N8gucg4IjGEvN9+VTIGt86OuWsauFIT/MO4hMqmdSkVnf6qaPWiJvKKpLUB9TCezt2
         g00khd61xkyPbVoMq2Aalr+H+06NH0is4Yw9w8qb21pEti27MfRqxUeSdZ8VvU8AvQZf
         P/WHgf5tH4zeJS4eqemsvk1iNc8AycsqHsefqY1E2Aydhbx/TN3CJQ+mfK7Wnwp8LM8/
         okv0BFoJM5ie5kLfiy3Od7dwufIvtPULcbxbn5EEhfwZ1FjUzu7xsDV6/pDydkigGLFn
         4NwGlMXvW7ai91GPfgRUkjqvP2eOJSztoxQMYMMSFZ5laSG71f7CfdA+X0SdP77AQ2HH
         841w==
X-Gm-Message-State: AOJu0YxKrz2Dh0sq4OKdVjnjg84uR48sC/hCe5817BIPM5wCbB/tqS/p
        ttZsswoIm7A6gyBUt2il/to=
X-Google-Smtp-Source: AGHT+IHQjqP4ss6RAjHKdp48XvlaiwLE59zsm0ttZMacwSKYnoz7zPhcE40z1lNftwIMZWc/LGZyUg==
X-Received: by 2002:adf:facd:0:b0:314:3ad6:2327 with SMTP id a13-20020adffacd000000b003143ad62327mr8096342wrs.12.1692780887797;
        Wed, 23 Aug 2023 01:54:47 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d49ca000000b0031ad2f9269dsm18179338wrs.40.2023.08.23.01.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:54:47 -0700 (PDT)
Date:   Wed, 23 Aug 2023 09:54:45 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <ZOXJVamgYV1Mb+7S@debian>
References: <20230821194122.695845670@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.47 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.3.1 20230625):
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
x86_64: Booted on my test laptop. Warning on boot, already reported by others.
x86_64: Booted on qemu. Warning on boot, already reported by others. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/4765
[2]. https://openqa.qa.codethink.co.uk/tests/4773
[3]. https://openqa.qa.codethink.co.uk/tests/4772

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
