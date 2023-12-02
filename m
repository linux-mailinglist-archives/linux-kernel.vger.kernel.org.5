Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34850801DAB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 17:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjLBQNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 11:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 11:12:59 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D4FB3;
        Sat,  2 Dec 2023 08:13:05 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cfb4d28c43so10206195ad.1;
        Sat, 02 Dec 2023 08:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701533585; x=1702138385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YDNk1jmdwQDntioUE7PoLmWlouuePgJ2nEY002JaWO8=;
        b=ATQsx+ZyrG+4lFiKUoViy/CYmbjyvDrqhvPldRjp14bvEjt+jOnZLFNO9g5ngLwZ3k
         WCQxmvRCC51pQEoEeInx4vsm6x03CveWtT4tl8amSuZ/eESlNjmw8+pzH3VpIdn20jvk
         O68KRfE7fF0KFmNivL7Uq5iXAJOPr9vSh5w3CRfS2UU3FeJT/tdNpa0UkRNnQjXPmA6g
         6UOwrw+JSXfU7PHpmIvcCPyckuCMkbyHaowYtBSu3KPAmR+X1gRMrAsAeXLXVlKTndNw
         00OL5uXewklpWSnAqtLK82IBtF9VYA+0u48UPTOqC11wJOv3Ae2co0PgC8N7AKSY2W+P
         DmYQ==
X-Gm-Message-State: AOJu0Yw5kh0vylGFtZlOBWmzqGPV83pcVM5/ZeSV2mZ2BISB6+ey+Um2
        zZFMWLCH5Mh38yPEH+fjggE=
X-Google-Smtp-Source: AGHT+IFXl18Vj2sf5hIPpAhU5jpSmmTtLLOWYzUDyF/C37ipJGFGXFwDRgPBTqayqFXWyzmduekyOA==
X-Received: by 2002:a17:902:d48d:b0:1d0:6ffd:f1f7 with SMTP id c13-20020a170902d48d00b001d06ffdf1f7mr417572plg.77.1701533584934;
        Sat, 02 Dec 2023 08:13:04 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001cffb969683sm5294260plg.174.2023.12.02.08.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 08:13:04 -0800 (PST)
Date:   Sat, 2 Dec 2023 13:12:59 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1701533582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YDNk1jmdwQDntioUE7PoLmWlouuePgJ2nEY002JaWO8=;
        b=s2qvKN6V7Q6G/T+khTWTB1Gjjrhn7zaucjqgumEyK7q/dQiKaeFg+X2C8k7PnY3gbTE31O
        9T0xLzheIsUOtzdKzP3XJ3eHs0WDq1WjaecPTz2Ca9N1lz7qooFiGlqSsrhWG9D59x1sbO
        ceXSPurrURUHwxSHuqfXjtuy5Mfl0/MO/LaTJMXswoJZEZNOgGz9dKEvW6zhGIt+/iADkM
        e/xPhiC3/YK8LOHAwo+myekk8OEalh1f/8v70epSmg54oeibjltkQxnL1ArEwjzHUJnPcZ
        y1Gt/fDpvJvAqtrnMsEzjzKq0Mgo7QSF0Hm18tz/yr5O2CjjZ4IvHI1i/c/QHg==
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
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Message-ID: <syx6uvizegwiyw7qkgz2tvxt73zbhhcq5wyjr4ryfyowr4j2ed@lcvogozykach>
References: <20231130162140.298098091@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/30 04:20PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.4 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Dec 2023 16:21:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No regressions on my system

[    0.000000] Linux version 6.6.4-rc1+ (rbmarliere@debian) (Debian clang version 16.0.6 (19), GNU ld (GNU Binutils for Debian) 2.41) #4 SMP PREEMPT_DYNAMIC Sat Dec  2 13:03:02 -03 2023

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>


Thanks!
