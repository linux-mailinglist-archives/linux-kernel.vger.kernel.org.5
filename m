Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA77EF7D5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 20:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjKQT2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 14:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjKQT2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 14:28:11 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AA8D72;
        Fri, 17 Nov 2023 11:28:08 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-280260db156so1900007a91.2;
        Fri, 17 Nov 2023 11:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700249288; x=1700854088; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=id9bEmxNMwkBfvEWdosyxs6JLZUmUudjE79JcILkBXw=;
        b=HG13aiAzUBK1yPeAegs+No3r0TZwUDmGG+vFZ5uoBKQ5CB5GrcsrgkW/WKXIFbjpma
         xzIfCxpPE2WYw8JOyiYvNONVR3tXPtcNWVL8eJE+PYZhVkXopwx8kaBmizSg4ZZVnlIl
         WFSkX5880+G+tdUiCqqpjn7fdwY62xdrTFo3ge9VEQp9NHb7tYHh9DfbZdCs9opP9+fy
         ycY7szYB9lk9zDSg5q4Ei//4CJdDUQxES9p9lrLk7qCwj5YNG6CzlPf4+2SqJMQxLGuJ
         kVsuV48jZdv21jNHXHmNsG17lSSvOQa7ZifpQzYtoRaj7aU5jliH/n24EIzdKfAPMsNz
         zeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700249288; x=1700854088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=id9bEmxNMwkBfvEWdosyxs6JLZUmUudjE79JcILkBXw=;
        b=NMjS/t+wIhflcRTIAyP3h00IqFEu8vUT4A6N36U6CMwc1r+Rh3XD6Z8J/JZbptrGpR
         PoWIQk4OCYxw9s7bywj1aRCUOh9CFtNrOvb8+QnOaBDyz8E+ve7CgsPXERaAC7A7i4BX
         03V37wzeFRYS446YbHMDRPblCIvJ0OvyoO0EVzosnh0Lud+mMX2P9wKQK1i7qSdSx4Fw
         MfTf4VJ6zAGOY+SZ8o100G2glHEOUS9txQD9PX18/LSNat9OqdwNZIyuOlKz/vNSJ4Jf
         AIXmBjxnGnXoCRssSjKV7lcCc5bFYZSgI2S0jL3S2Mb0hWOcmxT4YCeIy1/DxA5G9Seh
         zs+g==
X-Gm-Message-State: AOJu0Yw5hxN9HTbp90S4lB0vJsno+4drY67Rf4WtGySltrAWblxJEAqP
        6qmjgr3kq06Uh+1zEvGhiErM9kTThoR3zGjeVuo=
X-Google-Smtp-Source: AGHT+IGJoasHnwhcvJ9VGKmXyGSubTd4bNLiRRuYHCgEvsNQNZBbUyo8u/UuqpQSWOpmglEOb+bMqvZtpvyxsugZYWQ=
X-Received: by 2002:a17:90b:4d92:b0:27d:97e5:f3fa with SMTP id
 oj18-20020a17090b4d9200b0027d97e5f3famr455694pjb.29.1700249287877; Fri, 17
 Nov 2023 11:28:07 -0800 (PST)
MIME-Version: 1.0
References: <20231115192645.143643130@linuxfoundation.org>
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Fri, 17 Nov 2023 11:27:56 -0800
Message-ID: <CAJq+SaB+R0Aox4wvEXt9Qjtq+xi9fAqerakEzXvj3b=UjHYx9g@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/379] 6.1.63-rc1 review
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

> This is the start of the stable review cycle for the 6.1.63 release.
> There are 379 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 19:25:27 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.63-rc1.gz
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
