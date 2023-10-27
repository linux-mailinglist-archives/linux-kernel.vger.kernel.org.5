Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354D67D97F1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345740AbjJ0MZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345735AbjJ0MZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:25:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA4B129;
        Fri, 27 Oct 2023 05:25:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B93D1C433C8;
        Fri, 27 Oct 2023 12:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698409549;
        bh=MYEyUUlsJs+iZgGeLmTbL5xofgyQMNOOT9INtcAOOjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JFVirIHauXlFphEwwzwy1n45Ac8RgLlrM4OavdZx4EQ3WLxm686kL7tjZMwFC8MJ5
         jsInj/eZiC3y39ii8Z1egcQjEmBaS89V1Omf09kv6DvZc2aIc1E9rdPX+pXIULl228
         aywtQ1H3UgY3qU7GL3NaVTA/DlMxzOAv+VaUoo4k=
Date:   Fri, 27 Oct 2023 14:25:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/199] 5.10.199-rc2 review
Message-ID: <2023102728-gigantic-favorable-71a6@gregkh>
References: <20231024083326.219645073@linuxfoundation.org>
 <6413ac66-2608-cd76-1b3c-5a185fe6d88d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6413ac66-2608-cd76-1b3c-5a185fe6d88d@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:07:26AM -0700, Guenter Roeck wrote:
> On 10/24/23 01:36, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.199 release.
> > There are 199 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 26 Oct 2023 08:32:45 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build reference: v5.10.198-200-ge31b6513c43d
> Compiler version: x86_64-linux-gcc (GCC) 11.4.0
> Assembler version: GNU assembler (GNU Binutils) 2.40
> 
> Building x86_64:defconfig ... passed
> Building x86_64:allyesconfig ... failed
> --------------
> Error log:
> Unsupported relocation type: unknown type rel type name (-1940038754)
> make[3]: *** [arch/x86/boot/compressed/Makefile:122: arch/x86/boot/compressed/vmlinux.relocs] Error 1
> make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
> make[3]: *** Waiting for unfinished jobs....
> x86_64-linux-objcopy: vmlinux: unsupported relocation type 0x9e
> x86_64-linux-objcopy: vmlinux[.text]: relocation count is negative: bad value
> make[3]: *** [arch/x86/boot/compressed/Makefile:114: arch/x86/boot/compressed/vmlinux.bin] Error 1
> make[2]: *** [arch/x86/boot/Makefile:115: arch/x86/boot/compressed/vmlinux] Error 2
> make[1]: *** [arch/x86/Makefile:274: bzImage] Error 2
> make: *** [Makefile:192: __sub-make] Error 2
> 
> No idea what is causing it, but it is persistent. Something odd between
> compiler/binutils/objcopy.
> 
> Guess it doesn't matter since the release is out already.

If the commit that causes this can be figured out, we can revert it.

thanks,

greg k-h
