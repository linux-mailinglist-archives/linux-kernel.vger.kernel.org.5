Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0566D75837E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjGRRay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjGRRax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:30:53 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5C4DD;
        Tue, 18 Jul 2023 10:30:52 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-345d3c10bdfso25121355ab.2;
        Tue, 18 Jul 2023 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689701451; x=1692293451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7uJNrPb2IKEH47xLNWX/WXtagKONU11JTCz6dajhAnA=;
        b=bw80+EiqwxwsbhnqikH/AUsHwlYK0VB1mUp355XdaB9G82juR3s1l1HjUZVznoknb+
         QyKAkoQJ4oyNwhZiXSoxrFtr4ihgBRnqJn7R6SJ9DxriJaN+5rE4CTyd3Y0UGOU9YS16
         aHDqWI1TJTb4Nw9o761oC0nEvcoc75hHNwya4D4O2lqTwzsKMySUNN3w4dt8C44TLRYz
         zJjD8zYGA5vDSES4B64rxSaofCMx6XC/3+GfQRGxxWL+diz4CozI3Beo3JOhkSO0Y8Mr
         hZGDXrYlXGAILIiy6SZwB3l7PLK9L1K6yEZR5Rk2WRNFd8ZWe1+ie2JoFsn9oe4YxthC
         eywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689701451; x=1692293451;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7uJNrPb2IKEH47xLNWX/WXtagKONU11JTCz6dajhAnA=;
        b=BHZD9O6gBmEx+M0BJp4iKtvpw6OGwN0JAgwyU7oaOWU+lg+XG1GNviQ7Xn+NCFSwRt
         wvpdhVLbk/NKOwCvH9H/wNVHGRaAahA1IwkjqzDTYV7RA9qqrf1jsFwYuMtiF4pFfW+N
         fgwaPoDirHdFtC07DALbXv4bzqy9M76cInj4D0CElPTgnrqB86IDcOsU+2kLxP52y3KU
         fiNW74S1IkVSpRaoy5OsTlDUnk9YYH5AqjCJRImpxKh9rCQG7ghyKNqd5pLP+yPNFHeV
         8TObbzhggUbIwM68jCBTfo0208Hk7tpCmdv7KWmK5m+92QXusraDd8WdYNP5DBTeVE1H
         55kQ==
X-Gm-Message-State: ABy/qLaK/d9lhDF3AZim+zKVCoLdVgsSmD2CAfkvogJOvYh+G+Zz1dhw
        JpZ2Kid8xoJzr119enaXrsOC4+uc0H6PKwEBiDceOXNPGHc=
X-Google-Smtp-Source: APBJJlG/hjrwsimT1/hWsDLi9khDkXsFq+F16HLb1wrHRRHYdrxXqWGln+eTku/hXOVLCjC4hRCmPFzTtXL9pNScEDc=
X-Received: by 2002:a05:6e02:2191:b0:346:3eec:c893 with SMTP id
 j17-20020a056e02219100b003463eecc893mr3917937ila.0.1689701451515; Tue, 18 Jul
 2023 10:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230717201547.359923764@linuxfoundation.org>
In-Reply-To: <20230717201547.359923764@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 18 Jul 2023 10:30:40 -0700
Message-ID: <CAJq+SaCn7wCd=Ve3Dimadd68sd9TUBZa97Py7nNdtoJGt3DkGg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This is the start of the stable review cycle for the 6.1.39 release.
> There are 589 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc3.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
