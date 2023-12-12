Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B48E80F508
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:56:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377038AbjLLR4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbjLLR4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:56:03 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F5AA1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:56:06 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 46e09a7af769-6d9f879f784so3145476a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 09:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1702403766; x=1703008566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GhO7i0g8+DEMkg+DsYpqZaGmgA2sy3F5nbL7wCmBS1U=;
        b=P8k4N9JTMNKxIV3r6DYiw9urjtc4G3Yb7Cd06VfJwm/sWBxIaK5LfqHTTS0SrGs3Ob
         YBs4LxrUGB7LNjqCOoYvDS/V7JoFbO5wqAe005VtQ7Q0cAlIaaJPjFfGBib1sqpZxl9S
         orbhg4+TV9FLhdm1+QV+afX55bp1mUw1LN6dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403766; x=1703008566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GhO7i0g8+DEMkg+DsYpqZaGmgA2sy3F5nbL7wCmBS1U=;
        b=OdiVpot3KjzrxPyoWmTIhPQcGQmuMKE0IOAgk4oerJUmR4K42mpaL/l0mTLsoMq2PK
         IFsI4q6VunBBK3BtfKUTCYMyaqEU7WhtfULIwXg0vHgm83Ro7+6PN6yf1vXJJDNXSxFb
         GamGmJkyRUuPvf7P/wnJ+I1GKnxylOOZBezPt1Hh3hQY/pSfuKFeKG2enjfJ2R24nFzJ
         29UmRFnA8N+lp/xe7dm1Sj14f2gjXIM9mRdN/Ykf+C+Ynn0usWNTN7kRyT0WyFM6ttLe
         WTLZBy3Ade5JEXB5rMnT6M2+jp6ieKqMnzDWY8Bq5KPYFJvHO5yu2MTj5etg/PuC8J/X
         Gy1w==
X-Gm-Message-State: AOJu0Yyu/linmWuJhJfF+pRdUnO2CSEP6rQxuaVTE+kOiKQ2rmwPm7iP
        S2ZtHDMqwhbO/KF7Sj2WU6qBGA==
X-Google-Smtp-Source: AGHT+IE1HD/oLSOYMj2B+IFoC9wztLPu0au2lOiT2+Zr3iFAqi8xJaGfKRpN/aRGMvC921QVzFRVTg==
X-Received: by 2002:a05:6870:d205:b0:1fa:2602:2e9 with SMTP id g5-20020a056870d20500b001fa260202e9mr8329662oac.8.1702403766102;
        Tue, 12 Dec 2023 09:56:06 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id wy3-20020a0568707e8300b001fb38204e42sm3315094oab.20.2023.12.12.09.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:56:05 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Tue, 12 Dec 2023 11:56:03 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/244] 6.6.7-rc1 review
Message-ID: <ZXies-AXCT0ZXuT3@fedora64.linuxtx.org>
References: <20231211182045.784881756@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211182045.784881756@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 07:18:13PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.7 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.7-rc1.gz
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
