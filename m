Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2016378FE7B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjIANnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 09:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIANnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 09:43:06 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12831982
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 06:42:31 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1c4d8eaa8ebso1221258fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1693575746; x=1694180546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=605GXJuY9VF2iuE9QUTMQaSiwWf8mYV89VIA5q7Q680=;
        b=CnmI8ssBCCoJ6N4763vS/gHLdE8kiq6w62FEtZF9mDsMVEozHa54YmaIoQY2XrknjM
         hpFKKWv7kXLvCDnL18TwMfxPg4ZBuZx5DMoK3Jw8MHfD7fgkmXG4LMskYPLDBIx10Poh
         gdUbwad6i/fS4eG/qRTIkLCUoSVwwieB6j6f0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693575746; x=1694180546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=605GXJuY9VF2iuE9QUTMQaSiwWf8mYV89VIA5q7Q680=;
        b=AjjDAecrBwBHCCLSW2PKwWl5qB3FKHtR2GhXmlMJh/IRWX0NmDGM+c+At06dLxHD5O
         32uV0o7xwYUwNg3JSW6bPu9pX+3DnqIs3x58ilidxiDN5clSMhrtEbCw4H0AjG9tSNW2
         xxOTy7V9ZYHxB+uyp6raThjNjBrXCyqu8fRVCOF97ES4hhafkvxMAfRZsGmm+ORFPKTS
         SB8SbdXVoLfEE9gSKqdN1tWrgqd72EYFczPF8z1E/wA6SE4Pb8geYCYtuN2iSEI2mWPs
         fsDCLc3y4HRdAINvVX9Wmnukv1Ik1e+FTt9rV1fqW/gXYcWJ9GDC/xZbY33keCQo9eBR
         QUww==
X-Gm-Message-State: AOJu0YwMt+fKLGzVjkPLjJxlEF2HjB0Jw6N8m1y2LNN8sXZQrHuVm+D+
        wIl5bJ2agutKoei1d4gQmVq08A==
X-Google-Smtp-Source: AGHT+IEnz/CwVS9UgmJ48qny79FGnNZJqSMHcHKkMABKmFxPd2rM5sdazTnUXn1t+J4QxMgAzqE44w==
X-Received: by 2002:a05:6870:6312:b0:1bd:55be:5880 with SMTP id s18-20020a056870631200b001bd55be5880mr3066060oao.42.1693575746481;
        Fri, 01 Sep 2023 06:42:26 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id t23-20020a9d7757000000b006b83a36c08bsm1792754otl.53.2023.09.01.06.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 06:42:25 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 1 Sep 2023 08:42:24 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 0/9] 6.4.14-rc1 review
Message-ID: <ZPHqQGaILoFNy6tX@fedora64.linuxtx.org>
References: <20230831111127.667900990@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111127.667900990@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 01:11:27PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.14 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:11:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.14-rc1.gz
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
