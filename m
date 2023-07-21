Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A8E75D7D4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGUXO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGUXO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:14:56 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C821719
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:14:53 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1baa6fc33f1so1894812fac.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1689981293; x=1690586093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8pl4+KEkTr4riPSItxRj6r6i2XVOObONgI+gpH8d55o=;
        b=QqAx9akK+6wVnxjRUgGX3AKizMFHDaWo1bP8k+aXYARshZGKcMt4etFHdi4ISpR85A
         yM93agVqtl8ELOR26QiyV38CKkedrrnrsjVv2/Hea7YVRUp18NXqmrsQu4DtzXV5izqQ
         nSmoNTVql0ajmSxPWht67scocCyUuUYScAEBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689981293; x=1690586093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pl4+KEkTr4riPSItxRj6r6i2XVOObONgI+gpH8d55o=;
        b=gezihcFbdhbvdvffmmlt+GL3DUUaOZjda7MhzXduOwwuyMqtn1ku3Osg2bmq/iFWEP
         1El49z9n5iCzueBIU+hBIXCUOSRWXw7oPvRgWMhfKc3sN3S2GZ2zmEDx9NXSE2D3nHGr
         Gnff4GdLUZ3I9hxkRdIkD1p3Mf+Dbul8WQOnC/dVoN6xjjDfnxNBBMAk/MZV4cQ8RO3J
         75vL6yYyGKZkoNAruzgoaB5WARZwmkdlJi9AxbfV2cGofiG+zxgpbFsbo5/AjEEdlDTi
         AB2LI4kR8h12LPR9ueZPyjSFORUcwb8vI0ZR5k29/f+vBxvgKw9qXmbcZISnS+XGLe1+
         qcUQ==
X-Gm-Message-State: ABy/qLZYQJz2Rgl7zLUCO8c41+gLg5hr0O8ltxGp4lsmqpos/2vEwy/6
        duWjzW9rlATaQqSIA88kNKERzQ==
X-Google-Smtp-Source: APBJJlFi7ua3WeSNgOWmcXMexHBw/DElyBpUADYByVQ1nOPHIcHrf2suS+VE/wRVlFb0YPikGmRjfA==
X-Received: by 2002:a05:6870:8091:b0:1ba:7f7e:2b20 with SMTP id q17-20020a056870809100b001ba7f7e2b20mr3907660oab.20.1689981292798;
        Fri, 21 Jul 2023 16:14:52 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id h40-20020a056870172800b001807f020a39sm2003909oae.12.2023.07.21.16.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 16:14:52 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Fri, 21 Jul 2023 18:14:50 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
Message-ID: <ZLsRajeb+IAwynza@fedora64.linuxtx.org>
References: <20230721160528.800311148@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:01:49PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 23 Jul 2023 16:04:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.5-rc1.gz
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
