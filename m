Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7537925DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237192AbjIEQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354119AbjIEJlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:41:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3AD1AD;
        Tue,  5 Sep 2023 02:41:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31c5a2e8501so1910688f8f.0;
        Tue, 05 Sep 2023 02:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693906871; x=1694511671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QgJx92vjXTkTpttBpTwFSL3+GPVEdvVno8ObySBYzAw=;
        b=QqubKl5QTeK7ObYraHju3pKiAFttdWqdcX110ZNsh8VJpxt/LrPGR3+8DM90TRAI3J
         MsFrgP3tJZFMx5LHxV5L7hN6HQPgx5QmrrmS0mfMQ+gqs1Ix/K2+3NkTPerspH+Kbaob
         Om5TgOt2HV2GyJxL2vBriagyj4sEOY7uJ8DsMSyaAV4hLaBNLUxUxiXkB0+DOL7zdRAH
         CG0wVaUFgxUaACzc2UH8g7nlkC+PtMyppXZ5FU6NHLkdCM7/oQ+BiaMZ7AtUFAXvE7T4
         DZMgu25b/tr/niBAzk9cjP99NGBOiIVzzEKsCbjoScfbi5KQBJW7OOmf4GY4DJCxaAKE
         QePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693906871; x=1694511671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgJx92vjXTkTpttBpTwFSL3+GPVEdvVno8ObySBYzAw=;
        b=FLldPi9pogELrGCwrXsASbaNfhn84h4A448946sjNqmIBYJkuacgEFh8NPYrxIgYKi
         hFg4fclk3zur65i+HotIkWeKXGUPHvCYCttj2Cr+2XTlsVyOD2i//mqPstN9BOIYs91h
         21jvyGr2YXmlW+w4WM1f21okZGsk8JKtBLhdNAktQivKSeFL4puOjw3zTYGYyh2bOmGM
         6MDfk6wIiUxNqrZ4MQkeiCp/zp249sQRJM7hoY5JxRClkyT1XnyQrRBnH68l8HI7Jv4H
         DBb8353UwNiQMy3Konc00iHCE3Co4Co3x/uTbpRyLzlpVXllkuVBxZftsDgGi8IVB5xr
         oBsw==
X-Gm-Message-State: AOJu0Yy3g1SCIkHuPBORkx26CAlxebyvIWU+uoiFpf0xgxoF2LW7MBw8
        /YCQciqyKA76l1JahB81/T0=
X-Google-Smtp-Source: AGHT+IGoWSR2aqZbmIZ7hgg8jVBiWpsSfPlwPPGJaYvM/yrDW64biTEHWOw+vteZXDnVn1ma2BPxaQ==
X-Received: by 2002:adf:ff8f:0:b0:314:1ca4:dbd9 with SMTP id j15-20020adfff8f000000b003141ca4dbd9mr8028088wrr.27.1693906871394;
        Tue, 05 Sep 2023 02:41:11 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id m6-20020adfa3c6000000b0031f300a4c26sm11812954wrb.93.2023.09.05.02.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:41:11 -0700 (PDT)
Date:   Tue, 5 Sep 2023 10:41:09 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.4 00/32] 6.4.15-rc1 review
Message-ID: <ZPb3tUUqe9WewDyN@debian>
References: <20230904182947.899158313@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182947.899158313@linuxfoundation.org>
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

On Mon, Sep 04, 2023 at 07:29:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.15 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Build test (gcc version 12.3.1 20230829):
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

[1]. https://openqa.qa.codethink.co.uk/tests/4940
[2]. https://openqa.qa.codethink.co.uk/tests/4953
[3]. https://openqa.qa.codethink.co.uk/tests/4954

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
