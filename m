Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C030B7CC204
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbjJQLu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbjJQLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:50:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72ADF2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:50:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99c3c8adb27so880276366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 04:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1697543452; x=1698148252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWNFjq7J1b1bH2lphfT1Fu13xafbJk+ueucEMZRdQUY=;
        b=mmNv0G+LbrxkSsqLPSB85jrwi4vzk2ia34tK1wbC+UxWMipX+BhZAkqKTytY66/Tjs
         kvG0HW2vrDTFvqgDTjVYetwTq7rKmitPHG+ylD41doVfqRBQ7pgIORyUM69l2EYWlKS/
         jjE/jCoimDE1InQ9IRC+6SBE1G1gmVse4/3gCVJjW85abpIGULPTR4xCdlT1QYHeRJyo
         OIsFX9ENUDCKoMHtuEHhHUYJTJFy3P3bbShNkU+hS+dXyA6e96WsTvHsVF/odIKw7Vr/
         /rmXiyT4p3Eh4Bi6RK/Ymmp7VaT5TvSdW2TI1RQHZKs4CgdcvHhgMdJPtylB5JBIaGKJ
         QxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697543452; x=1698148252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWNFjq7J1b1bH2lphfT1Fu13xafbJk+ueucEMZRdQUY=;
        b=Z0RPvgOjhy5HWwX26HoapFv4wzIE2Lz5GRwqGMdBLMUYttSdxkoPCZ59coZOSi1umI
         xuxyHnNgIn4IszWcGaZylsNCKME+WFtywlWj2TTR4XJNjgg90YZsZvZ4s2CyvpOhqfbI
         WYbI9K4cIKkC8+r2l8d+cZuBgQx49ZGdBlB5pLY8zgrVd9rZyuWksqahXEmaOuXCAb9k
         UnGYmqxhnLJBGtwu3UAVV98wmJBMezXwDgL3B4UtKQj1Gp07TJRkNDWgDajkigd0CY7m
         6HisRTuYW08DO0HmWyGqL7zTVe3g52tWWwx+6XSqmXvCE7pupXVyNS5Rg1v19EhwgGGe
         /48w==
X-Gm-Message-State: AOJu0YwnLS/knT2S1ewU9Vz21oP/xqZCxNUKk2WLuhJDnyOTkQC6twzp
        62ntvWuY8364JiLXA0lc5KzqX7jnJ7YzyUKlFXpCM7LLxifu2Oe4i+4=
X-Google-Smtp-Source: AGHT+IFg+ZLZEHu0kdf0bELio3Q7hx39EsGlyjfnPCLtBOZvQ7d8GQpkLSwxOk+q4t4K6UNt+The68B2G7eTkvc71yI=
X-Received: by 2002:a17:906:da87:b0:9be:6bf0:2f95 with SMTP id
 xh7-20020a170906da8700b009be6bf02f95mr1582393ejb.20.1697543451569; Tue, 17
 Oct 2023 04:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20231016084000.050926073@linuxfoundation.org>
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 17 Oct 2023 20:50:40 +0900
Message-ID: <CAKL4bV4Dy2qTKQ3NZo3Gh604c8Cn7t5n5xUkajkjkRys8xByzw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
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
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Mon, Oct 16, 2023 at 5:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.59-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.1.59-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
