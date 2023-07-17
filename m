Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D8756213
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjGQLvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjGQLvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:51:21 -0400
Received: from qproxy2-pub.mail.unifiedlayer.com (qproxy2-pub.mail.unifiedlayer.com [69.89.16.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB897
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:51:19 -0700 (PDT)
Received: from outbound-ss-820.bluehost.com (outbound-ss-820.bluehost.com [69.89.24.241])
        by qproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id 6A46D8027FC2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:51:19 +0000 (UTC)
Received: from cmgw14.mail.unifiedlayer.com (unknown [10.0.90.129])
        by progateway2.mail.pro1.eigbox.com (Postfix) with ESMTP id 1728A10047B6B
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 11:51:19 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id LMl5qyZ9q9GkSLMl5qQyuN; Mon, 17 Jul 2023 11:51:19 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=FMree8ks c=1 sm=1 tr=0 ts=64b52b37
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10:nop_charset_1 a=ws7JD89P4LkA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=89RRq+ra4BlON9EVwqnKJekcTY/ywsBHb8kUotYEHaM=; b=M8rgweEsg4ZJuXQ/b37H8GxiN3
        Ouv+jfef+BirAmbKr4GYdUl+kEZbanHx5wOYVGHeIu441jgleJlaREZqJYrrXXOwHZRwssvKP7PDm
        8Me9y4doQkpG95sQrPTrK0vGB5BpPAySKHsYxGPyZYUYXBMIGzTrQWq8kZjESfYtocZ8FD0Xfc1NM
        relcFpcFn63sStz8nTmftBKFcFyFG0BQqEIq1XANQ/fBRQJmiW3Nj9A+zrh7ky0/Wb67IThgGi9Mz
        ES5En4yRlksb/FpOp+g4FZMFplSVV/UsuK488Biy13EpFwmRevvFVeC1p+bGIeD8kWnJHoQqJG8VA
        9c/Mb1yw==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:48204 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qLMl3-002GPL-2a;
        Mon, 17 Jul 2023 05:51:17 -0600
Subject: Re: [PATCH 6.4 000/800] 6.4.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230716194949.099592437@linuxfoundation.org>
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <7aad5565-2134-e050-927f-9f5a62dd05f6@w6rz.net>
Date:   Mon, 17 Jul 2023 04:51:15 -0700
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
X-Exim-ID: 1qLMl3-002GPL-2a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:48204
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/23 12:37 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.4 release.
> There are 800 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 18 Jul 2023 19:48:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

