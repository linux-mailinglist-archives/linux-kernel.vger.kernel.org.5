Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FC97FC5B6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 21:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346181AbjK1Unb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjK1UnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:43:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DDB19A7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 12:43:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B733DC433C8;
        Tue, 28 Nov 2023 20:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701204212;
        bh=uiG+18Gryl6FUbTMZaD5U12UgWJzL8HDhfWkQCuVBR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aC4px0VlHM1VN6OFGZDn3gaO3zVNex4SbUUCdbEPcUgt8f3HSs7SGGPqYxBrHh5iH
         ATbepWj6V8SPqX/ovoJ9llgbaLA0erwrrAErAlTii6NofMAxAtV+7yEwpgqxSnrlMU
         Oyh1FVN9aQCZ3oNIy9OrmMo9YlCtWmZXSe4TooDA=
Date:   Tue, 28 Nov 2023 20:43:29 +0000
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
Message-ID: <2023112818-browse-floss-eb6f@gregkh>
References: <20231125163059.878143365@linuxfoundation.org>
 <ZWUBaYipygLMkfjz@duo.ucw.cz>
 <f4a7634-3d34-af29-36ca-6f3439b4ce9@linux.intel.com>
 <ZWZQCJtD7kmX9iRO@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWZQCJtD7kmX9iRO@duo.ucw.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 09:39:36PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > This is the start of the stable review cycle for the 4.14.331 release.
> > > > There are 53 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > 
> > > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > >     RDMA/hfi1: Use FIELD_GET() to extract Link Width
> > > 
> > > This is a good cleanup, but not a bugfix.
> > > 
> > > > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > > >     atm: iphase: Do PCI error checks on own line
> > > 
> > > Just a cleanup, not sure why it was picked for stable.
> > 
> > Just an additional bit of information, there have been quite many cleanups 
> > from me which have recently gotten the stable notification for some 
> > mysterious reason. When I had tens of them in my inbox and for various 
> > kernel versions, I immediately stopped caring to stop it from happening.
> > 
> > AFAIK, I've not marked those for stable inclusion so I've no idea what
> > got them included.
> 
> Fixes tag can do it. Plus, "AUTOSEL" robot does it randomly, with no
> human oversight :-(.

the autosel bot has lots of oversight.
