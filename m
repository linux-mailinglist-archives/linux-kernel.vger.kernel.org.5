Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92975792C96
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238215AbjIERkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239423AbjIERjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:39:16 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38E36950
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:14:07 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1d4e0c29028so1460281fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1693933906; x=1694538706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aKkV/gdpVbXWeDor+5ZiimyzgnnKqYGNlXMHbycLo6g=;
        b=PIFP6jCQQVc123Msh8lgfyZSlNP0DPcmoAIN3f3cpH8es8msPLaTuWQ7nDMXxb3Fkp
         gg+HrtSGBPMrB7NQ96R2iqVo8Qiozy4/KYvfBVUFUMdJP2//A8jqrHtOaoEveGj3i2ac
         p06VLJYoEpKlapA7AEnGhrBlpj/BQMu/geRl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693933906; x=1694538706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKkV/gdpVbXWeDor+5ZiimyzgnnKqYGNlXMHbycLo6g=;
        b=TcEzrBXMc980ApqXljSnH08IKsm74hM97mgEU0frzmtr2WVvNTD7OU13m+jWSwibpR
         35IKJ1TP23HsxT/UDmnRYsh+2ACsTJIP3Qa0aHtJDV3v/JhcppQVGRy9XY4nueRBg6ds
         twvzDS+w9cfPAoR7KGFNHsLp6KH+muBJ+HpzrqH9yB8Uil43jQRsK3UlvV7Y5kMkWgn4
         yJXDk8UjklqBksdIMqDbG5cGnXK+hazXI7lQ2bX9U15y/WCtVukyURbyO/Yay8cE45j9
         5Isdpk4mWl7i2mJUnGeQx6Wm00Wjb3pbVeWr+KjkIma1j6m2dASglwN8xNTpRjCsmY7X
         1VWw==
X-Gm-Message-State: AOJu0Yy7TarSarOKUDNtuCSQsGVvWz1f/UTqr4jIZopaKcztewvklqWA
        q97aB3deGmkPHDCOlSAux24t/w==
X-Google-Smtp-Source: AGHT+IEzhtU1JZMoj8kA++Rihq9U3PC0Oyza2Z9UchGDwNwhqqyrJHcKEMD0nUuF32FRQAGsyfAr5A==
X-Received: by 2002:a05:6870:78e:b0:1bb:9c27:c7e6 with SMTP id en14-20020a056870078e00b001bb9c27c7e6mr16121041oab.41.1693933906036;
        Tue, 05 Sep 2023 10:11:46 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id g1-20020a056870c38100b001bb919237cesm6736729oao.3.2023.09.05.10.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 10:11:45 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 5 Sep 2023 12:11:44 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 00/34] 6.5.2-rc1 review
Message-ID: <ZPdhUB3R/vYp+zxz@fedora64.linuxtx.org>
References: <20230904182948.594404081@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182948.594404081@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 07:29:47PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.2 release.
> There are 34 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 06 Sep 2023 18:29:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>
