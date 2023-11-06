Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB727E2BBD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjKFSOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjKFSOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:14:36 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7E94
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 10:14:33 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5bcf83a8f6cso3638992a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 10:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699294473; x=1699899273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eApiH5er5Q+LmkTrIbz1RtOUAFBAp0J1EDavJZLMnI=;
        b=krBaCoSckOyvAbipWNHdVS3zSH4SyrmNET8GcmTvmgATO1k6/p1enb7pNcmnnxp+6y
         Rv32fo426D5zvLoY80WQDIw0JADBcDZ+kNYN5HLCZNxKrp0C0RPWySwgsNkZsaYemLlV
         PDAD893zQ52HJZGmFSDxCMTawcBp/2+TuH712758R4blSXfp6xeHF7EPCA51jXXiAgD8
         /iKHz4oYRSOoeoXjwcn/w8IkZOdBVUXo0wrrWZXgZLR7K661U2hGb37kAhLl9cuPWwMW
         WuRNX006NUs3AEFGHgAsPVua3FlJZHc2hXL2M+n8K8ystmBJnAj38IPPJQr++TA6u2WJ
         36xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699294473; x=1699899273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eApiH5er5Q+LmkTrIbz1RtOUAFBAp0J1EDavJZLMnI=;
        b=DTgvAzgKVpkWqr7VYs8KGvkLenqKJhEa7OFqnTi9NyVKOmBi+Y7bcV0JXxUZFP99g8
         k2jkN+ybm/LAUSxjDpoXvEqctJUELVR3ZdzPMKx9O+O0jVw+8PDUabkruHXF2+n5qDPM
         maFGP6GIiIh35tl35+v5wrI/C8UMwBlUvLLpwVWClU9XXoqjjTgYbgoXYH+nyl/suHOM
         Jw48CsAGPNQXX+GAWqxo46f6AhBA43I0WQc8z7sEW6UXYt7agtRIeSjmjJUbpMApt6wW
         gbT09N0a86obB2fHsRcCoJavIkLKjiW787/tZpkiMceJOE1h65WQL59Oey3mAbH1tB3t
         NzAg==
X-Gm-Message-State: AOJu0Yw4ChgSjt3DIzjlB+pVHdw5bUtcPke8PRavcaK4A/ffVD4krHLy
        vyyQmeaMKKLwlj/9gn2SiapPHugOEizccenG79YiaQ==
X-Google-Smtp-Source: AGHT+IFxo6QPh+LlR1UORVHDkuRmzt/uzetk8veCXwUog6IYZKml7Dzr0uG/OJNPi7jnuYHy2QaQxVRk5w1zTym/o8o=
X-Received: by 2002:a05:6a20:9188:b0:15e:a8:6bb4 with SMTP id
 v8-20020a056a20918800b0015e00a86bb4mr27161506pzd.8.1699294472848; Mon, 06 Nov
 2023 10:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20231106130304.678610325@linuxfoundation.org> <8aec1bd5-befc-486c-9e47-7571b937b8c7@linaro.org>
In-Reply-To: <8aec1bd5-befc-486c-9e47-7571b937b8c7@linaro.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Mon, 6 Nov 2023 12:14:21 -0600
Message-ID: <CAEUSe7_g2LbOkb6BqqdPha4SX4669O33H0a04sJ7AfbR1wfA_w@mail.gmail.com>
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, 6 Nov 2023 at 11:53, Daniel D=C3=ADaz <daniel.diaz@linaro.org> wrot=
e:
> On 06/11/23 7:03 a. m., Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.200 release.
> > There are 95 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.10.200-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.10.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> There seems to be a problem building for RISC-V with GCC 8, 12, and Clang=
 17. This is with defconfig, allnoconfig, tinyconfig:
>
> -----8<-----
> /builds/linux/drivers/irqchip/irq-riscv-intc.c: In function 'riscv_intc_i=
nit':
> /builds/linux/drivers/irqchip/irq-riscv-intc.c:119:17: error: implicit de=
claration of function 'fwnode_dev_initialized'; did you mean 'zone_is_initi=
alized'? [-Werror=3Dimplicit-function-declaration]
>    119 |                 fwnode_dev_initialized(of_fwnode_handle(node), t=
rue);
>        |                 ^~~~~~~~~~~~~~~~~~~~~~
>        |                 zone_is_initialized
> cc1: some warnings being treated as errors
> make[3]: *** [/builds/linux/scripts/Makefile.build:286: drivers/irqchip/i=
rq-riscv-intc.o] Error 1
> make[3]: Target '__build' not remade because of errors.
> make[2]: *** [/builds/linux/scripts/Makefile.build:503: drivers/irqchip] =
Error 2
> make[2]: Target '__build' not remade because of errors.
> make[1]: *** [/builds/linux/Makefile:1832: drivers] Error 2
> make[1]: Target '__all' not remade because of errors.
> make: *** [Makefile:192: __sub-make] Error 2
> make: Target '__all' not remade because of errors.
> ----->8-----
>
> Currently bisecting.

-----8<-----
Bisection done!
First commit presenting NEW behaviour: 6751b1fbf98ba2c40bbdda22e2e6714a9c27=
b91b

commit 6751b1fbf98ba2c40bbdda22e2e6714a9c27b91b
Author: Anup Patel <apatel@ventanamicro.com>
Date:   Tue Oct 3 10:13:51 2023 +0530

    irqchip/riscv-intc: Mark all INTC nodes as initialized

    [ Upstream commit e13cd66bd821be417c498a34928652db4ac6b436 ]
----->8-----

Reverting that commit makes the build happy again.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
