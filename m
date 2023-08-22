Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B247841CF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbjHVNRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjHVNRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:17:46 -0400
X-Greylist: delayed 375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 06:17:41 PDT
Received: from postout2.mail.lrz.de (postout2.mail.lrz.de [IPv6:2001:4ca0:0:103::81bb:ff8a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1AA18B;
        Tue, 22 Aug 2023 06:17:41 -0700 (PDT)
Received: from lxmhs52.srv.lrz.de (localhost [127.0.0.1])
        by postout2.mail.lrz.de (Postfix) with ESMTP id 4RVV952pW7zyX2;
        Tue, 22 Aug 2023 15:11:21 +0200 (CEST)
Authentication-Results: postout.lrz.de (amavisd-new); dkim=pass (2048-bit key)
        reason="pass (just generated, assumed good)" header.d=tum.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tum.de; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received; s=tu-postout21; t=1692709880; bh=7
        MXBSA2oPcu+//EHHLMQozjXroTKi4+sBWXdNVXS71k=; b=LuuD/tm2rdPtMca1x
        wTO32C1Z3C9GMBu1lGwVBUmIO23Q5WaEQsQCY3fHPGbyxh6XF33OvTiYUDoahGvc
        5FXeYL4z9IhePrSHrqiO6cnFGAVLTSTxwcKydMKeCPzAtko1pGvNWJZu51O7PWYp
        94aT9sIgkGIaTtUzt/ylqmSBS3ZMBaD+s5R2voTxyhyWnk3dcSIh0zHnth01z+ei
        3nOsADb9eR4FHgh82BjOPxrsbiK4XORiDH3v4Gpj0QMUWzQUz4p5W5eY7JCCC7Jv
        vkC/b2ukIDnqzo+9d4gYP2edHff3PfGYCTbsYGCQ0px1NHUftLyQFaNY+l4FxYKi
        zVn+w==
X-Virus-Scanned: by amavisd-new at lrz.de in lxmhs52.srv.lrz.de
X-Spam-Score: -2.871
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from postout2.mail.lrz.de ([127.0.0.1])
        by lxmhs52.srv.lrz.de (lxmhs52.srv.lrz.de [127.0.0.1]) (amavisd-new, port 20024)
        with LMTP id DfRD1ZXrXZAS; Tue, 22 Aug 2023 15:11:20 +0200 (CEST)
Received: from r2-d2.localdomain (unknown [IPv6:2001:4ca0:0:f293:2e93:503c:b2ad:193b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by postout2.mail.lrz.de (Postfix) with ESMTPSA id 4RVV933VvKzyV6;
        Tue, 22 Aug 2023 15:11:19 +0200 (CEST)
Date:   Tue, 22 Aug 2023 15:11:18 +0200
From:   Andrei Rabusov <a.rabusov@tum.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Subject: Re: [PATCH 6.4 000/234] 6.4.12-rc1 review
Message-ID: <ZOSz9vvKd9FNHr_u@r2-d2.localdomain>
References: <20230821194128.754601642@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 09:39:23PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.12 release.
> There are 234 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 23 Aug 2023 19:40:45 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

6.4.12-rc1 configures, compiles, runs, and passes most of the tests with
my custom config for Lenovo Thinkpad X220 (x86_64). Here is a short log:

system-manufacturer               LENOVO
system-product-name              4291EM4
bios-release-date             06/21/2018
bios-version            8DET76WW (1.46 )
kernel                        6.4.12-rc1
selftest result                  570/652

Tested-by: Andrei Rabusov <andrei@rabusov.de>
