Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE97A5BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjISHzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjISHzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:55:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9F312F;
        Tue, 19 Sep 2023 00:55:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BCD3C433C7;
        Tue, 19 Sep 2023 07:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695110110;
        bh=NxpJYkRRMKcYH1DrE4WcpNHNOZjOskdv/B3fMk90j1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwU709TYd4H43Xymnx2gXSUYOblXr/N/AwcpXTe8GbUUCobTdZFmu1SLxSiEUlmd6
         GCoy3mLEIlPFja1uYTOdbTqTYEkfjQr+PgClyaxHdEnfgcciKAOEz/qbFQdQg9IvRi
         qgZY1RMG4snDcJEoHRGhS6T4kEYMNogqzJ5IbbFA=
Date:   Tue, 19 Sep 2023 09:55:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jon Hunter <jonathanh@nvidia.com>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Sameer Pujar <spujar@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Message-ID: <2023091956-harmonica-stingy-21f8@gregkh>
References: <20230917191051.639202302@linuxfoundation.org>
 <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
 <2023091846-cabbage-imagines-3fde@gregkh>
 <bae1a61f-ab9d-2560-9c70-e09092363467@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae1a61f-ab9d-2560-9c70-e09092363467@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 08:17:43AM -0700, Guenter Roeck wrote:
> On 9/18/23 05:56, Greg Kroah-Hartman wrote:
> > On Mon, Sep 18, 2023 at 01:52:10PM +0100, Jon Hunter wrote:
> > > Hi Greg,
> > > 
> > > On 17/09/2023 20:10, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.5.4 release.
> > > > There are 285 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
> > > > or in the git tree and branch at:
> > > > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > > -------------
> > > > Pseudo-Shortlog of commits:
> > > 
> > > ...
> > > 
> > > > Sameer Pujar <spujar@nvidia.com>
> > > >       arm64: tegra: Update AHUB clock parent and rate
> > > 
> > > 
> > > Unfortunately, the above change is causing a regression in one of our audio
> > > tests and we are looking into why this is.
> > > 
> > > Can we drop this from stable for now?
> > 
> > Is it also a problem in Linus's tree?  Keeping bug-compatible is always
> > good :)
> > 
> 
> Sorry, no, it isn't, especially in the context of at the same time suggesting
> that everyone should start using the most recent stable release immediately
> (instead of, say, selectively picking security patches).
> 
> I don't think Tegra users would be happy if their audio stopped working,
> and it seems unlikely that they would accept the argument that they should
> be happy to be bug-compatible with the latest upstream kernel - even more so
> if that latest upstream kernel is a release candidate and the problem was
> introduced in the commit window.

Very good point, I've now dropped it.

greg k-h
