Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438EB78FAA6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348787AbjIAJUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348786AbjIAJUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:20:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E410F6;
        Fri,  1 Sep 2023 02:20:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401ec23be82so18094835e9.0;
        Fri, 01 Sep 2023 02:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693560019; x=1694164819; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eoDPIMR93fFo73tpDzClv3W9lTUI4siMLDCC0A/zMFY=;
        b=QI4Y5ylMipWUDJv6JolDHD4JlsmEfgOfCR8MS8ZvzmZnLcv2AYxfUeRykl9U1Ngl2/
         q/Dr8Ur+WXFOey3JRiCjoZDqSaKzrnjv2/WUKvrDWGq7NL3ABibpg1bZIuaq+sT5tOWV
         ptTmCJncXjgTSpP/QRUjeyrO7X+BUuPLGNA7jda9VxhepMw9f1hCMdfhEX8abZCfmvQC
         HJ0HIh6L/O6Z41e2dhi7cQTli07ZIsf18rV7/czxBV3ytW9OhL+JQDAl5pTlDfbTMQE0
         YeQTLQhzn799bWnPMaw5u5wd7XuAl5m2ZYUU2XjXSvaYQDcPFN+2apb3vJbepeFoxQa1
         Tjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693560019; x=1694164819;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoDPIMR93fFo73tpDzClv3W9lTUI4siMLDCC0A/zMFY=;
        b=MBC/YISVoSaMRFtOXvF/60KAUhDeqapsW5S+DXrnZ96kkQjfzcnCD1nT5az3v1V0Wg
         whaleMBwyYrvzNrPLM09hy39Jd9IOe87g46Z2hfqcjATIT30H3z3yZjvR5GPcULE9mzD
         CVLIw4zlluR0atXtkFQnxBU6siXyaiydxzXIKyZDa5n1J4cDkWHVYF8DlHiFt9iWpUS7
         cLwrwi2e/h6i3zsv3CvljzDlFJqDQN3f2DLLMTe3CE1bsqNiPZ6B4GhDKhEK8SXrExVF
         1tU1oW+K/51dD8ddKwmAswWBqbkJrDLzf0K1WIcVD2yVAmrFYnYJ9euN9USXnXGQfGR0
         8SVA==
X-Gm-Message-State: AOJu0YymXPWF0yuV9kU8n7gAfYtYA/gwQYxRRHBVEAb7AkvakVBV5P4b
        aL4Ew/4XkiIUr2LzMg4u4CA=
X-Google-Smtp-Source: AGHT+IG3EJppxHOF4LgW3ZbOskCfv+9wLDrY/GDjW65q0eRIvQfPRQOFxNnW7DdUGuzZ7P79x1ynXA==
X-Received: by 2002:a05:600c:2283:b0:401:b705:ebe6 with SMTP id 3-20020a05600c228300b00401b705ebe6mr1326376wmf.32.1693560018868;
        Fri, 01 Sep 2023 02:20:18 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id p3-20020a05600c1d8300b00401e32b25adsm4404674wms.4.2023.09.01.02.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:20:18 -0700 (PDT)
Date:   Fri, 1 Sep 2023 10:20:16 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 0/3] 5.4.256-rc1 review
Message-ID: <ZPGs0EX6i0+xc3DZ@debian>
References: <20230831110828.874071888@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110828.874071888@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Aug 31, 2023 at 01:09:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.256 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.4.1 20230829):
mips: 65 configs -> no failure
arm: 106 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/4880


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
