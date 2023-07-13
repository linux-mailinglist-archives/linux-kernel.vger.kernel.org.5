Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54A3752BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 22:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjGMUd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 16:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233426AbjGMUd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 16:33:27 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757D02127
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:33:26 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-5634fbf0cf4so848300eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689280406; x=1691872406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q4LBnvQYMGaYAXdu1AoVu2cAixaHPevENTPqDGX8zmE=;
        b=3qkvShK5M5ZZTm1rRRNP7fxG4P21ZOQ44gVVdW+FARcOqArr9OYc8E9QjvKIg7ad+b
         wnljlOhMhHjdwTmXnXV6cwI14JwQG6O+goxOETiH4Lslcr2CiuH/uwwjYmeu3/XE2Bjs
         uZQZR79Sf7nXNLgXcLXMh2KrdEjguSI2hY7N+Z58pMoMWLV2qVwkLkzy1oV1arx3C2m6
         1C/HlwoxiZrPCDUO3VKqts5vGocGOVKMFxFmfDP4DrhwgUDL0s5HKd+aI3g7uh3VKBCS
         RCNXv+cAXcBR5AuTaQOd7VOkjhYMLRzl6URr7RBaDOFk+bRo//BBJgDoP8FNqddt59mJ
         3Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689280406; x=1691872406;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q4LBnvQYMGaYAXdu1AoVu2cAixaHPevENTPqDGX8zmE=;
        b=lBYuVrlmzrPqrqxPU4vfmDB0OXJZXUxzgMu2IPxC9tiF1lRhp/MVuHMNvjvp+x1tjG
         zZzBERFPbh/wQOzNKV1io/R1fpoIjerFW6ZK6wwmj8M7z/iXG64Mpj0juLnVm/w2NRky
         izX1Mx8B/b3VINN22tZnW8x/9WhF9DL1Sv8otytGtgKVmT/lJWVWEX2987z2vNv6+JOd
         Eq+ETfUcprtUUw0qo872NdNFcQWTefm7weJPxputm4zR/qVFY0YjEwYJZNpDmX2PrZiz
         vC0RORxEp+T7z/Kk/tpVYrPtpPE9GcRFK6uuRDPU2Y55zMBw+QCAXUYU35ZSTGZy/nCP
         NuNQ==
X-Gm-Message-State: ABy/qLYDTFv+zFLYotpuVl/JfbdV+i2g2Jo9HcMALYdohjM7x94cpqjA
        1mr9QODqmiNjkgTCOqJZE9vc7vPPUjVscIPfuWBQTg==
X-Google-Smtp-Source: APBJJlGG4VuVwM+4L4wB4MX/WwSs+GeQBUdteNFfVVbOzd4v6pIevqoKMkhL/4Q92QB03MJq/O9PRA==
X-Received: by 2002:a05:6358:7e43:b0:134:e59a:2ffe with SMTP id p3-20020a0563587e4300b00134e59a2ffemr2922810rwm.11.1689280405544;
        Thu, 13 Jul 2023 13:33:25 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id s126-20020a0dd084000000b0057a918d6644sm1923706ywd.128.2023.07.13.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 13:33:24 -0700 (PDT)
Date:   Thu, 13 Jul 2023 16:33:24 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3] nbd: automatically load module on genl access
Message-ID: <20230713203324.GA338010@perftesting>
References: <20230713-b4-nbd-genl-v3-1-226cbddba04b@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713-b4-nbd-genl-v3-1-226cbddba04b@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 09:29:35PM +0200, Thomas Weiﬂschuh wrote:
> Add a module alias to nbd.ko that allows the generic netlink core to
> automatically load the module when netlink messages for nbd are
> received.
> 
> This frees the user from manually having to load the module before using
> nbd functionality via netlink.
> If the system policy allows it this can even be used to load the nbd
> module from containers which would otherwise not have access to the
> necessary module files to do a normal "modprobe nbd".
> 
> For example this avoids the following error when using nbd-client:
> 
> $ nbd-client localhost 10809 /dev/nbd0
> ...
> Error: Couldn't resolve the nbd netlink family, make sure the nbd module is loaded and your nbd driver supports the netlink interface.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Reviewed-by: Josef Bacik <josef@toxicpadna.com>

Thanks,

Josef
