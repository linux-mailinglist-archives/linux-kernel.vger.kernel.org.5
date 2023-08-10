Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF02777DBE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbjHJQIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjHJQHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:07:40 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6682705;
        Thu, 10 Aug 2023 09:06:27 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-56546b45f30so856149a12.3;
        Thu, 10 Aug 2023 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691683563; x=1692288363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7QTlvRoNFyRkX134ok9OXAI5i34/aitXtvtzRW1b4zY=;
        b=c1uli04YlC1QuVJyrnAyDUG1dktQfEbYV5+ruAVTnx8APe45u26qzq22tpvrFSa7Ji
         9LsFSCkQ1YVNAocfwIqISiw1/XWQr7acau6ys3HEjIocGbqaIITvriakFIMhIcVGckpG
         h71GJ98iZmp+FAax/QUIEO/+njb+FoztpoY4NyekEhVw3Mof6jyHVUubWo1gCzsTLO6l
         4viT+RsV53XY5HjoESUYXKAtOON1uyys0xgiTz01IINMw1UrnctBgJDFH3dVmO4qCB10
         Dd8sL0asyPXPy91dVOCcYQk4R2FZ6bQbo/LbtEV8kHrTQIKopbaeR/RV2uQTZJ0zGTUv
         LPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683563; x=1692288363;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7QTlvRoNFyRkX134ok9OXAI5i34/aitXtvtzRW1b4zY=;
        b=HY4R6mDtcou1LGM6Y8KDYbOv4xNPDaEjLe0YOhmd1YgT0nHCJ26pOQZqrUEQOZ7Oh4
         XoJt3KkjKQd7RRvfVMI0pTWx32YzXwu0vdbJxoT1qjs3Y1a08EdVoYQ/k4fP4U//zQb9
         ar03SWxLzMjMjSL1xSW45gZJT54QP5VFpTYGK8Q7cVmQ+sdQGKm+hrR7jp9/zQJRR9V0
         eNfAUmUg1in+vYYjZBYSIEN0VCF7OG8KA0lLHxOrBqIGbAEIj9KSH2Kb74SJLYUqNETo
         2hd4dQTEQg8WbpTKxJOnOh/Oc3kskNWxH54CjoEtesYrERSYntrUQasK+xCez6S0cq6u
         2lzQ==
X-Gm-Message-State: AOJu0YwkrgOs30NcrG5D/xUjnjFzhA1QrZJJEX3ylPGKsoMY9SsLt0of
        ufSe2ztZfcxZZQ5/82BAdCU=
X-Google-Smtp-Source: AGHT+IFYuzGXk0YLQzgsucbh6baCPkIJDrQ80m5KaFMbG7JdAt8Ixv2BouUHDvkq9z5yklEglcqWKw==
X-Received: by 2002:a17:90b:4d8b:b0:261:1141:b716 with SMTP id oj11-20020a17090b4d8b00b002611141b716mr2564311pjb.33.1691683562805;
        Thu, 10 Aug 2023 09:06:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n20-20020a17090ade9400b002682523653asm1685322pjv.49.2023.08.10.09.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:06:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Aug 2023 09:06:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Message-ID: <681f8e2c-df72-4a54-bef8-803ac0bc69f6@roeck-us.net>
References: <20230809103633.485906560@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809103633.485906560@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.126 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 160 pass: 157 fail: 3
Failed builds:
	arm:allmodconfig
	arm64:defconfig
	arm64:allmodconfig
Qemu test results:
	total: 501 pass: 423 fail: 78
Failed tests:
	<most arm>
	<all arm64/arm64be>

As already reported, plus:

Error log:
drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c:176:20: error: 'drm_plane_helper_destroy' undeclared here

for arm:multi_v7_defconfig

Side note: I am surprised about successful arm64 tests/builds
since arm64:defconfig fails to build with obvious code errors.

drivers/firmware/arm_scmi/smc.c:39:13: error: duplicate member 'irq'

drivers/firmware/arm_scmi/smc.c: In function 'smc_chan_setup':
drivers/firmware/arm_scmi/smc.c:118:34: error: 'irq' undeclared

Guenter
