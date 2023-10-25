Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAF37D6985
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjJYKwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbjJYKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:52:06 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA7CAC;
        Wed, 25 Oct 2023 03:51:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso40167805e9.3;
        Wed, 25 Oct 2023 03:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698231118; x=1698835918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cv65HA03cvoAKx8a2KmloKz5yACTW5awrrDOvOUGaOc=;
        b=Veb93RVFmP/nV0tbdN6/C23meTuiMm/wSDzwLurdgpkFV4Yyq8vcKJICHyRJ/lQLWl
         NuVuKMvVhTrCgcmOv29EGXiFYNizBGAaUgM8fGywkLqbrnLqksF1FJ6ek4WCvUfrdkyi
         AJlbNXqcUyHRKA8VINStoX9I3tRrWtrRomZBwXO1T6iX2IoCxo/BqTqsw0qOZm7Hd69U
         lJDGew0ywaYu+JNhlu88ri74J49WydAQLrzrOn2px7o6gbgf6+4YWFCQWRoLnTTW0O0R
         g9dhxbmENozwPybyqCP/l7yWcXRG1z5n1wMwTgsPaVFafEYLd3mmsMe90yuehFohEwL7
         FtTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698231118; x=1698835918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv65HA03cvoAKx8a2KmloKz5yACTW5awrrDOvOUGaOc=;
        b=XXypasb8TVTCU3QofW27+muBYZSF6/46tq7Hv+Kj52Tm6jdiU7Ive7CzdihmaNxx52
         oD2TtYBquSwQ+o2aiRKA+I+aGnclKjmaO/gPI29K6W3yEhaQGp6SRt0QMso/vqFiZuVZ
         XG0TN7Rkp8uJh3ebZ0VHmbOppJLJJ6bnSaDE3rg8iG/RdolC/XMcUw7awUH+tluNf9SG
         6fTQ0iKQ+23gBOR03a4cd4JcEyJS8/TPE2tqAvWaBwbEGpAxgbCvNh5iYNUjzR/TWw7F
         MXJ5vwRrG4PNS4LaUNgmF4Q0YLaH9A8uhC66cuio8nxfC5KI1YGRFyEXaujxv1/c3iYF
         cKfg==
X-Gm-Message-State: AOJu0Yyvwzl7rYr2TiSR5bEeAcsrcGNDTBicNK/znneAK5Ucaau6aFdY
        JvizaZxeMY2mwLm2m2QEu8s=
X-Google-Smtp-Source: AGHT+IE9tisrZljoEq5Fuh1o5TH+dXqa0jPky6iprufzEjvQSQltz33lDSlYc2FHgH12nLqZ2wpqMQ==
X-Received: by 2002:a05:600c:1f90:b0:405:92f9:b090 with SMTP id je16-20020a05600c1f9000b0040592f9b090mr11656642wmb.14.1698231117943;
        Wed, 25 Oct 2023 03:51:57 -0700 (PDT)
Received: from debian ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c231100b00401d8181f8bsm18898939wmo.25.2023.10.25.03.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 03:51:57 -0700 (PDT)
Date:   Wed, 25 Oct 2023 11:51:56 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com, srw@sladewatkins.net,
        rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/199] 5.10.199-rc2 review
Message-ID: <ZTjzTHTo6ZaP_KmH@debian>
References: <20231024083326.219645073@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024083326.219645073@linuxfoundation.org>
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

On Tue, Oct 24, 2023 at 10:36:35AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.199 release.
> There are 199 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 26 Oct 2023 08:32:45 +0000.
> Anything received after that time might be too late.

Build test (gcc version 11.3.1 20230511):
mips: 63 configs -> no failure
arm: 104 configs -> no failure
arm64: 3 configs -> no failure
x86_64: 4 configs -> no failure
alpha allmodconfig -> no failure
powerpc allmodconfig -> no failure
riscv allmodconfig -> no failure
s390 allmodconfig -> no failure
xtensa allmodconfig -> no failure

Boot test:
x86_64: Booted on my test laptop. No regression.
x86_64: Booted on qemu. No regression. [1]
arm64: Booted on rpi4b (4GB model). No regression. [2]

[1]. https://openqa.qa.codethink.co.uk/tests/5376
[2]. https://openqa.qa.codethink.co.uk/tests/5377


Tested-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

-- 
Regards
Sudip
