Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84E578C422
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjH2MUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjH2MUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:20:20 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3DACF9;
        Tue, 29 Aug 2023 05:19:45 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-401187f8071so27155255e9.0;
        Tue, 29 Aug 2023 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693311562; x=1693916362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mNfFsSrHfmhhWlX6jJezyPUMpq+AyznfbXEcUEhwfFo=;
        b=phP6IbXgWo1ccHlUUiaW/MqXctIjJ1N5TK8jUf45zhLzqG4vyQP9X5ZUJJFIDdiGN4
         0GlC64iSzWupjz9UgllrJAcAZ0QoaEC6geGOYjFCkGkAQCV6F2Hi8TKvt8FEhEf+lgQK
         bWmdIc2rbRqcNs2ikHfRXGI8uuLRted7xQ4jTb5ce4ssIh3dYrA9qF9nVvW6Ewbq+O+0
         Fy6v6W+6yeVDsL6tn/xfmi1XdPCT9zB3lxJI/njmPWa5RTI5HbCu8yANAO/wf37SLoSi
         mtmkIuq+STxI+6NlXad4drJ1coKDgidu4fj0kh/xuaknhe6A13ENZyN8dKGLIBG0v9zk
         WO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693311562; x=1693916362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNfFsSrHfmhhWlX6jJezyPUMpq+AyznfbXEcUEhwfFo=;
        b=YfHP6FCDt/qcwh/I6RblFNt6Gx4+XhTJW2dEz/y6Owt5KWDfA3cnonQ/QZ3+G4sG50
         YqEtk4d+bNGqlNw0SlyWnEmZ+NqPPiRiLrnb80kiw2Pmztnb4ZghC+OqlMRFxlYlzjIn
         rZWUU8xJlh4QkbfvmKmdxJ17x0XGmzeNbT4HifxToYjgFlemNfET4upiEETiTbI4Ujnn
         9R3d4RGhvpF7P47lmp0bN8J02qjqruhgATqMurAHRBdcb3060fe7N5BRJ1sr3TBCGr4s
         wP+3Zci9AJ94//gTD7ZZh7wqqQrhClp2fnkpzPp4+M9kTvaq9DET8bBm2OkoBRndcxBc
         kedw==
X-Gm-Message-State: AOJu0YwqrXtVs+ynaZROi8sizOy+AGTpt6IAtKTJIALFW5qaz7xedPyQ
        TJtmLFcsgE6RaAvTkCWH4d5jYAJGLPI=
X-Google-Smtp-Source: AGHT+IEeh+znma1g4setjUEYhruswbgcqMaM9C2GUbUmqFMZvQcW5GFOn0WKfSU8IkmrhKjzs8tTxg==
X-Received: by 2002:a1c:4b17:0:b0:401:b0f2:88d3 with SMTP id y23-20020a1c4b17000000b00401b0f288d3mr2024106wma.19.1693311561822;
        Tue, 29 Aug 2023 05:19:21 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id n23-20020a7bcbd7000000b003fef6881350sm13981741wmi.25.2023.08.29.05.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:19:21 -0700 (PDT)
Date:   Tue, 29 Aug 2023 13:19:19 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/122] 6.1.50-rc1 review
Message-ID: <ZO3iR/frz8QhqTGB@debian>
References: <20230828101156.480754469@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101156.480754469@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 12:11:55PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.50 release.
> There are 122 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.3.1 20230829):
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

[1]. https://openqa.qa.codethink.co.uk/tests/4840
[2]. https://openqa.qa.codethink.co.uk/tests/4862
[3]. https://openqa.qa.codethink.co.uk/tests/4861

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
