Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621287BAEBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJEWRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjJEWRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:17:44 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D6395;
        Thu,  5 Oct 2023 15:17:43 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-3529eafb3a9so6149715ab.2;
        Thu, 05 Oct 2023 15:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696544263; x=1697149063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMZ74v+Yhyq1HY+EmpusGwpg/BnsW21vrUBe3zi75ls=;
        b=ZQ8XsRsFa/8KrCsrbRSrNI0eNazdWOwM3VblDB6Kl3SG8Tc+mrPBbbPncGAuAY9ezt
         G/J4OcoUte+JL3Pv5Qp2hRQHgGK76JrzhC6F/cWs7u0g1gzMTcyAlmWWOQuKM1ZCVLj/
         bhKrmNMp8TCuNuGIyQNRAbVLKqPQydFKrTer/h6K1wZPUUowkRr4sbfBpCSunvOgQlbm
         CBvRVtXzSwZpecLe6XaLHLV42tKWaaBYKMj5qIlotsMANGMbp6glDNJhMWmcSNgGuEuG
         IqW0n+QCHh7odMBjsytwVedNba2RydKM91fQhcbuKtqJ7RQtHHG6SyzcAbEvxiCoO5iE
         Q5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696544263; x=1697149063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMZ74v+Yhyq1HY+EmpusGwpg/BnsW21vrUBe3zi75ls=;
        b=rWYFCNZf3ts74yIIbDtrIWM2DpK2mb5lUYalqbUpnGsTCTGCy1+TSfAgP7vAfXdNqP
         4fD3afojk1FknH9WsBqGhacXdRsiqNwRc2lJHXaZN/ZcsWZDYV28kluBPvKTyagNiTah
         XsFLct1Io/hoK74ql4QUZarcn0CjXYvfK4BRzNLyl6so4z9Sz6gRknlSJXDYX0cJGLlE
         vGD6siyS9IhCXstKrCmkXsZezVN57IQULPl1Pr7GO7l9RSOOz1vew+bCz/5a+gHVdhaa
         ho/AwEpWpRnT+g9613uDMeZRjg+j2W5n/Cm5LQeKjaOLo212squADO4ftOe+nSJmsodA
         pL9w==
X-Gm-Message-State: AOJu0YxzGc4+7UIKO4TvojSs2zlHWJz1AfaAx9yZaWGvvxa0SH578yZU
        FSSaTpGO9JDjaAFl1fw42cI=
X-Google-Smtp-Source: AGHT+IGUGVJz/GNNgv+cXAuGwffVpynGpod5hzwXjfvFDEGr4+P5Kypb4VCM+EBlbmNL479zwOftpg==
X-Received: by 2002:a05:6e02:1d11:b0:352:a306:9ad1 with SMTP id i17-20020a056e021d1100b00352a3069ad1mr7957475ila.0.1696544262787;
        Thu, 05 Oct 2023 15:17:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c6-20020a92cf06000000b0035262e1080esm677764ilo.0.2023.10.05.15.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 15:17:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 5 Oct 2023 15:17:41 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/259] 6.1.56-rc1 review
Message-ID: <1c112633-ff1d-42db-a1f7-0c6b218d2eed@roeck-us.net>
References: <20231004175217.404851126@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
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

On Wed, Oct 04, 2023 at 07:52:53PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.56 release.
> There are 259 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 155 fail: 2
Failed builds:
	i386:tools/perf
	x86_64:tools/perf
Qemu test results:
	total: 529 pass: 529 fail: 0

Guenter
