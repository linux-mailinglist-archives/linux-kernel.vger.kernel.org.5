Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B35807B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377223AbjLFWeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjLFWeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:34:20 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6D2D59
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:34:26 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-3b88c29a995so256887b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 14:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1701902065; x=1702506865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLAnzUmImkhc8qIHSMyVS5GmGRI3/cRZA2cD+zeipTg=;
        b=P2+VFVd91FhMYdDvjKfNHUiArb24/CYL83mKm7g8D8ECiL+waQh5opOpPm5UGlblwP
         e/dnbPT0I2GnKMk99kvsjPB2SijJiww9Bm1TKBalGzH3YN9B/6yln4eXajy3mesq/bRS
         4kiOly8fMHG5Q/5/Hrwe2x2iEeZYozyDOg31Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701902065; x=1702506865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZLAnzUmImkhc8qIHSMyVS5GmGRI3/cRZA2cD+zeipTg=;
        b=uRcQJUhpw4K1AebPM9Nja4E9Y/Rtf3Hres/Ie6i+qM+C2P+YdkDGIgh+RMfAhpbwYk
         PJdR3TBnldK/PpF1g7bDkkxa2PlmmHZ30qEs3Quv8RL2dUyAjkFnCkfwy5KBUiDQ7yY9
         xh8S2anVsiLBPRCI/9gO9yGRMUExeH3P+2NVFEhaR3cm5r+iG9iN2D3YEweS1t+tFPZd
         KowsdwEiq0oLIuHat55KElKarZ6pUtpLV+jifdmOsKisxeHM3KOIqHfGDgCMDrl+V6GV
         +fPbKplCniAmZqVtYs/d6rDDNfZNQuoK3Yiyl6gGScue8YYO/6KBZwCKQAqFlXFB4jYJ
         Yfmw==
X-Gm-Message-State: AOJu0YynbS5zdCwATv8z9wP5WgYcEsFDCFoIGDT2BiSn4epBmk7o+HFL
        57Ww5ocQ8i7bHbyEiXm4rTwPOg==
X-Google-Smtp-Source: AGHT+IF/i0+BQhG4ASvw1P/Q/HjuK2+tumaFPvDBBwN5XEKcKYVZi79XVoybw+GeboMuvgjJju3MIA==
X-Received: by 2002:a05:6808:1aaa:b0:3b8:b063:a1e0 with SMTP id bm42-20020a0568081aaa00b003b8b063a1e0mr1464142oib.106.1701902065495;
        Wed, 06 Dec 2023 14:34:25 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id z7-20020a056808048700b003b29c2f50f0sm11033oid.18.2023.12.06.14.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 14:34:24 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date:   Wed, 6 Dec 2023 16:34:23 -0600
From:   Justin Forbes <jforbes@fedoraproject.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/134] 6.6.5-rc1 review
Message-ID: <ZXD276eHg24P4237@fedora64.linuxtx.org>
References: <20231205031535.163661217@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205031535.163661217@linuxfoundation.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 12:14:32PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.5 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.5-rc1.gz
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
