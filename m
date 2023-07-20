Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9375B5E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbjGTRur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjGTRuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7320268F;
        Thu, 20 Jul 2023 10:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F9D661B95;
        Thu, 20 Jul 2023 17:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29110C433C7;
        Thu, 20 Jul 2023 17:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689875438;
        bh=tA6jPNyslJC+LUacjwi2kvTq/6NHCcqxlljp7wunIe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jK80v0ACTaeStmC6h4QNp1pZrzv0tbJx9pDdZTutOEZSz2o5PaUnz5Kcu7rhsAnhZ
         CH112eu/lWtwN+YI1/fu8p2HLNVx1ex9Y5PfK75MzFEVV2tkMeum5SaE35yS7yoM5/
         6C0yuU8Se2inio0BdvdVD5rjpF2PxM0LFbnmnPrQ=
Date:   Thu, 20 Jul 2023 19:50:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Paul Barker <paul.barker.ct@bp.renesas.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/589] 6.1.39-rc3 review
Message-ID: <2023072028-elevation-undead-bb94@gregkh>
References: <20230717201547.359923764@linuxfoundation.org>
 <9da5f8cb-5ed0-1854-0a0a-252794e01ce3@bp.renesas.com>
 <9705c130-997d-6356-18bc-ee5ce5d8b325@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9705c130-997d-6356-18bc-ee5ce5d8b325@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 03:50:06PM -0700, Guenter Roeck wrote:
> On 7/17/23 15:39, Paul Barker wrote:
> > Hi Greg,
> > 
> > On 17/07/2023 21:34, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.39 release.
> > > There are 589 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Wed, 19 Jul 2023 20:14:46 +0000.
> > > Anything received after that time might be too late.
> > > 
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.39-rc3.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > 
> > Building i386_defconfig in my Yocto Project environment (with gcc 13) fails:
> > 
> > | /.../kernel/workqueue.c: In function 'get_work_pwq':
> > | /.../kernel/workqueue.c:706:24: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> > |   706 |                 return (void *)(data & WORK_STRUCT_WQ_DATA_MASK);
> > |       |                        ^
> > | /.../kernel/workqueue.c: In function 'get_work_pool':
> > | /.../kernel/workqueue.c:734:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> > |   734 |                 return ((struct pool_workqueue *)
> > |       |                         ^
> > | /.../kernel/workqueue.c: In function 'get_work_pool_id':
> > | /.../kernel/workqueue.c:756:25: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
> > |   756 |                 return ((struct pool_workqueue *)
> > |       |                         ^
> > 
> > Cherry-picking afa4bb778e48d79e4a642ed41e3b4e0de7489a6c from mainline fixes the build for me.
> > 
> 
> That is not a new problem, though. I see the same problem with v6.1.38
> and with v6.1 if I try to build with gcc 13.1.

Thanks, now queued up.

greg k-h
