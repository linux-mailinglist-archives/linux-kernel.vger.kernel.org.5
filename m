Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BA479CADE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjILJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjILJBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:01:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B471995;
        Tue, 12 Sep 2023 02:00:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-402d499580dso56827885e9.1;
        Tue, 12 Sep 2023 02:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694509254; x=1695114054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8rV3D73n/4g0Ho3wzqMSJx0WXLNoTiOvH9lCB8cr9hc=;
        b=bqwky3fMWfjRx+MeLNXTqZpRpKSu+ML43gx8jsTRPAEEu2gahvJR11zSwP/8T5eRTf
         FiWHN5XVw20je4p+EW9uXxeGHYig2fyKNfmKnu5uyOw89cwd7K2vzX/pf2Ta/cIgTfIA
         H7ljqUYQacwUWJmH1ab31PG24Jff+EC2UasiICVnfKrQJFTVxYnlhhHI/LJheRXE16r/
         hI3DXE0w4xYa2tn12IKDCBq42lJlxNir83TYllz5R2aWkuSbd9avdmmkQPsn6LdqCpCz
         sWVk3M50lkM9Kn7ZukBIjcuJI98n8PGSgYqAUjEugsCk+YulAvAwlBwQ1KTOgIN7i715
         +yvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694509254; x=1695114054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rV3D73n/4g0Ho3wzqMSJx0WXLNoTiOvH9lCB8cr9hc=;
        b=rlxZ/A3hiuCOurcV1gbIjp03gGwKSTuXC5veou1pNG9Na4zvycYejhZlqoLWmP7vn5
         +C9wihD/t08L4nuiJxD9HneKoV5qIyVcdToj/ZSDniNEleFkWaLvCyqKvCLOJZVELMZS
         3LCoua0ErfwgAX+jLwAK1SElTIr0k0Svedvjo4oQaqapUqkWVGJSBqc6zXe3wU53s/RZ
         LtXZAZTIQboV1gVbSOll5aSaU2giKCIQfBpkF16WHk85rxZuYKFLoiC01X5O3TON1yfo
         rGCh6BhY3lgn6DT0fKQ4SltqR6KqXzfupoiQftkfs3RtHyAM9OGJf70Z23jQ96dLIrSe
         ekWQ==
X-Gm-Message-State: AOJu0Yy6s+aFKPbbW6iE6zhHno2B86UXtLS51SempouaPHxVdhqglJ64
        aRT/I5aoK/ZfL7h19nyMHEg=
X-Google-Smtp-Source: AGHT+IEvLajAPVV972MBmGyk86DNVPmr1wsQgB8aX54G9X0nBNspdlg6SDntMJpDeko1hwS0KZg0fA==
X-Received: by 2002:a5d:6812:0:b0:31a:d90d:8d9f with SMTP id w18-20020a5d6812000000b0031ad90d8d9fmr10559533wru.25.1694509254299;
        Tue, 12 Sep 2023 02:00:54 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id g10-20020a5d540a000000b003176c6e87b1sm12186392wrv.81.2023.09.12.02.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:00:54 -0700 (PDT)
Date:   Tue, 12 Sep 2023 10:00:52 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/600] 6.1.53-rc1 review
Message-ID: <ZQAoxIS7sohiB1Vk@debian>
References: <20230911134633.619970489@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Sep 11, 2023 at 03:40:33PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.53 release.
> There are 600 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 13.2.1 20230827):
mips: 52 configs -> no failure
arm: 100 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/4999
[2]. https://openqa.qa.codethink.co.uk/tests/5001
[3]. https://openqa.qa.codethink.co.uk/tests/5000

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
