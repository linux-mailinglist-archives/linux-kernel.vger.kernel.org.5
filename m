Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1EA78A031
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 18:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjH0QfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 12:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjH0Qe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 12:34:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFC1FE;
        Sun, 27 Aug 2023 09:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 072F56246E;
        Sun, 27 Aug 2023 16:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6172C433C7;
        Sun, 27 Aug 2023 16:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693154093;
        bh=J/F/uBhPlsY7AE/Vfwu6zri6LsrLMFUmvMG+meosyAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n6LMR5xB1Ebw4MNrS8UoicIB0coaF7XgzCCou1hi1ZP6b0npt7lvHURh741Sg/k7b
         sJ8XdahLXF8iVh+8qJTVoEV8UvDUVE3WIBHlzyLfmPpgZ8NELY7e0zGn+coAEbQLYa
         8LTNcgRarab8pPn//z5+adtX/WoxNCysMFaTnQcE=
Date:   Sun, 27 Aug 2023 18:34:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
Message-ID: <2023082743-obsessive-thumb-01f7@gregkh>
References: <20230813211718.757428827@linuxfoundation.org>
 <b392e1a8-b987-4993-bd45-035db9415a6e@roeck-us.net>
 <2023081631-uproar-tapered-2221@gregkh>
 <2023082627-tabasco-concave-1366@gregkh>
 <7e5c80f0-45a3-407c-8c2e-e85bf97f5483@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e5c80f0-45a3-407c-8c2e-e85bf97f5483@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 04:21:40AM -0700, Guenter Roeck wrote:
> On Sat, Aug 26, 2023 at 05:48:59PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Aug 16, 2023 at 06:26:47PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Aug 14, 2023 at 07:04:57AM -0700, Guenter Roeck wrote:
> > > > On Sun, Aug 13, 2023 at 11:17:25PM +0200, Greg Kroah-Hartman wrote:
> > > > > This is the start of the stable review cycle for the 6.1.46 release.
> > > > > There are 149 patches in this series, all will be posted as a response
> > > > > to this one.  If anyone has any issues with these being applied, please
> > > > > let me know.
> > > > > 
> > > > > Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> > > > > Anything received after that time might be too late.
> > > > 
> > > > Booting with f2fs root file systems still crashes in this release
> > > > candidate. Would it make sense to mark f2fs as broken in v6.1.y ?
> > > 
> > > Ick, yeah, let me dig into this next week and figure out what went
> > > wrong...
> > 
> > I've now pushed out 6.1.49-rc1 with the last 3 f2fs patches reverted,
> > and a single objtool fix.  Hopefully that should resolve this issue, if
> > not, please let me know.
> > 
> 
> That does fix the problem.

Wonderful, thanks for testing.

greg k-h
