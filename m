Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C2B7EEA0E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 00:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345575AbjKPXml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 18:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPXmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 18:42:39 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB5D8E;
        Thu, 16 Nov 2023 15:42:36 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6d645cfd238so800172a34.2;
        Thu, 16 Nov 2023 15:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700178156; x=1700782956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmpRtMVImizvD04Tgs0IdV7+Ixa4P5o87c35xN/QN0o=;
        b=Zrn2rmu4jTlgTc8ZmPbwmqT+L9UZbyVv8iBhGouDPrAmhsdfgHlBJ6MSPvdObKgRcC
         ynW5G78EWbCPMxtEMu/dCuatCerZYX0FgFyty+7j/1LxbtPwypUQ0ZweDcXFKaD1cXPy
         1ol+V4BiaUHUB0KpNjrRHCULCTj+PEyhUibuGW/OErGLw8gCrnZO7r5bjDSiH5v3PCbd
         8pSdr6fjcfqjds78tBVa3UQ7gIxHEdDuQtAy0iVNGB0YAZbh4J0MFD8WisMXWg1l49bV
         /x55sUV1sAs/oLYR1wxf1SUTgVJwnS0rZaq6wsGzrFk1PZLfhDgmP+kqQzVlibx3hdet
         zjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700178156; x=1700782956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmpRtMVImizvD04Tgs0IdV7+Ixa4P5o87c35xN/QN0o=;
        b=Cdyh2cBvgnB/NH5G3w9P8Iklsz9e4qcxuO0E5INBxw6JcY1mo8q+1N77i0xaVTu4Tr
         L+ZTlGCntIgBbwxsG0QIBIUAjM1ZX2cCqjByMXSTc2BVbtnYhrY6mPakl7T1onnZvVoC
         fyW5Fs6rxd/6eud0yk/PRgBRnxylRDgiCwpusz0kE9qBWthtv0Ef+ZNXkHLnLi1914Rd
         ObMtD6SzIf9GyaMFIkkIUw4xafV30zUf3lydqqWYfLcIwNMyGvi3KnR66ESmoSKzw1OU
         oUCZKXxzefKvGePQ1kPBocWw72jpQAkFPrFgJXDzJWM5fOBfoRkRyj6CoARyE+WOZ8co
         D5wA==
X-Gm-Message-State: AOJu0YxY7uyKe07JmeEAC/AsE9W7ZKSx6Qd12S20bdFuDFZU5BpCeMWi
        6tq/Dy0znmoJ1jW9EDW2MNY=
X-Google-Smtp-Source: AGHT+IFVdWr4sT2vfDHDv+EOm4WVZfS8dZxyQHDf75wcRjf2H7ce0ovCNIufPp6tAWNQ3kC0/t7Hfw==
X-Received: by 2002:a05:6870:538f:b0:1e9:c7cc:df9a with SMTP id h15-20020a056870538f00b001e9c7ccdf9amr20528999oan.11.1700178156060;
        Thu, 16 Nov 2023 15:42:36 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 14-20020aa7914e000000b006926e3dc2besm278387pfi.108.2023.11.16.15.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 15:42:35 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 16 Nov 2023 15:42:34 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.4 000/119] 5.4.261-rc1 review
Message-ID: <3c4fa3df-d0db-4eb2-b6ec-a397ec1ce399@roeck-us.net>
References: <20231115220132.607437515@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115220132.607437515@linuxfoundation.org>
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

On Wed, Nov 15, 2023 at 04:59:50PM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.261 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Nov 2023 22:01:17 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 154 pass: 154 fail: 0
Qemu test results:
	total: 464 pass: 464 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
