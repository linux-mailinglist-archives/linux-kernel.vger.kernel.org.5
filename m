Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68138789923
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 22:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjHZU5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 16:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHZU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 16:57:10 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CCBE4E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:57:05 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79275d86bc3so71909039f.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 13:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693083425; x=1693688225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mWUWofiHOM7DQZ0jywZUsI2/zykuQKvwiKBt6rB56lo=;
        b=mJqCZhKdhJl28wKlasaVGmbc1QTnf4wLX1OXSt/1aXeGR6g6ROsW2/3UifS79ahvuU
         jVoyrX0b5D78upqnUXdWjmV8eZ3YavtNXd5zMLi1le3GjGo/z8QXS0CbfHLOvGPwAgyW
         PwvutqPaRUPNk8UTRdOPQDzW/PHU7U2+745Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693083425; x=1693688225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWUWofiHOM7DQZ0jywZUsI2/zykuQKvwiKBt6rB56lo=;
        b=KdKR9aoDJdYfmyYKC87NGffTuhvL1nGxi+VkdUv8SL1ZD2dkyrTW5M1j2ZgO9/qfPK
         CRnaGaHZei5VCp06PcGS8YOU4QIk1tx33gny4HCXH6rmmThGJj4GxlWbS0s4E2BMGZbH
         uvU4akONdivYrnm9nVRw4jYtRIhT0DvyZFoI8hbHy3JEE7lhVPXpfgBUm85EqVJcPXSY
         5d/MTci7dYfb85P/VxyyS7qjTQ6tSXJcZjxJgfd+8IgWIiqbit8hefFMOUzvBLVnUWFY
         /xeV9Tpi6yxNhHZxt6m2dke0vDV+uDiJpYpm8t6cQFZ6IFetSrUs+E9yBI/NFLMtWL6A
         MYIg==
X-Gm-Message-State: AOJu0YyTddnbw7NE0+2lDr1Pksnp8YZpDspjUlw6CtSNNm5R4agI42+Z
        flJZo97+PzmennnPSum8miVP1w==
X-Google-Smtp-Source: AGHT+IGc3nTRI3b/cUNX8UYrIAn+RQLsp6nClKr7WUYpeFfGQ8nyHTKBM8UKU0sFB1eF3aRoiypWtA==
X-Received: by 2002:a5e:cb07:0:b0:785:5917:a35f with SMTP id p7-20020a5ecb07000000b007855917a35fmr12739426iom.8.1693083424770;
        Sat, 26 Aug 2023 13:57:04 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id n17-20020a02cc11000000b0042bb2448847sm1355102jap.53.2023.08.26.13.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 13:57:04 -0700 (PDT)
Date:   Sat, 26 Aug 2023 20:57:03 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 0/4] 6.1.49-rc1 review
Message-ID: <20230826205703.GA2311600@google.com>
References: <20230826154625.450325166@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826154625.450325166@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2023 at 05:47:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.49 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 28 Aug 2023 15:46:14 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.49-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.

Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>

thanks,

 - Joel


> 
> thanks,
> 
> greg k-h
> 
> -------------
> Pseudo-Shortlog of commits:
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.1.49-rc1
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "f2fs: fix to do sanity check on direct node in truncate_dnode()"
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "f2fs: fix to set flush_merge opt and show noflush_merge"
> 
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Revert "f2fs: don't reset unchangable mount option in f2fs_remount()"
> 
> Peter Zijlstra <peterz@infradead.org>
>     objtool/x86: Fix SRSO mess
> 
> 
> -------------
> 
> Diffstat:
> 
>  Makefile                             |  4 ++--
>  fs/f2fs/f2fs.h                       |  1 +
>  fs/f2fs/file.c                       |  5 +++++
>  fs/f2fs/node.c                       | 14 ++----------
>  fs/f2fs/super.c                      | 43 ++++++++++++------------------------
>  include/linux/f2fs_fs.h              |  1 -
>  tools/objtool/arch/x86/decode.c      | 11 +++++----
>  tools/objtool/check.c                | 22 +++++++++++++++++-
>  tools/objtool/include/objtool/arch.h |  1 +
>  tools/objtool/include/objtool/elf.h  |  1 +
>  10 files changed, 54 insertions(+), 49 deletions(-)
> 
> 
