Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D84878556D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjHWKcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjHWKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:32:29 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DD8CD5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:32:26 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44ac60aa8f7so2219059137.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692786746; x=1693391546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ThXAIByqVCkfjwracUVqooFzKpe/zsTo3REPCd68fCI=;
        b=IVnpF8gxq8Txsumh4crzwz78XaQgk13drDB1Yzp+MPPMJlAC7Lo8gprin2HuS7yhv/
         5gpJJClDCKpZxseorxCy/Zo0imkzlGpiC7iXWuXlh2xqfhRp53DIEx4MECW34K37XzRi
         zxxbEt+02rGrTCyG6cf8ztdL7DplQP7qodl2LfANPkLvCnHW6pbgl8ppv2f4GMnB4Ljy
         mpRtF86GyF0l7IOD8GXxWkuC8XVXK7bObya7XA+OVCKpiFy+hcEaTtD14RfjCXXZf1FG
         YLFeIi/09zIyuVrLditZbbOBX1hT88Eu2rY5azMlXzIdPdTNswARSpeBNVM9exV2L7Xa
         fVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692786746; x=1693391546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ThXAIByqVCkfjwracUVqooFzKpe/zsTo3REPCd68fCI=;
        b=dDgXx31yd5ORHb1J5+6pR0dEMfr5hSGwSzzCy5kTzYlWqvtKvXlP8H6t9qF/+sTkOY
         rVmtfKH5vArGouKcvm9gGDQh3I+WcRb763kO38cjwNR9ppOwweuJdhiM5mZZKZ7Nd78T
         HWmeOYZ0SxpyVSObHWSUuuISEsHUjXziTIv/XaJkCSjWBXQzqRv0ahymIhmgL6a4bFlk
         b0Uu6PsXuAi1B3l0u03HekIWGoLXfSXzd63D9qx97XqcdpKFCtsFSDjH25/mWBSZOwAR
         nia1nxp+ImysovVxXcFLx9mMaAm6hjAOVIKKCsrPFEv4DicWrL/CoS0UGH4mldDtujOH
         zXGA==
X-Gm-Message-State: AOJu0YzObRADSvdFaSQnHbSkZ/Wx6ZNViGjSfOJSxBw5m9UyIJ0y6TKW
        mikdzSDAQjP4J7HCvjQ0r9x7YsuyRM0aaoZp85EwJw==
X-Google-Smtp-Source: AGHT+IFXiNEHNeIm0I6eRoH5Vo6bgJn8WN/p5jAXu3EpULJukA2e8vxhilxq9z+tgd0mxAZLPhg27qavDJr0SIbrQWI=
X-Received: by 2002:a67:fb0a:0:b0:443:4e7d:c8db with SMTP id
 d10-20020a67fb0a000000b004434e7dc8dbmr10239104vsr.2.1692786745997; Wed, 23
 Aug 2023 03:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194122.695845670@linuxfoundation.org> <ZOXJVamgYV1Mb+7S@debian>
 <2023082303-musky-plastic-335f@gregkh>
In-Reply-To: <2023082303-musky-plastic-335f@gregkh>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 23 Aug 2023 16:02:14 +0530
Message-ID: <CA+G9fYvm-7DPuA9kAF3784DpW4BmAXa_+_NW3AP_919_UND5-Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug 2023 at 14:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Aug 23, 2023 at 09:54:45AM +0100, Sudip Mukherjee (Codethink) wrote:
> > Hi Greg,
> >
> > On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.47 release.
> > > There are 194 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > > Anything received after that time might be too late.
> >
> > Build test (gcc version 12.3.1 20230625):
> > mips: 52 configs -> no failure
> > arm: 100 configs -> no failure
> > arm64: 3 configs -> no failure
> > x86_64: 4 configs -> no failure
> > alpha allmodconfig -> no failure
> > csky allmodconfig -> no failure
> > powerpc allmodconfig -> no failure
> > riscv allmodconfig -> no failure
> > s390 allmodconfig -> no failure
> > xtensa allmodconfig -> no failure
> >
> > Boot test:
> > x86_64: Booted on my test laptop. Warning on boot, already reported by others.
> > x86_64: Booted on qemu. Warning on boot, already reported by others. [1]
> > arm64: Booted on rpi4b (4GB model). No regression. [2]
> > mips: Booted on ci20 board. No regression. [3]
> >
> > [1]. https://openqa.qa.codethink.co.uk/tests/4765
> > [2]. https://openqa.qa.codethink.co.uk/tests/4773
> > [3]. https://openqa.qa.codethink.co.uk/tests/4772
> >
> > Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> >
> > --
> > Regards
> > Sudip
>
> One question about the warning on boot, all still works afterward,
> right?  Or does the system not work?

The warning while booting and root login successful and
LTP and other test runs are successful.

- Naresh
