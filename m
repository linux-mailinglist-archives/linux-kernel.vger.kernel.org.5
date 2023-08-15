Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD1077C473
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjHOAbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbjHOAap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:30:45 -0400
Received: from qproxy2-pub.mail.unifiedlayer.com (qproxy2-pub.mail.unifiedlayer.com [69.89.16.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40F81715
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:30:44 -0700 (PDT)
Received: from gproxy2-pub.mail.unifiedlayer.com (gproxy2-pub.mail.unifiedlayer.com [69.89.18.3])
        by qproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 77DE08026EF2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:30:44 +0000 (UTC)
Received: from cmgw13.mail.unifiedlayer.com (unknown [10.0.90.128])
        by progateway4.mail.pro1.eigbox.com (Postfix) with ESMTP id 2FCF41004807E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:30:44 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id VhxMqTsfIsBigVhxMqlrvk; Tue, 15 Aug 2023 00:30:44 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=OdNdsjfY c=1 sm=1 tr=0 ts=64dac734
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10:nop_charset_1 a=UttIx32zK-AA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Mq17y5sD9Z9vYHrZ7xm7qLvRo02ff1Q/ZpijYugkHw0=; b=nW/Yrd7AOntDbMgYDPON9lttGd
        G3Xqwg6NHhNgTSSKIKci1Iiz796Gblru4q/5dCFsSHkXy0xC1E2rkGMJIvJCYxtuD0A04bY6Td8hn
        /2eO3WOtLRJAsj6sGlYeTHUKDbu+7wilOudI/mjWddTew8kxBxiLP3cUn0amPz46mTxcschHOCA2j
        tsziJmw+92Bs8LLVxW+6xdwU42xzSe0P76fidz6OS7TETY4T9Sj3/+/H5RU46t+RkRY63UCLREck1
        6q2VOq3jIGCJCk5l+TW2TSLfc0eNCw4/EMArQE9J6vN5XTJN4bYhDK7hCwB9yc3f25xI9nU/7gCu3
        +jSL8Gmw==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:51858 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qVhxL-003gbL-1L;
        Mon, 14 Aug 2023 18:30:43 -0600
Subject: Re: [PATCH 6.1 000/149] 6.1.46-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230813211718.757428827@linuxfoundation.org>
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <6e696499-52d1-1f18-516a-3939f68f7e24@w6rz.net>
Date:   Mon, 14 Aug 2023 17:30:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.232.9
X-Source-L: No
X-Exim-ID: 1qVhxL-003gbL-1L
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:51858
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/23 2:17 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.46 release.
> There are 149 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 15 Aug 2023 21:16:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.46-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

