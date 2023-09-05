Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64FE792D15
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 20:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbjIESIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 14:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238420AbjIESIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 14:08:23 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CCECBA9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:29:15 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7a257fabae5so996500241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1693934800; x=1694539600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7h1pOWAWn2f3/0pIwmJa14UCgmY4tfc3A2xWVFCKn/A=;
        b=Q8QhQM3GXvB7j6yR84r8U0OebCuFVooe4FYtys5EtSb1ub1QCdZ133gfuSx3wgk2Do
         pnj9NXS/k+NL7Xg0LwpqnML3Rb2gwY9sILWtWJ9xDSlhnDmWMhMLWmRjIjJeLkrEDnXz
         d9lwBrz+IBNRuE36KIGCdyC18QSMxb0rpJZ7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693934800; x=1694539600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7h1pOWAWn2f3/0pIwmJa14UCgmY4tfc3A2xWVFCKn/A=;
        b=YYUToWpcJGE0m3hNtGNcENdXfhcAoPnohf15xm0b/tlf5hXIkq2C5JMjCyTfz1u5a9
         PXG45oD70vyoUFIwUselMYiDZSyIpL+nofayruxigiRk6r+rBj03uFslf8f8sCIc/7PT
         /rBi9RCarozbQSeri4elHsTQPJvLqnvBlLc2HKv4rIgIQIJkhsdCbmkTn1LHdiyeOlKM
         pu8xb0Zsft4Ql/w2NBryyMuiYml5FOE015Vk9umO7490vkaFbgHbYF0UoQ83ZinL0ObG
         jKDFutMphr7WjmGUoVRF7Rht0j3iuBYd2M8KJP9XbfdnlyeU6UUiRH8onn+cHkhGUIO/
         ZNrg==
X-Gm-Message-State: AOJu0YxNuA+UL+ufqGh9yATZPOHIgLglXW/1o31sPaNX4B++1rKwprgW
        C48YZzqN9sM0UdaNHmM6Llt3z4dkiAQsPOlNYurC85PY
X-Google-Smtp-Source: AGHT+IHyoieeDB0PNwVvLRlAczgv2xHwUxOdj1W5kcWlyPok77Aa/jXmKT28xB8W4J/4Y/qekumOfQ==
X-Received: by 2002:a9d:4b05:0:b0:6b2:9bdb:a84a with SMTP id q5-20020a9d4b05000000b006b29bdba84amr15026049otf.32.1693933771878;
        Tue, 05 Sep 2023 10:09:31 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id t25-20020a9d66d9000000b006b89596bc61sm5666307otm.61.2023.09.05.10.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 10:09:31 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 5 Sep 2023 12:09:29 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 00/32] 6.4.15-rc1 review
Message-ID: <ZPdgyWKSJkXf7Q/z@fedora64.linuxtx.org>
References: <20230904182947.899158313@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 07:29:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.15 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.15-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
