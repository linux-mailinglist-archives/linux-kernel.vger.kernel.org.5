Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C072F80128F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379192AbjLASYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:24:46 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB139A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:24:52 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id 5614622812f47-3b2e330033fso539725b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1701455092; x=1702059892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YReR/ElyLsL0HPHj+5ElEXiMYpqxoQVx7nZynS4QGhQ=;
        b=eKEBS93+jIUELnJTharIDMKoTEzFqLAUuv2msgc7j+w7ZXNUHv3MIY4jvB6lGKx8m2
         bkjBaY4vMG2ffefM1uBmIcXjd1l+G5wX9Nju1xK47KURYDB2VgOPn9GDZYPnS+zuGmV2
         patAy1vTRttovgcCrtL4+iUZhuQO6E+K1Bprc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455092; x=1702059892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YReR/ElyLsL0HPHj+5ElEXiMYpqxoQVx7nZynS4QGhQ=;
        b=tlsHmIXc60W1y7geAWjl4absv9lnkl1TGomMtQYaFpeeiUSrQ/qe6NfELQab0GYdri
         N41kxTXYj6neUyvfgdN0gxPkxv+a6Xh6JlEHRe41YqMvux46MnoqLPkMHNk1nFek47EK
         szWaPpAXazR6CEEx1XRHavyrQsogvKNhjz2hKpzMS+v8U1hddR7nW6eotbtBsIITYc7H
         gsEyaWkPQ44JVg4+HfluNLKtNB4wap7JwWFeMmAzVVNdBbw72b7TeUyx+Eyvp05N8+Zr
         9CXwjK9v/rVB9cLWmRfJmTEGiovrLcEpU7PsMS4kFhoMA97X9dB9gC45Yuzu7O5oyw/y
         r+2Q==
X-Gm-Message-State: AOJu0Yzm2KSljqZL8f8UroaOdBij6tR2kCA0PHgruvR3c5iasucPgS7X
        c6m3k3rtskVoUn6GKJzNv+66Kg==
X-Google-Smtp-Source: AGHT+IGPgafOly1IVWDEaRcvfphGZBGLi4CqUruCxwY+paDAHENLzM84AGvunQeaAC0WN9Esn1lKIg==
X-Received: by 2002:a05:6808:2c6:b0:3b8:5e9a:b2bd with SMTP id a6-20020a05680802c600b003b85e9ab2bdmr3632976oid.15.1701455091793;
        Fri, 01 Dec 2023 10:24:51 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id be25-20020a056808219900b003b898ffd8fcsm631188oib.50.2023.12.01.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:24:50 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 1 Dec 2023 12:24:49 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/112] 6.6.4-rc1 review
Message-ID: <ZWokReR-lD3mFIIo@fedora64.linuxtx.org>
References: <20231130162140.298098091@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:20:47PM +0000, Greg Kroah-Hartman wrote:
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

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
