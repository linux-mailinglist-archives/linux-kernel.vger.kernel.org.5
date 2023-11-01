Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0DA37DE078
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjKALmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjKALmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:42:45 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCD3DC;
        Wed,  1 Nov 2023 04:42:39 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso712144276.0;
        Wed, 01 Nov 2023 04:42:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698838959; x=1699443759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C2egqJtjMEVY832Egz6NiSBaRiA5E24nP8wjEBXHQN8=;
        b=UUOxCckYBd0NLA52PBCw7z91uMfL997NkD4FRq/hqRZBuO8jQNOb17ohUSAfVtGExE
         NFsBZouLciqm/nuOxME+M5GTn7G5raXQ3/9Mad+/dpnbGYtkDIlqGVVQG0vyKHnLd1VH
         OGDWUFSeHLLtLnx+fAkv41iAuV3YKwEPgBFeJJTtBsZD0iUhHaVqbm9MxBrBZKa2FrNK
         84AWJGpvi96gacqicIOZ69ZYK4uWld25bNKRf0ZyGH9T3nCz0eSticlM+OwvxyMs+2x9
         OVacVAjbhEqugAP4hdoVbkUcX0Q2st+SlNahGbhnpVSwO/BWVvdm3Qo7AjORuTeH2LYI
         b2LA==
X-Gm-Message-State: AOJu0Yz8CjObq3QJA11p5ly8w7zUvkl6ko7OHTLJy6sf73eg97clzVXJ
        XhY1cuv+OpITQyHqqXnwxhQ=
X-Google-Smtp-Source: AGHT+IEt5JUHNTmKjGlZ8GO1dh1xbcpbijmW7pMtYlfK/Xcx/u3VdEvLqB0v/QGRx6umoMZePuSUiQ==
X-Received: by 2002:a25:5104:0:b0:da0:c582:da97 with SMTP id f4-20020a255104000000b00da0c582da97mr1608076ybb.24.1698838958782;
        Wed, 01 Nov 2023 04:42:38 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id y62-20020a25c841000000b00d8674371317sm1881279ybf.36.2023.11.01.04.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 04:42:38 -0700 (PDT)
Date:   Wed, 1 Nov 2023 08:42:50 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1698838956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=C2egqJtjMEVY832Egz6NiSBaRiA5E24nP8wjEBXHQN8=;
        b=Tw24Q834At+VjLLYYDiTPP7WDKdtXf/WpkSqRdr2q4G8sJ8sege0PFd3aIFJRQyrFO9jkw
        utZbRqZL092xcXtxMZOH+/ewIcIfZCQ9cz6CtxYychtj1MXCK0aowlQZ70H0PxEP3qKaPh
        0pQ/vdmeUZ+5H22DI44WW0OXHUKJGD01gjKk2ZrFmAteWKcbQNC64kTHY/GkLk4ieZELOX
        OMTdoMzXCfBHlLfx4WZMNxvYi3Obh5gsFLMF4Kxt9kGnRVe4bCtceF2hxhIl6YliUYE5/S
        +JD0On4xBuFnTWfNVYcPIHIhhVEQMguMpT9IKSNhAOxTF4X3m2rMsi1ltS6NAg==
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
Subject: Re: [PATCH 6.5 000/112] 6.5.10-rc1 review
Message-ID: <ozrwtfpo2njf4qdojazb5jpqdpjqbqmcmh3akjpqbphvg5zwpt@l6e34jngmvef>
References: <20231031165901.318222981@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/31 06:00PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.10 release.
> There are 112 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:58:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No regressions to report on my system.

[    0.000000] Linux version 6.5.10-rc1+ (rbmarliere@debian) (Debian clang version 16.0.6 (16), GNU ld (GNU Binutils for Debian) 2.41) #10 SMP PREEMPT_DYNAMIC Wed Nov  1 08:08:55 -03 2023

Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thank you,
-	Ricardo
