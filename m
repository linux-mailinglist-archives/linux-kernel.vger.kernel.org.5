Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437FE78EA33
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 12:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244407AbjHaK3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 06:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbjHaK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 06:29:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51355E43;
        Thu, 31 Aug 2023 03:29:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C7C9B82171;
        Thu, 31 Aug 2023 10:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4813DC433C7;
        Thu, 31 Aug 2023 10:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693477781;
        bh=DmxDznbQymJ2l8KcXrB0FW74Sx+X6XG0I+epJHJAKgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zlXeIlhhR1EEgvMgKY1aP4Y3gNA9z7wylIZIEs3u5d7Y0zxUSt4lGc5YnKbTE4/jP
         NIQzb9hHlDGGgvZj6t0aDfhb7LyxRd2zS/MixP6aKcr7V+fXNfrczFle3vh4vhRhtF
         /6xM/coOxFa/sTSu36TsBI3ySUg6fXvtwfet4vRE=
Date:   Thu, 31 Aug 2023 12:29:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 000/135] 5.10.192-rc1 review
Message-ID: <2023083132-puzzle-vastly-b840@gregkh>
References: <20230824170617.074557800@linuxfoundation.org>
 <27d08b24-3581-4451-b8db-5df144784d6a@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27d08b24-3581-4451-b8db-5df144784d6a@roeck-us.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 09:44:33AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Thu, Aug 24, 2023 at 07:07:52PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.10.192 release.
> > There are 135 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat, 26 Aug 2023 17:05:50 +0000.
> > Anything received after that time might be too late.
> > 
> [ ... ]
> 
> > Lang Yu <Lang.Yu@amd.com>
> >     drm/amdgpu: install stub fence into potential unused fence pointers
> > 
> 
> This patch is causing continuous log spam in chromeos-5.10, so we are
> going to revert it.
> 
> WARNING: CPU: 1 PID: 13383 at include/linux/dma-fence.h:478 amdgpu_sync_keep_later+0x95/0xbd
> 
> This is just a note to let others know that this may be the cause
> if they see the same problem.

Thanks, I'll go revert it now.

greg k-h
