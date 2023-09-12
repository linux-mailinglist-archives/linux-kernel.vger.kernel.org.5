Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25E479CAB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbjILI4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjILI4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:56:02 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BFBAA;
        Tue, 12 Sep 2023 01:55:58 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3ff1c397405so62590275e9.3;
        Tue, 12 Sep 2023 01:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694508957; x=1695113757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ddS0ZkKFz8dmDcsSnwtGwTHKJaIvnEUsLWicZrz9JKY=;
        b=PqK8XCrF8q3wTOFStHRN2ojmo5JzcTDeOFhcUAFbEXtOJO5NLorkYU+GjzA4iVp6GO
         dIKqPoqVVP3booYpwk9lwFw5TgK/9WAtRDP9REhL4XXSkG8VKaXTN/nzDeyut4OxO/Bw
         VZs0EthiXmXhxCcz/ucvDOnW6Ksv9gs0GeZZqdzdtHRYe0pui6pjS1Qp/ePOAKc1wZuL
         BOJL4Rv3pO1Nmz7Q5VjwVkoiV7AJGtvDTZodxq649kWLdYy+eOslUGsQzmQJMEWSHN/G
         DO9vzodZFwPK7DqsFwYHlzvNeBcXJKeMDQcCeI9s0d83Kx4az93ibvkI/gymQs1bmZQR
         Y1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694508957; x=1695113757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddS0ZkKFz8dmDcsSnwtGwTHKJaIvnEUsLWicZrz9JKY=;
        b=SScj0cjC8nG5lpwASwm6RhjJRu7EXAHSYSoO9KOpa5vSVCPhei3HOTzIpCEntrWAHg
         s+dsQTchCv++bzFQq2N+J+w3rDv8EYa2vOo8YqIEQ7JoJuCP67G8eJHDFXvDC1ubceGz
         CqgDO0PrW9ERKsIOhCqt55gpdm2nA1Yfaj+yTOLrX/E5cxzrwmtmCxPrDGphCfzfF2Yg
         EKceqXoiZmArdqwaEdEXucGNZPHYJ9m4NkE32c0hyZZtho5NlnD8FLAkm8KqoJnODPEO
         79lRfKY1llC7GrP9LpylldaqBfQKFYgyWpGEo+MwS3alC03Qyhdp7OWY8uvBl13Vprw+
         wWCA==
X-Gm-Message-State: AOJu0Yy4WC1JZcT0BTHw8lU4T1PTEFZ/A+gPjaBXVZXJnEhJEQdnk5F+
        gIKXT2DpCaVsh1RSvpjfJ6u7yGS9jRY=
X-Google-Smtp-Source: AGHT+IE1E8L1noKwkbnXmhynwzkunFsBvTCSPHqmDk6jy85DHdMD6gSvgYUpjupeFJsK1bNPDAbO4A==
X-Received: by 2002:adf:fd4d:0:b0:319:67da:ed68 with SMTP id h13-20020adffd4d000000b0031967daed68mr10496784wrs.7.1694508956739;
        Tue, 12 Sep 2023 01:55:56 -0700 (PDT)
Received: from debian ([63.135.72.41])
        by smtp.gmail.com with ESMTPSA id n7-20020a5d67c7000000b0031c56218984sm12231475wrw.104.2023.09.12.01.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 01:55:56 -0700 (PDT)
Date:   Tue, 12 Sep 2023 09:55:54 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
Message-ID: <ZQAnmlIBrsGlGGRZ@debian>
References: <20230911134650.921299741@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Sep 11, 2023 at 03:36:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

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

[1]. https://openqa.qa.codethink.co.uk/tests/5005
[2]. https://openqa.qa.codethink.co.uk/tests/5007
[3]. https://openqa.qa.codethink.co.uk/tests/5006

Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
