Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFAEE78FA8F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348757AbjIAJTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjIAJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:19:00 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250410F0;
        Fri,  1 Sep 2023 02:18:56 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso30947651fa.3;
        Fri, 01 Sep 2023 02:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693559934; x=1694164734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6+njEKjcTP+ez0Q2gzhNZpFi7MIABKKwCebuyo0ubII=;
        b=EerHLrWb8S/lDLorxTuK7eIAb98bkkkjlY2+7F7xQC8+vYFi8cFFHXRPWbVbQ8JU4I
         bl0LVtaZOFCpLorD39Wk9cQxBOR9WM+zCKKh4otGRHiQgXolyqkCz8tEiKY7jinyCSKK
         DYa8aMFMUvnuvPEgHULLlzNjgqqzs1QrWlUA59n1i3fiA/8BC0Zw0DKELDCBfJ7T4NVK
         E1aZjyUGyUJlFd+4X8g3hdOxrJ/XbbnXIGPuhnxVERZpW8ohzH4rRi1ezFbHi2kBIxf+
         9s8+mXhGe09t8s4PjH8Jvp9yFgvT/C0m75HLJ1oOSCFP9zHGqhvobCh4OI8L5ZyrTgN6
         dtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693559934; x=1694164734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+njEKjcTP+ez0Q2gzhNZpFi7MIABKKwCebuyo0ubII=;
        b=kuRCbU2wGtikDRHC2sP4E8Gyf0OxtdSnNOaxEbrGWr/ncqBV+5vZwtihpf4Ij7owya
         VvCeW4f3Oim3yOnooJEBM4PP719XFsYjoxLGU82ua+uWPgCqbz6TifwdGoNAsJHQhNQy
         DIjlguhrDq5MjFFxaJmbWEmVUfOL5EX4ot5cboF9bmlI6X7ssDCKZviDRRIXNMOoSAPx
         0WyHBM9mqopZQS0lF7srWZp8rcamCG5kFNFfm3Uzx6inqjQULonbT5KbOEh5P5x6ax7w
         VwbiPvo60w4EKg4VIbGPxFMzmby8YKa0copU8/wHOB5ft28gReUeySpMi5l6lVSmnzob
         mThw==
X-Gm-Message-State: AOJu0Yw9QIPhwrdmkt36V9Aj/6F2EXcF4KEqk5pvZ44uQHVBgkbqtej9
        Fc9H1Ast1TnE3+rK0yW57Q4=
X-Google-Smtp-Source: AGHT+IEuuUVNlcvvZD9+UdKgZYWHNdlT09FhxxgTeD7XtEa6nwx5c8AdfbirneV7j47yNV+2pin8DQ==
X-Received: by 2002:a2e:a0c3:0:b0:2b5:bc27:d6eb with SMTP id f3-20020a2ea0c3000000b002b5bc27d6ebmr1131010ljm.8.1693559933940;
        Fri, 01 Sep 2023 02:18:53 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id y11-20020a1c4b0b000000b003fe2b081661sm7368206wma.30.2023.09.01.02.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:18:53 -0700 (PDT)
Date:   Fri, 1 Sep 2023 10:18:51 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 0/2] 4.19.294-rc2 review
Message-ID: <ZPGse1U/KfXLI+q3@debian>
References: <20230831172214.759342877@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831172214.759342877@linuxfoundation.org>
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

On Thu, Aug 31, 2023 at 07:30:20PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.294 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 17:22:08 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.4.1 20230829):
mips: 63 configs -> no  failure
arm: 115 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/4879


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
