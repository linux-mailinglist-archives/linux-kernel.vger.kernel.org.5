Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC4A76C85F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjHBIcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjHBIcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:32:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF32171B;
        Wed,  2 Aug 2023 01:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B589461890;
        Wed,  2 Aug 2023 08:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A8FC433C9;
        Wed,  2 Aug 2023 08:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690965138;
        bh=WCYaS7WaNcg3pjGQ1y5KfJ2f08APy0pqC/hoQFKvh9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FviH/yt2U1vWUE6LFvpQgWeIe8Wug2QurDoKIat1aeRLlclKM+q6B8SlFgppeacGQ
         zP5YCQOtSG93RA+FK6zmokU3/UqdfC57uu1JgwF8HelIu9eBp9UabWtoLjezJYbGCI
         SXdgL0zo0o4jwHF6UNbNRF/e7ngOwmXcYU5nIPEM=
Date:   Wed, 2 Aug 2023 10:32:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 6.1 000/228] 6.1.43-rc1 review
Message-ID: <2023080200-expediter-dingo-8fd0@gregkh>
References: <20230801091922.799813980@linuxfoundation.org>
 <CA+G9fYsqEE6P8vKKvWgFDjpgT64FebUssPNS48n6qfUriu6Z1w@mail.gmail.com>
 <20230802082226.ok23iygasc3byc35@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802082226.ok23iygasc3byc35@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 10:22:26AM +0200, Uwe Kleine-König wrote:
> On Wed, Aug 02, 2023 at 07:24:23AM +0530, Naresh Kamboju wrote:
> > On Tue, 1 Aug 2023 at 15:00, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 6.1.43 release.
> > > There are 228 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Thu, 03 Aug 2023 09:18:38 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.43-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > Following patch caused build regression on stable-rc 6.1 and 5.15,
> 
> Looking at 6.1.x, cherry-picking
> 88da4e8113110d5f4ebdd2f8cd0899e300cd1954 can be done without conflicts
> and fixes this regression.

Already done and in -rc2!

thanks,

greg k-h
