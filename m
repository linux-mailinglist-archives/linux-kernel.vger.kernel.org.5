Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC27778AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbjHKKGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjHKKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC45E3;
        Fri, 11 Aug 2023 03:06:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42695611E8;
        Fri, 11 Aug 2023 10:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C195C433C9;
        Fri, 11 Aug 2023 10:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691748378;
        bh=pQM9paCYuFL+5tn+eVihZ7qtEqyTnXlqJRdwgIwFhiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ul1GouuQNSEW4tPzH+EheXgpIqcQfVY+CfRKmJAwEZFfRnyTe/Zq0H0KJ3Sh4M4zl
         8ZVXIFDbtcN+XsolGDY85dGTnYkxOCl7vf6eiV9u8/s1r0cFuUbRxecZcdw87mKt/E
         WEBAkxk22kbY9Y/3uW/H4NIw/NsNrgq5iOBefXE4=
Date:   Fri, 11 Aug 2023 12:06:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Message-ID: <2023081105-gentleman-greyhound-75c4@gregkh>
References: <20230809103636.615294317@linuxfoundation.org>
 <fcd7b764-9047-22ba-a040-41b6ff99959c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcd7b764-9047-22ba-a040-41b6ff99959c@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 03:15:28AM -0700, Guenter Roeck wrote:
> On 8/9/23 03:39, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.45 release.
> > There are 127 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
> > Anything received after that time might be too late.
> > 
> 
> 
> Building loongarch:defconfig ... failed
> --------------
> Error log:
> <stdin>:569:2: warning: #warning syscall fstat not implemented [-Wcpp]
> arch/loongarch/kernel/setup.c: In function 'arch_cpu_finalize_init':
> arch/loongarch/kernel/setup.c:86:9: error: implicit declaration of function 'alternative_instructions'
> 
> Actually introduced in v6.1.44 with commit 08e86d42e2c9 ("loongarch/cpu:
> Switch to arch_cpu_finalize_init()"). Alternative instruction support
> was only introduced for loongarch in v6.2 with commit 19e5eb15b00c
> ("LoongArch: Add alternative runtime patching mechanism").

Thanks for the report, I'll fix this after this release.

greg k-h
