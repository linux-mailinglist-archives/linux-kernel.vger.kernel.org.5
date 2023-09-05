Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00504792C33
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353413AbjIERF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354103AbjIEJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:38:43 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560B51A7;
        Tue,  5 Sep 2023 02:38:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so2044188f8f.0;
        Tue, 05 Sep 2023 02:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693906719; x=1694511519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YWqYpOjejr1s3ck7UjoKhIuDCJZwI6o2HKvOQT7nAA=;
        b=m/kOVLveNQnhHJvREx9xa6nl81Ysfw9Uihm7VZ5IKdOx4qBQNu8nHU8SCjpco5Y2zx
         3JyqXoPEtn3LbhxFL6vOYbbJWTrCCot88X9QWvpnv3ln5LYj2ojy+hBsk0P1TIJ0LvPg
         RwfLtRYkX3Gj/B5iEIzGw/kue2ymKVp56cGde6c4qc8WkeRluzc0tSV3O1fhIgSutxr7
         oidBll4U2nCbppsgoTLIDRlmJm+hdMQVj6gz9QZ5nwZxhKa5KW6z+bYjZzjoLtsnzod/
         zhcIPBhjkHPy3xV7fHBdiAgawS1G9sSx2WrCfRroYQFsWuctULo2syByVx2UrjY8DrCj
         B77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693906719; x=1694511519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YWqYpOjejr1s3ck7UjoKhIuDCJZwI6o2HKvOQT7nAA=;
        b=Dl7m+JPAlQLk/URm1hsWhVDd4CP3cz23iG26L+iYzW+4b7nAynHDlwbhK8fSr7+wZP
         uZd5QPP4pnHsZEzEWg+TM+JhZZIV8g0aOulrjqiGRxEJHqE5T9SGgmmUAlvuSxIbxV2W
         IypBkbk02QQ/7RVQK+Eoz4TkW8MacOudTBMqcCvYa4n8uIQHVKxp94pvcFkEP/LbNoov
         WWYO0ZvEjOrQMvFEILnMPaMJBJrh0l/34P4DgcRvt+69gRL/1+tU4XU2Oe5KbdqpSoh4
         Ultv+/Xz3nheEzoPc+feIWYXPcSUm+NdhCz3ziFGSwYi8XPAFeMmQwcAeutnfI7IIVMN
         T7mA==
X-Gm-Message-State: AOJu0YxPFbjpT8OfNiblgullwGZyUsBQDLc7/kUicpnMbiWlDy+PGs+M
        A2hcbbo9k6x/jj1WemYF2mw=
X-Google-Smtp-Source: AGHT+IE2wZOjcVFoM9PsqHK1B8bLhtoW705WXFzXq05pi2XmB6vFZniKw69cfoSvxGWmMcwph+PH0w==
X-Received: by 2002:adf:de0e:0:b0:319:7c1f:8dae with SMTP id b14-20020adfde0e000000b003197c1f8daemr9628315wrm.3.1693906718063;
        Tue, 05 Sep 2023 02:38:38 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id m18-20020a056000181200b00317f29ad113sm16819997wrh.32.2023.09.05.02.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:38:37 -0700 (PDT)
Date:   Tue, 5 Sep 2023 10:38:35 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 00/31] 6.1.52-rc1 review
Message-ID: <ZPb3G4Pi0C2pCCrn@debian>
References: <20230904182946.999390199@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182946.999390199@linuxfoundation.org>
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

On Mon, Sep 04, 2023 at 07:30:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.52 release.
> There are 31 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

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

[1]. https://openqa.qa.codethink.co.uk/tests/4936
[2]. https://openqa.qa.codethink.co.uk/tests/4952
[3]. https://openqa.qa.codethink.co.uk/tests/4951

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
