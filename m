Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9557E46A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjKGRPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjKGRPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:15:44 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E457114;
        Tue,  7 Nov 2023 09:15:42 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-59e88a28b98so52227597b3.1;
        Tue, 07 Nov 2023 09:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699377341; x=1699982141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SrHAbNTd2R4zfKcIFl+kmISGlspMZzCXcQgCw8OfYD4=;
        b=wSERoKA4e0HTsQRc+V7tYCLzlVPz7QfnfYEW1e8MU409H868reWvHbM1cWfjX599/K
         Z1TNNbZ4vXuqaURP026ExrxTnDZrlNZHfCFaf/uARnajTiVCJGMo74P50lz22muA/EfN
         zKywIHtLKq3Zew+ebqjEyyAYdrvThTTX7tx5ffw3mX6e/yraCwjzSurU2F2at3cwHDaO
         mCa67vDIhvsLJyLZhgmVBaSQJsQOdnguPIX6QCDugj7fTZHFfHH/fN+n1SlXf42Thzu2
         +0cHeGk+2nnt7cHebcyB0MsHNvwX1kYb259cHdhXHMg5g0vitl84hcH7QvucaBcUq9l3
         aAZA==
X-Gm-Message-State: AOJu0YxSH3fjO+jbNYuPftT/lOY46KyQYN+XRcakggNjprcxbvOamRb8
        essa4XpVMuExGQdJcctpHsM=
X-Google-Smtp-Source: AGHT+IFqvZgNEW6f4NxT41MVDR3JkdFtJBD5fq09Q2pzUrKVMSkjah6VwIPUMRZAAfPax/jI2fjkOQ==
X-Received: by 2002:a81:7804:0:b0:5a7:d8c8:aa17 with SMTP id t4-20020a817804000000b005a7d8c8aa17mr2471358ywc.13.1699377341561;
        Tue, 07 Nov 2023 09:15:41 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id p128-20020a0de686000000b0059beb468cb3sm5837284ywe.32.2023.11.07.09.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:15:41 -0800 (PST)
Date:   Tue, 7 Nov 2023 14:15:42 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1699377339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SrHAbNTd2R4zfKcIFl+kmISGlspMZzCXcQgCw8OfYD4=;
        b=VyozDtQkJX5HsWZ4FuyrhgHdZIHMcYvzOTOA6HthNFsobnSY9vii/aho2PRORxUS96pGlB
        7jECO7/BjUn/RAaiOvdJZwMLcP1Uy6LKcCDjip171WAnCui3AdsNAzLcKtpyBus+s5f2Zf
        76cNyh2acJwriqgDtE3I4HfQNrVYpfBYvlZtY80STQ9Y4doDeIUTHn4VOADskoVDouFw3M
        8BC0iwfKr2ubstQ3ESLsf6KuCZvrDMOR2yU9labXaGyKA0Hb69xeXHEfgz0bRecRICQ9y6
        V8XsyMJcBzv9pTg5CCIH/buSNNfSSpWkQkxxy6m3Ub/8WDNdg6fBZ1NYeeugKg==
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
        conor@kernel.org
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
Message-ID: <pluy2xbt2qyg5irtulf2ukfbjngsbsm7mtxh3hbed3gwwtt2ao@zhcn7kn45oil>
References: <20231106130309.112650042@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/06 02:02PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.138 release.
> There are 128 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.138-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No regressions on my system.

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thank you.

