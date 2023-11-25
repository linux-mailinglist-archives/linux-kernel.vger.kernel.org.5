Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0CE7F8C07
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjKYP0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKYP0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:26:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458D910A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:26:10 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61225C433C7;
        Sat, 25 Nov 2023 15:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700925969;
        bh=AxS91YaKOq3eGrZCLY+7MTYjoghw/8YartYwc4isNbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b8VP3DDZUVqRQmaMk8BXN+oIr50lKsDnRAj+g+JYXQAcEJKiM2vX2ObB0uhRKxn3i
         mBwTh6aJsYh/nyIvAQZ/0oHwgRbWLPIfUrOi0DNoSAVJa0gMGiS9lKV4U0yntpSfdT
         m1OtjSlLhQFH2XGPs1P/wUPNhLD+Nx4cVl/OEJms=
Date:   Sat, 25 Nov 2023 15:26:07 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 4.19 00/97] 4.19.300-rc1 review
Message-ID: <2023112518-traverse-unsecured-daa2@gregkh>
References: <20231124171934.122298957@linuxfoundation.org>
 <d48b5514-759f-47a0-b024-494ce87ec60f@linaro.org>
 <ZWHYlErVfVq8ZoOu@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWHYlErVfVq8ZoOu@duo.ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 12:20:52PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This is the start of the stable review cycle for the 4.19.300 release.
> > > There are 97 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > 
> > We see this failure on Arm32:
> > And this one on Arm64:
> 
> We see problems on arm, too:
> 
> https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/1084460512

Note, posting odd links isn't going to really help much, I don't have
the cycle, and sometimes the connectivity (last few stable releases were
done on trains and planes), to check stuff like this.

Info in an email is key, raw links is not going to help, sorry.

greg k-h
