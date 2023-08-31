Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5279478F1CD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345410AbjHaRWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 13:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346919AbjHaRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:22:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A69ECFF;
        Thu, 31 Aug 2023 10:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1D34BCE2026;
        Thu, 31 Aug 2023 17:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5752C433C7;
        Thu, 31 Aug 2023 17:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693502548;
        bh=iImPqkFM0alVdg4CvWUfxDNDltAgQ72o2O/mlA/lRxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnW6RjyoeLKpu8UsHELQI8YoKXo4OEg/UU96/JMM2m0LYbZ8hcK7eRQz+tJrIMOWw
         mJ3HyTWa1PxyhI/A1L1BbOoZXMUlcUh5hIgAbozGbZxvagU6aWw0F3zKTefW3aPAF/
         P5AnP0zvrwOT5mxOxhF1rwBFRgAGM8EydvwbDtWE=
Date:   Thu, 31 Aug 2023 19:22:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.19 0/1] 4.19.294-rc1 review
Message-ID: <2023083112-hazelnut-subject-0736@gregkh>
References: <20230831110828.433348914@linuxfoundation.org>
 <fbefb0cd-e056-4504-b0b2-ebd778d4996f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbefb0cd-e056-4504-b0b2-ebd778d4996f@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:10:02AM -0700, Guenter Roeck wrote:
> On Thu, Aug 31, 2023 at 01:09:48PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.294 release.
> > There are 1 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> > Anything received after that time might be too late.
> > 
> 
> arch/arm/mach-ep93xx/timer-ep93xx.c:12:10: fatal error: platform.h: No such file or directory
>    12 | #include "platform.h"
> 
> "ARM: ep93xx: fix missing-prototype warnings" needs to be reverted in
> v4.19.y as well.

Oops, missed that, let me go add it and push out a -rc2.

thanks for the quick test.

greg k-h
