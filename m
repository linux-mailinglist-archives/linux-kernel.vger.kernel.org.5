Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF26784570
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237052AbjHVP1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjHVP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:27:08 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254311B0;
        Tue, 22 Aug 2023 08:27:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fef56f7223so14557885e9.3;
        Tue, 22 Aug 2023 08:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692718024; x=1693322824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P8Gu3e55JmS9M6j7VGf0BGDN5maX8MZT1jBCyJ1KpJs=;
        b=pTS5glFP09xWkddToRrsvw+rzji+JZnjxa/vXdk6ubi1lRuxH7pU3SAek6mu4kfyX7
         NoBwTFX9hkU3AtN7X+p887Z3xoDwu/Hns1wxrS08Ixhox9mA1BOpU23XxAU3tzNV7lHO
         52xd6+JParNxxT1zFLgBVu+NmOs6N9DtaUTmil7UBpWknQbM4ZqciGLo4UElvurwhG+a
         fc49p18gEc2PwyIcojYpmaiLFJjf+YhtPrIL49CIa8y4RnFiXU+EyFPauNKow4NNjX1l
         Xx46IUt49eqEh/NusZQn934tksJlhqkgZMoDSWvwitGxCvYINv+vnS17WkLeN4uyZx4W
         rpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718024; x=1693322824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8Gu3e55JmS9M6j7VGf0BGDN5maX8MZT1jBCyJ1KpJs=;
        b=Wu5UlMFbgaxfEicYqZv9vNlOa/l4owYJLSB4go6xDfuWQh2QlRMhq0qVBuTdISsCsF
         Z0wJ62ngCTTRnzz42CwsJlUEDqCuawkvq1RmJzJ48rbxmuL6IAz6ATqkhME9Df8M7ZXU
         CY1Fq92IqLdZxstr/vYuFlGz8opI15SC5WvmbxPaDUfMw6McCOfHwbuBp3vpWt1DL4O7
         ETVy9svMFdeWV9IaF1MKqyYyuRiY4AB3lfqf2g/2rvEfhPIbFDLHEdQnqqyTfxRaPRLw
         0Z6iupNJM6eEHioHb7tiDfcrl7R/4fqtlviVsy1ha3nRBw4OgtqS2nP9QawxJ4p1P5XP
         YFjg==
X-Gm-Message-State: AOJu0YwwrDYCYvGUWPkP5QfPbYHhj9pt0X5M6HrYe5soIwXSJTTkX/dq
        ZYvO6LoP8Xuw2hGMQckeatc=
X-Google-Smtp-Source: AGHT+IGyrQGqEFG9EGxeiNZupgIw8uPE0bXsgKS9m9DzgYCB57XrzUgOv60079WGh4qOE2pgnuBMYg==
X-Received: by 2002:adf:fed1:0:b0:319:7421:fde with SMTP id q17-20020adffed1000000b0031974210fdemr7888446wrs.32.1692718024302;
        Tue, 22 Aug 2023 08:27:04 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id c10-20020adffb4a000000b00317a29af4b2sm16022296wrs.68.2023.08.22.08.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:27:03 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id A90CABE2DE0; Tue, 22 Aug 2023 17:27:02 +0200 (CEST)
Date:   Tue, 22 Aug 2023 17:27:02 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Borislav Petkov <bp@alien8.de>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <ZOTTxsW5IGhOO8IW@eldamar.lan>
References: <20230821194122.695845670@linuxfoundation.org>
 <CA+G9fYvkBSb-i_6unB3bRLwRibVtZ3snYDe_gG+bsZehu3Hv3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvkBSb-i_6unB3bRLwRibVtZ3snYDe_gG+bsZehu3Hv3w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[Adding Peter Zijlstra to CC]

On Tue, Aug 22, 2023 at 04:25:22PM +0530, Naresh Kamboju wrote:
> On Tue, 22 Aug 2023 at 01:21, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.47 release.
> > There are 194 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.47-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> 
> NOTE:
> Kernel warnings noticed on x86_64 while booting the kernel.
> Paul E. McKenney reported this last week [1] and discussions email
> thread provided here.
> 
>  [1] https://lore.kernel.org/lkml/4dc3d0ec-b827-4bce-8927-cfa5d837fd03@paulmck-laptop/T/

Seeing the same warning for the 6.1.47-rc1, which is missing
4ae68b26c3ab ("objtool/x86: Fix SRSO mess"). Unfortunately the commit
will not apply cleanly to 6.1.y. 

I guess we need at least as well dbcdbdfdf137 ("objtool: Rework
instruction -> symbol mapping"), but not sure this is enough.

Peter, is this correct?

Regards,
Salvatore
