Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B675C7A4A42
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241670AbjIRM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241539AbjIRM43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:56:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF06C3;
        Mon, 18 Sep 2023 05:56:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D7DC433C8;
        Mon, 18 Sep 2023 12:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695041767;
        bh=fa5q584AeojZM06/73JeedrQrTmfVHfWQyhaCrGqrlo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJwL7P5NYOTezcdMDuOqiJCTq0SeJ8SWlx/pB+mR4hby/yeGQT6179OpSs9JkdW1+
         n3WiLVYfhOQnDXVg7F241kETtYOyFJZCOAoIecTkcylLRzuKCYZAFHISzymHc4edP7
         lVJKsr2OFZ2CSgUD535X3VvKWbD2V/yKvCb9xpsM=
Date:   Mon, 18 Sep 2023 14:56:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 6.5 000/285] 6.5.4-rc1 review
Message-ID: <2023091846-cabbage-imagines-3fde@gregkh>
References: <20230917191051.639202302@linuxfoundation.org>
 <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe78c1a-8322-413b-f1b7-3a6a307a831c@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:52:10PM +0100, Jon Hunter wrote:
> Hi Greg,
> 
> On 17/09/2023 20:10, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.5.4 release.
> > There are 285 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.4-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > -------------
> > Pseudo-Shortlog of commits:
> 
> ...
> 
> > Sameer Pujar <spujar@nvidia.com>
> >      arm64: tegra: Update AHUB clock parent and rate
> 
> 
> Unfortunately, the above change is causing a regression in one of our audio
> tests and we are looking into why this is.
> 
> Can we drop this from stable for now?

Is it also a problem in Linus's tree?  Keeping bug-compatible is always
good :)

thanks,

greg k-h
