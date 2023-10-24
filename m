Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CA07D4AD2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjJXItG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjJXItF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:49:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261BEAC;
        Tue, 24 Oct 2023 01:49:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-32d8c2c6dfdso2700956f8f.1;
        Tue, 24 Oct 2023 01:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698137341; x=1698742141; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mo7Xx0J6SUzUUTIhfv7Y9XKD/ghnjNlWvwQxCcFYVUc=;
        b=JsB+YcdF0+iN4o/1xf742Q3MS4sQEfSFjsYxvAm9oPGeaKF0yXxgz2lGwKfIVPU0My
         h2Wh8x6nyHrFZp5LthQoIMLa8UtLeN0K81IF6GRAle71kkEogs8DxsiamoAm9CB3+FY/
         lzFaEDTviIT7iI7zcbfZq1e6C2Ql6BrM4L56/lhZ2x4+QCHVk+b4hjxVJH2/VpqAuzKo
         FHJ4vAFnuKTwyVSMScntwZOjkAhfWlAXaNdD88V1wSWBJYVvwaqZUccK8ehtUTTxYhNz
         mqRs0W4rY8RihNtOlAM6atEHy5d7knYEL0YVuiGqcwwlIlzc1P1i8eyLVh8netUB/43h
         j4IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698137341; x=1698742141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mo7Xx0J6SUzUUTIhfv7Y9XKD/ghnjNlWvwQxCcFYVUc=;
        b=JxiJomk5/G77x5H2WA49A4CjDHFMFYq2w32Uy1AJeRRboGn6GnuxWKknOsLTTrRivd
         XnPiN1YjsuwwL2/yPyVeZcxvbBE+PK/5OZ44TAAzz6OPjPSA7QIKQFIWj+/gcWQUTDhU
         zod3+DFV+rA/XRWFz+tkkhFxqgnx7gA/JFZgpi+T9GF0nQzsb1vW3YKN7TlgtIWEGRh8
         d46mMAqEDei3YYMgZpmvjE8IkjrcFvUiXjFE/IxrHilG/npGdn9HOeh8aM2UAeJ2ilCy
         CiE1GlL7ZegBCIeBTYwzNfbXbgczNNoJlO/pRj2d1mDDv9quLBZbIRt9du1d64/QbX06
         mMVA==
X-Gm-Message-State: AOJu0YzIjjkcmCQeImX6TbFPKFH02KJTrQtnuJsBL5Qz3BlImp8f/3tt
        t7XfPmiguwxOZkDJGU2Gplg=
X-Google-Smtp-Source: AGHT+IFYnntQKKmgFF57gLWNDHCriOfCR2w7Uuy18Hr38cyfpNHRgWxpL0oHJ/uZOKpa1PxvtEpIrw==
X-Received: by 2002:a5d:5291:0:b0:32d:a717:717a with SMTP id c17-20020a5d5291000000b0032da717717amr10157922wrv.40.1698137341339;
        Tue, 24 Oct 2023 01:49:01 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id y10-20020a5d470a000000b0032d9efeccd8sm9465323wrq.51.2023.10.24.01.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 01:49:01 -0700 (PDT)
Date:   Tue, 24 Oct 2023 09:48:59 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/241] 6.5.9-rc1 review
Message-ID: <ZTeE-_JQy4M2TfO6@debian>
References: <20231023104833.832874523@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
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

On Mon, Oct 23, 2023 at 12:53:06PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.9 release.
> There are 241 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> Anything received after that time might be too late.

Build test (gcc version 13.2.1 20230827):
mips: 52 configs -> no failure
arm: 70 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/5364
[2]. https://openqa.qa.codethink.co.uk/tests/5365
[3]. https://openqa.qa.codethink.co.uk/tests/5371

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
