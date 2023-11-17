Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9027EEB95
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344874AbjKQEOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 23:14:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQEOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 23:14:10 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5AE1A5;
        Thu, 16 Nov 2023 20:14:07 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1cc0d0a0355so13083755ad.3;
        Thu, 16 Nov 2023 20:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700194446; x=1700799246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1IviFP1UmvZ/gHfcbxMG+ukFwTbGKkI3NY0964zDgY=;
        b=cY1SfyWUXpIh8Jh3sp4t4SB32BsIk+Tm2CrI/StMhpInWxVSd9IQD5eEQUYVuwYuIC
         xCIRYMq23brqknjFKElm1XO0vHOsVLQqSBGNTM71Miz+Nd2C0JVE/71nQLKTYfk+Fr6u
         zyonxBZEErFW0L4f9AuRVCa318bCFAgon8dYkwvs0oCMdM8/3hlzle9PyK8rAJfogUrC
         xrXmIyH3Ab3p8iq3JOxE2D6rOKsNAH4WexiU91+Q49HoB0b7Lby4Hpc/jmdpeE1ox4g2
         cmpWDpf3hhXNC6fKJfzlXMx+HnvRkK3NKe3p3uJd9TDEmO4xedwWMvVcF5KUwsYrMRpZ
         7UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700194446; x=1700799246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1IviFP1UmvZ/gHfcbxMG+ukFwTbGKkI3NY0964zDgY=;
        b=QZ6c/gzWSgcwDWH7Q2Ox43RCXR8jMy1kSqpXGy2pdzDtEdGLcO6DgZbS+nLkuPo0N7
         xgLazP1FF6FwkXLztOtuphWIp2WkKofDx3CxNoT+fdi1QkPKYxP69OwurYlJI3d6Qmys
         a8c7qVUvoHb9nBmp8Z1xuwA/Sj28AZpIcXFZmxeCzSRtFrZeRJ75O20jPjCl2uuK8MCb
         50b1WQ0RX1U50cOewM0gxnXyOuTm/UjIZufSJj1sMxLu+vK0hHjZ+VlYQrjXw5/ZQOJH
         c15uFcLrnb0mmCj94LMdv7JA6J32ihcjfifgeChQQTY6GFioQjYVm77jKX/P9p8wt1O2
         VwxQ==
X-Gm-Message-State: AOJu0Yz/puXiTMIJhGweuEDLAPbM9Ynk6KxRuvA8MriWYUkafgpuswGa
        qBnVVJZcFfTjjrGII3nzunY=
X-Google-Smtp-Source: AGHT+IGRWr0hFpsOm93SdG7YYSwLthuSdyhc6evr7+nyvmVBQW6izTePlhRxOsUC2b/kc67Sayo2Ig==
X-Received: by 2002:a17:902:ced1:b0:1cc:1e16:e998 with SMTP id d17-20020a170902ced100b001cc1e16e998mr12362911plg.51.1700194446427;
        Thu, 16 Nov 2023 20:14:06 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090264c800b001c9c5a1b477sm458829pli.169.2023.11.16.20.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 20:14:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 20:14:04 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.5 000/550] 6.5.12-rc1 review
Message-ID: <6c9f2a56-367a-455e-9d62-ebb507e225f0@roeck-us.net>
References: <20231115191600.708733204@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 02:09:44PM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.12 release.
> There are 550 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 19:14:03 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 155 fail: 2
Failed builds:
	i386:allyesconfig
	x86_64:allyesconfig
Qemu test results:
	total: 530 pass: 100 fail: 430
Failed tests:
	lots ...

I didn't check all failed tests, but it looks like the already reported
kunit build failures are responsible for at least a large majority of
the failures.

Guenter
