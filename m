Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE617EDF77
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbjKPLSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345118AbjKPLSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:18:16 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6EB5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:18:13 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-27ff7fe7fbcso522736a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1700133492; x=1700738292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xit1Esx4idoFgZhfPLc9TTvkzWtJT71XEeJRKrsKB7E=;
        b=Lxbs0ePaZxpHrj95Vwsk4n+4z8NHtD62TBr85oJWpLQzxYYZhTY2Asghim2rUI3FUU
         pj8jBuRZ9Rsdq0MD8zh/zG5EyMzf/hcahnxc521nAWYS7yxi8uXvvTJjW1GlB+naQQUS
         WLh3VMrtg6ihVrL3Jdi0YA5okKKfdB1Ah6Fndu621KVO2I5LFn8S1oy3DQeixdub6sHn
         6dEC3XyDbP6tWBiueef/kYpVCkj3wuOTLvvorSim6n1TAUaKNHuLqGUs7eX2xWMrI+dC
         +zrVylswBltjIEE06+tXsWCLJpTBozkQIH7pez5XivlsjvC3kqjxEwk4HzEF2E3Mxg88
         fSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700133492; x=1700738292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xit1Esx4idoFgZhfPLc9TTvkzWtJT71XEeJRKrsKB7E=;
        b=ITM89A+lW6RsqdU8KJwNiLBIz0RC38Ux8/+JorI7kFDmgzSExbzIPkV4gYf0LVcn81
         kA7yUv13JtSx8qE+EI15vPPPT3u2wXvmCSC3eMzrqgnQWDZSfl4XswXLffzMXF8xtx6J
         petvU35yHNYtbDlIJIPMOxjGBpcsJOsvCDBv2VutKh9slG9PXymazwvRCghwlFZetmFh
         7uLq7cH0sMKidQebz8Zq5aOkkxQtxtECrdlCQHBHKBuBNPjzijryvEUEKaB9ry6tEzS4
         Tn7y6McnWsruQrhXwz31fTP8e1WnkjgjWo9xpfrWVWDMvSWtxhfUjHoLNfaGxij+BF3i
         YkCg==
X-Gm-Message-State: AOJu0Yzch/gYjqhhczRGltreLHoUcgzwZ9Xfm5jDfXsyMoQc+2ojb0Af
        OJ85NF5oLRfvNc1CqC2kClgPofLf6fGGHIHObrV7Ow==
X-Google-Smtp-Source: AGHT+IFd2C83fKKWAojxeTf534pIRJKEp0E9M6JGoAbow9IEjqCGzjTiSIlV/+gwzJLw/BrtQ/YgfwkBF5TnJcOR6GM=
X-Received: by 2002:a17:90b:4c44:b0:280:3a0e:d34f with SMTP id
 np4-20020a17090b4c4400b002803a0ed34fmr15750920pjb.10.1700133492428; Thu, 16
 Nov 2023 03:18:12 -0800 (PST)
MIME-Version: 1.0
References: <20231115191613.097702445@linuxfoundation.org>
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Thu, 16 Nov 2023 20:18:01 +0900
Message-ID: <CAKL4bV4fE2_79yd633QUZy3c7NsHZCSgUD0JxsjsM8KF1zfj+Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/603] 6.6.2-rc1 review
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

On Thu, Nov 16, 2023 at 4:32=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.2 release.
> There are 603 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.2-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
