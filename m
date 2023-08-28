Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEFF78B57B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjH1Qld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 12:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjH1QlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 12:41:15 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E25110
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:41:11 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-572a7141434so2093754eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1693240871; x=1693845671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YxFxiHk+V4WPvxmce4sVK68Zw1aZ82QkNmJDshmYps=;
        b=ABFGf+UCJrERZ8Rir5RFXLgrlhU6YGPPPNs/LtQKppVzEbwXKMi0JAY05X9oAWQY+T
         O5CXvHrlicbhWI6ensHMDap3S8cYH91eWCOkaRCloyf7iDUTEWprj0HHUmBlEHO2ePao
         OE6170fgVEmXv38ohxGU9vCGL7XRS9B69aCUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693240871; x=1693845671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/YxFxiHk+V4WPvxmce4sVK68Zw1aZ82QkNmJDshmYps=;
        b=Cq/cEnWUM03MXNcJIQfXKz4W8HUTPUJLlfgxtUCNGr6oo+pfBOobPXCsGT7YCpBOs4
         6U1DQF15Xrb6Ht1V7I5DEe/2N3EDbngCvUXXitm68YJtJlbB277rWS2p6bqNYbYJqhBo
         jrGDk9D6WF+O2o8GaJQGO3EpwL4JhNG6HJ3DqqzFTf4Jt/dsNE2L9uLd6ziqrZur3vb+
         RyypXMNYjUue+86tmXP9thFZMCnsQ9cfigIRmqFBr1MU3LT/Y5vIuMm5+xI++THOD8kS
         rMAvk+uj/cj9MiFVRz4rYPW93+NdnYMXNYekwXa3Gvi5eaV0R2eozFvc9ziJy15hUb2w
         aIhQ==
X-Gm-Message-State: AOJu0YzvvPgpwUm+8w5ZtHAcEEPHNnqOmZzQSFAP2VcyfK+D7kEb89XZ
        yfdgCbQhhuk3+uUmRgarwTG33g==
X-Google-Smtp-Source: AGHT+IEjYCpyQaKSkqsuwF3CM021iTI/a22UZD1yTLU1DB+P2mSTJnOXxTfjx4GvnBPSA6DMVg/njw==
X-Received: by 2002:a4a:6211:0:b0:56e:a1d3:747e with SMTP id x17-20020a4a6211000000b0056ea1d3747emr11575028ooc.6.1693240871184;
        Mon, 28 Aug 2023 09:41:11 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id ay3-20020a056820150300b0055ab0abaf31sm3812150oob.19.2023.08.28.09.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 09:41:10 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Mon, 28 Aug 2023 11:41:08 -0500
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
Message-ID: <ZOzOJEfDcR4pS3Do@fedora64.linuxtx.org>
References: <20230828101157.383363777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 12:11:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.13-rc1.gz
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
