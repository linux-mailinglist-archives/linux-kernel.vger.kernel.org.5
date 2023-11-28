Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BF67FC893
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344927AbjK1VQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376632AbjK1VOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:14:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB6D213F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:10:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8ADC4166B;
        Tue, 28 Nov 2023 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701205805;
        bh=Tk8vqq2f+B+POOBODD8vnVMKQofy9qJFCjtMT7FlNR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iKqTfH/0fZ7PC6Ri15G7qxwxShqEPIZQDuTVp/GlILYShPIZniktNnsy3bTCem8by
         5u6sGPvGGlHbQJqrPSW36t9Wzmi1+fwKCxe3eeG9m+baqy6bQUW2HCYAFd8uUAINDK
         KSJ9Kewp9jr5eeDbVzVkZJ1swj9On/D5TeLbLbrg=
Date:   Tue, 28 Nov 2023 21:10:03 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com, alexander.deucher@amd.com,
        mario.limonciello@amd.com, zhujun2@cmss.chinamobile.com,
        sashal@kernel.org, skhan@linuxfoundation.org, bhelgaas@google.com
Subject: Re: [PATCH 4.14 00/53] 4.14.331-rc2 review
Message-ID: <2023112844-sesame-overdrawn-5853@gregkh>
References: <20231125163059.878143365@linuxfoundation.org>
 <ZWUBaYipygLMkfjz@duo.ucw.cz>
 <f4a7634-3d34-af29-36ca-6f3439b4ce9@linux.intel.com>
 <ZWZQCJtD7kmX9iRO@duo.ucw.cz>
 <2023112818-browse-floss-eb6f@gregkh>
 <ZWZSKgxjSRcA/qUK@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWZSKgxjSRcA/qUK@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:48:42PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > >     RDMA/hfi1: Use FIELD_GET() to extract Link Width
> > > > > 
> > > > > This is a good cleanup, but not a bugfix.
> > > > > 
> > > > > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > > > >     atm: iphase: Do PCI error checks on own line
> > > > > 
> > > > > Just a cleanup, not sure why it was picked for stable.
> > > > 
> > > > Just an additional bit of information, there have been quite many cleanups 
> > > > from me which have recently gotten the stable notification for some 
> > > > mysterious reason. When I had tens of them in my inbox and for various 
> > > > kernel versions, I immediately stopped caring to stop it from happening.
> > > > 
> > > > AFAIK, I've not marked those for stable inclusion so I've no idea what
> > > > got them included.
> > > 
> > > Fixes tag can do it. Plus, "AUTOSEL" robot does it randomly, with no
> > > human oversight :-(.
> > 
> > the autosel bot has lots of oversight.
> 
> Can you describe how that oversight works?

There have been many papers and presentations about it, no need for me
to say it all here again...
