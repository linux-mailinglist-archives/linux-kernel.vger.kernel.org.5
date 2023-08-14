Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4969E77BFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 20:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjHNSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 14:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjHNSdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 14:33:45 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A4FF0;
        Mon, 14 Aug 2023 11:33:44 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7910620f45dso181154139f.1;
        Mon, 14 Aug 2023 11:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692038024; x=1692642824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hA1c32nPoqRtqKf1PeXAkYTakp7BkAfWNw6eIzfC7MU=;
        b=SoApQCrCfC7Mt89LgZDoWi1W1VWVv/sBUPllr/NAiHmv7RJREjec9tUvnmqf2ONb8f
         FTuhY+ZCQCL8UYzmbahUniwGqy9YqArSKiJl8bhPxu20rR5ny+2QKQ5SoRW3QM0ZWblX
         Jgxkc7ANJnqnsJBhyhBZJxtdDsXjTKcAgST/bKI1YIV4/o5gwyC6qEL6Y5eTcVvr27ma
         bgu1Yv2E8bVcwsGCvhWYVmx32odVL8jGMF+lYn0OyyJnr4K62jV4/JXnO+0AKuJFWmoQ
         y4JPrFchLR/ie2g+dJKkBXb1lZBuQhW1Wb8oR4zBD9tIjVumkKegnj620ntCo7XeKWwN
         rCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692038024; x=1692642824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hA1c32nPoqRtqKf1PeXAkYTakp7BkAfWNw6eIzfC7MU=;
        b=UZ9D0Fb5GEgrtnayisqCecHDG7qGRXQbGbCQYBgsOSv7VFno34wCsAoAcYKwZIRYyS
         bCDmTvsopWC5IJq8fjQfcZXPmb0fviffspKPy3RvYoJ9XhuRXiJJv23sr/ur6RnXOtl8
         D90F7t1eB9/WKiUSKXCTntGa7XFu4C8YW9EiXah2gmC4fZdDaim5BKTMThmXJPW0Eir6
         u1+a1lViMHQpROuOtQ8UBNTgmZqMpxKuVq9Y/HgqOo3x57kAJ5j3UKYL1pyfgV9zUBVi
         mxLZHyAyC4Jxrh/pFWLFo1eBS03zXxeKBEikE153VKChY0N/nP/cAV4Ym1009otmcMAH
         am2g==
X-Gm-Message-State: AOJu0YxKi0BTgI147LNVc17fv49R2g4/U+8eDjGYCZAYPHxSeQus0fOd
        dvAMCgsTtRFlz7EeNAw/xNI=
X-Google-Smtp-Source: AGHT+IGInvIBfbQ8LylVFc5S+ya7eq8omF2ey3IsarSvH5b8Avvbz5J1tuP4Xh+uIsPEnn4nNDa1mg==
X-Received: by 2002:a6b:4a17:0:b0:790:aedd:3e81 with SMTP id w23-20020a6b4a17000000b00790aedd3e81mr12348202iob.8.1692038024176;
        Mon, 14 Aug 2023 11:33:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u2-20020a02c042000000b004310d570d6dsm3193100jam.94.2023.08.14.11.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 11:33:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 14 Aug 2023 11:33:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
Message-ID: <ba8db9d2-2bf3-4b23-97c1-1db07f93644c@roeck-us.net>
References: <20230813211718.757428827@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
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

On Sun, Aug 13, 2023 at 11:17:25PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 157 pass: 157 fail: 0
Qemu test results:
	total: 521 pass: 519 fail: 2
Failed tests:
	arm:fuji-bmc:aspeed_g5_defconfig:notests:mem1G:mtd128,0,8,1:net,nic:aspeed-bmc-facebook-fuji:rootfs
	arm:bletchley-bmc,fmc-model=mt25qu02g,spi-model=mt25qu02g:aspeed_g5_defconfig:notests:mem1G:mtd256:net,nic:aspeed-bmc-facebook-bletchley:rootfs

As already reported, the failing tests are crashing in f2fs code.
This bears the questions 1) should I stop testing f2fs and 2),
would it make sense to mark f2fs as broken in v6.1.y ?

It doesn't seem to make sense to keep testing code which is known
to be broken.

Thanks,
Guenter
