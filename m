Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCF676C5B0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjHBGv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbjHBGvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:51:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD2530C7;
        Tue,  1 Aug 2023 23:50:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E75F617F5;
        Wed,  2 Aug 2023 06:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBD5C433C7;
        Wed,  2 Aug 2023 06:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690959054;
        bh=kA6LMeMa5KWRXjA4E8xeiCqx2O/5yf0NT93jEs4o2gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wkhzKWPyWi+DmqzYYFnOGjY59X9M0Yn+CWLhHo9O47R1POH9UoojuU26yWNE1musW
         /dkzDSDBGFJ+KCqv6kmLLgRwoNC00YMKpHQ/Rr5LLFrI/sAzhsSvs63VCZsjgsO4v4
         OXX9SEfohahWhrtMDq6zCwlmC4a5LaxJrO8zZ5d4=
Date:   Wed, 2 Aug 2023 08:50:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.15 000/155] 5.15.124-rc1 review
Message-ID: <2023080219-starlight-entryway-0203@gregkh>
References: <20230801091910.165050260@linuxfoundation.org>
 <CA+G9fYtCYSQ2fzmJU0t7ZCOUWjeRp9+Dn3gJ=4oRJP_CJttOcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtCYSQ2fzmJU0t7ZCOUWjeRp9+Dn3gJ=4oRJP_CJttOcw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 07:27:03AM +0530, Naresh Kamboju wrote:
> On Tue, 1 Aug 2023 at 14:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.15.124 release.
> > There are 155 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.124-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Following patch caused build regression on stable-rc 5.15 and stable-rc 6.1,
> 
> Regressions found on arm:
> 
>   - build/gcc-12-orion5x_defconfig
>   - build/clang-nightly-orion5x_defconfig
>   - build/gcc-8-orion5x_defconfig
>   - build/clang-16-orion5x_defconfig
> 
> gpio: mvebu: Make use of devm_pwmchip_add
> [ Upstream commit 1945063eb59e64d2919cb14d54d081476d9e53bb ]
> 
> Build log:
> ------
> drivers/gpio/gpio-mvebu.c: In function 'mvebu_pwm_probe':
> drivers/gpio/gpio-mvebu.c:877:16: error: implicit declaration of
> function 'devm_pwmchip_add'; did you mean 'pwmchip_add'?
> [-Werror=implicit-function-declaration]
>   877 |         return devm_pwmchip_add(dev, &mvpwm->chip);
>       |                ^~~~~~~~~~~~~~~~
>       |                pwmchip_add
> cc1: some warnings being treated as errors
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Ah, looks like 88da4e811311 ("pwm: Add a stub for devm_pwmchip_add()")
is needed, I'll queue that up for 5.15 and 6.1 and push out new -rc
releases.

thanks,

greg k-h
