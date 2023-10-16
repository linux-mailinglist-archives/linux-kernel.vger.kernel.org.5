Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6ADD7CA6ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 13:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjJPLp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 07:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjJPLp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 07:45:26 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2758E;
        Mon, 16 Oct 2023 04:45:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ca816f868fso4173585ad.1;
        Mon, 16 Oct 2023 04:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697456722; x=1698061522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UoT4NOqpMewD3Bp2pnsgrCjMS+q2vQ2Hzj/Ou711y2c=;
        b=J8+Te/vvESs2sxBm00IkYyVBkdikFE7J3GolzT1a/X1S/sxeN+47G+HQdE2KhVwcpy
         uEPPesuv3swrP9fdqOiegFWKQc6dijsJLpzMC8NYSh2sXY+TYaMldc3Of4q77CrWdgDB
         2uX6TrmTrwuyxJtlvuGgMA/d0oR/TgOwR7lLGL6A+Buw55Hd9aJa4Jc8BypwFY24Nnpb
         uAOptBRpULNFqkR6/t/ZqwrFb9XmLmiNVT98pg+4qPi6jlPtNdmTqWmXBd2lQiuzcMtO
         1nRnLkvbpfeeWgiij7DqKZ4WfhC3PpzmJuk8aShM0dedacQpTDdUEOcnr0kVvhX8oazU
         6Mug==
X-Gm-Message-State: AOJu0YyqkkDuO+UbddrxW3Zi3Uu7S+146sAm2yeRrP669i5YjwRK3QkU
        uBFCWg84MvCW276z4xOPKvg=
X-Google-Smtp-Source: AGHT+IFHrI8VVdtMkj7pA5nmdnL8rjl1TDUrUZVjzvpekRK4MRuSemYlJDn/576ewVMHYNUsFYzYZg==
X-Received: by 2002:a17:903:2307:b0:1c6:21b4:30bb with SMTP id d7-20020a170903230700b001c621b430bbmr37339764plh.15.1697456722429;
        Mon, 16 Oct 2023 04:45:22 -0700 (PDT)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id o12-20020a170902d4cc00b001c61073b076sm8248924plg.144.2023.10.16.04.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 04:45:21 -0700 (PDT)
Date:   Mon, 16 Oct 2023 08:45:15 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
        s=2023; t=1697456717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UoT4NOqpMewD3Bp2pnsgrCjMS+q2vQ2Hzj/Ou711y2c=;
        b=QhsFR8C/2gMeLq/r8q3c9SceRPT4GdxBQOXjgOLkeFZ7qQPhVkWJ3H0+z31fQ6NygHqKc+
        RRnJIm0lPTk8znfxqxgepGcHJn/s5S7oaNdkDPMQJgd8LJ8BDbVB2Fi5Wj80Kt7FDVthi3
        RYeR5j15wf0zVhBHSYNlLEHc3jx0brDTtxkt7FljD0WccpRTHkuiicmb2s2jE92ium5AZM
        muNjrVtnVnqJGXU7WoWDKjHcpKhmI92z/8mJ+bWSMXLBy0IASataG2AvLFZ+ZVD9muob1D
        JkhRtQuUIWy6KE35t0dfvRUdmuSk7FFRXhy9SNSDdZbqA8S25pWGRgsSirawdw==
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
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Message-ID: <ytm5emjxhdt3bzbcfv7e4ly67hj4vt3uxjea3rd3forus7dhmp@7v2ikm6q3caa>
References: <20231016083953.689300946@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/16 10:39AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.136 release.
> There are 102 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> Anything received after that time might be too late.

My system runs fine, with some minor warnings:

08:42:25 rbmarliere@debian ~
$ dmesg | head -1
[    0.000000] Linux version 5.15.136-rc1+ (rbmarliere@debian) (Debian clang version 16.0.6 (15), GNU ld (GNU Binutils for Debian) 2.41) #1 SMP Mon Oct 16 07:33:42 -03 2023
08:42:27 rbmarliere@debian ~
$ dmesg -lerr
[    3.907484] nouveau 0000:09:00.0: DRM: core notifier timeout
[    6.457694] nouveau 0000:09:00.0: DRM: core notifier timeout
[   14.533137] nouveau 0000:09:00.0: DRM: core notifier timeout
[   17.870791] nouveau 0000:09:00.0: DRM: core notifier timeout
08:42:32 rbmarliere@debian ~
$ grep warning /mnt/md0/linux/5.15.y/err.log 
arch/x86/kernel/smp.o: warning: objtool: sysvec_reboot()+0x43: unreachable instruction
net/ipv6/seg6_local.o: warning: objtool: seg6_local_fill_encap() falls through to next function seg6_local_get_encap_size()
net/ipv6/seg6_local.o: warning: objtool: seg6_local_cmp_encap() falls through to next function input_action_end()


Tested-by: Ricardo B. Marliere <ricardo@marliere.net>


Thanks!
