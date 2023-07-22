Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0B1F75D9A3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 06:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjGVEVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 00:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjGVEVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 00:21:34 -0400
Received: from alt-proxy28.mail.unifiedlayer.com (alt-proxy28.mail.unifiedlayer.com [74.220.216.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7D33A97
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 21:21:33 -0700 (PDT)
Received: from cmgw10.mail.unifiedlayer.com (unknown [10.0.90.125])
        by progateway1.mail.pro1.eigbox.com (Postfix) with ESMTP id 1889610040619
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:21:31 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id N47Xq6aXU3S70N47XqH9UW; Sat, 22 Jul 2023 04:21:31 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=YL5adTKx c=1 sm=1 tr=0 ts=64bb594b
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10:nop_charset_1 a=ws7JD89P4LkA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=IZ7dRHLSemCk_RukjgUA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QWbqpQ6Fn6ywQfkMu5EeDNzi60wntTjUYgXZIODpI5Q=; b=Kd2NHMNVwYd2PoF8ioqHuTD9e3
        Pueu4jKDA88pEwvn83gmlMGg1lobYZlzy/wIm7vNf6qPkPa3DHt3KrxablsWqN+HERW2wcy5AsOMc
        EdB52o0LUbzEi32LYQxD2+PTshPvL9MZHyudZ61xFj/GAn1HU02qccWfgUuSBi+abjx5nWUmnl1kS
        Ll9mXJYy6I7wni1mIL3/V3v/g8VvJaqaFOG479K8PCJkkBqyFTcCG9gmDA8D/V6SufmrsU+G//ZOn
        fLMoJRxQVkJuBO7tWaezgc0axjzblVgNbT4wWmzdkXqzUTQoeOYpLUDw4B6bhNmjf2oyD4gNmFAaG
        vDNBBelQ==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:48864 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qN47V-003R96-20;
        Fri, 21 Jul 2023 22:21:29 -0600
Subject: Re: [PATCH 6.4 000/292] 6.4.5-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230721160528.800311148@linuxfoundation.org>
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <23901c5c-fcfe-ad8a-1dc6-9218c6e2a179@w6rz.net>
Date:   Fri, 21 Jul 2023 21:21:26 -0700
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
X-Exim-ID: 1qN47V-003R96-20
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:48864
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 9:01 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.5 release.
> There are 292 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 23 Jul 2023 16:04:29 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

