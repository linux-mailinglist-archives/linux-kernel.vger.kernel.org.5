Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 419AB78C43A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235030AbjH2M0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbjH2M0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:26:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF1CDB;
        Tue, 29 Aug 2023 05:26:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so40340945e9.0;
        Tue, 29 Aug 2023 05:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693311976; x=1693916776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/vl6V+/9Rs5Obbv8m6Ii1Y8RyQvDJMieLJcGjD769I=;
        b=eJE3iJH0cEFx0Ij0DL+xRcchTugw04PthN4i3mSBr+XTRr1KKDOGuOlRLKwivVc9tl
         fA0U8xot8XVHU+fDkxIAHxIWGrMVdsgs9OSA41Px4w34lNKdNE4nNKcmMBjiUXn5xW/L
         9YHBfJBwFyy0up9FcFVIxWYXUNY5l5whZHa9NwLUCBpwD87zQNFwizG4n46WlpvxzCQ6
         YmGV4qd1D46A9xf8jtMgl+1LToiWvT6TauACCqKmGMSh3GowiKSLXLN69yM0eBkiw/sj
         B2WTVVGRaM82J3IGyJSdwmqMZtMgg4brgbUtyVA9aXinRaTF8tlrc3/dPh1CRnN9d4Qm
         KnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311976; x=1693916776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/vl6V+/9Rs5Obbv8m6Ii1Y8RyQvDJMieLJcGjD769I=;
        b=dZT9y/3lLqBLYIfoK9cX+1QqvcN2Pe12aggSxOY25fVy9PgX1ltmUx115twt+W5ssY
         Jy9I2zQLZMtv+FaPAvh+Hw9oAQXJSGx4FDPiPY/DsXkHwvSBNlqF0KsrRzszqtZ/ZU0T
         HNDt/Oakvsi33XsYiwwnThJeHNQHCjK1RIsmZAG0YcEtHHrZclQbiVmIVihCQmegTo1m
         FuOQ/ApWlEdzGJMECydErwf4HkmU1GBcCouSf1iuUKPawMcZPY8fo/llmBns0LcrsuBm
         r5vf/3OuYRfo639W8arXrs6wiP/p5/Rd7KQoxefqswLRlMKOD+AIO2+Sm37IWY33sybl
         pogQ==
X-Gm-Message-State: AOJu0Ywf/iqYoW/S2Ho7xrMsirtIg2YMWMOZ/Jd7/oh/KIJfE29GtILW
        /pyJQdmugYFz9VKEe3mK2Xu6SRRgE6A=
X-Google-Smtp-Source: AGHT+IHz2BQglAeihsEWvAnkKI1HGNHU4OG399teUxWeazkybqCsNXASm823S4K/L+CNErKHWgUvxg==
X-Received: by 2002:a1c:7302:0:b0:3fe:c7fe:206e with SMTP id d2-20020a1c7302000000b003fec7fe206emr21544055wmb.16.1693311976081;
        Tue, 29 Aug 2023 05:26:16 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003fed630f560sm13776467wmc.36.2023.08.29.05.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:26:15 -0700 (PDT)
Date:   Tue, 29 Aug 2023 13:26:14 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 000/129] 6.4.13-rc1 review
Message-ID: <ZO3j5h2AvQRph+HL@debian>
References: <20230828101157.383363777@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 12:11:19PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.13 release.
> There are 129 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.3.1 20230829):
mips: 52 configs -> no failure
arm: 71 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
csky allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]
mips: Booted on ci20 board. No regression. [3]

[1]. https://openqa.qa.codethink.co.uk/tests/4841
[2]. https://openqa.qa.codethink.co.uk/tests/4864
[3]. https://openqa.qa.codethink.co.uk/tests/4863

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
