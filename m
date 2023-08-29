Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9763078C38B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbjH2Lnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjH2LnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:43:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C6A7CDF;
        Tue, 29 Aug 2023 04:42:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fee8af9cb9so39982095e9.1;
        Tue, 29 Aug 2023 04:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693309375; x=1693914175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DUFgkWgRGJdQGLH7OwNpWHqQKyvcDuixCo9WMkNHlOw=;
        b=Je4fBGHd6zZykC2QDsb2KPelhvWoDyDhy4FR48JVGqMDhTJdQnDEb5GlVxG96AYmpR
         GJuw2fG98I3mWOQnTuxP9e/h8Hbmg43A/oJVeFXriViiWXQukTOyj1JqgugU6pwOaioe
         yytdh0P7aQCVOwK/JAMuAZ2IQz/LgM6Ta9zk2jr1FYp7kNh1hWUSch36TVQvdMQuDW7s
         NOvbLl2mVqfFTeedSOYcyIB5pJyqcawZYQCpkCGCmzlsjizSHRfCbNv/gM1zSptpWMtA
         wnfr5vrHyoU4mN2jA2kNoN/lGpfe9n373A7iBjKDjR4J0aFF6NMs+YAcsG2U9lBcPJjG
         N81A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309375; x=1693914175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUFgkWgRGJdQGLH7OwNpWHqQKyvcDuixCo9WMkNHlOw=;
        b=fzsa6X2tdQXQB7KXVZUB9kwy+eGUduYgeXvm4awRGoYhb1XpIKMy+al5w/HqJjjcx7
         sz5Oq2eb3g8YN8bpblhRE6jqkXDMXs49fNrTOUYMJ8S4j0QH1Bfr6VoHB86MLEUcXaAX
         xb1N38OD5pD1SjEbbcX4HY/9PGHGGA2BqiI8FPrzeUaMD6blDOtNVcuDln8uUq7ILREA
         sMAAij4YKZanzcHwLvPNRrtaMzboPIbxLK7AzkAkFusF+v6JkWgoGNQXqvK987CbDXs+
         kwyOxBL/AjoF2V9OuSv2+MYB4zfXwk6zZXMH5Rsg+43602rO5Xuy1k8CFMkTghpM+NDM
         w9Xg==
X-Gm-Message-State: AOJu0Yz9y1pAMp44nJMMwUzyBYZGaZX4H+GQpb0hf7nZtrAfMLX0CUfw
        r3waeB7iwfUrTx1BuPqNADo=
X-Google-Smtp-Source: AGHT+IFWrmVRduvT1XLhQ4gyTPLnyZUQiknaD0axW2HfQCI9n21Rc1x68Mm+QuGe9Mtu3slHLukl9w==
X-Received: by 2002:a05:600c:2993:b0:400:57d1:491b with SMTP id r19-20020a05600c299300b0040057d1491bmr12757073wmd.2.1693309375326;
        Tue, 29 Aug 2023 04:42:55 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q20-20020a7bce94000000b003fedcd02e2asm13718105wmj.35.2023.08.29.04.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 04:42:54 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:42:53 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/84] 5.10.193-rc1 review
Message-ID: <ZO3ZvTOwn0dS0IcQ@debian>
References: <20230828101149.146126827@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101149.146126827@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 12:13:17PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.193 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.4.1 20230629):
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

mips builds are failing with the error:

arch/mips/alchemy/common/dbdma.c: In function 'au1xxx_dbdma_put_source':
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

[1]. https://openqa.qa.codethink.co.uk/tests/4838
[2]. https://openqa.qa.codethink.co.uk/tests/4858


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
