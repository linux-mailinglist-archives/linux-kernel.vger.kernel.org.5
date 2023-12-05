Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6DA9806081
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 22:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345714AbjLEVOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 16:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345687AbjLEVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 16:14:30 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E35FA5;
        Tue,  5 Dec 2023 13:14:37 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-46484f37549so921894137.1;
        Tue, 05 Dec 2023 13:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701810876; x=1702415676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o/ZBnlG/4O4Nf+VPlwuFFktfrixZ06nlRki7xqoRblk=;
        b=GYT/KKJVsldVVmuE+K7d+Rvz2XW68JMPTmSbgg4LCyDwiK9NkMkm7fYBcG0LFlT4A7
         Lo9tQjmpr/vI7P11HLw1Oak9h1j5rGZwk7NKp7RwS9H6RAIh6pkboVZcx/gqnPKQmcKA
         lVH5TctWJrVpNbal4p3tHDaKJhJpscqHTJnYo0jK1uuy79yaVw6fZPNjgCU2IIprd8n/
         P2dtiZ6uZ87m0tq+b8rd3IQ63F18ms5vAOeSGIeDkzZZgz6LS/Jb0iEGZP/jyroskryO
         p8rP6MQX2AJE4Rf6bazdCd35P9HZHpAvU61yTp5x2WK+FMaKgdLZW2p0vDAqm4H1FvVm
         diMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701810876; x=1702415676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o/ZBnlG/4O4Nf+VPlwuFFktfrixZ06nlRki7xqoRblk=;
        b=CAp4xyq96GodXceQcLs6rEdpVyP9WBDMi7xM1MAqbfUlWGRptXJ3Rgwwu106cFWScc
         e70MntyZRxmqxZM8zsux9zHtKfZsa1vXNTUitvrbe5yvY1y8Xm13TW/YBoqT/Gaxo9Y2
         6CdW8SlNx86znasg1185T4/kyYTo7GqprJV0oN8Fd1nDaE82gwBLVATsHpIk60+5SUP7
         YBrYyJ97GBxDVeWqlV9TYg7jVa1d415auu4ILACTOUOwdakFCfDrbpUWk6EagUwN5gnm
         +axf1aNFyNqi0r8L5bLMxzQwuN55RUfgUNUGwYHyIQOEo75xvjH5Rx3qHm8N8hnOkVEd
         58aA==
X-Gm-Message-State: AOJu0YxcwyXRqbaD+EJXsSkOrGU/6PpTR/J6aJavRrrRVnQaW8k1OuHW
        gcgazYvBMOIPX/lz79lMs8f4M5cjsUu53v+EfXc=
X-Google-Smtp-Source: AGHT+IH+UdlfWyVlMgyHnqKWo2m141tgyAR3pqlIW+VX4wUkEZ6lSV2rACyt+JSRvaT0kg2N03iEUaTiYpgOSsOODxA=
X-Received: by 2002:a05:6102:284d:b0:464:55d4:b41f with SMTP id
 az13-20020a056102284d00b0046455d4b41fmr3539942vsb.0.1701810876415; Tue, 05
 Dec 2023 13:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20231205031519.853779502@linuxfoundation.org>
In-Reply-To: <20231205031519.853779502@linuxfoundation.org>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 5 Dec 2023 13:14:25 -0800
Message-ID: <CAOMdWSJRR+iqqUD4iVuxV0mL45CJ10zSrTo5YXn+_f2bd09ezA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/67] 5.15.142-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This is the start of the stable review cycle for the 5.15.142 release.
> There are 67 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.142-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Perf builds fine too.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
