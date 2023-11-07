Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DAC7E49C3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjKGUW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbjKGUWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:22:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5DC10F0;
        Tue,  7 Nov 2023 12:21:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E5DC433C7;
        Tue,  7 Nov 2023 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699388496;
        bh=0ZrrlUoDaDnYyIbMCJ+OpPT6t/CuFoTIItvkmvLiM0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dNrpqd1p31hy95o3OLzLLZalzfvoirNfdbgMYo/3TCxQ6z2+IIx6YjixetYBq2eYT
         KABA0Fe9sXU2J3xNWOC45HvNvzX1Px9ce8/y4yIip56e4BLY472avZ8qtsYrIrqloA
         hIMSZK0ytpkh5HN9DcDLBW9u6w5GN7fJ/WCBD+oU=
Date:   Tue, 7 Nov 2023 21:21:33 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        mizhang@google.com, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
Message-ID: <2023110717-saddlebag-reflected-ed93@gregkh>
References: <20231106130309.112650042@linuxfoundation.org>
 <2665d8bc-111c-45ca-a473-b1c892867e9c@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2665d8bc-111c-45ca-a473-b1c892867e9c@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 08:24:43PM +0530, Harshit Mogalapalli wrote:
> Hello Greg,
> 
> On 06/11/23 6:32 pm, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.138 release.
> > There are 128 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> > Anything received after that time might be too late.
> > 
> 
> I am seeing a build failure with perf:
> 
> tools/perf/util/evlist.c: In function evlist__add_aux_dummy:
> tools/perf/util/evlist.c:266:31: error: implicit declaration of function
> evlist__dummy_event; did you mean evlist__add_sb_eventâ€™?
> [-Werror=implicit-function-declaration]
>   266 |         struct evsel *evsel = evlist__dummy_event(evlist);
>       |                               ^~~~~~~~~~~~~~~~~~~
>       |                               evlist__add_sb_event
> 
> 
> I think we should drop these three commits:
> 
> 20a5799cae7dc perf evlist: Avoid frequency mode for the dummy event
> 7de783c81c7e7 perf tools: Get rid of evlist__add_on_all_cpus()
> 141ce9207068e perf evlist: Add evlist__add_dummy_on_all_cpus()

Thanks, I've dropped all of these from 5.15.y and 5.10.y now.

greg k-h
