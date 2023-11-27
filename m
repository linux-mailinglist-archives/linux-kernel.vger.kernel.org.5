Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B887F9FD0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:42:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233373AbjK0Mmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:42:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjK0Mmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:42:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B1C135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:42:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10A4C433C7;
        Mon, 27 Nov 2023 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701088958;
        bh=aaKzm9i45LO58fVj2NpSXP+hjRQ7QKMZXrEwp83qEB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1unsdqfov2BkJ1pGOY10t3XNL0cFdCiYdAEURB5PGMJFoLfjIwXgexbkHns54Cvvc
         2rOTHTymcJxnZzl3qiEbMsOaievkSvjVWl1UnnG49StDWSXLvEHnLsdX1GZfhG6lYj
         mzJPnr7n3DvyaUZGl01TN0pyCRRvjT5fQ8CndaRs=
Date:   Mon, 27 Nov 2023 12:42:35 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.15 000/292] 5.15.140-rc3 review
Message-ID: <2023112722-delicacy-arrange-59bd@gregkh>
References: <20231126154348.824037389@linuxfoundation.org>
 <3632c7da-24ba-4259-a590-5c46f899d43f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3632c7da-24ba-4259-a590-5c46f899d43f@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 08:24:57AM -0800, Guenter Roeck wrote:
> On 11/26/23 07:46, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.140 release.
> > There are 292 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> > Anything received after that time might be too late.
> > 
> 
> For v5.15.139-293-g0dd3c4f0979f (-rc3), powerpc:defconfig:
> 
> arch/powerpc/platforms/pseries/iommu.c: In function 'find_existing_ddw':
> arch/powerpc/platforms/pseries/iommu.c:908:49: error: 'struct dma_win' has no member named 'direct'
>   908 |                         *direct_mapping = window->direct;
> 
> 
> git blame points to commit 19bed3228b3aa ("powerpc/pseries/iommu: enable_ddw
> incorrectly returns direct mapping for SR-IOV device").

Ugh, forgot to drop this one from 5.15.y, now done.

thanks,

greg k-h
