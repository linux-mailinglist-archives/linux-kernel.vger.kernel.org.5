Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D74D7BA94C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbjJESkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjJESkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:40:14 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E207212A;
        Thu,  5 Oct 2023 11:40:11 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-53fa455cd94so915522a12.2;
        Thu, 05 Oct 2023 11:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696531211; x=1697136011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5l5tCbT7AwXclsm4TT4kUF89MnMcwGKVudjWa61dhCI=;
        b=IWlDxaWqpmYCsvaF7//8xOV3nkY0g1M8Cstp696N03RHadMbiesF4dBwymsAvygD+n
         Y9mPBCBTdURfBF9o7SivMB6VWGNBfhE2rQbFK2uMEptiGkkdPIKCCao9ixM4BupNRzXR
         AdhqlyunwHsEa57fAVQVuNntmpxhu1OvHQo+bs4m+0v22M/7i10Vdo4IP9umbeWlXyKv
         N75afWMu5K826VhPKIdvtm9h7x6xFE033aRfNsOxs34wgKMMp5NbNh94mYXURXTZwlwM
         8oooR776cc7dC6lw6iVemMSx2aMMuPsdA/h7GahlkMFF6MBb4m19i+VHeNgjvE8FGVcL
         IIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696531211; x=1697136011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l5tCbT7AwXclsm4TT4kUF89MnMcwGKVudjWa61dhCI=;
        b=vMVNiTPvKhV6e8A0m/NrSeQN3Xa9wiT2cHIJ3XEXi08V/PDsbjUBKA2yR3vXPVywCr
         yMtijhQ5ca04AcZgC8FR5VKNqe2ICrQo2qs4MUQbamREym+mVMgCGsEWztzYS6HBXFP5
         jwxfKy9YVfATZe0iHtpD8a6OgwhD3/rWyTGYeDzwXADTRcwPeL/LMqqg4FZYR2Pi7uy5
         9+S0p7+5X7AbHrrpPI3Q/YnOBlGcMQB0D3FoPEgY+dJW+zbPKPS64Poh9cI3aR7jqMmH
         lUwhTAhQ3wYgYVUD2GIiy9G/vDNQBRi/bBX8nrrqHAD28wqLJWQ/tbsuthxoLKAmZBzs
         G2YQ==
X-Gm-Message-State: AOJu0YwmitWT6s0u1xUz9/Z7+q4BnYTz4Sfcp8jlsVEGhe8RAhnZ6tky
        mi71iC2F5inNLyOWO88vyWyfKYBXGvoKjNw684c=
X-Google-Smtp-Source: AGHT+IF/js+fEc1ftTbwYZS92jYAx564Bi6HrWVPF0MfbN0OYNLsdz98od/UVOOEVKKC8hh6iVNAcw7/egXCoYgdNB8=
X-Received: by 2002:a05:6a21:4981:b0:15a:592c:131a with SMTP id
 ax1-20020a056a21498100b0015a592c131amr5424851pzc.30.1696531211273; Thu, 05
 Oct 2023 11:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231004175217.404851126@linuxfoundation.org>
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Thu, 5 Oct 2023 11:40:00 -0700
Message-ID: <CAJq+SaATWw9L7JEV2CU+46xACCvqYwkGxoNB04YuMFJ7kOL01w@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
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

> This is the start of the stable review cycle for the 6.1.56 release.
> There are 259 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.56-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
