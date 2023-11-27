Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998B27FA060
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbjK0NKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233369AbjK0Mkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:40:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6604A183
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 04:40:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AA6C433C8;
        Mon, 27 Nov 2023 12:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701088854;
        bh=mFCKdLu7hgFSzZlU35GDqQpUtEwbIPeo0aA8OfG/OPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=weGFaxmed+deLIEa5XZKOW4yn8VKLnfzzdkR1+ohhDrJiC4GHE8qz4V4Inl+vu+qd
         nvgVRzE37EnS4hRtAUIqYZERZfzkbNsDcNBdksT37I+PY/LVfGSfCRik10BlCbNZT3
         Zc6JV1Ds2HIQsrowDy+aCHZWmb0Us7LgReQVwoJU=
Date:   Mon, 27 Nov 2023 12:40:51 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/187] 5.10.202-rc3 review
Message-ID: <2023112745-spree-require-c3a6@gregkh>
References: <20231126154335.643804657@linuxfoundation.org>
 <76363981-1f2a-47c2-b1b1-ae039844e936@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76363981-1f2a-47c2-b1b1-ae039844e936@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 10:23:24AM -0800, Guenter Roeck wrote:
> On 11/26/23 07:46, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.202 release.
> > There are 187 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> > Anything received after that time might be too late.
> > 
> 
> For v5.10.201-188-g2f84e268b78b (5.10.202-rc3):
> 
> s390:defconfig, s390:allmodconfig, s390:debug_defconfig:
> 
> drivers/s390/crypto/ap_bus.c: In function 'ap_bus_force_rescan':
> drivers/s390/crypto/ap_bus.c:791:28: error: 'ap_scan_bus_count' undeclared
> 
> $ git grep ap_scan_bus_count
> drivers/s390/crypto/ap_bus.c:   if (atomic64_read(&ap_scan_bus_count) <= 0)
> $ git blame drivers/s390/crypto/ap_bus.c |& grep ap_scan_bus_count
> 467f51fb3ab6e (Harald Freudenberger 2023-10-23 09:57:10 +0200  791) 	if (atomic64_read(&ap_scan_bus_count) <= 0)
> 
> which is:
> 
> 467f51fb3ab6 s390/ap: fix AP bus crash on early config change callback invocation

Now dropped, thanks.

greg k-h
