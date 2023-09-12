Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD179D67F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbjILQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjILQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:38:35 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96742CF;
        Tue, 12 Sep 2023 09:38:31 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-273ca7ab3f5so4054008a91.2;
        Tue, 12 Sep 2023 09:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694536711; x=1695141511; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VIjorw0mAfYvUocMlUp9ngShL4M6Rm9ZrInYkBC19Q8=;
        b=AN6wRCNd23+54RwxRijPHkuIbmA0cyfSH4AhgvoflxVMW2y3HOGHwkMbv4J6spbXjV
         l42+DwQxxrjbLep8g4HZ8V47fli4IGzwca4KqrRUptTpJN1T+eclVBzxQMcLqxDkQnnY
         e6Ioff40Ri3zDy2qyH9WyJUWwiray13Il6zQqPWCTGwFTMj2LZZjbw+wypjMV5mB1Nx9
         tj2NX+MGI/GB+yIOkdVP5DD3Vq/fozN69eh3Z5qfSlBs+eq1LLu5qi3jONnaRcxtt+bj
         5vov8Jnfs4mKs2WtMt2jMivCmGXsNJHMTFrmweoRtkexJiHQXKhFE+FHtjVpkO7lJBx/
         WVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694536711; x=1695141511;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VIjorw0mAfYvUocMlUp9ngShL4M6Rm9ZrInYkBC19Q8=;
        b=dMcI7LrgZGp8dq1EPOd35MzwnQ9bYoQRd7PlzXcAK07k+LLDPq2OKkYyYu7Px9XdDG
         Rux/k4Fqc/sroxepxOhhugYOmb7tpMkPH9s4l07YMdP9dq/rstcpCOIXhGL0nCKl9HSQ
         68FvGNDVOtcKK65bVMuKOIdDmu/c2NkvOOhcNEnAFkqUr3TVjg4n0SgQPczGQKhoNGOL
         hgOU/7V5LWzediwPOXKQP8uekAfDRLnoYnkORZIXpzFPKvd/dYkcT7OeO9dGwYnMWgEZ
         aMPcahG5HZtosKioevPjn3xwJZMOU/xs0EHCftmpFOPd4RDNMXSrJgFBNFEUNyIBZ9N5
         jykg==
X-Gm-Message-State: AOJu0Yy3vUdqKDBeE/6LW2iD1gFBzWuEKt/x0yuAqwu/4cPFYRPbiPXq
        UCqJofHka6+8xYb6g/M1rCkx2bMiegLkbTo4Ml8=
X-Google-Smtp-Source: AGHT+IGwZ8zVFarCqHn4qA49faOc/j0LC1UjXq/jaeq3LCN2xvhegJ2XX1lBFRsE+81ZHUaVYgCKUczj9YlvXjYCcgI=
X-Received: by 2002:a17:90a:fb52:b0:26d:3d3a:a198 with SMTP id
 iq18-20020a17090afb5200b0026d3d3aa198mr9804553pjb.42.1694536711006; Tue, 12
 Sep 2023 09:38:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134650.921299741@linuxfoundation.org> <CA+G9fYv7PymkiagSGFU-BXG43gHm2NYDd2CNJw26C52EGhjpig@mail.gmail.com>
In-Reply-To: <CA+G9fYv7PymkiagSGFU-BXG43gHm2NYDd2CNJw26C52EGhjpig@mail.gmail.com>
From:   Allen Pais <stable.kernel.dev@gmail.com>
Date:   Tue, 12 Sep 2023 09:38:19 -0700
Message-ID: <CAJq+SaA8qPLxod62+an6ygwXE0Np-LM66WxG7oPg+4ZEpsyTQw@mail.gmail.com>
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
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

> >
> > This is the start of the stable review cycle for the 6.5.3 release.
> > There are 739 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.3-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h


Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.
