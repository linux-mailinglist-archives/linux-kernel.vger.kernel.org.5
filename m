Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9AE7A8F87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 00:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjITWjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 18:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjITWjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:39:00 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7066FCC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:38:53 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3ade37f4e50so216336b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 15:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1695249533; x=1695854333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1CFASXI8WL+dneofPZI+e0hjnEpkK/1rD0JOrrCGQjw=;
        b=dI85TGgUuKbqlNXCfnvsqBMCo5yvuswHQscujd5VMJtGvCDyLqzHlHgnNPR0DQ1eCG
         7vkeue103rD2OB7HZTx5GFt51gad3Cv5AgAkAlpPmCxtXAJJm5EF12OIR8NYfNLkyq9Q
         4yGsRhylz+v15m+kDLKL9E5S8AUBR+Pw3WS70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695249533; x=1695854333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1CFASXI8WL+dneofPZI+e0hjnEpkK/1rD0JOrrCGQjw=;
        b=Rv3elpXrWSVlKr7rlekW1UVh70cMAy9iTFKIfNrjIvYCjPGa9x0I1WiVTL9qOXvcR/
         pco+osaceCACCHgzYgCGeMThAsjXjITvn8atb8KXl7pWprSwtegxjvyShWy4kO3R49nS
         lJ11Pc5Skv4FCcdjvKRXMBH5RJw1vmKrPscR/tMklFlbch4HxCtiJlE7W2LYYNyMvcpH
         asRKYoDhGOvb/upT658bwOvuCXvf2nIM/nGcPWiQvcAlXYoa1ozEeen8h86oezo1Ai2+
         k0FW2nkbIIOkaMWgDfPL1Yz9lM4jc8bXnKnwX4rVUooH1EHf1cppBvrdwRBhC6ieOPY4
         Ax6g==
X-Gm-Message-State: AOJu0Ywv4o1/Uqt1shbj7arfkp4YQR+NP1snxLSMiPoqmKeFH/DpyTeS
        mGy0gDCo3ngh6zASoPGpuVRxfw==
X-Google-Smtp-Source: AGHT+IGhUbWmEAffQC5yTBBemEJib/r36R7qLuhAsphONKsVaV8sfYP8KCR7H+a40zjz8GJXoTbr6A==
X-Received: by 2002:a05:6808:1912:b0:3a4:ccf:6a63 with SMTP id bf18-20020a056808191200b003a40ccf6a63mr4107683oib.55.1695249532790;
        Wed, 20 Sep 2023 15:38:52 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id v14-20020a056808004e00b003a9cd23980esm52020oic.8.2023.09.20.15.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 15:38:51 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 20 Sep 2023 17:38:50 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.5 000/211] 6.5.5-rc1 review
Message-ID: <ZQt0enUSOWLGAReo@fedora64.linuxtx.org>
References: <20230920112845.859868994@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:27:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.5 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.5-rc1.gz
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
