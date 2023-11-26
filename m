Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39BE7F9586
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 22:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjKZVfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 16:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjKZVfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 16:35:47 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBB2101;
        Sun, 26 Nov 2023 13:35:53 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-35cdbb68b58so334425ab.0;
        Sun, 26 Nov 2023 13:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701034552; x=1701639352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dfp1Maha76BpxLHUK10BZqpW5acoPNNjbw/39vxDgBI=;
        b=QcYlUUPXSBgJo313LrAqOUFmuO+RiYPgSczAQ+Cq1nJQnn7C29fjRvNBz5jv+Upht0
         5kRo9lqkUangLySYgXsioC6HWTQki4XXoGZNPpq3Oq1y3P1rxBLb9CDQyGGt6VYL5JjX
         gBZd6nYUAudNO2FKugzIzJc4BngwtkunD/nogUs1ZFz1VRbl4kpL3CxSI9cy8fKkBVgz
         mmfplvJXIgISbSJYfYdBE0G3kLVkgBJ48lvkjrkvGHqoNvj9g4FE35LWI7NzS1pFVluC
         32m5FRnInAboR32pj/CZV+nyuorUPtfjX9Z+klf5ZrcdQyqtHgZTJEdHTNeExj1iT0Jv
         vkNA==
X-Gm-Message-State: AOJu0YzNRrERGjJGvRvPNsVtmIXULsPepf1PsnQDhrZliY4Chh8/0CLR
        E7wJaew5WoFXpRkzw+KHsVg=
X-Google-Smtp-Source: AGHT+IHZje/z0vUDvMtxGVRjEHBpx++lbgNWdgSrCUTgTq+SAqmUvHpQYrVKOzTp4eMvNY3BQXezxg==
X-Received: by 2002:a05:6602:2ad1:b0:798:2415:1189 with SMTP id m17-20020a0566022ad100b0079824151189mr7364302iov.12.1701034552513;
        Sun, 26 Nov 2023 13:35:52 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y5-20020a5e9205000000b007b37b1226a4sm1627619iop.42.2023.11.26.13.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Nov 2023 13:35:51 -0800 (PST)
Date:   Sun, 26 Nov 2023 18:35:46 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1701034550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dfp1Maha76BpxLHUK10BZqpW5acoPNNjbw/39vxDgBI=;
        b=DrKL4Uf36ZkECOdTVZ7fFMaD12uW3+JNui4o0PFaAoO/+Cj5njaIfp/pOiS7/b4X47xJuK
        WG0KHRi2S5U48CP/F1jbFxWUYqLYtPcCdIQWwC6Z3tUvVclp1l9VMYFofiWrGIfCtpQCCV
        1ZOwZfAsQ8CsdUqLN5LRexHmNyowFrUzz/uH3UJq1G/hJDJJW0H/iP8y+hPQciTTpkU1kq
        zRGoov3SFajHaLmiWSd0Sy2RioqGvOHefdsLx1MWg4E2bmbKb7t+9/YHbjdcYEaP3uMEbw
        9WaDk6NQjJ0wK6OsCQ7xhbjc3V8ZiGj6G1GP82RQyebYBlK2eTsMGrYoKVsn5A==
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From:   "Ricardo B. Marliere" <ricardo@marliere.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/527] 6.6.3-rc3 review
Message-ID: <ocdvulmynucsniuh2al76ravwdjjrhijxcfknjidhmmsff23mb@u2ntehh6lykd>
References: <20231125194417.090791215@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125194417.090791215@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/25 07:45PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 527 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 27 Nov 2023 19:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,

No regressions noted.

[    0.000000] Linux version 6.6.3-rc3+ (rbmarliere@debian) (Debian clang version 16.0.6 (16), GNU ld (GNU Binutils for Debian) 2.41) #2 SMP PREEMPT_DYNAMIC Sun Nov 26 08:04:31 -03 2023

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks!

-	Ricardo
