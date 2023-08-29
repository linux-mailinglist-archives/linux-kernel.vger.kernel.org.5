Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247FE78C349
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjH2L1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjH2L0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:26:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096ED113;
        Tue, 29 Aug 2023 04:26:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bceb02fd2bso62872681fa.1;
        Tue, 29 Aug 2023 04:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693308404; x=1693913204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufSg9Xoj+x6gy61mYl0sxgKzEfU/wHkCsoLIIIpLSCo=;
        b=NPDHY7/JjnhmasNoj/YgiopaMT39cypdrWk03wl4/c+WW54646al81e3krE5eaRg2m
         ZMIdtjLhgQtBoh/f+WvT/FsT3XtM85dCXqxN1L4NeZ6zw8AltYfUMQNlSny41GK9rrkU
         xVLIGiiLU21RqmqZZwGdpREEerIIEJKbf6lZ+r/lTSKiBifzgwXnWvpsPh7BP5P0Tq0S
         6qrWkluemXez4hvzPvuuN9Kkl1zLs1cwo56o5wHRxygpcj7nFboCePBKtxxrjOs7d2Qc
         KgzZnu5Ifs9hKBOaZCifP+icVgNXNXtU53/g2mOnmUagp8ui0/gcc9pgmBt7ULBoqkWP
         oIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693308404; x=1693913204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufSg9Xoj+x6gy61mYl0sxgKzEfU/wHkCsoLIIIpLSCo=;
        b=g3ULyqUF5eyDOKYIUj3Tc+2L7gR4CcmsxLYXC+tcugHIHj0j4GtZfuTYhZCHNq5BbA
         KTWXapmxBcbFzqHDKrIjulPyDjzPAWHwZa0uLknwUE2spQEmW9X2icPaxQ4eekVM2/tB
         l0+L8dJC3bqzBktD/IJL8eeekEZot1tG+K7thHzYQlYmXasDNz2ua9ZqNFhQJweL/ZYS
         GGgBLsUtfkx15I5+4+G2hWHopmHrxp3j8maO6yz8A0SZZ4Eskw04LfWusY3hXukwjLUd
         cqhfQhfi99Q3rt+7jrA/wElZWY7sVW8wxcKaVI3Gw58bkfpEDJk8cyGQUDv0ugOMJD0P
         8O7w==
X-Gm-Message-State: AOJu0YzBTUR5byeGlVmIMaQ3Q//PTt1MkK0dZHzH+5eukUFCaHjABJUi
        Zk6FcdXin0Hzwl+9Uke4Tao=
X-Google-Smtp-Source: AGHT+IHx80hDPLDi3mPvKofK76yE9I19hj/tEJYW34QX0/Hoy6KPfeifJcRu1buiS8wq0nTq1VdzBw==
X-Received: by 2002:a2e:3607:0:b0:2b6:de52:357 with SMTP id d7-20020a2e3607000000b002b6de520357mr20322457lja.40.1693308403970;
        Tue, 29 Aug 2023 04:26:43 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id g12-20020a7bc4cc000000b003fed8e12d62sm13741408wmk.27.2023.08.29.04.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 04:26:43 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:26:41 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 000/129] 4.19.293-rc1 review
Message-ID: <ZO3V8apl4EtNq0FX@debian>
References: <20230828101153.030066927@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 12:11:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.293 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.4.1 20230829):
mips: 63 configs -> 4  failures
arm: 115 configs -> 4 failures
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Note:
1. mips builds are failing with the error:

arch/mips/alchemy/common/dbdma.c:33:10: fatal error: linux/dma-map-ops.h: No such file or directory
   33 | #include <linux/dma-map-ops.h> /* for dma_default_coherent */
      |          ^~~~~~~~~~~~~~~~~~~~~


2. arm builds are failing with the error:

arm allmodconfig, multi_v7_defconfig and omap2plus_defconfig:

drivers/bus/ti-sysc.c: In function 'sysc_reset':
drivers/bus/ti-sysc.c:982:15: error: implicit declaration of function 'sysc_read_sysconfig' [-Werror=implicit-function-declaration]
  982 |         val = sysc_read_sysconfig(ddata);
      |               ^~~~~~~~~~~~~~~~~~~


arm ep93xx_defconfig:

arch/arm/mach-ep93xx/timer-ep93xx.c:12:10: fatal error: platform.h: No such file or directory
   12 | #include "platform.h"
      |          ^~~~~~~~~~~~


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/4857


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
