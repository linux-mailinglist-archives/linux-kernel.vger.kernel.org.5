Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ECDD789C48
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 10:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjH0IpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 04:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjH0Io2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 04:44:28 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35EDE;
        Sun, 27 Aug 2023 01:44:25 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c6d17aec4so1893744f8f.1;
        Sun, 27 Aug 2023 01:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693125864; x=1693730664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O8fElRcs3PkUY8Q02I9sE417svoQVgtmV0B5qTTy35g=;
        b=PWoIC2Fqvh4JPT0mV5SHB697KI4aSaB086YLt9z5rFSms+bENpXTDDprLakZ2h5lae
         OS7JepK6YVfLGTiMEDpMSIzk7JGzt0AeZtpXfhJrk8YmFvUWByPSClCrN990pjaF2r4k
         QSEQOUOGfmZeLNvh/KW82X+KuEIkJ1Avag5bEfbNKUKTV6QQTXLqA6Zc0Y4s1y6Zwy19
         tK4oYFXGHE/HFSofCn7TnPpWj2Y2ET7Agw404Q7e/jcQj0WWa6eTtE5l/wDat62dsqJT
         JTAvkkbFHr9mb+M5MszYXclJyqRu3CBkmjbvKQ7NgLaJ8M5Fmb94Aw1eiIDDmlUWhSgx
         WOww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693125864; x=1693730664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O8fElRcs3PkUY8Q02I9sE417svoQVgtmV0B5qTTy35g=;
        b=JtXteySypG4bzpwvoV+673+BpLDVwU3J5EDNZ2JKGoIEjDjJvYpQ5Avo6kqWbQmPKW
         XCY4UJuqSVwSw3JAaL5raU9uYtw/k4HDz9rdBsoF0FrP8s7Vge3M8x67OUzNXoRYDPpD
         XupbedbPHcHiyrgzubp6YgDXq14c1t0Nncadjnoe4U2HlZwfKyleFjhofXs+ecA3r6L8
         vnh0zDnpRLFM8wV3UOZLh/zrfaZiG7jvxq3CZ2649oNbRrUSLHPlGOmmEeWDWVibceLE
         k6hOsPxDqjeQzDEaDX1suOKiZ5jZVY6Gw6Z8xXI5b+T+FdkUoK4gntZh+r3pF97tctmq
         MMkw==
X-Gm-Message-State: AOJu0YwkUdLNN1X3Hafo88kOyjkENLsDvVfHSQzwW6zInGI+Sv4eabTU
        NcMy9qJJmwfm6KMxvlXnC2g=
X-Google-Smtp-Source: AGHT+IGFh9IYLC2/wjGRLv3SITjKE0sIgxuBuO/y76BZulsNmwpk0RjC+eZ3P+DtP+ZRyw+cifNOBQ==
X-Received: by 2002:adf:fa52:0:b0:317:393f:6e6a with SMTP id y18-20020adffa52000000b00317393f6e6amr18476798wrr.59.1693125863878;
        Sun, 27 Aug 2023 01:44:23 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id w4-20020adfde84000000b003143b14848dsm6948603wrl.102.2023.08.27.01.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Aug 2023 01:44:23 -0700 (PDT)
Date:   Sun, 27 Aug 2023 09:44:21 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 0/4] 6.1.49-rc1 review
Message-ID: <ZOsM5e50dwZhw3JY@debian>
References: <20230826154625.450325166@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230826154625.450325166@linuxfoundation.org>
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

On Sat, Aug 26, 2023 at 05:47:56PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.49 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 28 Aug 2023 15:46:14 +0000.
> Anything received after that time might be too late.

Build test (gcc version 13.2.1 20230826):
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

[1]. https://openqa.qa.codethink.co.uk/tests/4805
[2]. https://openqa.qa.codethink.co.uk/tests/4807
[3]. https://openqa.qa.codethink.co.uk/tests/4806

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
