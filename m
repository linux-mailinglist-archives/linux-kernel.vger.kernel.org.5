Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44DA78E049
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244887AbjH3TPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343650AbjH3QdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:33:12 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480D819A;
        Wed, 30 Aug 2023 09:33:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-565334377d0so3717047a12.2;
        Wed, 30 Aug 2023 09:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693413188; x=1694017988; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qLb04PjPHAKkElFOM4zEg1DvSUxLNtirH0qTRIs/MZ8=;
        b=DIp1ioyWyQSwvO1ocOmC4l04SyHQnSISmhv3nCaOYzHg84aGuQ63Df2r3U88jX359H
         t7ycy+XCtZAFnoVXoU4wH9DahdM/fKBHesnos1Jgd0/74myS9uNhhaJE9T9tHONr/yzC
         v3glAd3OJC96lGTnUMsScSlxJP5hJxV5zu+OaMPy/HQtNg2azLb3uwkkY58cYSJb4B0v
         +6B5vH4C6XjjgDK9G14YoWjnNB0lKNzwJX3gxlSpAg/0YKczKY3eilnAxdGzy1cfiFG+
         ygxAe3onK2zNz/hu29QykoS2XQo50GyUA8Ijsj4dDqBnN5jqUxUgOW2DuEacDxpaCrSE
         NksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693413188; x=1694017988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLb04PjPHAKkElFOM4zEg1DvSUxLNtirH0qTRIs/MZ8=;
        b=dw7kn2iFyeO4zLGKZl3v6LN31gOf0Kd/zCxpNoLSp2QhFmZWzpzzgtuBAwKouU45YJ
         ri+EyHvr4WB/RLRewShGE9d5E9FPF42izrnT/Be6tdE86/NIHWkVMdzYn1kjKThLEw2F
         4Kna2tURswdps34yjLcWl2l0mwMikNqdal+YVXAxytFNIIHf6g7lD5j7bc76RolUtXCI
         A4qDFuctv0kQvdoQRgsO8ElcZrbgAeqWL/QeqlhLboisAfd8nTVbGTst+1HdeCp3b/rU
         WD76jGpxoMcOfkuRGzUDqcsvAYYvvDISEOHg4pAiF1hFdbpes4G0/pHbBqnFMHIFgQpp
         yJpA==
X-Gm-Message-State: AOJu0YwfluROKKXYJtqgyBI5/Y2LtkrK8YYwwYK33fn0PRQME8ewESmb
        sDOSc+cn0R4c18n6JwEvnmZJCXJlRp97JrTHA8A=
X-Google-Smtp-Source: AGHT+IFrcOygUcEGQM+NJxGZgi51vhGwiajCsPw73JLpC2sttxHYlJq0rcRWAOi9eGduPrbHAkt2UIWJ9O/VKr6MKaI=
X-Received: by 2002:a17:90a:928a:b0:26d:2162:f596 with SMTP id
 n10-20020a17090a928a00b0026d2162f596mr2603868pjo.6.1693413188478; Wed, 30 Aug
 2023 09:33:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101150.163430842@linuxfoundation.org>
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Wed, 30 Aug 2023 09:32:57 -0700
Message-ID: <CAJq+SaCZ7moOv2TBD01h6LEg1B1RVmOzR5=eF0nD7Uc6hUaj-g@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
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

> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.129-rc1.gz
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

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
