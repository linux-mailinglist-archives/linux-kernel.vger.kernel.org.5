Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEA1784861
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjHVR1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjHVR1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:27:20 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7DA59020;
        Tue, 22 Aug 2023 10:27:18 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1c4dda61eb0so2919684fac.3;
        Tue, 22 Aug 2023 10:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692725237; x=1693330037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fiue8adnEplxNCTAe8x76ojpHeALtOKAEKBFz0Pp5XA=;
        b=XLSVcSF7OK0Dx/KBUVSJfmuTPF788JH7nop1wrwgECZ2000enPzPxDIyDKEiiFcbic
         dFyPL//RMX6Jfp74r89NUAK4TETGpf2tPUONKOm0gzQcaI9RoJ0PRfkZLkT3LCTueD0i
         1cXPBqCOKJnFDoEax6sZDUYmguc/LMpxpQ8Ro77K3pGNGA/w4cRwL341OS6zcYx9OdO/
         hvBLmea1RmGYK2ze+Q8lW2YSVJhfqVUakUKv/ow8MxVn9u/634dzrPZkP3RaQZ4ggQpO
         ICdJSBrYtQdUvxpodJrkBMhSp6FEmvb8PVmENMH6Ye9D8LtIUIKG7DYSrcQTc5NVS/xC
         q/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692725237; x=1693330037;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fiue8adnEplxNCTAe8x76ojpHeALtOKAEKBFz0Pp5XA=;
        b=c/EFybaEBNrM0FE+anN+Ibbig6OrRIC5JU89vL7xVq2sVMzly1HrmVikm3Cl+1xqbh
         lP+RxA5K22hmgUigCPvSKnpHVSE0iCpcSRoDCl6uZ8d0E/PyDIft4s3adXu24k4VqzWS
         Tsf9VXUF+cN109Kd5pCHDVZzz2B0IONg+ksgsa0V7AJlB8vjdbTsD7Y6DWcR2e7H9fve
         GMJ3cXwVqvCM/VO05WLSjDDGfM+EKeZ9pqw6iOuLuJPp14s5X2Ycs3UKgXHvT4liGerV
         A5mGSTKc25pBnAjFQh+n4jFaIAhIxaR05LX0WMfrFRwibBBWwiMB+RGEticj4mbqh3GU
         U2RA==
X-Gm-Message-State: AOJu0YzhbSKEClBNxHAkFCkFhudja3cC17vHESMC0kgf0GWTyUQKjxEu
        oPe4TOPygYOCXYdrQ+9Lolujd5WtWy96Ozjcw1w=
X-Google-Smtp-Source: AGHT+IEcDfI+EwFqDNdY62vV9JavQLjkFt28CXAKlmLiVxH10C30Wd+S+GYDGckUiNyX1divnx95wkPO5XNmVhqNIt8=
X-Received: by 2002:a05:6870:9110:b0:1bb:99fe:6ad1 with SMTP id
 o16-20020a056870911000b001bb99fe6ad1mr12592794oae.6.1692725237163; Tue, 22
 Aug 2023 10:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194128.754601642@linuxfoundation.org>
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 22 Aug 2023 10:27:06 -0700
Message-ID: <CAJq+SaD6Ls87X4tMwZSjrkOJtwn5oOo=DvszZsYiaAEX57HXoQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 000/234] 6.4.12-rc1 review
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

> This is the start of the stable review cycle for the 6.4.12 release.
> There are 234 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
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
