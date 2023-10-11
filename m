Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C867E7C5A71
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjJKRo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjJKRoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:44:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A949193;
        Wed, 11 Oct 2023 10:44:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6BE8C433C8;
        Wed, 11 Oct 2023 17:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697046262;
        bh=y0K9DVRBqp1HgbG+cgzx/KsoOmdPExD1Vm5Y0WzuCMs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=usv8J5b4Bt2qLXXcRJ6Z6BOf6ZNgOiJiCwf/IHEozbZSvsCIuZafRTt2V54lyEJ74
         h0Lcdq6bCl5hSWnEYDvOmU9YlhRCuUVWCmLA1barifA/cYDXI1/2pYkh8x4ChzkVEj
         mqJxY6CBAfV5cXblpAB6Muq+JEI7QT/jINUyszI8=
Date:   Wed, 11 Oct 2023 19:44:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.15 000/183] 5.15.134-rc1 review
Message-ID: <2023101110-resurface-nuclear-bfee@gregkh>
References: <20231004175203.943277832@linuxfoundation.org>
 <CAEXW_YT6bH70M1TF2TttB-_kP=RUv_1nsy_sHYi6_0oCrX3mVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YT6bH70M1TF2TttB-_kP=RUv_1nsy_sHYi6_0oCrX3mVQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 11:58:49AM -0400, Joel Fernandes wrote:
> Hello Greg,
> 
> On Sat, Oct 7, 2023 at 9:00 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.15.134 release.
> > There are 183 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 06 Oct 2023 17:51:12 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.134-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> > and the diffstat can be found below.
> [...]
> > Liam R. Howlett <Liam.Howlett@oracle.com>
> >     kernel/sched: Modify initial boot task idle setup
> >
> 
> Let us drop this patch because it caused new tasks-RCU warnings (both
> normal and rude tasks RCU) in my stable test rig. We are discussing
> the "right fix" and at that time a backport can be done.
> 
> Hope Liam is also Ok with that. I am happy to do that future backport if needed.

This is already in a released kernel, a bunch of them:
	5.15.134 6.1.56 6.5.6 6.6-rc3
should it be reverted from all of the stable releases, or just for
5.15.y?

thanks,

greg k-h
