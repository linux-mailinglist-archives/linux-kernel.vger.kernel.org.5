Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5233C7E48E0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 19:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbjKGS5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 13:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjKGS5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 13:57:10 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D47999;
        Tue,  7 Nov 2023 10:57:08 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc330e8f58so44536915ad.3;
        Tue, 07 Nov 2023 10:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699383428; x=1699988228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JfOOzo8iylvtwSLRlUhW2XY0pCfvt1cHpqZ+0lY/ivc=;
        b=blJXcXvOEDYQ/17X414VoqFp0N0BSju0bIxWkNADhHSgRV+cDa3M1L2qAkLt29ge9z
         iwjIYSK1jkm1xcMNsVC3bUSEjQanAQWBADeRju6yFCcx1vovMUz81S/RHwPhEtndeJdL
         K6KV2LfsYYqh7i6yqHsJWfnsxnHMmQ16UhDtZgmLQ+30SfqCUgCv6l+PpsV3yYJAojnp
         paEuAjuFhFoJQNffFuarCGg/Cdw7Iy5hzSVdTh/l5M2OJPVY8C8usEk4PtxRfRJxPKll
         eexGwOl/CtJvPixdquEzXeeRk8ArzdHjbVPX9DvpzHIfqXWWvqgezYMZErtISJ1IU1T+
         raEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699383428; x=1699988228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JfOOzo8iylvtwSLRlUhW2XY0pCfvt1cHpqZ+0lY/ivc=;
        b=W7zuD4UPKGaSAsh87o0ByKb0twFK62j2IJW2eff9XiHKBTCdQx2kWWW3VX5F4OGgG8
         V/H9vqaeIJJh/Sae4HGI/cbTSytgVOZMoxG3qf2O11LxMdlRzhNeei7ANZS9Um3fhJuI
         EpNFNgA0HZg2xHLgehlx82pVB0TLZU2MavrIqT89bUBVdGUq/CZ1sCnT3CFhfl3XnVE+
         c5iggIubzKQ/GbPkv3o6C/LP0GFWsovGPZlWLMxNa+LNo8PKb4OS/fdsIBTEwZCM5rXv
         r9axoNxNg6ud8Y34ES5D+4Zy+rqN+gZI8xp69ft8AYO+09ZFiNrberGhfR35612lSGh+
         TIpw==
X-Gm-Message-State: AOJu0YwrQ+I7Zr5Z26Q34p2u3pKZ1eyx8iz+p5wsYDUKTyg/sRc0/+Q8
        jBYFDuuPNfJ60hAV0XN7JJsCebIvDdo=
X-Google-Smtp-Source: AGHT+IG6fmhenCu0zLqS20cK/h8oh6S4QBrlV65xInaTaQqY6ptqoWYeW0HRjD6hDd2rJ9DxnXVpAQ==
X-Received: by 2002:a17:903:41cc:b0:1cc:5dd4:7cf8 with SMTP id u12-20020a17090341cc00b001cc5dd47cf8mr25212675ple.27.1699383428016;
        Tue, 07 Nov 2023 10:57:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902cec300b001c57aac6e5esm168944plg.23.2023.11.07.10.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 10:57:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Nov 2023 10:57:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/95] 5.10.200-rc1 review
Message-ID: <a8de34ba-0be8-491f-b4f7-a9d233526380@roeck-us.net>
References: <20231106130304.678610325@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231106130304.678610325@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 02:03:28PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.200 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 149 fail: 10
Failed builds:
	i386:tools/perf
	x86_64:tools/perf
	<all riscv32/riscv64>
Qemu test results:
	total: 495 pass: 456 fail: 39
Failed tests:
	<all riscv32/riscv64>

All failures have already been reported, so I wn't go into detail.

Guenter
