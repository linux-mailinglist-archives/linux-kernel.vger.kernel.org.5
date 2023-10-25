Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3F77D697F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjJYKu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232789AbjJYKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:50:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168F08F;
        Wed, 25 Oct 2023 03:50:52 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32dff202b4bso2012918f8f.1;
        Wed, 25 Oct 2023 03:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698231050; x=1698835850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bPKkz+vjJvjQly7UyaRBk2YCrClRb/oFfsG2xUXP3aA=;
        b=BOF8/rhoqCGAoaFOlsRfj+kJAM8/8KnzPAu1FtcqVhC+euZf+HtRn8EnKB25r7ml5+
         rlP5waBhBqjYXj5wmGwegJPt2oB/XI14W1wE7twrmN+UyexrFVE17b7bmi+QWGgVi24Y
         KZK9LaT5eMdsGo+dize0SQ/UBpinMHOT176FnboDet8w/bP6k18vcRd+yXgntEb+Z1lR
         HfG/Q6Bnfr/VlRJqDF2HbnQ1UTFLR25eEfjSzPJbAD801CrKI9jT1HoaQCYRM98wrZEF
         24xTl3hrXOQZLIox2Xvj0Zd/RDoA+KIqiHG+sU0IaTnq1AeWiK5Tu2GGcG+2LAUc/uPP
         15mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231050; x=1698835850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPKkz+vjJvjQly7UyaRBk2YCrClRb/oFfsG2xUXP3aA=;
        b=hT9rwOSqE8PaNesTXGgAk1lrZ/b1AGRrg4Izz++xPOEBN5/oYQ1mRhZT5va4Vb29qi
         gq5emJgLCAN90iIPf9oZ4eUgPCJgaefugV6hW4rzVgqNI25L7KzcpbBRCDPTyp6Nmxw4
         iir+GNC8Evgc37VMjHcZkR1kgyhsV/3Tau/QIeQ3cdYux2fdlCAIxyLqHm6SX4hfcHz2
         kWhT2//NFDtvxLV+X0U+gKJDNqaty0JxPBXV/8P/bviJn8F22mVkGnII7ofXA6wsxaAl
         4SpqxsBxJ6JePc9y2cd95YFhATVTaf0YQ6Yws4Wz1TJxiXWF3iqpRhLvcOgfqsm/OmbF
         LKvw==
X-Gm-Message-State: AOJu0YzwH+CjKBK8syhyLEeZ7hD8zNjdaTFOJDLM1bd8pIxXd+IeDZEQ
        E6FsLgMY2jrjN41TwgbbQb8=
X-Google-Smtp-Source: AGHT+IGwaxVLt/dmiX8321rXIm1YMr2aoLrRxFqelYqLmTQRbYNR1Sx7N26TqW+Tzt+p9q+rJ0Gyuw==
X-Received: by 2002:a05:6000:1e8b:b0:32d:a2c0:fc28 with SMTP id dd11-20020a0560001e8b00b0032da2c0fc28mr10207956wrb.28.1698231050234;
        Wed, 25 Oct 2023 03:50:50 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id n11-20020adffe0b000000b0032dbf26e7aesm11755629wrr.65.2023.10.25.03.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:50:49 -0700 (PDT)
Date:   Wed, 25 Oct 2023 11:50:48 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/120] 5.4.259-rc2 review
Message-ID: <ZTjzCMtJY4DsnoXv@debian>
References: <20231024083306.700855687@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024083306.700855687@linuxfoundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Oct 24, 2023 at 10:36:44AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.259 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:40 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.3.1 20230511):
mips: 65 configs -> no failure
arm: 106 configs -> no failure
arm64: 2 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure


Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]

[1]. https://openqa.qa.codethink.co.uk/tests/5374


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
