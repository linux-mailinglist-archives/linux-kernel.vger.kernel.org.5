Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3A67DE06E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 12:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjKALjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 07:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjKALjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 07:39:44 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB07123;
        Wed,  1 Nov 2023 04:39:36 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5afbdbf3a19so55181497b3.2;
        Wed, 01 Nov 2023 04:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698838776; x=1699443576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=76fWz7sYzgzsLyhHBeS4vUH235XSSv9WBQdYgMrAu9w=;
        b=ZkCiOeSVfklVCP6Ki1fm4k2BzJD77cRQxikmQHAXN0qYWYY7rjRRH6HLmSE9a7DJlG
         4hvMIVYRg9TM4Md2LftQBRKbQGabZ2jootCaYa+ZCH1ImnDCbf6mnaPwL9h8ipW5pjjD
         CPejwoKnxtizyo42OeeXBzjQ7gBE4/pNi0Cvr/ov4o0GeP+nUxG5AH8xh2E9nGM9Vq82
         36QETrTs31T09LHlVBjF6ttGAPG6Hbt1KdPx8BW1BR4XgsO4nol3ZeSbhp9McqJG36Um
         LOFl4lw/4va0IE/dpSJODUxTS8cH8X/weQykDOy4SjdKy4iik9jd14HFE9WNhejLy0oJ
         4BZA==
X-Gm-Message-State: AOJu0YwkgjMMLPjCsf076t/p5ngc/eOISnOpLFHS1rUXf9UaK5v5KFwh
        lEKPppk1W1ZUgw4ra6z3Itg=
X-Google-Smtp-Source: AGHT+IFd2pu1sDeoz+KtsfD6Yi+6pdhX63v9Q2YhuHs9lEF2ENpLydmXzVNcR33eyJiufVeyyac3YQ==
X-Received: by 2002:a81:d40b:0:b0:589:f41c:bc63 with SMTP id z11-20020a81d40b000000b00589f41cbc63mr14606899ywi.39.1698838776000;
        Wed, 01 Nov 2023 04:39:36 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id m3-20020a819e03000000b0059b2be24f88sm1941415ywj.143.2023.11.01.04.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 04:39:35 -0700 (PDT)
Date:   Wed, 1 Nov 2023 08:39:45 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1698838773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=76fWz7sYzgzsLyhHBeS4vUH235XSSv9WBQdYgMrAu9w=;
        b=LC1fMOalGd8rTFgC4XXeh8SYlixPjuBCXbnkXCLhxdaeocaQmflaZEY5S90swuxaFilY6u
        L+lrY+DBkhn/Fpul/ZtAYN6rq7KoYVXHCYRAM3N45sLKfjOG8l32TXB3M6NG96Mjfdt9oT
        HatMhTYfbmJu9fS8uysVlgbAblxHBZVNODKPGyOUbPGQnSlS/HCRDfcAqaydH953EkYEhb
        EFrIMVRfYY24XLNcMB6qMa5hM2Zz77FenC5okUWAsocjV0YpYSW8T3t/hNu8sykbKBIbt0
        xtmR8lMfaG7BDvoRAUmGXM341G7X9KX/zC7kiZCfiwWZYu6h/GCCiz9K5/Rz3w==
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
Subject: Re: [PATCH 6.1 00/86] 6.1.61-rc1 review
Message-ID: <c5qjc2zj4kcmaascbrr4rxvn2q4mzcbvh2oysh7svu7c7a3r2z@lcg2vz5fvr4y>
References: <20231031165918.608547597@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031165918.608547597@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/31 06:00PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.61 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Nov 2023 16:59:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.61-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

No regressions to report on my system.

[    0.000000] Linux version 6.1.61-rc1+ (rbmarliere@debian) (Debian clang version 16.0.6 (16), GNU ld (GNU Binutils for Debian) 2.41) #4 SMP PREEMPT_DYNAMIC Wed Nov  1 08:08:49 -03 2023


Tested-by: Ricardo B. Marliere <ricardo@marliere.net>

Thank you,
-	Ricardo
