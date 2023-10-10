Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5CE7C03A2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343507AbjJJSnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbjJJSnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:43:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2200893;
        Tue, 10 Oct 2023 11:43:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A2EC433C8;
        Tue, 10 Oct 2023 18:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696963381;
        bh=xuJQBkZ40eoYwA9Ihdt5nQEAu4U80UA46rmFAeOlETI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J+CeRgYmUqznuNK3A1KzeBLqZHQ6qj7M/VIMOvqj6S4LJDKZvHbAb0CjoVfWkmSVz
         DXuyk2QQe0sIYUDeqO6aboVmJA1mzWP3TBBtiwpfEjLT+ulusGDrdH3COfezqj9cov
         QwDVkw6uNkkCQ7+fBpVofXKsoJ42YtHLCOOQC58w=
Date:   Tue, 10 Oct 2023 20:42:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     wqu@suse.com, stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.1 000/162] 6.1.57-rc1 review
Message-ID: <2023101053-heading-chase-e2c2@gregkh>
References: <20231010161046.7861.409509F4@e16-tech.com>
 <2023101008-argue-impart-a6ad@gregkh>
 <20231010194221.C1C3.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010194221.C1C3.409509F4@e16-tech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:42:22PM +0800, Wang Yugui wrote:
> Hi,
> 
> > On Tue, Oct 10, 2023 at 04:10:48PM +0800, Wang Yugui wrote:
> > > Hi,
> > > 
> > > > This is the start of the stable review cycle for the 6.1.57 release.
> > > > There are 162 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> > > > Anything received after that time might be too late.
> > > 
> > > 
> > > drop this patch from 6.5/6.1/5.15/... please, 
> > >   Qu Wenruo <wqu@suse.com>
> > >      btrfs: reject unknown mount options early
> > > 
> > > becuase of this report.
> > > https://lore.kernel.org/linux-btrfs/f3ac7b74-c011-4d1f-a510-677679fc9743@gmx.com/T/#t
> > 
> > Is there a revert somewhere for this already?
> 
> Yet not.
> 
> but we can suspend to apply this patch(drop this patch) for stable.

Now dropped, thanks.

greg k-h
