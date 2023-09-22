Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B357AB5B4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjIVQTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVQTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:19:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541E799;
        Fri, 22 Sep 2023 09:19:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7A4C433C8;
        Fri, 22 Sep 2023 16:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695399542;
        bh=r8ZtX/WhNqdykwR8TbeoJiycGFO05185e+m1c96HymE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zGQI7Ussf1xuByWNERNVaFe+5LihRSxsioj+Df775DsgRCi/TXKhBVIxXILY92asa
         QKWA+t/IfFmqYdSW8qIq3GGa2P12LormGBAzUwWlUwobpkpW/DqJbDyKJKx2SrRD8D
         W7+LPIJiDuUcGnnHtq+7JUALX4PwPVDVzP/fdLq0=
Date:   Fri, 22 Sep 2023 18:18:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/139] 6.1.55-rc1 review
Message-ID: <2023092233-frozen-sadden-5f0d@gregkh>
References: <20230920112835.549467415@linuxfoundation.org>
 <7d99c7d8-cf39-4ab8-a385-36af98f4a30a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d99c7d8-cf39-4ab8-a385-36af98f4a30a@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 09:03:09AM -0700, Guenter Roeck wrote:
> On Wed, Sep 20, 2023 at 01:28:54PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.55 release.
> > There are 139 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 157 pass: 156 fail: 1
> Failed builds:
> 	powerpc:ppc32_allmodconfig
> Qemu test results:
> 	total: 529 pass: 529 fail: 0
> 
> Building powerpc:ppc32_allmodconfig ... failed
> --------------
> Error log:
> drivers/usb/gadget/udc/fsl_qe_udc.c: In function 'ch9getstatus':
> drivers/usb/gadget/udc/fsl_qe_udc.c:1964:17: error: ISO C90 forbids mixed declarations and code

Very odd that this only shows up on this one platform.  I'll go fix it
up, thanks for the report.

greg k-h
