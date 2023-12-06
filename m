Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84306807AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 22:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377116AbjLFVmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 16:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjLFVmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 16:42:52 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7A998;
        Wed,  6 Dec 2023 13:42:58 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-58d12b53293so139572eaf.0;
        Wed, 06 Dec 2023 13:42:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701898977; x=1702503777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G+/fJM3jhJ9Ym3ibRvsgfYVd/7GnLfdEWeKgca1GSDM=;
        b=WL6SSoZKkmBmj+Vu4w16S6LdsXnO7fBgo0eEW1ucgEL2WwxJPo9spm09hEpAMZhnJr
         hOm09mwoMLsLoBobYseXZLWytW+KQvdoyVp4KNLpHO2rXjrovDdDJr1yqAIG0rTDu9Q1
         yHVk6yOqbPaeOqGtF4TVOMgM84g1t81QPJnLbnKW0inx6RTfvnePVTia9La7PiW09Ilz
         iGJBYIts0FLSDjlwVYigceO5zTySJerJA0opZXsXUwUhEVrFfb8FzRjrdGgeihTldE7D
         K0wpseqdRXEMaaP91gKCFV6zb/FTt5BTD6C68xF2mcdTPxS4LFfEorKBKnr582ZrB0vm
         xk9Q==
X-Gm-Message-State: AOJu0YxmIhteHWT5QnlYci5XMeboa7o6abcv8Ku0bwFtZc9dmisWDXey
        X8hcsRnQDRBBgo3EfbIhWsI=
X-Google-Smtp-Source: AGHT+IEGaBIM38k+345rksTXCmqkaZf55qi/QOP58bKt3rV7Q69ICIjRIzZGQ6PJVsI/HVeMIJBjZg==
X-Received: by 2002:a05:6358:7e84:b0:170:2abc:6e34 with SMTP id o4-20020a0563587e8400b001702abc6e34mr2358249rwn.19.1701898977379;
        Wed, 06 Dec 2023 13:42:57 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id b1-20020a056a00114100b006cb7bdbc3besm447820pfm.17.2023.12.06.13.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 13:42:56 -0800 (PST)
Date:   Wed, 6 Dec 2023 18:42:54 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1701898974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G+/fJM3jhJ9Ym3ibRvsgfYVd/7GnLfdEWeKgca1GSDM=;
        b=SK7ZQ7m7+KS+DkQUUFCZ8kDv0apQxPzOOmE+WUEaUfR4yg07D0DfAWbIkfyrHlnqOkyLaA
        u1fXezvaOIrBWqe0X38jIl2m/RnuU34waHDpBbT4cKFcFEqU/CsSA9rLoVLPSHqrN15yIr
        TMxf4gcQuQtAVryDgbTLrBmiCUTnHMR+6GR+KL0Cq29jap+abUaz+fCUQiBoT+LJ/wLXFM
        jFFa8l6XjypUwVNkDG+Txs76A/gkNfvS9ul/D9FaEUDHSf8huAELX5nUv1lq0+/+PCpV05
        5XydvWtHBeFRk+/E7bBv2copG43W8KH7V6N2H5o6zrH4N/GDp+/ayiyusK7NQw==
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
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Message-ID: <vtxguldy2soodrfvvfqrvfojlfpo66axtaodszyuguc73mfh4u@qbtwh5qxjuzz>
References: <20231205031535.163661217@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
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

On 23/12/05 12:14PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,

No regressions on my system,
[    0.000000] Linux version 6.6.5-rc1+ (rbmarliere@debian) (Debian clang version 16.0.6 (19), GNU ld (GNU Binutils for Debian) 2.41) #10 SMP PREEMPT_DYNAMIC Wed Dec  6 18:35:57 -03 2023

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thanks!
