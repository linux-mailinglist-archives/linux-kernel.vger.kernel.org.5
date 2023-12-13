Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FC481155B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235415AbjLMO4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442032AbjLMO4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:56:46 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BAF11A;
        Wed, 13 Dec 2023 06:56:51 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1d345b187bbso13772415ad.0;
        Wed, 13 Dec 2023 06:56:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479410; x=1703084210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=02iXJsr8I1Hx9DZ+EoYreRi3wtC3FVG+hruJRxTtQ7A=;
        b=qVJlyFFwUG045BNSPFryRYReOm2TTo5lFSSEFYkEbgdx/vAkfFU8MfWWVLSMsvn4Zy
         WYC8s8w8iIAyUnAs2fb8UT5SJQ44Xn1AzKx79vZ/VxuK6NG7yJbhcMb8woaBhfA8YUfz
         6VERFZADHGNsLh26IOVO1vAJOhEAZOp2+5D5lnn53emeCZqAR/D4OmMtvbpgFvy4j1RV
         wo2zewwI7sScrXnbt9pxo2+8+69dMC3pPYJ89GPIO+Ysafnqpq6JYyWW3+9O/QV6bv6V
         0ubvf/yF8oRWwgim1nBLw92Tj6c8jEI86GZ5YYHVpIvtwRz+t/Kh5+SygeiPJ8+NNbKD
         0pDA==
X-Gm-Message-State: AOJu0YwS79G8fWhaGf8UpOxHWI9xOpssanfRSXQHaf7dhoXfm/yEaQlB
        hWsHzDnQir6HDLby4IxieFw=
X-Google-Smtp-Source: AGHT+IEUekH9GLpWwt0/WDKEjJs8j4o6eNZpMgpQCDoKoClcvbEREqLdQ6LnT8C4MXV9lTmXxI08yQ==
X-Received: by 2002:a17:902:d481:b0:1cf:f3a0:3c8e with SMTP id c1-20020a170902d48100b001cff3a03c8emr9251575plg.28.1702479410447;
        Wed, 13 Dec 2023 06:56:50 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ab8700b001cfc19c2d01sm3288445plr.296.2023.12.13.06.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:56:49 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:56:48 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1702479408;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=02iXJsr8I1Hx9DZ+EoYreRi3wtC3FVG+hruJRxTtQ7A=;
        b=b0wEgu04ocg3IOIKXrOQ3dQnCw7yQIdZVesOv/Y8h9L8xhaMS11m4gTAxV9R5XQyF4zEWi
        H9YIT5JiSDo2r7YTljqS/VyihJGYFNCd0S1StYDmR3ICAiKLOeA0mSra8G0ecx6fH8DGjn
        LVk6/LICEyRx84geKZWBAK/xS8X3/z3agSCl7L7hmGUF+cH8eZ8QZ+l9dBgzLgk/RhW7AG
        izGup9AkxwxOHZg2gcHhwGVgH20PIVivHnq1SKbu1Rx3Ss4WeDtRt2MAgPz//csgxgFJVf
        zJKd6UyVEtNSRQWkFSCCD1daGG42mmc24gOcOxrYtp8QzNF1gEdI0n0+GCa4FA==
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
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Message-ID: <zzonspyiqrsxgs7ygfpuwo5pbqeuhj5arizokbungiwwms7tj6@zkwnv2fwk2hf>
References: <20231211182045.784881756@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
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

On 23/12/11 07:18PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No regressions on my system:
[    0.000000] Linux version 6.6.7-rc1+ (rbmarliere@debian) (Debian clang version 16.0.6 (19), GNU ld (GNU Binutils for Debian) 2.41.50.20231206) #12 SMP PREEMPT_DYNAMIC Wed Dec 13 11:37:51 -03 2023

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks!
-	Ricardo
