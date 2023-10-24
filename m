Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1264F7D4A1E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjJXIcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbjJXIb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:31:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF51F120;
        Tue, 24 Oct 2023 01:31:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D290AC433C8;
        Tue, 24 Oct 2023 08:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698136317;
        bh=BYQEbgrs6X61ixSYGvdHAsL1b7y8U2m7ZhKq7Y4SGFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZclkhsmNsPql+3TnbKv3S9YL0/90JmCDTmuUBbfu9KU11Balc4EBEbMBO13/cewqR
         yG9vukpc5PoknNU9WWCuktsBCa4TbzfYzjGFegxJMrooam7euifBvrUtuetHrY7niH
         cipNa+8ZAxXGnyF3Ub8bpPxiK+uMJ8LDtEz1iQCU=
Date:   Tue, 24 Oct 2023 10:31:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 5.10 000/202] 5.10.199-rc1 review
Message-ID: <2023102443-woozy-spud-171a@gregkh>
References: <20231023104826.569169691@linuxfoundation.org>
 <ZTd3TZ7oZH7nxKfY@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTd3TZ7oZH7nxKfY@codewreck.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 04:50:37PM +0900, Dominique Martinet wrote:
> Greg Kroah-Hartman wrote on Mon, Oct 23, 2023 at 12:55:07PM +0200:
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.199-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> > and the diffstat can be found below.
> 
> Not much point in adding to the IRQCHIP_IMMUTABLE errors reports; I went
> ahead and reverted these two commits:
> da4ad7dba3a1 ("gpio: vf610: mask the gpio irq in system suspend and support wakeup")
> 90225415cad6 ("gpio: vf610: make irq_chip immutable")

Thanks, I'm dropping them now as well.

greg k-h
