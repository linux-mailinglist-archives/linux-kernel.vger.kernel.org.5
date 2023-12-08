Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5796A809C6E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 07:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbjLHGde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 01:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbjLHGda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 01:33:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6919D1703
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 22:33:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A3DC433C7;
        Fri,  8 Dec 2023 06:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702017215;
        bh=Rv/ruy3db5Oz95ujeCfBD1LwNpGZWxkjI8JTNYAGUC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u+/b/5P0ZJHidKNaF6EmO+CJ36TT197KsvH7ahaswiveFl1rn1LJgMSLZv/JpwJ+d
         chenp7LAjW4vG3IrEd6Uc2CTq3s1LPFatquDMJA531E5TiHm909F2cbfcv/TxB4gWy
         ZMFzyCRBmA6Kl4fvPpAe94q123sCvhuN9QYRpKKQ=
Date:   Fri, 8 Dec 2023 07:33:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH 5.10 000/131] 5.10.203-rc3 review
Message-ID: <2023120812-shrank-draw-9b9b@gregkh>
References: <20231205183249.651714114@linuxfoundation.org>
 <efdb0591-2259-f86c-0da4-781dfdae22e1@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efdb0591-2259-f86c-0da4-781dfdae22e1@ispras.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 02:00:06AM +0300, Alexey Khoroshilov wrote:
> On 05.12.2023 22:22, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.203 release.
> > There are 131 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 07 Dec 2023 18:32:16 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.203-rc3.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> 
> 
> It seems something is seriously broken in this release.
> 
> There are patches already applied in 5.10.202 that are in 5.10.203-rc3
> transformed in some strange way, e.g.
> 
> Neil Armstrong <narmstrong@baylibre.com>
>     tty: serial: meson: retrieve port FIFO size from DT
> 
> 
> commit 980c3135f1ae6fe686a70c8ba78eb1bb4bde3060 in 5.10.202

Odd, yeah, something is off here, let me look into it after my coffee
has kicked in...

greg k-h
