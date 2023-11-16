Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEC47EE567
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 17:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345040AbjKPQrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 11:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjKPQrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 11:47:00 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82228B7;
        Thu, 16 Nov 2023 08:46:55 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-53fa455cd94so775375a12.2;
        Thu, 16 Nov 2023 08:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700153215; x=1700758015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OolimXFjci2sq0iqnv6FTsXghgRy0JeCTvt6M1ohGfU=;
        b=G49btYQfo3AX1zhRov7ItD7nNWJarcXeLJgAhMSwZvXpD2WAlTW7csKhoV7Os048PL
         SO1QZoxA8cccOEF/eIkKQEyDErNiJ/ztxxZwfZ47muSy7trO0ou+5n5cqrsox11STKoO
         VInVBg4Z2kt6v+b7VLAwuRUxHiZLjlCXbNdpNNjYG3x1J5cRTAdPZpoHFo0nVhzjsInj
         ZApYmFBu7kD/HN+jZwexLhvzoJpjnX7lFpxywPWXO2sEB4dpIyE/Rx1xbmQbH3kHX5dZ
         p19OEwnR+UgUvcHad8QYxoDmzN+i+SprXy/5/bEhbVitsquYlI1KzwNNX+sTOy1epV1P
         a05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700153215; x=1700758015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OolimXFjci2sq0iqnv6FTsXghgRy0JeCTvt6M1ohGfU=;
        b=NVNUx3jWUjJKZsABWYG7JoxVzsO8rEhyMeNxlNQ57OGLTkBCkXiHwqr4r9kMmqsZJ0
         8yQ21OOl3wN+a0lT6cjy4XPwsojd0NtebfdCS8gJ0OKJ9zNSCrxi7eG/dLUQ+u096MMl
         PSNpk8Mu+LFRlvC0DqOjljCtgEkt9UHaVMET9fZJQ1ufdJ3ZxhXqSbAYYz4wuRzNwtSv
         Kplo8oki140RcgcJaewuziczmdCxUNKsevoup2cHC/vp46yQKFe1q75Csi2Lo7nli5Go
         UIWvVHcnSFzFBwMTQbij1ds+TYqfUvChB16j2lPpNJOBLwEJW6lvgX9Nr51CGh9kidDn
         nnpA==
X-Gm-Message-State: AOJu0YycYnhzKv2CX9ScZ4VHFkQfh8rUL3wYYarXAY9945+ZKBMxVzhh
        /jpIjkjSvPUwmgcKAG4vks9I6SQSCv9aaKCUFe0=
X-Google-Smtp-Source: AGHT+IF5/SEQWJEREMGPHUCZ1LmNZM1iuxnvDxRQDsGxq6HYPAtPUUhqGTz0d14cg9BfIQnvICXiZip82B4crhq7aEs=
X-Received: by 2002:a17:90a:6f84:b0:280:1a19:6dd5 with SMTP id
 e4-20020a17090a6f8400b002801a196dd5mr13185462pjk.36.1700153214846; Thu, 16
 Nov 2023 08:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20231115191613.097702445@linuxfoundation.org>
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Thu, 16 Nov 2023 11:46:43 -0500
Message-ID: <CAJq+SaD5K8eH-vrhTDM47P8pnb_GjxiPN4cTp6dKji_cO6okqQ@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This is the start of the stable review cycle for the 6.6.2 release.
> There are 603 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.2-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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
