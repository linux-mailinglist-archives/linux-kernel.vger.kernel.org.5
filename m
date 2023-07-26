Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D680176326B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjGZJge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbjGZJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:36:01 -0400
Received: from qproxy3-pub.mail.unifiedlayer.com (qproxy3-pub.mail.unifiedlayer.com [67.222.38.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3769226B9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:34:37 -0700 (PDT)
Received: from outbound-ss-820.bluehost.com (outbound-ss-820.bluehost.com [69.89.24.241])
        by qproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 7CB548027B0A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:34:36 +0000 (UTC)
Received: from cmgw13.mail.unifiedlayer.com (unknown [10.0.90.128])
        by progateway2.mail.pro1.eigbox.com (Postfix) with ESMTP id 92B9B100424EF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:34:12 +0000 (UTC)
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTP
        id OauKqYizXsBigOauKqtV0l; Wed, 26 Jul 2023 09:34:12 +0000
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.4 cv=DqGTREz+ c=1 sm=1 tr=0 ts=64c0e894
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10:nop_charset_1 a=ws7JD89P4LkA:10:nop_rcvd_month_year
 a=-Ou01B_BuAIA:10:endurance_base64_authed_username_1 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=mdOrbuIhtOySShl96DIA:9 a=QEXdDO2ut3YA:10:nop_charset_2
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mvJxg9KtoG9FU7GEcaCMIUGRt36Z4dn/RSA4AVzo0GE=; b=GLu3CpLhVJ3ecL/a5PhT+bI4rr
        7Rw9ykrEmkznubb5dmkeyapbyUkQabj28jXjR4eeT/2oSEUNFw1QfRMPyOo6EAT1ZA6lyZUcZNqil
        SGm0bm8aaVRynz58S4YLTOuKl4Gd8t3O8lc9xFQpBzWZ0Ofv7jVPD+YP6QTSFH0TuZE6cudDMMpPw
        UIA1+FToBSyQC7mqmAIEVNZy1rw0R+ia7VEMbNgRvGhDe2zoIsvH/gRZwyHy0pgiZaXtb1Ar5t5U2
        f7MNuNrQ57OvrMCj8wmrMOfELe/LPXE2vmrufAIY+s5WCxrnIBAAYzN/icZrHwlp6aK1zh0h8IEmF
        mfu+I6Ng==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:49430 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qOauJ-002kDR-2b;
        Wed, 26 Jul 2023 03:34:11 -0600
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230725104514.821564989@linuxfoundation.org>
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <f07401db-ae8a-9a2f-c6bf-82615462e6d4@w6rz.net>
Date:   Wed, 26 Jul 2023 02:34:09 -0700
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
X-Exim-ID: 1qOauJ-002kDR-2b
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:49430
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/23 3:42 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.7 release.
> There are 227 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

