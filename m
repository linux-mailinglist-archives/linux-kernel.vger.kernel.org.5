Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC4788301
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 11:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbjHYJHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 05:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244194AbjHYJGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 05:06:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664942107;
        Fri, 25 Aug 2023 02:06:30 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fee769fcc3so5708045e9.2;
        Fri, 25 Aug 2023 02:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692954388; x=1693559188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i2nKk0BPW5aUoC/i6MdosDErp4K/kH35/8TD8Z/46T0=;
        b=Mo8NvNjeDv9g2VTAEOh4XIAzg2uJ1V203fkY6ENjtVIxmU5nGuSgy3ZwVrcyb6gPGt
         LBBjsiJxkeDECuqgMwMFkqBleQhit2sWEN8Q/XSBs99SM9I3fZrV5OEwLO+Z8GOnTa4w
         wvb4f0qw58DgYTYS8PS7kWtKG9W5Kf9yzMu5hH20N3hWqFl58hV/Mk7nDKtlt07Wli4j
         /J/2767vnf5Fd2HXPfhfNV3q99u2yCUvKBnGS1IY5xrOPe/8TcDpF3sj6dNW0XPQVdeE
         5qPMsAdQK5cSb6FpO/KKt3Rvq8DJ9DPAzKfhfeoiu9NfG1iAAMcJ7Qco02CN0mv9GXKB
         Db6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692954388; x=1693559188;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2nKk0BPW5aUoC/i6MdosDErp4K/kH35/8TD8Z/46T0=;
        b=HSdqYM+M4CUaJWasFlYEDwFgNiYGMgyff4clL8QIgxsR+WdEGMGIKtX27AP9BzHQPm
         g7C5ArHOS3wtMGjruMAJ/RImFPQJEhwzz1ire8I03aeoUbEAihsXIsh5snRk0EBjIa+m
         riRiY/KxM1IoPl3nNvFipD9svPrhvAfMuGAWcXd7w08TM4m5QywJUeEHXmkf6UcUDPjy
         1LRarJVKteD74nO7timh1uj+8PefdwKBlLycevvosHXyY56i0BhI4gEfDtCdqrR92zq0
         4oIQEL1CVKjyCxZA1USTbVdtvm7zLAUvgW+Xje7lEzvGvU5SljCTxHpSswXe7lUykUCX
         /NCQ==
X-Gm-Message-State: AOJu0Yy0c3W7ofByg3E4lAAPziI7iEyKebOsvcwSc+nmx0PY5KaSzY1g
        Rx6N4Ot0z8c7b5JRVDEkBJ/LVHDMLXk=
X-Google-Smtp-Source: AGHT+IFTRtpEgC1Fn8L6CBbV15hUqmulfli94PdQ6IwRK9ygLGLRHNz2ursxx5+h4i8bd/yOWGiN9g==
X-Received: by 2002:adf:fc09:0:b0:31c:6476:b730 with SMTP id i9-20020adffc09000000b0031c6476b730mr7191600wrr.68.1692954388265;
        Fri, 25 Aug 2023 02:06:28 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d5090000000b0031432f1528csm1623492wrt.45.2023.08.25.02.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 02:06:27 -0700 (PDT)
Date:   Fri, 25 Aug 2023 10:06:26 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
Message-ID: <ZOhvEoeysXR+4tGj@debian>
References: <20230824170617.074557800@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Aug 24, 2023 at 07:07:52PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.192 release.
> There are 135 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.4.1 20230625):
mips: 63 configs -> 3 failures
arm: 104 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Note:

mips db1xxx_defconfig, gpr_defconfig and mtx1_defconfig failed to build:

rch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_source':
arch/mips/alchemy/common/dbdma.c:632:14: error: 'dma_default_coherent' undeclared (first use in this function); did you mean 'dma_free_coherent'?
  632 |         if (!dma_default_coherent)
      |              ^~~~~~~~~~~~~~~~~~~~
      |              dma_free_coherent
arch/mips/alchemy/common/dbdma.c:632:14: note: each undeclared identifier is reported only once for each function it appears in
arch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_dest':
arch/mips/alchemy/common/dbdma.c:695:14: error: 'dma_default_coherent' undeclared (first use in this function); did you mean 'dma_free_coherent'?
  695 |         if (!dma_default_coherent)
      |              ^~~~~~~~~~~~~~~~~~~~
      |              dma_free_coherent


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/4779
[2]. https://openqa.qa.codethink.co.uk/tests/4780


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

--  
Regards
Sudip
