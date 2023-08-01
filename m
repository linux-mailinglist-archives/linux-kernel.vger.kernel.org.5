Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5976B4FA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjHAMqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjHAMqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:46:23 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EC51FD0
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 05:46:22 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fbf09a9139so9094575e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 05:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1690893980; x=1691498780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Is8zYpLKksJYkV9dheJoep50WM9TZKR1lDw6gL7yZ/4=;
        b=VENwXiH+kNawpRU7bMwjho9x40IIabsTdfetP3ui5b4yX4YgEVaAIaUXY3IGyGZvEN
         Z65EwE6GjliIEKWHyxSMC0m1WvO8ZyrN4VtAMmOmuZkgxMKe9NXVR2iT2EdH+q8kKwf2
         JekAkKzutCDb/nY4MprijzMC1HkDqQJXEJYKyRZs7ihHqBHC69/PHSV3YkMGVRod8V6+
         iEq9CAeGgHfiQsMASuHVmnZdmUYjo4VdaFvUpWNSjeQiyRkbcElM7xZQmqUx3+ClJE5S
         XX3g8HvmSYlM5AuQUA9gXg01QL5fCKCgrxbR7YW2duQx2/U9p8ZG+T8V6oY2kp9JKX2I
         7org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690893980; x=1691498780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Is8zYpLKksJYkV9dheJoep50WM9TZKR1lDw6gL7yZ/4=;
        b=BNr9a7VZ0UePzJgqSaMkx/qI9mlZh/vxrLVKLqvoxlqsgqFD4DG41+eYG9/xhQny3X
         ruV43rfYKPXycM9Ms6ZWbGjUxoZhXiO0SHmUZPGiCmyeDdN6rOLVc8A67xoii1kS+DUx
         s7adMtGGWSFvpA6zy/r6SFbo9RzI7hLvwFRmF2uUsdR9D9GOrY0NZPCFdn0deLTQ5DU3
         PVg4vO7P2DUnDeZ35d4e3UiE/fV4r0NtH0Nphg7e8+ogZfMqcZ3VjadkwvE7Q+sF7tgF
         PP0YfWQDSAy5SZfbpf0fMI2ATFH7K+1pf9MxgG7N/z6Nv5N74SxHaVMc6UQkreQtyx3Z
         lcmw==
X-Gm-Message-State: ABy/qLZK1ibODpr6Ya5k7ju5jlWVHcvmcZ6YlaoOqDzK5XwmQ/PkNUDg
        s9rRTQ6/0KmZQwf1rTT+rFPk91xkG/OUP/6BLi3Bsg==
X-Google-Smtp-Source: APBJJlHVztoapKp9UMJzShU6AETqb1CHtJ24YW9uXJjh118Gs8dTOfXnT7tP5YuHwbNE5y2McAgoS6u60gG6TLBxa+E=
X-Received: by 2002:a19:f719:0:b0:4f8:5717:e421 with SMTP id
 z25-20020a19f719000000b004f85717e421mr2082691lfe.40.1690893980200; Tue, 01
 Aug 2023 05:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230801091922.799813980@linuxfoundation.org>
In-Reply-To: <20230801091922.799813980@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 1 Aug 2023 21:46:09 +0900
Message-ID: <CAKL4bV45C_iieW5P7FRtRyURPjLZP=U3xioS+hxhxO_AiKQ8vg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/228] 6.1.43-rc1 review
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

On Tue, Aug 1, 2023 at 6:32=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.43 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.43-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.43-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
