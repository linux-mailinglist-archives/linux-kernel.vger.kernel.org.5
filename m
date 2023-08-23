Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7E2784DED
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjHWAt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 20:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjHWAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:49:59 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E16CFF;
        Tue, 22 Aug 2023 17:49:57 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bba48b0bd2so33870155ad.3;
        Tue, 22 Aug 2023 17:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692751797; x=1693356597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EwKQQZjmpvwCc7+3qPK6l0MEjC1OGrKphiy40wLGUQM=;
        b=efFIrKCgCxm3PxjaPMDaWF2SLtMeoq/IeKmE+CdqcjGG4PiYou5I8RnKvWBsOPDCqZ
         NDysXF877DfGT2emsVhpv1fHAW26nVmdsPHarJTTRApW+ftScFw++2tkL85SLTwaCbT7
         MFLUMEZvFDPvGb/BIkVq/9ygi0Qt3gWu3XxWII26DiMXcc8DlpKIIo4Vz4D8RJkUtJJR
         PyGUmjRV5oU2VktQNyixUjmrbX4q73zROnG5hfjXVhjhGdwHUm7MtATIGmeLa1/LXECe
         q2CHInNlF6Whf7KTxrpPW2FAU9IxUulS/Xw3oL5MSIJo9KR2Y2IQKQ0X6F/MJyj1OO9z
         OgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692751797; x=1693356597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwKQQZjmpvwCc7+3qPK6l0MEjC1OGrKphiy40wLGUQM=;
        b=FmbulNEDHzYZh2VjIFG8ekZ2VyZJMP7ojFPyqyHn10It51j+Iz/4DYMiUH3vWBrRG5
         OfoQ6dTPspF/MDtsFmmZsxO45+oJqF65z01RAnTbAekA3hQ7/tbShZHLyFxi5ck92QFk
         zV/LYMSvC80lGIbB1St61VlGkNbttlOCHKz+5uETxOJuUh2UHp4J3iVIZYwI3N3fo6/E
         z83jg0tLbC9n3BdiFEThVuCeMdP8B4BcB5yFeGexZ6kfy/ZCOrarYBt9vSugfRNgalaz
         fX8GjqKQWbfL7e/c/xNGBH+NaX8rJ6sqj03/m3VBMNsj/ZHmvCGlphl8B4HGg0oTb2MC
         9W5w==
X-Gm-Message-State: AOJu0YyKMM/Ai2qx0ZuQb+q+JFjiXwfQa1vBGrlriK9NI+xlUILCuHMg
        TkVdkcZW6NUmxXWi9mUsD7PMuk2sktw=
X-Google-Smtp-Source: AGHT+IGg7Uqhbuss07EY3xzy+9AeCTRSSN7AcMVUWMoR4rxfLDp3u6ZvlucWPoVnqMsIO8J6MkW0hQ==
X-Received: by 2002:a17:902:b594:b0:1bc:9c49:f8bc with SMTP id a20-20020a170902b59400b001bc9c49f8bcmr8742401pls.8.1692751796711;
        Tue, 22 Aug 2023 17:49:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b001bc676df6a9sm9599282plh.132.2023.08.22.17.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 17:49:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 22 Aug 2023 17:49:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/194] 6.1.47-rc1 review
Message-ID: <991b93d2-9fde-4233-97d5-1133a9360d02@roeck-us.net>
References: <20230821194122.695845670@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:39:39PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.47 release.
> There are 194 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 156 fail: 1
Failed builds:
	m68k:sun3_defconfig
Qemu test results:
	total: 521 pass: 519 fail: 2
Failed tests:
	arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:f2fs
	arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:f2fs

The m68k build failure is

Inconsistent kallsyms data
Try make KALLSYMS_EXTRA_PASS=1 as a workaround

I already have KALLSYMS_EXTRA_PASS=1 enabled, so that doesn't help.
Nothing to worry about. The f2fs crashes are still seen. They
also happen for other architectures, so it is not just an arm problem.
I'll probably just disable all f2fs testing going forward. If so I'll
send a note clarifying that the lack of reported test failures doesn't
mean that it works.

For x86 I get the same runtime warning as everyone else.

Guenter
