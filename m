Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D9980489D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 05:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344173AbjLEEea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 23:34:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjLEEe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 23:34:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF2FA9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 20:34:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4522C433C8;
        Tue,  5 Dec 2023 04:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701750875;
        bh=8Ps76KLB/ZwO7Js1mZaNyHK/kOWqD+42yNXiGnKLZ4w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nf+47rp8SQVdhStKXaKUosvr7HkgPDC6Nk9l7yjPnnhGMmGbh3gapuSBah7q/7eMj
         ZmCv6ML3oG1lLXQ6TgtnRpyqw7hmLXZRR5FLEhxEoKChB5STBCCLRMboNcVLFoQEXb
         TEDvKvOy6jWxkg1X9ZvcRpHwUgsO4yctoLAK10Kk=
Date:   Tue, 5 Dec 2023 13:34:32 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 000/135] 5.10.203-rc1 review
Message-ID: <2023120526-handshake-kick-28a7@gregkh>
References: <20231205031530.557782248@linuxfoundation.org>
 <2d9146a0-3043-4e22-841f-78ada94224c6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9146a0-3043-4e22-841f-78ada94224c6@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 07:47:48PM -0800, Guenter Roeck wrote:
> On 12/4/23 19:15, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.203 release.
> > There are 135 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 07 Dec 2023 03:14:57 +0000.
> > Anything received after that time might be too late.
> > 
> 
> drivers/s390/crypto/ap_bus.c: In function 'ap_bus_force_rescan':
> drivers/s390/crypto/ap_bus.c:791:28: error: 'ap_scan_bus_count' undeclared
> 
> Seen with various s390 builds. Caused by commit 4c61e62ecde8 ("s390/ap: fix AP
> bus crash on early config change callback invocation") which uses the
> undeclared variable but does not introduce it.

Now dropped, thanks.

greg k-h
