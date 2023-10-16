Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98D7CAD1B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjJPPPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:15:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE2B4;
        Mon, 16 Oct 2023 08:15:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89704C433C8;
        Mon, 16 Oct 2023 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697469303;
        bh=Vkhf5sdZODzbnsmE4WvRLL3VUMVpLvun4OVrmHIx1GE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wRxXIecnusCrSL/De6Z97oBLS9lfxd/jy/eQ/8Q8GYRzk2dtbz7oeRbXQ23Rcbr0t
         yhDUNV3OdpCa8lbvMqeTrkZ6su5GAg1RmY8YNcP+2QDUmIqGiNUBCSgXXrgjxty+FC
         sQeb3vYZZNclJ8oAK8gQRTEFKz3/osfdx0EoCZMs=
Date:   Mon, 16 Oct 2023 17:14:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Message-ID: <2023101641-resource-scalding-3e1d@gregkh>
References: <20231016083953.689300946@linuxfoundation.org>
 <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 07:06:20PM +0530, Harshit Mogalapalli wrote:
> Hi Greg,
> 
> On 16/10/23 2:09 pm, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.15.136 release.
> > There are 102 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 18 Oct 2023 08:39:38 +0000.
> > Anything received after that time might be too late.
> > 
> 
> I am seeing a build failure while compiling tools/perf/
> 
> In file included from tests/genelf.c:14:
> tests/../util/genelf.h:5:10: fatal error: linux/math.h: No such file or
> directory
>  5 | #include <linux/math.h>
>  | ^~~~~~~~~~~~~~
> compilation terminated.
> 
> Patch 43 in this series is causing this.

What is patch 43?

> Why is this not reproducible upstream ?
> 
> Vegard bisected the commit which makes it not reproducible upstream and this
> commit is missing in 5.15.y:
> Commit: d6e6a27d960f ("tools: Fix math.h breakage")
> 
> Backport request for this was made here:
> https://lore.kernel.org/all/CAMVNhxS-6qNfxy8jHrY5EtZASTL9gAvZi=BdTkUA5_5CSQ2Cmg@mail.gmail.com/

And that commit is in this patch series, so are you sure that was
correct?

thanks,

greg k-h
