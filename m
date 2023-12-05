Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF9028062BE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 00:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346254AbjLEXLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 18:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjLEXLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 18:11:07 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E581F120;
        Tue,  5 Dec 2023 15:11:13 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3b837d974ecso3938292b6e.2;
        Tue, 05 Dec 2023 15:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701817873; x=1702422673; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YiM0zcsyKgxywZKVKK//YeSGcTecMKDV4q9GcI5jqSY=;
        b=ZGiDBWQXFBfleKSqUL+o9GQ2KYNLUWJQ73vGjksmw7mN2sOAE34mTgkCKaz3VFQZP3
         5x6AjA1Gn8g11lKv3tx7SNgN9C9lZeE7FfvTHxm5hZmXBRT16LczYdIAsLXZfvlxaCix
         9yDpdJwV87q+2cZF5OQ0GjSMqGxSLd4H+JLiglN1xfZU73akUUm7aPc+FEMTDUAOR/Sx
         KbpKIkVw1OcJUaVGsZuPoY6LpTEP+3DkO8FkSR4b69fr8SbK2W+/HOgPrKKE4kSh5sCN
         7Lq0/c8P36u1QxHBoA4G6vRoKKEZlX4G5mNv3XEolODYQND7rDLavObrv1BhZjINDdG7
         coVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701817873; x=1702422673;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiM0zcsyKgxywZKVKK//YeSGcTecMKDV4q9GcI5jqSY=;
        b=BPdFnlx7KT6sFSFd0Lr+1XILalZg19oiR1OYkoJ3OVYo6Pw39sNZXlMwEZ7JpQT7QU
         jN+Arh61ZwKHO29jIHy7Y9+StlS0h2i0ux1uBWTW+34vBYlcHcR8FbkZe3sr/JGzE7Bt
         dLGMko7zwbFf0uvSDEy88p4rp9aLSYCE1qAuX6jqiZt5sd/u5Y9gPk8ubBlIKhTmzdco
         tWkwAyXFp0Idk5IdV5CGQGJS4Gf2xtTADYu0PsGPNJeuT5shMcJE+izcptk6NGZzYeND
         p4RjVO5ib/36gG4qOVrgBoDn2yKQsyxzFvuVGhzmupCXbnD4DvZkPfJgDUG9QNRbf6t8
         qz3g==
X-Gm-Message-State: AOJu0YzIs7RhuuCjGiHZF1+ww3v7c1Gvmg53dSRqXgt4D5Ule++A/f2a
        MK5FGQ82EFb75wW+YkZXjo6HxY+tEsTa9CiSWjE=
X-Google-Smtp-Source: AGHT+IF7QP4s/HHKdsuycE0FCSgtY1QW4Ox6ohusNAZPotQ3vuUN/JIJv7KjFnCHt2I9zaSwkeBR2acaW3dHE2xDyp0=
X-Received: by 2002:a05:6830:1d6e:b0:6d8:74e2:c08c with SMTP id
 l14-20020a0568301d6e00b006d874e2c08cmr45346oti.62.1701817873218; Tue, 05 Dec
 2023 15:11:13 -0800 (PST)
MIME-Version: 1.0
References: <20231205183248.388576393@linuxfoundation.org>
In-Reply-To: <20231205183248.388576393@linuxfoundation.org>
From:   Allen <allen.lkml@gmail.com>
Date:   Tue, 5 Dec 2023 15:11:01 -0800
Message-ID: <CAOMdWS+9VcHETK6qeYP2QKut-=KM_W4WPb-OcpdfWyaiTBUgRw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/105] 6.1.66-rc2 review
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.1.66 release.
> There are 105 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.66-rc2.gz
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
