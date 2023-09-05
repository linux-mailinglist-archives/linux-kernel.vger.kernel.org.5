Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C78792A92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243282AbjIEQjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354093AbjIEJgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:36:35 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C191A7;
        Tue,  5 Sep 2023 02:36:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-402cc6b8bedso19405235e9.1;
        Tue, 05 Sep 2023 02:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693906589; x=1694511389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YN74zXxSunmC1J1XCmYDd1Mc9iKNJ+pIChJ9we9c978=;
        b=JN1HjS5PuVsQpxCCIVgVNnv98BGzfV6jICqmd1W8TBpPBk0g56sqaNke+xCGyqu2Fx
         F0t87QuCL/MZAJ82Gcgm4FDErRUQTZbe0MPgJAomX0aEskUBkXm15qW3ADAXxh2XjllX
         /ZMN/AP4X/eCZxB3LcwvpObA/xyh8P8WPFERH5oafD21MGHKKPQXilM90zkMdXwmKron
         BJZe31G90+rY+eSYd74jO3jJoSUjckSRQE77AIGpDHi2q3ZVwmJcI9TVHasCtY8Er7br
         AepzsYxmB3W8g48UDs8cuURW8/4IFGsadC6DRzoC/SFV6BrkBeHSSmsDyVPmELQSNH8q
         g7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693906589; x=1694511389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YN74zXxSunmC1J1XCmYDd1Mc9iKNJ+pIChJ9we9c978=;
        b=k+UDTyggNVRwtiqwqmU/2EwwEN+kP14SBbw6rDO4/5vMNN+ALakwWiWsouIArmq/58
         QQ9ObgThIS2oxeXzWgOkPuJc0THhq5N/T2MkL3oMbh6+ylmbhglnqv+FmxAm0dkc2icl
         kjhRggGSnL1NTKuiMRj/ONaBL5bGQTLdXmUzZD38puCmnNhgATMS4/cwYG4IqyHyv6TN
         tQlsG8e6SPt+MrbSGE8w/5WkZwruvjxo5CSl24PDUZnGd8KodZqV43f5/8WgFok7vKQp
         7oagqHaycamJ/HhwQujMKogbe9rFWC/mFPNjfPo+wllKwx5ZGaWLHN8mKFJvDquFJbY4
         jRxA==
X-Gm-Message-State: AOJu0YxBKGuPKFCA/YqJFshCns3tWJZOo9zWvH4gzuBvnTwI8Z6HVIFy
        kAnLyQCXRjiugoH0vLDN5Ic=
X-Google-Smtp-Source: AGHT+IEX3lGhBHiQY6i51kVXIPsNIJpgoOagjFoCu+G51Cy78QGjFeHnRZ+SJcKliEm3g4SK0jGHCQ==
X-Received: by 2002:a05:600c:28c:b0:401:db0b:48dc with SMTP id 12-20020a05600c028c00b00401db0b48dcmr9500781wmk.37.1693906589310;
        Tue, 05 Sep 2023 02:36:29 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id e10-20020a05600c438a00b00402d34ea099sm2614344wmn.29.2023.09.05.02.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:36:28 -0700 (PDT)
Date:   Tue, 5 Sep 2023 10:36:27 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/28] 5.15.131-rc1 review
Message-ID: <ZPb2m6bxirMCA2cf@debian>
References: <20230904182945.178705038@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904182945.178705038@linuxfoundation.org>
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

On Mon, Sep 04, 2023 at 07:30:31PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.131 release.
> There are 28 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

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

[1]. https://openqa.qa.codethink.co.uk/tests/4932
[2]. https://openqa.qa.codethink.co.uk/tests/4950
[3]. https://openqa.qa.codethink.co.uk/tests/4949

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
