Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62AD47FB233
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 07:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343680AbjK1G5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 01:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbjK1G5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 01:57:03 -0500
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB474E1;
        Mon, 27 Nov 2023 22:57:07 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 0C074C021; Tue, 28 Nov 2023 07:57:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701154626; bh=YtDBcs5dtkWgUo26OHvbwJYV3lr3fRfrqBl2F/PC0/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMI2dGkFHgLFWjaUMf8uaer8VNpkdTIowJXf3uGh/i2zw4/Z9slr9TuUDp+gwZnh6
         XznizYjUTLDH/grrsJDs3utkoRLn/+1iSkKvRS6DI2nAnehJpmamuOFmvJRE/Z73hW
         A6szscKoE4i2mxgvt7Qv3y+t1RmhEcdz+/f6vrtHyrFFBBMbT9dEF/mkX+8xPDToWx
         KA95zOFf0Yliyx4XG2vq+nh3Fwisks+MXR9AG7KwCt76yOzVGy0qR/PICb+mH81VD3
         NdI3SV5RXLCA4jkj9dSIGB4rIHfGSlU0Dwa0aiBzv5ERzRKMnuceBI9VR4SOsOwx1g
         GeIFYl+BiUAKQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id CFDF1C009;
        Tue, 28 Nov 2023 07:56:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1701154624; bh=YtDBcs5dtkWgUo26OHvbwJYV3lr3fRfrqBl2F/PC0/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o6M7FxIIUe/jHiaWMxCnhFBOBhiWkFKS13urGaHJY202myA+AiZfWsA84MzfC3UBU
         B0ep5VRlXqTamW/NXFg0I7n8AztHaMrJKkD/j7j3fVCz7OzXI+StfcL4mlG7VpF1Jy
         39mYKBfn3hOQDgQWxApyIO864BuEfyGC4Hj6UXOq7Xk+cqhi4C55IJIQar/5zV0yvQ
         UmfEteoXpiirASUwimbGRaDQpGvq0yGZW4Pv+n/IcDZj28J3p3gkFd6yrpkU/HvFR2
         CCYaSJyWVcUog+sRuXl7R4DsHJHR6GsyI7VIJlnJe2TwLEZjlC3Bw/ht25n3tqaOKI
         D3b0xAxQGxinw==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 7fc12b28;
        Tue, 28 Nov 2023 06:56:53 +0000 (UTC)
Date:   Tue, 28 Nov 2023 15:56:38 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Pavel Machek <pavel@denx.de>, youwan Wang <wangyouwan@126.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, allen.lkml@gmail.com, maz@kernel.org,
        andy.shevchenko@gmail.com, brgl@bgdev.pl, wangyouwan@126.com,
        jani.nikula@intel.com, rf@opensource.cirrus.com,
        ilpo.jarvinen@linux.intel.com, dan.carpenter@linaro.org
Subject: Re: [PATCH 5.10 000/187] 5.10.202-rc3 review
Message-ID: <ZWWPJtXZ12WuTtd1@codewreck.org>
References: <20231126154335.643804657@linuxfoundation.org>
 <ZWUJWhOkbHlwC2YB@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZWUJWhOkbHlwC2YB@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote on Mon, Nov 27, 2023 at 10:25:46PM +0100:
> > Marc Zyngier <maz@kernel.org>
> >     gpio: Don't fiddle with irqchips marked as immutable
>
> This is attempt to move people to new API, which will cause warning
> for existing users. "chip_warn(gc, "not an immutable chip, please
> consider fixing it!\n");". It is marked as dependency of another
> patch, but I'm not sure we should be doing this in stable.

And this actually did make some tests fail on tegra (other branch on
this thread), it's probably safer to drop the gpio patches unless we're
prepared to backport all the "make immutable" patches as well.

(I don't see why it'd be required for dc3115e6c5d9 either but I didn't
look all that close)


> > youwan Wang <wangyouwan@126.com>
> >     Bluetooth: btusb: Add date->evt_skb is NULL check
> 
> Could someone double check this? If we hit the null check, we'll be
> returning success, but it sounds like an error case.

I agree with your analysis; added Youwan and Luiz in recipients.

btusb_mtk_hci_wmt_sync will return 0 if the skb is null here -- should
this be setting err = -EINVAL or something?

> > Jani Nikula <jani.nikula@intel.com>
> >     drm/msm/dp: skip validity check for DP CTS EDID checksum
> 
> This is preparation for future cleanup, do we need it?

(For cleanup patches I'd say if it makes future backports easier it
doesn't hurt to take them)

-- 
Dominique Martinet | Asmadeus
