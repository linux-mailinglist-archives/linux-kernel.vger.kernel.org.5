Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4234C7FA035
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbjK0NBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233429AbjK0NBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:01:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA9D182
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:01:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4D1C433C8;
        Mon, 27 Nov 2023 13:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701090097;
        bh=lXWg88itlTnqydnqiK3rCRUDWJLDAFTD9g8Pk4yxK6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XGeA/H3k7yZ+OkeaJItHDcgTYsncPXxGgWd7VEpu4vLWbqVnhD5qwbrg+VA6CODBX
         pryou3AigatAlqrTj7FGcPk18Pkgnts/kZPjWBGONUVJEN8Kh/cp7x2T2SB00t54fo
         dMeBAv7SiUEGJQENNwUH4uDmAzDgzsMTOvyxc9C4=
Date:   Mon, 27 Nov 2023 12:47:03 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
Message-ID: <2023112751-predict-ovary-5afa@gregkh>
References: <20231125163059.878143365@linuxfoundation.org>
 <09f33739-9bf6-4ff8-895d-92d3567c3cb9@roeck-us.net>
 <ZWOs6uwZoCoxYSSs@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWOs6uwZoCoxYSSs@p100>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 09:39:06PM +0100, Helge Deller wrote:
> * Guenter Roeck <linux@roeck-us.net>:
> > On 11/25/23 08:32, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.331 release.
> > > There are 53 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Building parisc64:generic-64bit_defconfig ... failed
> > --------------
> > Error log:
> > hppa64-linux-ld: arch/parisc/kernel/head.o: in function `$iodc_panic':
> > (.head.text+0x64): undefined reference to `init_stack'
> > hppa64-linux-ld: (.head.text+0x68): undefined reference to `init_stack'
> > make[1]: *** [Makefile:1049: vmlinux] Error 1
> > make: *** [Makefile:153: sub-make] Error 2
> 
> Indeed.
> Thanks for testing, Guenter!
> 
> Greg, could you please replace the patch in queue/4.14 with
> the one below? It simply uses another stack start, which is ok since the
> machine will stop anyway.
> 
> No changes needed for your other stable-queues. I tested 4.19 and
> it's ok as-is.
> 

Now replaced, thanks.

greg k-h
