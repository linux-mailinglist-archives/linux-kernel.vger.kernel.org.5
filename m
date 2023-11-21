Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36387F3A34
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjKUXTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjKUXTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:19:47 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDBCD5D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:19:43 -0800 (PST)
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
        by cmsmtp with ESMTPS
        id 5V2arc9x1L9Ag5a1vrppoz; Tue, 21 Nov 2023 23:19:43 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 5a1trE3Wt97pz5a1ur47Th; Tue, 21 Nov 2023 23:19:42 +0000
X-Authority-Analysis: v=2.4 cv=ULDOoQTy c=1 sm=1 tr=0 ts=655d3b0e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=pVh-v41mxNHzIYEOPEMA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lDvRMk22BIWU3sgPfy8qmzMfyKnlWxCtumFka5E6NCg=; b=Mc9Q8Zu6bJ5ik2N0m+s4wfPtTA
        AWi9u0xmalpHRskVu6RrscCkEqRxsgyabJ3IG4/8u8flsb3K+OsqGMZqOkvTabudyyy2o59zZqn/K
        Ua4CSN7kaIsnJEHlDMm/jsEcLA0nq9xpxZOMxO2uAOQkF0+WJiHwe1NsfvkVkvE8ptFgLhoCYUeqj
        x5Xt3j2t6DgqL/141AzfzuOREHabIR9rygCWaV9Rh3lxoGklzKCRdYmCTO5/HFVDmmJCzV+4Xn6f2
        5gcUpScBfO0i14crR5AFXYVcm7W3z8OQBz3BnjEHBNXZsmnPlDYhBBcJg9sX1q8vBAhg9RWiSX2lu
        ybXCGIkQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:40180 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r5a1t-0006IF-1l;
        Tue, 21 Nov 2023 17:19:41 -0600
Message-ID: <e178b9aa-f766-4c3f-820a-ce02cc98830f@embeddedor.com>
Date:   Tue, 21 Nov 2023 17:19:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the kspp-gustavo tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231122095009.294994e0@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231122095009.294994e0@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1r5a1t-0006IF-1l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:40180
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLWIkSskT44BcFOJZ15fD1szlHcYpPGJyBAownmzcPqluJxFvrW5tzv9PibYhItKuuz6DIaonGyx3t1D/53got8TmIZ3ZhizDRt47Xfd35yFy6J2g8BV
 +Y0svrPfh4z1DygV+B7dMstWPWYPR+RxhqZ9+dd5jt+wKkVQYCGHXHsWiKoc+JA8O0H+d9ODk/vTLDGZVgarG/+Xq3i0TJz2yuJHoRTT+qtgU2MwK9RLzyZw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/21/23 16:50, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp-gustavo tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> In function 'aspeed_create_fan_tach_channel',
>      inlined from 'aspeed_create_fan' at drivers/hwmon/aspeed-pwm-tacho.c:877:2,
>      inlined from 'aspeed_pwm_tacho_probe' at drivers/hwmon/aspeed-pwm-tacho.c:936:9:
> drivers/hwmon/aspeed-pwm-tacho.c:751:49: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>    751 |                 priv->fan_tach_ch_source[index] = pwm_source;
>        |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~
> drivers/hwmon/aspeed-pwm-tacho.c: In function 'aspeed_pwm_tacho_probe':
> drivers/hwmon/aspeed-pwm-tacho.c:193:12: note: at offset [48, 255] into destination object 'fan_tach_ch_source' of size 16
>    193 |         u8 fan_tach_ch_source[16];
>        |            ^~~~~~~~~~~~~~~~~~
> 
> Exposed by commit
> 
>    1b56c90018f0 ("Makefile: Enable -Wstringop-overflow globally")
> 
> This is with your tree on top of Linus' tree (and some fix patches but
> nothing that obviously touches anything relevent) and CONFIG_WERROR
> not set.
> 

Hi Stephen,

The fix for this issue is also in linux-next already:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=72cfe7a99c9ea1e64fc532f4f05c99991858dc34

Thanks!
--
Gustavo
