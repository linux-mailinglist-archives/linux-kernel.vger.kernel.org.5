Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4892F7E36F0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbjKGIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbjKGIxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:53:13 -0500
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40055106
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:53:10 -0800 (PST)
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
        by cmsmtp with ESMTPS
        id 043ErEKq3jtZ30Hpfrc2i5; Tue, 07 Nov 2023 08:53:11 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id 0Hpcrl3IrRqxC0HpcrzP1b; Tue, 07 Nov 2023 08:53:09 +0000
X-Authority-Analysis: v=2.4 cv=IY2U5Ema c=1 sm=1 tr=0 ts=6549faf5
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=q7c2SjLRtcTvZR/AkJ4bUasgUJ/2vDguBz4oEY9Bg5g=; b=IgAc+G9VgpHnTZUu/nvops3n82
        CvHVGbnMhQsd4xl42QSFqX5cYhoHVEL03EQxq+v/FjjxmX3DgpEVU/DaMoOznuqvp8iup4osF3pjz
        q1hUdIjLMfUGRO5WwSS/f05fjwLWvN8sAeQkrfFpEIb4sF6mFcZ3F9gFg+vbstRt5UR2itTsKSSCP
        uZS/vP4MU6Ygx99TzFgHXSKw6aeZZ0oO2rrb9bM6SM9re0J8MZ4cTY5LC/lv9rtOY9mQoNVQ4zds5
        21F4uBwzpSg4LBpwChNtJUGD0O6lMV3MXojLXMPgKRdkyQhg9JOAolIoQgAJNfzLx9VtJ8s+4X46r
        0kXLyrEQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:54214 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <re@w6rz.net>)
        id 1r0Hpa-0006wZ-2c;
        Tue, 07 Nov 2023 01:53:06 -0700
Subject: Re: [PATCH 6.5 00/88] 6.5.11-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231106130305.772449722@linuxfoundation.org>
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <899472bb-300e-b976-7942-39457ab13476@w6rz.net>
Date:   Tue, 7 Nov 2023 00:53:04 -0800
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
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1r0Hpa-0006wZ-2c
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:54214
X-Source-Auth: re@w6rz.net
X-Email-Count: 21
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKQDawCMQQ2NKYijw5DmLL+GV1zn7yPwKBbpWx/3uuafbi1MxlIYn0obuHr0aMkUhCO9LZZRkkI6D1100UyFcP1AjMQ4RrMiih8NwNatA7JNKtmutQQj
 KIrp9qFbhe5ET4Uj6AQYYbzBM0VoeNpM+xajJP8BXARervm0QJtwrXtPP/x72ypiv1hxSGQXKSSzFXJGayemAU06xbfmO896bcA=
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 5:02 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.11 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

