Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E494B7F8244
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345922AbjKXTF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjKXTF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:05:57 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5590D2D64
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:06:00 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4ac1988ca66so1206921e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700852759; x=1701457559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNyfHMRrBzIt574Bt9GDCoLKWnWTa1vAH4W/mLYLces=;
        b=mN0Tsh3/XHYL1XKmGy0x6MsXPgIJ7gy3XSWbEF6OOXa8gtc5zQmYRZQkJyv7R8tvRH
         /ILNU5zDg4se6Njd7GigErtLRLlguXSyQEBmSbtm8WDSUOb+Y3ySwHn5JSfJ8tVBEcb+
         4GYg6S2WeuKjeFx20rCkZQ8KHP4Xp2EzOjWCDQKkh29S7TIuXmZUW47+SmX73yKv+E5O
         EopplRtHh6vPkniijB/CT5KM1fMtP1dLN7Z1/yXOVzNrukK/YmyU7VKcRi7ndZeSSL0M
         eT0pUfx5u+JcqJkAI8I17rHwXzmJqalO9OJ25W1vla860ol0vmsvgjBw/eIB3IXse9Ha
         +ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700852759; x=1701457559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNyfHMRrBzIt574Bt9GDCoLKWnWTa1vAH4W/mLYLces=;
        b=IVKD6V08ENUy0isKiPMAfzBDhjDL7mlNDr2cNbCNegqrDt80dPzo57B/ik7U0ecSB3
         bg6DenSJl6yKmcCwram9c6IqG2UB1p+6uqnDiSPbOKcZ2ZwL0opFd2XtBGSspE7NJ211
         I/6x0+vpkSuRll2Ds+KxlmANAdmJvoSPA7kUDaT8nbF6eZyq2hv1lIT9stAvTzFqy/E0
         oeQWKIDli2+uycQCZCVf1tl2VWeZx2ytIjFCaSFuK+CqFbSVrhGSEJbFRgFz95Q5PEwP
         VDLb4GXPGXnRl+wPgULTJLYkzuFRfwB6R0RRQk3hDAG4/cBFQaH1TggovKROwaFNC51/
         ABjA==
X-Gm-Message-State: AOJu0YzCw89d9cr8W/d8d2Ug9K6mtgisO+mrJZBJEBOEV94D55LMCaXR
        x/pCXPwA7S7/BuZc3YOGb/amFf/moV0rIX9BGo2UMg==
X-Google-Smtp-Source: AGHT+IGgEKPztEosXm9/H1kGq+JZEFdW00hbUz3Qf/fuM0hwoW0eNL4uztgDJFSz9DPS80w+JweeHhkk5qO8D0/fxFk=
X-Received: by 2002:a1f:4845:0:b0:49a:9855:2fbb with SMTP id
 v66-20020a1f4845000000b0049a98552fbbmr4456731vka.5.1700852759253; Fri, 24 Nov
 2023 11:05:59 -0800 (PST)
MIME-Version: 1.0
References: <20231124172028.107505484@linuxfoundation.org>
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 25 Nov 2023 00:35:47 +0530
Message-ID: <CA+G9fYtrUpJ_+-k6dBaX0yZX-dkkrz3Qg-1FRwkG83pZvN44ow@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/530] 6.6.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2023 at 23:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 530 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h



> Zhen Lei <thunder.leizhen@huawei.com>
>     rcu: Dump memory object info if callback function is invalid


Following build warnings / errors noticed while building the
arm64 tinyconfig on stable-rc linux-6.6.y.


kernel/rcu/update.c:49:
kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
kernel/rcu/rcu.h:255:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  255 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors


rcu: Dump memory object info if callback function is invalid
[ Upstream commit 2cbc482d325ee58001472c4359b311958c4efdd1 ]

Steps to reproduce:
$ tuxmake --runtime podman --target-arch arm64 --toolchain gcc-11
--kconfig tinyconfig config debugkernel dtbs kernel modules xipkernel

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Links:
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2YdN5Tb5NAFPo7H9WWQd0APrWu1/


--
Linaro LKFT
https://lkft.linaro.org
