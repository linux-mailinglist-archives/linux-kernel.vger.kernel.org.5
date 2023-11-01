Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A657DE62E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjKASxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjKASxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:53:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32532C1;
        Wed,  1 Nov 2023 11:53:47 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso153519b3a.2;
        Wed, 01 Nov 2023 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698864826; x=1699469626; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h3K1rBvCe1RDjJE7QSAQp/UtOiWZhcJnODORAKt3iL8=;
        b=Ow5jZIvYJB7Jpq5fqorBCeYGtMDXUyyGMmFxiVyRH8wP5/CfuUc+x+fMGtyLWymooc
         ycyu8+EaW6UKBRGozb70J1vajnAY2E5DAkS3Z+C0XZWyJQjuKGgAATEprLoXavllIVlX
         mCgnwyb3LKojrFTGN/l4rzp7f18CuBYAhp/41vqwldeGIjjBHvcE5zOdMMToUdCY0CCj
         57C8+zz6lf9y4T5NAbAqkoewd2pR+wyv7BMXkYrZSIWx4sEU+x7LPx1g9x8uY7vHUFNj
         cYK8oIx0qidaYHuypi8FOgisOIc74iReWLJT9YfvxH549Z0jhALNjc+2l4eeFYyCMNsz
         aoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698864826; x=1699469626;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h3K1rBvCe1RDjJE7QSAQp/UtOiWZhcJnODORAKt3iL8=;
        b=DvjbZlsD5nx34TO6KZS41njXv6PNR3eEWgG0JmEvRlJ12UYZDR9z5+VmtyzeKOhOrn
         8KuirVVYl27zPFlR5pAuKy2oecyynl2iXwF7eqfdzLWgHgTuMwUNg0frbZZ08yfAhFr1
         ULPAOPlFYJx5rDre7f7RD6QzI+bAOEwLJF370ymboNSzN4cDG0w7hOfZjBNq4L5UwBaA
         xz0S6/yDx59mNbb/K4kvdpnDmBH8CzXngmdq4+1o8NFaSWWWGwtKPXgQx2UMCoqgJMN7
         52KxuVhlKSRNFGQNxksnr0fp03iJr90I05hxLg+c0yPaxbfxQ6l541Eiov5KQczKY+U3
         4Ikg==
X-Gm-Message-State: AOJu0YzLoZD3CMixrdDfA6nbyfbNDhyp/HBQH+KV6MmVJLsPZF41jSnE
        xE5Kt4N4+weW6Jt1/zdMSkKZ5YlC/HhNAz4HVzg=
X-Google-Smtp-Source: AGHT+IHUb/xh2GakawJLmcH1FQCQwst2XSWLVPekwlsf3O9cPOVcMHjrCcKRQ7Ul9uFnldF5hAiQJfpdD3pZRnWSuMQ=
X-Received: by 2002:a05:6a20:7f9e:b0:15e:bf2b:e6d3 with SMTP id
 d30-20020a056a207f9e00b0015ebf2be6d3mr17998491pzj.46.1698864826641; Wed, 01
 Nov 2023 11:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20231031165918.608547597@linuxfoundation.org>
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Wed, 1 Nov 2023 11:53:35 -0700
Message-ID: <CAJq+SaDrnwRQ7gFMchjx+8eQ3AbNH7EgszPOPmSrm5XaFg=05g@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
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

> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.61-rc1.gz
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
