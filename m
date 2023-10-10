Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C167BFFFD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjJJPJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjJJPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:09:27 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF4106;
        Tue, 10 Oct 2023 08:09:24 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-279150bad13so4313062a91.3;
        Tue, 10 Oct 2023 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696950564; x=1697555364; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nTeWqq3jl5FawKSID+DoaxkM3CPNpkRkh0wkQJ5fbxQ=;
        b=HdDS1TPqnJnO26FutQiS/jKubEKdmanO2S+DE1VyoGAinC0na1awB5Z+TpJYDwH7v7
         DFGwnLEoAWeaUZbKLBqV6KfsJAbqXrOsVN9KzPYGkCFn3QBcPtN6/rDGC2phxSfXmP4m
         fjfFcP8tzHDD1ZSJ8h4h/GtVdSvIU09WV1+4Y1gG+5XMxArua+EyIuLt8icR0RHFGxLT
         3WzwKpUVOpBkKjQAR3z5GvBrgEciqBBHnFPIM5JIqrYdU941pZDOG01FMtGaUyZtk2mp
         LHk/Kd+y6I1o7oV+cVFrzBAXCbdX79vr6yKp64V+xgI/vSPfZnBpHsBQlogNinRqYjsU
         SLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696950564; x=1697555364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nTeWqq3jl5FawKSID+DoaxkM3CPNpkRkh0wkQJ5fbxQ=;
        b=uj6Gw5c50sXjaKshjkmpe8TiL0lXFa5tVgxN8TczUr/gQAGhUqy1Lkey620Yf6F3He
         furyGwdXwBMcW+Ozlq+8Xv8yoaaJromj0wtY61QvRHZb+95s6fDCU0gER+Sl8hD5EIFt
         T6XkjGjq7Z3z1FRdL9yhLHmM8HfuagFUfRSGCvntgbjC6ld7iTSwV4dw9iF7zEnIkEKZ
         h/QgugH9dqjk6KSQVRdBGrr8GzY/KA9FLXQJSjdGGk7+0GMH9J0zWsXaERFXdydpPXKA
         AsgFIxrjTdtz2AkYlODoZdY91ZaxGgHitjNkBCS3YsCM+8wz8WYo2LdI2Lq+uApbr+K6
         8XFA==
X-Gm-Message-State: AOJu0Yy71DuEK2+l/OYhdq4xZnOeV7nMyP3g5+Xf+KbmYPSblZSo0qN5
        qUAYUFdNJkQuy56Qe4cHWOIZIXUX61OBRh8cgag=
X-Google-Smtp-Source: AGHT+IGE13Cewo15WURJDAdpU6z7zKzguK8r1Mul1KQJyl7+6HWzaEz12tNtzPvJgUFZ0LHCG6ha4GSTGyT7Retw6Pk=
X-Received: by 2002:a17:90b:8d8:b0:268:13c4:b800 with SMTP id
 ds24-20020a17090b08d800b0026813c4b800mr16999401pjb.21.1696950564066; Tue, 10
 Oct 2023 08:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231009130111.200710898@linuxfoundation.org>
In-Reply-To: <20231009130111.200710898@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 10 Oct 2023 08:09:12 -0700
Message-ID: <CAJq+SaC8gksd5o9HazMcL2vNJeRnLmnE1wDX-Mr47Tf5A=ChWQ@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/75] 5.15.135-rc1 review
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

> This is the start of the stable review cycle for the 5.15.135 release.
> There are 75 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.135-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
