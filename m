Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604E77F91DD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 09:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjKZInD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 03:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjKZInB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 03:43:01 -0500
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBCBFD
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 00:43:06 -0800 (PST)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTPS
        id 79GcrtjZx8Hte7AjKr4EMg; Sun, 26 Nov 2023 08:43:06 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id 7AjJrg8vlGKIc7AjJrCB16; Sun, 26 Nov 2023 08:43:05 +0000
X-Authority-Analysis: v=2.4 cv=E+beGIRl c=1 sm=1 tr=0 ts=65630519
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=2zxgpyc-tqoJWZ86AioA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OcCAqEYCF7/UDtZ4/EjgDtUMzPOc306OgNIIspnUHq8=; b=3rkpuWOmHxPzexFDxr1TqyEq6N
        3XEiDfUGCyiOn+NQYUhOAngpk5/wE3Y9rLLAibOZbIighRBySaVTU3mAdmy29BYXGTunre1MSbjnv
        tK6DFhDhc9/9RUFH+Uh+kOQzs4tdrvzP0c+8EEY+0bRalLnN4LiJcnR5lNvPyA6+dhnJ7dZaQVEzn
        QR4GLKKA+hPItoilbiyggW9FpWGLItIP5JQfZeo0o/eW6OSPKo6ANzvPBh1arC+cb+essmYNtf+j8
        +U3r36bozdQrmecCAIShQ+MO+imSLwGoc0Ke9U0Gca5NVB/YSdjjc2NdBPeBV0iCBsu+4MVOxRwon
        RVWLkNAg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:56936 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <re@w6rz.net>)
        id 1r7AjG-000R8h-2f;
        Sun, 26 Nov 2023 01:43:02 -0700
Subject: Re: [PATCH 5.15 000/293] 5.15.140-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
References: <20231125163129.530624368@linuxfoundation.org>
In-Reply-To: <20231125163129.530624368@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <1309b931-9196-0a8d-941f-c6e1d7567753@w6rz.net>
Date:   Sun, 26 Nov 2023 00:43:00 -0800
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
X-Exim-ID: 1r7AjG-000R8h-2f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:56936
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN+OJNCIReugKxZKkMZeeDlaqW/ABL0/DD/OmquXvsetL08MRITunqxN8TocXkQy/nobQB3OYLc53Mw2hB3LSQXqZpdZ8g83I0zoD2axL30p/kyaP7sB
 v+TCoaVg1bP3nWlv2h1fFbVv2rGhq3BMpxU445PwpOp7QhiE3bGe0uhEaGxiGQ/nFmi0u11afIVgifE4Vh9Rm4gMTKb2jb4ixOQ=
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/23 8:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.140 release.
> There are 293 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.140-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

