Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FB47C0006
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjJJPLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbjJJPLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:11:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D63CF;
        Tue, 10 Oct 2023 08:10:59 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d2e13074so4358810b3a.1;
        Tue, 10 Oct 2023 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696950659; x=1697555459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EgFuaMyHuuA4Z4cKuZPQOYAOGaxw9YhSSGYsa53WHvA=;
        b=S5g517eTRS9C+mXEZYrlyZKwFoRBAnWTfzkGRipE6XgxsupiJbq9WAFww5+4frEry3
         tc7uVVZhTB0pxQ1kGBjn6ZdPmOWvtlUtKD3EEIEvh3K/WXhCb8EaALtdvBCxYZb2neaf
         fXlFXvbkn6N44Ed/yc2i6IXkc/vcn6eJ7jgksRa+r/qAio6JwOMeU/45qzI1DtQPBk0j
         Og/W6Z52GFpEftZ5BjeKPh4veYJnI+sg/XcBIr9DykUmesCZG5FCQtSKDDJb8zCAYQ0e
         KXB+7B7OuSgxFmIIY1q9nm/BEaPMvJNVSS77Cfa29R9amwB+/aAgx+ACTq6yHLtPLE4S
         OWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950659; x=1697555459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EgFuaMyHuuA4Z4cKuZPQOYAOGaxw9YhSSGYsa53WHvA=;
        b=Q/fm2Hvc5uYRQd2Z1+7euoYa8LMeNo1mps2yOgIPqMNbNVzOCq/+jauURMLxEqMXM4
         z4BJWRJfGVx4yFTleldEWocJiPJDqi6V0U9JfcECnsoOnJeFpCg99+S2w60Kx7aCtVwQ
         5NQVs/VRICSipf+i/tqu+f1aBCqI+0guag2pFOsg8Vtp4mw8VoAyjoDUrwrxtUrnO5My
         dr4aOoCj5r7KT+ucKfLapjafxVeWSIX8SzsS5/PP1qJ+IYVnJv4Fi7kbEVbSKjmPLRHY
         ixXh9TRtNqogzl8GbfijSgb4nBLNix87Wn3RCHi6v4wAXZTU6bEDVkq4QHRpAMCc8VvO
         5pGw==
X-Gm-Message-State: AOJu0Yw/kDuexCHq7tcNSraLJJDqAG1w72p018z9znSIRg3K++TJle09
        SqHPeRaOL0f9X/fF/xf74D7ZoUDrOsjr4qzSXlM=
X-Google-Smtp-Source: AGHT+IHVhn2WL2v2vSMq4ifECus+idIWrGQvfwR9ivLh0JEr4CWDFSDsL2Crwm3sHsYMw15OfgafWIueLAOMt7lIDVU=
X-Received: by 2002:a05:6a20:1593:b0:155:5c28:ea74 with SMTP id
 h19-20020a056a20159300b001555c28ea74mr19193414pzj.12.1696950659348; Tue, 10
 Oct 2023 08:10:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130124.021290599@linuxfoundation.org>
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 10 Oct 2023 08:10:48 -0700
Message-ID: <CAJq+SaA5WVYqZeSLYP505c2VmvAXFuetdgyr8VDi6X_ukOaNyg@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/163] 6.5.7-rc1 review
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.5.7 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.7-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
