Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB278B0E0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjH1Mp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjH1Mpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:45:45 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB71100
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:45:43 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44ebf4c623eso220646137.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693226742; x=1693831542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTdd850krtmWOtzkmq2Um5vO5DePaECfmrOyvFGNw0A=;
        b=Cl4kvMCHEE66Ya0Go8DA39JpS4V1fIu0PIESwO0nFk8jbH8PGbH+CcJhRg/H4db+xu
         90Ouxfl5VQ8e3ZNihXfNkROCddPI8nHa6ihNn0xIia50OBkLRoS+kkH9kQiJxXIgMJ5i
         1HCtKLUHJfs110V+xnWhWaQMIduOBhQrpTWpCzH6yl9gmzyOiVgximeqfee2XAwHIL30
         XYL1eqyfVRUdPgUYMkCDZlJFilTN+4nE4c492dX1GTQ+CvKRD0PdtkOWvGwQ4xjaZtXE
         XoL45paXRbVv00CLxyGJ+h5C4F0aOtjMjGbmLpY6MSToKwTadNC9m8YVqodTMf4nHuHc
         z9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693226742; x=1693831542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTdd850krtmWOtzkmq2Um5vO5DePaECfmrOyvFGNw0A=;
        b=Pje3vnRAWDHLB9WsM9V1WI6cRGSJ7dIQ5KklvpP52kvmMYBXaDsqzWOBAc+otmI/uX
         kvw3VMnu3JhUu/wti17Mvezr1t5JL/RiQQkeCFihAaAOLw2pY/OcuPSm6JcOLFlLeZzC
         vCgT+YDMcLguk4sAmQyV4d6aBMc05a6Row4jAwBmcPrTox760X8wZqTmRAIDHAOwRU11
         dqMfrToNxH0hu+p08meIKPQ6k1L/FO5RWZleHVeGktOI8HIooxrwGDgNAwy2gVEn81oy
         SSc9YB9gW/3vsD4YjspJ9SOaMSpfxqB7W2QVetSTVMizkq/K3XcGQU0fTyTu2f3Mt/c4
         reAQ==
X-Gm-Message-State: AOJu0YzlbFIqLOsRwAWVDJim3aSI9BhrloVfejzGJoYLUKDM62Oazv3Q
        LUtVnPw2QpMnX5LKuFOwAM/kr0LnmOxgK8hxaUsQ6g==
X-Google-Smtp-Source: AGHT+IEdtTtOwloNSd4mKOu1fuHlpzN9wjd8g8mWnEVcCo/jqSV0UrXEouOfLDsQ4b3Si8PKFIfpCo1vgB6+TlUNSw8=
X-Received: by 2002:a05:6102:533:b0:44d:42c4:f4c0 with SMTP id
 m19-20020a056102053300b0044d42c4f4c0mr14199635vsa.3.1693226742327; Mon, 28
 Aug 2023 05:45:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230828101153.030066927@linuxfoundation.org>
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 28 Aug 2023 18:15:30 +0530
Message-ID: <CA+G9fYuQXq7-jkL59MMKfRbqqB509T3nQdtcW+4wVW_QRovx5g@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/129] 4.19.293-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Aug 2023 at 15:54, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.293 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.293-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm.

stable-rc linux-4.19.y arm gcc-12 builds fails with
following warnings / errors.

Build errors:
--------------
drivers/bus/ti-sysc.c: In function 'sysc_reset':
drivers/bus/ti-sysc.c:982:15: error: implicit declaration of function
'sysc_read_sysconfig' [-Werror=3Dimplicit-function-declaration]
  982 |         val =3D sysc_read_sysconfig(ddata);
      |               ^~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


 > Tony Lindgren <tony@atomide.com>
 >   bus: ti-sysc: Flush posted write on enable before reset

bus: ti-sysc: Flush posted write on enable before reset
commit 34539b442b3bc7d5bf10164750302b60b91f18a7 upstream.

The above commit is causing this build warnings / errors.

Links,
https://storage.tuxsuite.com/public/linaro/lkft/builds/2UbpNRPtHJcx6nk8e60a=
mSmKgZ3/


steps to reproduce:
tuxmake --runtime podman --target-arch arm --toolchain gcc-12
--kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2UbpNRPtHJ=
cx6nk8e60amSmKgZ3/config


--
Linaro LKFT
https://lkft.linaro.org
