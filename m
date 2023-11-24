Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1829E7F8622
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjKXW31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjKXW30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:29:26 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE2910F4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:29:32 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6c4d06b6ddaso2018779b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 14:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1700864972; x=1701469772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtO7rC2KdoTCgc8G93D/JqXyAf1FXvlF8iNq8cF+6uk=;
        b=wUlAz1XXVOyo66hK6nzGENEESF5k6zkSHlmPgh+I1N46/esWvaetrdbNyP4J395dMQ
         4DowJ5cWY++8ArbZ7Y2feReBcmz3hC1zGzGoxQPXXblalJ4vBDrg+avTDVas7XMYN+u3
         1XxoQ5SszuQ9Ijg111gviCSnhX69kfGTogBstW3EKcYQkhnSIbp4qKUq1GwYjzf+uw57
         MKTDLkn516DF5786ziytnThTJINUmn5ptsI4Sk6nLCjDqazFZlRL4KjKLfvvxVAsDeeQ
         BN+cQfVnX0R10WxUynkHObNbd69OOr5cWLGlEMh7J7qVtBl0uKG/whBQRaU++Shoz8JV
         KEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700864972; x=1701469772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtO7rC2KdoTCgc8G93D/JqXyAf1FXvlF8iNq8cF+6uk=;
        b=oLS7oLxEuem599UCNN+jq3gpWtDmI5y9tV8IgInJWByJq8HbQLkf/beUKYsYMyggOD
         J4LBq0iaL9P8/Z8M+yOSmXqN0aUyXsVLxPa/kj1imR59XJHWiRbr0FI4QVbagDF7/WmD
         RHhp3KpBxH1l1BW7TyvWbuliV2riEgBO03m/hRsp34iS4F6vQjmvMLIye7hZKoullxrp
         R9hj4DSOjCLKznjSH8PKl/bb5UTb6HgK6JGBIarzHWgnOqV3rums+Fqk6x/b+LRvLJ5t
         Vimt85LJ2gXh1EsB18jftGZiEOXt67hyIdA8fWCNBSNnYH03Tdph/KxSv/o2qhMQ8Jc8
         tZmA==
X-Gm-Message-State: AOJu0YyErAuLSBMoEf2tWmjahYa/eo0ujKpIIT7kErkPxntzKNoUt6WS
        RDfavKeI5lx0PZkFI7hgNIUrH4j9/6t3rsAV6aQmaw==
X-Google-Smtp-Source: AGHT+IH5NbPttjWJkpecrastRq53qLAAtUK4Oazr2S/MEe65+eKyE/40H+jjaEPBL+i3tRuz7vCgnz3jR8yu91mspg0=
X-Received: by 2002:a05:6a21:3998:b0:18a:fbd1:8e1b with SMTP id
 ad24-20020a056a21399800b0018afbd18e1bmr5700264pzc.26.1700864971900; Fri, 24
 Nov 2023 14:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20231124172028.107505484@linuxfoundation.org>
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
From:   Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date:   Sat, 25 Nov 2023 07:29:20 +0900
Message-ID: <CAKL4bV4T4ncGqfZB-qJO8TE3eoeSGsb+f9AXKsX1aUZOj=tPHQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/530] 6.6.3-rc1 review
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
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Sat, Nov 25, 2023 at 3:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 530 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 26 Nov 2023 17:19:17 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.3-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.3-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
