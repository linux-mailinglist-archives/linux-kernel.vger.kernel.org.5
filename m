Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D3678FB06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbjIAJjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348855AbjIAJjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:39:12 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C36C0;
        Fri,  1 Sep 2023 02:39:07 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-401187f8071so10964985e9.0;
        Fri, 01 Sep 2023 02:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693561146; x=1694165946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8xZ9ZbaoplgcAhTiVLC1bDr8uxnmA/nekFkByFy1DR4=;
        b=si5BpWIf+qRWXuv8+SHW/zwPCkckNF0swgACWJLY+bFzr73QF/iWs1SMnJYimV4YX9
         ghggc85S5DaZfpbp7yk1GfuCreqy8RTWaEd/LomlPxAaPMjeYLwPdsh2hbz6nIZL/uLr
         NbhfYiJ4ZML19RMs7epQ1mDGd3U+tK49xjVMVa0FnMw3daxWKRrQF+ro0Lx+DghRiC8E
         HzJSEzmzQKn3sv9Xj7gsYn1EAKg/tI+gv/7dq74lNcxANKuqoJbJocdAsUOT7NdYqZyt
         mfKj/WIs2HMLbjNWKF8VSTS3LR+PySBgDgpXxLPv44een3y41lCNH8qUuswrmp0D+eiC
         TyCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693561146; x=1694165946;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8xZ9ZbaoplgcAhTiVLC1bDr8uxnmA/nekFkByFy1DR4=;
        b=adz9sgHBdKd7Gntpb10YcY2Ccathw6G4E7swwNufT5RFTg72drEw0y86NioNO4CeSt
         70CvJqM7JQ3zucTCUjkRXfgEF4vZaby2MyxL1/Jbyp1JjAMGnGbiaHqjmHnQ2z2Lx7bW
         akFynZ2wdDe9YVn1rZsWafWftm/ujQQM/TlzdKW0SgHweyQkqOPyp+v8rvgKLNQpekLr
         fjN1sVo2jUufRkjcvZbDVDzh1+3T9GmQ6/G/Oa5alwn7yRfG+xzF+xpb0AKEE+5arbUS
         0Rf/elQ+vVXqa6Jeym6f6YCi37PJc3pWGF8GMWiAdGb8OXe2L9dRgQdZsNW3xS5V64Dm
         MaeQ==
X-Gm-Message-State: AOJu0Yy2IAlSweBqk/VcGdT2gZW5z5YXBplXZrrZo3WHARqVAokJAuBd
        ZyxZfV5QwhAWEwClJSluZ8Q=
X-Google-Smtp-Source: AGHT+IFXtaTUGny1kxuRDcOK1Ut+jp4CLT1eqTNyu1lF+/eLom9GoaA5NXi2WQOesh/QlqYFXHLE2A==
X-Received: by 2002:a05:600c:3591:b0:401:bc03:1aae with SMTP id p17-20020a05600c359100b00401bc031aaemr4051227wmq.12.1693561146124;
        Fri, 01 Sep 2023 02:39:06 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id l7-20020a7bc447000000b003fe1fe56202sm4330877wmi.33.2023.09.01.02.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 02:39:05 -0700 (PDT)
Date:   Fri, 1 Sep 2023 10:39:04 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 0/9] 5.15.130-rc1 review
Message-ID: <ZPGxOEEJa0u8DgiA@debian>
References: <20230831110830.039135096@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110830.039135096@linuxfoundation.org>
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

On Thu, Aug 31, 2023 at 01:10:08PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.130 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.3.1 20230829):
mips: 62 configs -> no failure
arm: 99 configs -> no failure
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

[1]. https://openqa.qa.codethink.co.uk/tests/4885
[2]. https://openqa.qa.codethink.co.uk/tests/4887
[3]. https://openqa.qa.codethink.co.uk/tests/4886

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
