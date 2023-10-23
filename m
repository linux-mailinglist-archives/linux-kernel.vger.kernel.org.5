Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187D27D3FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjJWTEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjJWTEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:04:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6E998;
        Mon, 23 Oct 2023 12:04:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27d0acd0903so2333128a91.1;
        Mon, 23 Oct 2023 12:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698087890; x=1698692690; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HbRGnRWCjj5q11jzItIqda+J9VwY61MfSnIjemYMdv0=;
        b=mAbitGJ/Bwoel6F6l59hID7PaMZJpo5cdHUkuUn0o6UjIFotfNcy5+sq/Hv8EsgQma
         9vG6ScHyeaNBBa6+cBzhV2IbMh/dr739e5Cey6KxLNWLqU+y0EHrmfqFNqTyiwnmIpnk
         q2A5LkUyOAnI7/keBQiqvxvCRgiBZUmg5jG/jJ/46GSJp3/iIjTP8t4k3G84RU2RNie0
         DUkH/P3zggk2nh3ULmGiLy+L54ZZ7vEq7kU3peZAx4iXjkYkUcaVsSaBoNarEFFYZziI
         IMMPI4/9tODCTi2ThX/b8/Skbi3lOzJPU7crJKXXoOVGo9VzWqsOeKU5VO62Yezy1SMK
         qYyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087890; x=1698692690;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HbRGnRWCjj5q11jzItIqda+J9VwY61MfSnIjemYMdv0=;
        b=vmFtXNLNknOxZp1hScSX6Fz65w63XmuzIQtZYHRpJcwKz7F62fPKkg7iC8r9MXCE3o
         B568JMZ5cXivsP6Q+dThOfEQDxVOfEE2rHNXiSsT8ICwoySPlWPykRxMJQ7cHPmHKQlR
         xzS+bMFy5uZNMQRisHoCp3Syox/gYdxH17QS9iR/Z2PSo3/syhjhEI/LuBe2rU2rkP/A
         Vlhrn0oi7NoZ+8LVwkUyoFHRjK2i+1C7+bMsUZCh1wWGjDhwaGXsvJB8dZSIW97Sxnea
         J6G56R5MCAkW0Vxkit4UCvRtFIWEZgk13lx556sNEiYeQFm/ZlRh1d3b8yVZ/Gw9nRtx
         YIQQ==
X-Gm-Message-State: AOJu0YwwFLcZ0tnQhoD004UmENzkIOV4JhrOgVse7lPo9WyhrSFiMLjf
        tnll6SFHqEYdvmH3Y7eOBbAFdzpW59m4fJOaJ/Q=
X-Google-Smtp-Source: AGHT+IGUAY/IV1/LXk0yKKkgmz5lmn63NdZsI/R97mHZSHKUVQfE1j6ES5iNiR0S1JI5ivUJyH82Kehy7jLJPKVlcEM=
X-Received: by 2002:a17:90a:4f:b0:27c:facc:e3eb with SMTP id
 15-20020a17090a004f00b0027cfacce3ebmr7890593pjb.31.1698087889889; Mon, 23 Oct
 2023 12:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231023104820.849461819@linuxfoundation.org>
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Mon, 23 Oct 2023 12:04:38 -0700
Message-ID: <CAJq+SaDcwDtnLL0AHaBjXqXtPHo2RF9xVp2HptmSot67PV+Zkw@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/137] 5.15.137-rc1 review
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 5.15.137 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.137-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

I see the following warnings too:

arch/x86/kernel/head_64.o: warning: objtool: .text+0x5: unreachable instruction
arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x43:
unreachable instruction

Besides that, I have compiled and boot tested the kernel on both x86 and arm64
test machines and found no regression.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
