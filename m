Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF87AA4E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbjIUWZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbjIUWZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:25:25 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E9498A59;
        Thu, 21 Sep 2023 10:56:50 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id CE3F9C009; Thu, 21 Sep 2023 08:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1695276455; bh=NNAd8hBazUT7q+i5GrRpTZnyh8y+ObeLpTZ022LCAvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8QlnTKqjzuKx4FNalVbhKSvN9V6iQhsV7bOjGxCNHvqGRvhPTHc5EdkBkkw1M/SX
         +mSimrzKqJ1Vfdo3DzJkGe3Kzm1Uos68uUgs704Ma9C7zFh6tadu/qC3N7BzZPsuxD
         EewnDgloAiqLjFbXRaK7fArqa773jEZticuXj3R5qz64xGQY89uFOnZi2EX2eqJ8Gw
         LefZbDKJDHqRJITdO0WxRXUG+37F6X9EcqhW5hYaDYtWbnO/TAXBW9wL+fZkE9vM4A
         PxLAPSj28XnXHkpnbLo/BDJ6N2meuFZU+Ah3Hq7mdqE0RqWV5Aggfz1p1R6zP5Ol9M
         G1EshNcD++UBA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 40415C009;
        Thu, 21 Sep 2023 08:07:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1695276454; bh=NNAd8hBazUT7q+i5GrRpTZnyh8y+ObeLpTZ022LCAvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRzWF7WAwNHgM96SCbeWfJiEOGfOUbu1t0CSyzok5jwHqHAbXeTcySEaw3glOsC59
         6N9mYjUx1nPCiMhonJ1ooqccsxhYlYlGxSxd1MPQBYzcR1ItWlGphvxculERDu9vE5
         bVwfQNFeVsCn6hYbnMsSkTyaAf5nGm2con7iUGDQJ5HDfF56DBKdw/IOzoc6OXMGMG
         mihleLH2mbnna8r/KXxt+M/2RcHRtnwgTRx48rrXsBeIJxCm6bKpXI2NpC3A+YI6uO
         SqNt42p6j1fcMBdUBM+RcIw8SEvIFgaWMLmxv1bySGqHiWmfO9Ux0u0jEEc4OGEh5H
         dRqEsNGTNsLyA==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 73b27eeb;
        Thu, 21 Sep 2023 06:07:25 +0000 (UTC)
Date:   Thu, 21 Sep 2023 15:07:10 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Subject: Re: [PATCH 5.10 00/83] 5.10.196-rc1 review
Message-ID: <ZQvdjhnxlIAdXKuo@codewreck.org>
References: <20230920112826.634178162@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920112826.634178162@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman wrote on Wed, Sep 20, 2023 at 01:30:50PM +0200:
> This is the start of the stable review cycle for the 5.10.196 release.
> There are 83 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.196-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested on our armv7 and aarch64 boards (respectively Armadillo 640 and
Armadillo G4), no obvious regression:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

-- 
Dominique Martinet | Asmadeus
