Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE2C7F8389
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 20:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345959AbjKXTSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 14:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKXTSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 14:18:22 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7BA2696
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:18:28 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-59b5484fbe6so21895707b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 11:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700853508; x=1701458308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y5EvPm+dIyyxToEIiLBN/BUv/oh/7CgG9QocWi6TRY=;
        b=hNC/9PE+RveNcuq7uj8Pjjsxh2AmR6SnhyEtGUh5hg8qwztS6A1DGSmN8MwIi5cmem
         O8WPdjAG9D28Npd+VL8H5yc6dp8C4R+dN0o4pBrFqjRyge6Kqqxb6qPtODnVcZV2AbfU
         yrDHEopYseeLoI4jn3stUfx3plEc0EtAx2h7YjFNTLtzxVmjd7uUgcqeOFwTkL/M0YK8
         oGVsL36CcN/rhD3hNGmzl8g5im4vj4N9DoZ4SSbb1ND3uy64EJtiV7y1idoULH+Y41x2
         0vLwyjzUL+Q96OUAHY7m1krSgMm2K5qlcFhaKVnDN2NKpqnclAw2gHz2x1V/ZX56rP6J
         Dq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700853508; x=1701458308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y5EvPm+dIyyxToEIiLBN/BUv/oh/7CgG9QocWi6TRY=;
        b=YVPz/ThS682vZr9es+TPbZMt2kZizBThNZgF+RG8SOkxO2oCKsYs3tf9EZZb12AxA1
         nBePOQiy+57r0uQbOD5rFIzxpO+6JV6nK7NVgirO0NwTzwgEyySlqpXwFwl1G2kllwHy
         ZGgRi2l7jOva9kwaA9tnatb1+cMKLJ5n0AJI/oc4rGFuU1vcJj+r6djKXmdkbF+hpt7j
         sCxFr92XUbsqCye8/M7uaNDKtwFJMlR5wAGMX06VlIRMnJOjr9HTSXvKSNUjPfKRjkNy
         3XYzr9Mbr9iFai34Wd2Nt6hjyABe+ycZnnALM5+P/p9lVbfTTFCGq1mzY8bPuPWXO58H
         IWeg==
X-Gm-Message-State: AOJu0YyZiBp/T4hUGDVmIxnEG/UTuiTpthDsN0+8pkA9+a9MvIlBWsPx
        oGyzrwby2xcob3XWK+Yc2BdWl/IQg3lkMd8IL+gsgQ==
X-Google-Smtp-Source: AGHT+IG0J+CigbyzoWqpfwOWZHGZshBQ3BB6VtNdolTpxujJlcObsE89jrok8amrqDkQvtpvSn2O/PyFKR2BHzwUbio=
X-Received: by 2002:a81:5e43:0:b0:5be:7046:b2f7 with SMTP id
 s64-20020a815e43000000b005be7046b2f7mr4634734ywb.40.1700853508071; Fri, 24
 Nov 2023 11:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20231124172010.413667921@linuxfoundation.org>
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sat, 25 Nov 2023 00:48:17 +0530
Message-ID: <CA+G9fYs1QwVjKK0wBcm2EtDbSbvG7fu7Ca=SBAZfGDAsEJLPZw@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/372] 6.1.64-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 at 00:17, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.64 release.
> There are 372 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Following build warnings / errors noticed while building the
arm64 tinyconfig on stable-rc linux-6.1.y, linux-6.5.y and linux-6.6.y.

> Zhen Lei <thunder.leizhen@huawei.com>
>     rcu: Dump memory object info if callback function is invalid

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
kernel/rcu/update.c:49:
kernel/rcu/rcu.h: In function 'debug_rcu_head_callback':
kernel/rcu/rcu.h:218:17: error: implicit declaration of function
'kmem_dump_obj'; did you mean 'mem_dump_obj'?
[-Werror=implicit-function-declaration]
  218 |                 kmem_dump_obj(rhp);
      |                 ^~~~~~~~~~~~~
      |                 mem_dump_obj
cc1: some warnings being treated as errors

--
Linaro LKFT
https://lkft.linaro.org
