Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B084D7D49E4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjJXIWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjJXIWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:22:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7201D120;
        Tue, 24 Oct 2023 01:22:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8337DC433C8;
        Tue, 24 Oct 2023 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698135755;
        bh=4pSVrj+SSWFw7rLDfWopdukUhyQvQyk5SOKZaKQkS0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXIiJktfIv7Abl+M8zp4gbGGj0GnTXHzbrf4LD6M0kU3+1RZuMGmw4+l/2mugI9G5
         NzUyjVtiWRV40ghQoAtw9uX5HPgnClbG/LqF2u0ghSL+1bkjWu1A9tPmpfODc9Vaa9
         2/N6CZmcPCtUv4cfv/jRzn5l8tZouQt+uLICfyNo=
Date:   Tue, 24 Oct 2023 10:22:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 4.14 00/66] 4.14.328-rc1 review
Message-ID: <2023102417-blade-bartender-29e2@gregkh>
References: <20231023104810.781270702@linuxfoundation.org>
 <f3b2a4ac-042d-4c20-4020-3a09822811ac@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3b2a4ac-042d-4c20-4020-3a09822811ac@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 07:37:36AM -0700, Guenter Roeck wrote:
> On 10/23/23 03:55, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.328 release.
> > There are 66 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 25 Oct 2023 10:47:57 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Building s390:allmodconfig ... failed
> --------------
> Error log:
> In file included from include/linux/kernel.h:10,
>                  from arch/s390/pci/pci_dma.c:8:
> arch/s390/pci/pci_dma.c: In function 'bitmap_vzalloc':
> arch/s390/pci/pci_dma.c:536:15: error: implicit declaration of function 'check_mul_overflow'

Ah the header file maze.  I've fixed this up now, thanks.

greg k-h
