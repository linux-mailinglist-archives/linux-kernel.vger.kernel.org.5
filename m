Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CB179D108
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbjILM2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235301AbjILM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:27:22 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF6010D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:27:18 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3a9ee3c7dbbso3928038b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1694521637; x=1695126437; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jl06CrRvDgpTNRZmZef/yKV5B26LF5da0hksP8EsMo=;
        b=OJGkDKOk2/Sb+0GVKOtx2AZv7t7RV8boLRANTRrgIhMwHcH4vAp6KeX3qDvYZ8Eibw
         11POK9yZXY4pXHxWA4TITCLb5b3Cw7+A00st3bUbtJSpDRSUJCX69afCLYW5/Qon8KyR
         TxRTs3A+1sHoDO3rjjwogK9GFy0HfxrVAdRNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521637; x=1695126437;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jl06CrRvDgpTNRZmZef/yKV5B26LF5da0hksP8EsMo=;
        b=BSDv3KjBJJ48Mz9UvO43pzgvmCG5/AfQfE+0j0gciGDOtdpA6iqrnr8LgkV+m0t90m
         iPxJlU7GliATO6y+VQvAATzJ1bT2e0KueXZiwimQbAFqeOLoVQKQRea0xmv+TtIyR99K
         0nkdsDwoj6kNX9k2YR3IkTuLFSvF7ZBFtgYbZ7PYcWhOUlwtFWAftiMcuOcSYPp1UdDo
         0hskaH6YV7JkOYLah0Yr0RqrtEmOlCWlOO54pKiDYgf8tMUCyeGOc1ukTtA7JDVZGD8i
         7ivpxJvSsbjEWNfRhHbprT2EIW+OTi9qPTeTSX9su4zs8+iSGJk1WkUG1qhI3YUgd04o
         gqPA==
X-Gm-Message-State: AOJu0Ywgb3w7Dwti5u88UFduSNvd8U7Or/pSCO5Fc5YG2CQysVk3tzrf
        EAOPG3FV1oCFFu3FatjwE6J4fA==
X-Google-Smtp-Source: AGHT+IGDfW7lad7Tfz375iAUI2X0OYcP2OBbBnUmiyA1DuosLZBDGCoT7qlc6cqTUVMHaEmrf1dhTA==
X-Received: by 2002:a05:6808:1141:b0:3a4:3072:e597 with SMTP id u1-20020a056808114100b003a43072e597mr16456320oiu.54.1694521637430;
        Tue, 12 Sep 2023 05:27:17 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id h17-20020a056808015100b003a7847cf407sm4116228oie.44.2023.09.12.05.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:27:16 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 12 Sep 2023 07:27:15 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
Message-ID: <ZQBZI3Byx504+Ys3@fedora64.linuxtx.org>
References: <20230911134650.921299741@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 03:36:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.3-rc1.gz
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
