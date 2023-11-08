Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA07E4F71
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 04:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjKHD1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 22:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHD1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 22:27:53 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1153A9;
        Tue,  7 Nov 2023 19:27:51 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-280260db156so5878799a91.2;
        Tue, 07 Nov 2023 19:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699414071; x=1700018871; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ytmubGM6iA/R2uJJz2HTFch2ZXC0QBgruER0JS6cWI=;
        b=H5zYagfrxc3fYmjP3U5dYcg8kFsh1WeQUIf5erAsKn2FNZALE1P3dVS13iRHGz7xcW
         9mdPkZw1UVCJczZhkIyfYnM2gVFjJ9xayfw3ErJvBmHIBSpIEizWF8RGHPw/mWCIAaU7
         Zr/YPX1D/vEcK5uG2Jl+UMEsfusMFpk+BWBDBTJmtFGERBbV5OPIxvOxNxSNbiBX6hUu
         svUQhgrdTKcgUSUyFWIhFZzq9FESiYIEmH+e2oVVV9eBdHlujG5Srxqi1hLjR4KiRNDw
         8SBUXRPzH7BUGZy/R0KcHm5ct9dC4vr9at1vNBxb7afwkEMUysuDSm1L/IQtoloLBnij
         Se6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699414071; x=1700018871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ytmubGM6iA/R2uJJz2HTFch2ZXC0QBgruER0JS6cWI=;
        b=svZxuJ2TN633M6Jcmhb9rZjcE/zlnMuMtgNQiuDZESriCYO3ErNq0IOYxmFmiJL+1B
         ilyssxpceJwrNF70ITM9EgdskPF6yI3iIhKjcUz32WwKOc7KmJPdQ+plkTCdoaIt3n0H
         iqzrTWnfsSC/wQL3LQWa4suimzW6bPa3yqRsMzystTBDD2HRYAjVlFVImFaXJSRsqoCq
         7vR+sUFPpEYRudXoP1O4LUvwO3wEa0tfWXFF2xyBumDjwg4OAzmdKWLXmq++G76lWDJJ
         lYpTgwOkUv05WxjIVs8MwWt7/CzpOl6ohWTWTHV0jKg6HLYlOvRPSucf25lN6NA/870/
         k9+w==
X-Gm-Message-State: AOJu0YyE8ZWJJYNhWiiEK3ZokKbNtlADdmJD9SxdXCmG9kuWIVBSLIag
        FSe57neEfu1Qh3VgOjcHNoUbOEjREDHLiHxlY0U=
X-Google-Smtp-Source: AGHT+IH0ycX/rFIiW7psOnLdpKmm4wBQ4UWCo+PapZP6FLibO8CLA+H0S1Iy1s833hKLD2acI38/Cj6EHcAVj6yMjzI=
X-Received: by 2002:a17:90b:1b07:b0:27f:f1fa:b448 with SMTP id
 nu7-20020a17090b1b0700b0027ff1fab448mr653426pjb.11.1699414071202; Tue, 07 Nov
 2023 19:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20231107202324.434534294@linuxfoundation.org>
In-Reply-To: <20231107202324.434534294@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 7 Nov 2023 19:27:40 -0800
Message-ID: <CAJq+SaCKgbQYL27m+msagHhsH4eJ9P9aDDA_uaj2of2d=V99HA@mail.gmail.com>
Subject: Re: [PATCH 5.15 000/125] 5.15.138-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 5.15.138 release.
> There are 125 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 09 Nov 2023 20:22:58 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc2.gz
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
