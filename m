Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022507904E9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 06:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjIBEQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 00:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjIBEQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 00:16:16 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824910FE;
        Fri,  1 Sep 2023 21:16:13 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-7926a450a0aso92959139f.3;
        Fri, 01 Sep 2023 21:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693628171; x=1694232971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W5mTjDDsIVAoQfJnfsps3hPdAwSGyGWAPaJJUcHWL5w=;
        b=BWYE56rAik6+och7w0bhLUiZPZ2DK4hhPfpH9oXudVK2uZsEwmurRK6FtBXaMiaafx
         Xuygzby56wL+ExJEDb1+KcZWyIX7EtlcGkCNSluDRrMMIPnuMwHNiK/FSOdGgVm3zpuv
         ICF6gHUp7/y+mK70iBVrY+1xbunwbVzAg8cI02bm0ETNuhyA/k284QZWKdFrXLvl6ofz
         sPYB19gBFTLFLkPXFdld499SwSL4pNf5D32cIdDbIugCcqOpWhORBeh9yvZm1gFT1i5m
         Iyqw6LYgjSTy0QaBsZyG3BfOtGvlQRn5Zbi7yogjbSJwUcHjyBsIyuy1OD43fKM47KyT
         G3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693628171; x=1694232971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5mTjDDsIVAoQfJnfsps3hPdAwSGyGWAPaJJUcHWL5w=;
        b=hQvpwFNHw4/6LQQiCUvGjpuFymN4n9eG7oil0lUaaNS7FT1GXTsCsR19CPmhQ10k7g
         CU7FQxT7dEq2rAHOWfJxgrkjMDXRr9MTEIF9L3sCxZaSHNAUk+5g1lWL9Sjg80NHoe6p
         qm+ziRSkmFoN+VFrx5JIdwxcxnT1scgtriXfqY3sDjEVCAlN5ShJOSVIZiPV+zHWSv6J
         K/RSTQSY9fJfBY3K40H4W21wj7n2J7eOqiiDypmyH4EJv2zler54N3QQG3qZ8jvffHxo
         PHADJgf3dp3shhUsfVZnfk5g6q4TDs4XIRncITI/6qHsO6M2B8VkzJskpxGdhNHbrDo4
         umAw==
X-Gm-Message-State: AOJu0Ywp1UsnZURjvuvVPwe32AKVGqawfk99H11/i89fcdaeKkI6NCEm
        DM4UXEar3AIJ7s22mDhn+io=
X-Google-Smtp-Source: AGHT+IHSet6TSJOotSDq2D0Tv8YX6F10eAV1fBrTk0WxrX9c9+Lvj1V4mPVSARY2aicSp7ABjjyDiQ==
X-Received: by 2002:a05:6602:22d1:b0:786:cc36:360c with SMTP id e17-20020a05660222d100b00786cc36360cmr4683810ioe.8.1693628171493;
        Fri, 01 Sep 2023 21:16:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 24-20020a0566380a5800b0042b05c1b702sm1512790jap.12.2023.09.01.21.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 21:16:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 1 Sep 2023 21:16:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 0/2] 4.14.325-rc1 review
Message-ID: <b412f90e-d355-4ff7-8bf7-7cb8fbaf5169@roeck-us.net>
References: <20230831110828.577111137@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831110828.577111137@linuxfoundation.org>
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

On Thu, Aug 31, 2023 at 01:09:41PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.325 release.
> There are 2 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 139 pass: 139 fail: 0
Qemu test results:
	total: 431 pass: 431 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
