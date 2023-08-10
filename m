Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759527782EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjHJVya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHJVyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 17:54:25 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647952D57
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:54:22 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bc9811558cso1273597a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 14:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691704461; x=1692309261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdmd3L8sQaZfmKOlh78OtU1Gse7xZrYcyHA92fE3hM4=;
        b=FFa1+I3haHlL1/+HcMEoxPyw0EeUsbVDi5SRuDPQNvuytf7mCyoQ/51X1YUS2QSrsk
         aJPx+zHdz96vvTDE0pqP1ZOFXCHbMRDol+iodLI7ycCb9l5V+PiXWglBVcmCZKfQ+KUH
         7RGesjrFOrbQ0q58YCKoHfaBs/NzacUyQfKyYYLMMtPpNQAvcs+UumPfaNgakiuScVJj
         vXikEyp7D9OW2vzwvdvG9ydPYD3G7P6Cf2gWjhj0WE46nEm1Wm8PU2rR0/U8f1eVcofM
         gwFTVXUoYSIVS6d21ib80EJyfBWimDjyym2DL+WeWX+7Cqs+hr2q0o7zVZT/Xrvzno4q
         5o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691704461; x=1692309261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdmd3L8sQaZfmKOlh78OtU1Gse7xZrYcyHA92fE3hM4=;
        b=A3HueBh3j3wb9iuLUoyUFesP0n6FohZhfHl8LyaiM1JEecEV893vCOebq3GSm7Znyv
         UT7DC3KwssCeK+RlSuWpnIsJQXmy9QvBhx5Y6eGK57WHsL8OiWEwzjYQTOwJeDlMUi8Z
         0CArpiQmYtmZniYmkVSJ8qsbkcPeYwvMMexAJr4aCwZWaC/V3IkyLKjTRh1w4Cgup1Z8
         +vkbJf0919ekaJ7KX6wrK3URKBVv/Q4Jd0jqdNnCsMPXqvr5+FGPPlXFTp7sx9d60IMz
         1ocSduWhI7kf1UDxJYdrC8Q2tRvVlI80lpXeqSFcnj2DjNXpLRBE+CEGReMeW/rjpXar
         RhhA==
X-Gm-Message-State: AOJu0YwnJBwGNF9PsXJRWxarQu535axBaho5w/g0/T0q9jpcXiuVG7n7
        sc0yqipb07J5LX9195r2MT11IvwkCkawG7R+i+PNLSwaGjIWjFBY1kcDHA==
X-Google-Smtp-Source: AGHT+IGtfaHZvpQYAoURixzrs6m8DYXk20z0dVjoIRoRWYDAgUXKwqbZ6rkttWpcf/8QXpNNipo1EPgClrgTMf9Y9eQ=
X-Received: by 2002:a9d:61cb:0:b0:6bc:88dd:4f0c with SMTP id
 h11-20020a9d61cb000000b006bc88dd4f0cmr83605otk.20.1691704461759; Thu, 10 Aug
 2023 14:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230809103633.485906560@linuxfoundation.org>
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Thu, 10 Aug 2023 15:54:10 -0600
Message-ID: <CAEUSe79ibvfBR6epj=BhysfrKV47zBAFLZr7j=ZP+-Lf4NzuTw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 9 Aug 2023 at 04:57, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 5.15.126 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.126-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

We are also seeing build failures on Arm and Arm64, with Clang 17 and GCC 8=
:

* arm, build
  - clang-17-defconfig
  - clang-17-lkftconfig
  - clang-17-lkftconfig-no-kselftest-frag
  - clang-lkftconfig
  - clang-nightly-lkftconfig-kselftest
  - gcc-8-defconfig

* arm64, build
  - clang-17-defconfig
  - clang-17-defconfig-40bc7ee5
  - clang-17-lkftconfig
  - clang-17-lkftconfig-no-kselftest-frag
  - clang-lkftconfig
  - clang-nightly-lkftconfig-kselftest
  - gcc-8-defconfig
  - gcc-8-defconfig-40bc7ee5

Failure is:

-----8<-----
/builds/linux/drivers/firmware/arm_scmi/smc.c:39:13: error: duplicate
member 'irq'
   39 |         int irq;
      |             ^~~
/builds/linux/drivers/firmware/arm_scmi/smc.c: In function 'smc_chan_setup'=
:
/builds/linux/drivers/firmware/arm_scmi/smc.c:118:34: error: 'irq'
undeclared (first use in this function); did you mean 'rq'?
  118 |                 scmi_info->irq =3D irq;
      |                                  ^~~
      |                                  rq
----->8-----

(Funnily enough, this was reported by Naresh [1] before this RC round,
but we chalked it up to GCC-13 on an older branch.)

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

[1] https://lore.kernel.org/stable/CA+G9fYvTjm2oa6mXR=3DHUe6gYuVaS2nFb_otuv=
PfmPeKHDoC+Tw@mail.gmail.com/
