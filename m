Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E587C0162
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbjJJQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233678AbjJJQPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:15:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232BCB4;
        Tue, 10 Oct 2023 09:15:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35719C433C7;
        Tue, 10 Oct 2023 16:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696954518;
        bh=E6kRIQQhwOKGKVKTczVQPqNC4o7DfYIF2l61fia6LCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NvSVceR7UXVU4u//6GoXudNeDUmoI7tVvtX5f2PWTvt8n6sLXLt/CxA1C7W940yoP
         WzH0uIufndvCP7AWRIeGTa1xH1mTIkCbAulOpJRHfkaVyx5T8J7yMZyCJb5O2bM5BN
         QyY2Gr4+4ECMfLqDcSizPJNHxqhw04j6ofe0NJpE=
Date:   Tue, 10 Oct 2023 18:15:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     sweettea-kernel@dorminy.me, dsterba@suse.com,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: unneeded btrfs changes -- Re: [PATCH 6.1 000/162] 6.1.57-rc1
 review
Message-ID: <2023101053-angles-audacity-a284@gregkh>
References: <20231009130122.946357448@linuxfoundation.org>
 <ZSUerjykMViykoYZ@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSUerjykMViykoYZ@duo.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 11:51:42AM +0200, Pavel Machek wrote:
> Hi!
> On Mon 2023-10-09 14:59:41, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.57 release.
> > There are 162 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.57-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> > 
> 
> > Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >     btrfs: use struct fscrypt_str instead of struct qstr
> > 
> > Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >     btrfs: setup qstr from dentrys using fscrypt helper
> > 
> > Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
> >     btrfs: use struct qstr instead of name and namelen pairs
> 
> These are rather intrusive, and marked with
> 
> Stable-dep-of: 9af86694fd5d ("btrfs: file_remove_privs needs an exclusive lock in direct io write")
> 
> but we don't have that one in 6.1, so we should not have these,
> either.

Ah, seems we forgot that dep patch, so that's now added which makes more
sense why the prep patches were added.

thanks,

greg k-h
