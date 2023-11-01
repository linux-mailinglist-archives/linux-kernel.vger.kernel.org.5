Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE47DE1AC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbjKANau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344200AbjKANas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:30:48 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9584F4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 06:30:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-991c786369cso1072024666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1698845444; x=1699450244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqp+tKsbxuT0dP0kvbmRHXQPetcAFAg5Ll5YZH6o/4c=;
        b=JTYwlKHLwTBMgX7BLi7RGY3k3PaCc/x4YiwSqQupeq017c7pU2qtEluozEbmlImE0x
         Qs5qKDRn2kDzfLnkj2kXm042OBCxV2A8+TNm9JuK+r7Xo3M9u9q5H3Gv3igPB0Y4qv96
         cph6c+SI1F1VmPU4UWrpk4fYLNtNakcdOhfEVG/bVQYj0kCwWO+1FCuCwPYJcV8gxhYP
         pz7Ha2hyM+Ao3qAUTC+T+/RFMIES63qMxxGGT6MYYoHFco+batbrfFie0533geEDI2mv
         RxO/nHnYdw0W2eeyI0vlIbNjIqEE0i02xN9/rhOcnLKKGfpWTqa5h/QEo1ehBga1QxIP
         WgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698845444; x=1699450244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqp+tKsbxuT0dP0kvbmRHXQPetcAFAg5Ll5YZH6o/4c=;
        b=tk9oSOMHgpo9QvQFLr21eCjAGuLSZ9y5xiAhBff/FUVU8+lVDc+tANrQIWRqz5W4eQ
         +MjUORQoAe2CcpA8coruDkKGwZOEk3SMsAlmPgIBF3OpHlNE6pP6K7NKPRIulaWsOiJO
         VZ8iAXteLhruSOmKXaraaH4qHs6CqD9SsOqQ400qsl+r5LFQMJFGXdt810JbRJ3F7pDZ
         IK1A+9c0TMeLn0bxHacxH0Tsr5f1XFDZQp7CU5b/UnfJiFeJLmh/IcTRNXi+mgJnHxOe
         XRhUGcwmfD/+g0DXYf80TCSa5pUDb4xvk/aUhC3PFxOJTfMtIko4dWHmYbX8a4EKHnOa
         3W4g==
X-Gm-Message-State: AOJu0YwjYwjLqfRijwFJvc/yKgsA9bPzZxnpZw1MRfUULCENadhJVc0G
        kVlM1J7kAp5yr2reZp8XDy5lwDGHoMdepqdTmIsVtw==
X-Google-Smtp-Source: AGHT+IE0QhPJiUSklN+lm5WtW4Z7Yv9ImCivRKXFVydz+RY3qA5o2XFPaZaGYPiYDAveM7G5Fo98a74g0NEDILnIC70=
X-Received: by 2002:a17:907:7f19:b0:9be:2b53:ac4d with SMTP id
 qf25-20020a1709077f1900b009be2b53ac4dmr1969204ejc.74.1698845444122; Wed, 01
 Nov 2023 06:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231031165918.608547597@linuxfoundation.org>
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Wed, 1 Nov 2023 22:30:33 +0900
Message-ID: <CAKL4bV743XcEZTObZ2qY58Mz5TZ-GXbiuTMykTTemO06Py2O3Q@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Wed, Nov 1, 2023 at 2:02=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.61-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.61-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
