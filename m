Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE16785963
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbjHWNcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHWNcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:32:18 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D518E69;
        Wed, 23 Aug 2023 06:31:52 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68a56401c12so2283949b3a.2;
        Wed, 23 Aug 2023 06:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692797461; x=1693402261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+D0W/16BoY62R/hiThUj2ugSOF40Kj3HdGJGIhUmYhc=;
        b=nvZeCsp///OZbBne2fiRgEgHTTWKM7LWvd09xMTBGY4NmiQFPK7KqdDLsYyOQGh9LG
         2xhQk6Ie/vraLN43k8FOk9aO7/0oD/xAwPcF4ORDKK0schgRNzcS50N7sM7juwzpeNR1
         9lxR18ZrKDNj1L0iLpso6gIbJat5XDVV4wScTKN5fJpshRHzx+nb04rryFIofO5Lhq0+
         M8QOBi8MdXRn8TDDOlTPXVHh19WDoxANN7IQdYjA3oX1LmdE1CEKXUn2rzVxMSDV2I2i
         GNVc/IxEEhQyFIfZYWEQgeBHXPQi8iLEIez5Z+OgfnIQnqnmRF7ybRva0/e2o5DOnxsU
         nEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797461; x=1693402261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+D0W/16BoY62R/hiThUj2ugSOF40Kj3HdGJGIhUmYhc=;
        b=Evc1jPmqgpA8kl0uJaSfY4MsHuxVOEqyWI+sYZV+fccgWTpU/RTuluwq8GgCFKAf1/
         jQNdhMyYBAfHWkoDme8iGaIQIvYquWrWmQiEDq/SV93ncfGshBYmkAziVgFhNhWm5idn
         rEnBYeUFRDMOP9nmCVISV6wJy4DTpjFFc42LCgcksWbuoDEXHUOVMyNhXV6tT8MBXq9H
         Uc3jmCwEV8IElyGUuW8BZ4DqB13uDmBu9yCSQ2omrinZtwOk9imo9MI0tihhXfEqILY9
         /hoatRZVsNLMPAWZ9HTnYpKU601oUk0ZO99XWCbP9ncumysBUHw3tbzu3+wfl5ed1xQf
         8RPg==
X-Gm-Message-State: AOJu0YxbvtIB8EB/P5B7Qobzt4tXubwdCOWdlziTddsuhbmRhAq5k5Mf
        9MYz5kgXzvGcb2NDFCviccDSrCze3UU=
X-Google-Smtp-Source: AGHT+IHxqIWYvGpO5p0maI7SBmqebnAHzyXG74P2UQdnr44NQ7qsDllqd4gy2UgfiycK38B8l5N+0w==
X-Received: by 2002:a05:6a20:748b:b0:136:42c8:693c with SMTP id p11-20020a056a20748b00b0013642c8693cmr11821998pzd.6.1692797460787;
        Wed, 23 Aug 2023 06:31:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2-20020aa780c2000000b00688214cff65sm9477564pfn.44.2023.08.23.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:31:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 23 Aug 2023 06:30:59 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <8ecc1785-2e12-4a66-b567-b4d50b4d2892@roeck-us.net>
References: <20230821194122.695845670@linuxfoundation.org>
 <ZOXJVamgYV1Mb+7S@debian>
 <2023082303-musky-plastic-335f@gregkh>
 <CA+G9fYvm-7DPuA9kAF3784DpW4BmAXa_+_NW3AP_919_UND5-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvm-7DPuA9kAF3784DpW4BmAXa_+_NW3AP_919_UND5-Q@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 04:02:14PM +0530, Naresh Kamboju wrote:
> On Wed, 23 Aug 2023 at 14:56, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 23, 2023 at 09:54:45AM +0100, Sudip Mukherjee (Codethink) wrote:
> > > Hi Greg,
> > >
> > > On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.47 release.
> > > > There are 194 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > >
> > > > Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> > > > Anything received after that time might be too late.
> > >
> > > Build test (gcc version 12.3.1 20230625):
> > > mips: 52 configs -> no failure
> > > arm: 100 configs -> no failure
> > > arm64: 3 configs -> no failure
> > > x86_64: 4 configs -> no failure
> > > alpha allmodconfig -> no failure
> > > csky allmodconfig -> no failure
> > > powerpc allmodconfig -> no failure
> > > riscv allmodconfig -> no failure
> > > s390 allmodconfig -> no failure
> > > xtensa allmodconfig -> no failure
> > >
> > > Boot test:
> > > x86_64: Booted on my test laptop. Warning on boot, already reported by others.
> > > x86_64: Booted on qemu. Warning on boot, already reported by others. [1]
> > > arm64: Booted on rpi4b (4GB model). No regression. [2]
> > > mips: Booted on ci20 board. No regression. [3]
> > >
> > > [1]. https://openqa.qa.codethink.co.uk/tests/4765
> > > [2]. https://openqa.qa.codethink.co.uk/tests/4773
> > > [3]. https://openqa.qa.codethink.co.uk/tests/4772
> > >
> > > Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> > >
> > > --
> > > Regards
> > > Sudip
> >
> > One question about the warning on boot, all still works afterward,
> > right?  Or does the system not work?
> 
> The warning while booting and root login successful and
> LTP and other test runs are successful.
> 

Same here.

Guenter
