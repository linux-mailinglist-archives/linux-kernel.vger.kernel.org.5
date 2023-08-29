Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A77A78C39E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjH2LvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 07:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232601AbjH2Lu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:50:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5E5132;
        Tue, 29 Aug 2023 04:50:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401bbfc05fcso36277385e9.3;
        Tue, 29 Aug 2023 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693309853; x=1693914653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IxizkUy5yBDTtEGaVTKg6jAoVfIxrNZ5Slb9begCALE=;
        b=QBdSWhTmUvyAjBTnt1XTxEeFQjDi5tkGmhrkexSO8l/M3aSSCFEZr4Alm8M8hA9Hj+
         ASIdCcYrI1RtlKAM0n6DbzsSnI66JpRt8gLK6AtHrx3Y9Vf6exP+VZXSd5bY9dTHXKbj
         pXkJjJ7kueoamOnNozOSLaDd5a308VvaMc3UTPuT9qGWkv6oc+Qj8qzNOonEIC1oRyqk
         neYbeimaZxAfUr/ifs5L5R63gqWeKJSh9+guWKXmg6GKEFuOzv9b94uFNJQ4rTm1PfbX
         nSTaLgdKu7kLLnCL4/ahOq2H2N6j9Lvw3szpesaZyCfiChBLO+dbWpbawq6DI7j1dY/f
         /rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693309853; x=1693914653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxizkUy5yBDTtEGaVTKg6jAoVfIxrNZ5Slb9begCALE=;
        b=H0CmVq7JmfShV84Nh23JpvHztwDtxypGxv9kopkyWtM6dAM0wy3n31UjB6thFTJIdh
         2GKSPWY/4/wilzYDJfRIRXtKWQT+7q7hgy3BpNzpOtVsjGjlA8+h8CZ99vujuPVOxpyn
         bodxVIakKUUtoQM0AyNXTqBi/rk2LxU/P72jh71VbVH1nNh4U57J7IDYFxMFiaB+WwIi
         M95mH1l3iyl/hafO3VBJ0m7B6+QYsdCem7lNvDJ+HBI9KYdAVc1FyoafbDkv9idylm8z
         KFQk9AQtoHdoLuRoy4gaiRav+i20q0RQNsEEMMWygT32zZVJ2nMZPiMzxcF8Uh7+2oYL
         h81Q==
X-Gm-Message-State: AOJu0YzjRCG3cDz/qcq6WtE3sM0aCZQimcJ1NnSvQwDR4+LaAXkX7aa9
        B0IHObvNu/tQHzutA9YE1FU=
X-Google-Smtp-Source: AGHT+IEesIndmqEJay6wwnFGesWsz1/5jdiPC4i14UignA7futhgSXTkmtwkhHT2HeVamd+ca9SdWw==
X-Received: by 2002:a05:600c:ad6:b0:3fe:fc0f:52e2 with SMTP id c22-20020a05600c0ad600b003fefc0f52e2mr15403503wmr.37.1693309852966;
        Tue, 29 Aug 2023 04:50:52 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c234a00b003feeb082a9fsm13812623wmq.3.2023.08.29.04.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 04:50:52 -0700 (PDT)
Date:   Tue, 29 Aug 2023 12:50:50 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/89] 5.15.129-rc1 review
Message-ID: <ZO3bmkc2J0UpzSGR@debian>
References: <20230828101150.163430842@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
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

On Mon, Aug 28, 2023 at 12:13:01PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.129 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 30 Aug 2023 10:11:30 +0000.
> Anything received after that time might be too late.

Build test (gcc version 12.3.1 20230629):
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

[1]. https://openqa.qa.codethink.co.uk/tests/4839
[2]. https://openqa.qa.codethink.co.uk/tests/4860
[3]. https://openqa.qa.codethink.co.uk/tests/4859

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
