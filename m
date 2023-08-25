Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D924788CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbjHYPlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 11:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbjHYPko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 11:40:44 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D648126BB;
        Fri, 25 Aug 2023 08:40:25 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26d1a17ce06so660359a91.0;
        Fri, 25 Aug 2023 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692978003; x=1693582803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIv5AfNee+1ahX6EDRzSKbY1j9QGGz1vV6vHz5xp9OA=;
        b=UF6nE3V2KmNNvnrImpgihEdjrx543d36tiASAtwDGHI3CMtKa3KQiEbqHK0Cw4F08/
         faj1ezU0UUKD8ZQth9WHx6J9UGNXpkDXxRacatjqD0vFPT04g4goK/9pS+OPRgb+IYuM
         ZWGqXjFH9o7/00JZ5VRKkfhCO3MrnoZ8ezVn0RviZSVYURPfGA6hYnb62cDksMa0azvF
         gEuXxPp11KCwVbH6gM94p9ooTdJ4AhXcPotNxxiZNDQ0pIamJtEFCVGJAR8Zg9811O7y
         NLtpl5nyBDs7BcAwtLk3BNXDFDRT2aKwYoma05cTELpVvDX5OctFLwTYRhrdrx9ZabR4
         eDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692978003; x=1693582803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YIv5AfNee+1ahX6EDRzSKbY1j9QGGz1vV6vHz5xp9OA=;
        b=C9LJCaU5hj3E+lrStthTveObj8SNBopDJ+YF+Iu4HEZuoHYRCYvas6rIRR0PjfF/fj
         EVLdUEYoyGzuHlIv/Gw/VDbrffnr5yfsp51pPEn7ARbo5qYxfAJvtzomfxdTva98xcsR
         CsaBb4WOTtjKJcdRkQyhngtgv4rtQqIFBdwf5xDUxVWExe4BBXXFOTatFQud+PruuEWm
         OwpDQ7Y70xjsfWSODU+Gk79ujDy367EBpAzsJVx29SI0Ru1OkMZTSPXQc9+PoE/pRlh6
         dDMl6PBsrBR1UlvMqGUeweEudjvpX0RyCuPKjN3JVbGkpUuC7fb2SGJ+ZtdOW07Xv3nK
         jENw==
X-Gm-Message-State: AOJu0Yxh4oDHLuxviB8gYY3mbE9EPJFcJ+BJbk8AWvp+r/3sFque72OL
        v+j27q+FqVvuReoHLUmdGss=
X-Google-Smtp-Source: AGHT+IE7rtTxs6Fqu1KJZIStxt4EUK7nepiEjIDUJgTf7bSmwpnDmwRijYF5IKd+Ic9hEgxle9WF7g==
X-Received: by 2002:a17:90a:df07:b0:268:fb85:3b2 with SMTP id gp7-20020a17090adf0700b00268fb8503b2mr15033161pjb.7.1692978003454;
        Fri, 25 Aug 2023 08:40:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ft7-20020a17090b0f8700b0026b45fb4443sm3704829pjb.4.2023.08.25.08.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 08:40:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Aug 2023 08:40:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/15] 6.1.48-rc1 review
Message-ID: <0ee210a6-60ee-4db0-9445-e94f6ec80c6e@roeck-us.net>
References: <20230824141447.155846739@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824141447.155846739@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 04:14:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.48 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 26 Aug 2023 14:14:28 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 156 fail: 1
Failed builds:
	m68k:sun3_defconfig
Qemu test results:
	total: 521 pass: 519 fail: 2
Failed tests:
	arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:f2fs
	arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:f2fs

The usual f2fs crashes, and m68k:sun3_defconfig still fails
to build with "Inconsistent kallsyms data".

Guenter
