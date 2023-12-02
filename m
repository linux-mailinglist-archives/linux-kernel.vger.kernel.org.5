Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157E2801AE5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 06:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjLBFXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 00:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjLBFXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 00:23:21 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5901CB3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 21:23:27 -0800 (PST)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTPS
        id 9HrFrYmaQL9Ag9ITOrPgL5; Sat, 02 Dec 2023 05:23:26 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id 9ITOrrAN1qmEo9ITOrp3Pl; Sat, 02 Dec 2023 05:23:26 +0000
X-Authority-Analysis: v=2.4 cv=P+8pOwMu c=1 sm=1 tr=0 ts=656abf4e
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=66dHH0Aa/TXdF6eX4w5pztqa/xzpy8RC6fG36AqQYaM=; b=eGQtZXx+UmTmNZuq0AGBmLRvm+
        U+XQvezpBdCGnpYeUmyfW9PTtyrxIYKi/ilU+9uhGuiejJ6pPcKc2Y9hfZh+YbcM0auT5tn2qvTa3
        oQOi5a826VT1G5NFEdmfJWvba/1MoxCtS7jd9sGX3NcYm2p0jlNmXZGCTKHdxZq7Cm6ghnXdCsJs6
        xK2vlWyezZ3JwoXH55JpGsFpSotPTVSY+MGlrw40fwAFZ45nxjNlZ6LysdKgSehnAKOjbxb1J/0bD
        9xbndG0HJGq3UaLVAS6fx8Co4M5+HisMFgnbohchLmmeqWFppYklq5zgZRbuyIGbEVymFQIOkMyqF
        X0cpdl0w==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:58010 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <re@w6rz.net>)
        id 1r9ITM-001INp-0R;
        Fri, 01 Dec 2023 22:23:24 -0700
Subject: Re: [PATCH 5.15 00/68] 5.15.141-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
References: <20231201082345.123842367@linuxfoundation.org>
In-Reply-To: <20231201082345.123842367@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <f9eeab96-9d8a-bdf6-b995-f9ef87893e3c@w6rz.net>
Date:   Fri, 1 Dec 2023 21:23:21 -0800
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
X-Exim-ID: 1r9ITM-001INp-0R
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:58010
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfL4eEMnMFnv4L4qfjqm1GWxg1Hw0Gmz3eoWW5N5HDsVWfPWsvsQb5NQA13LID6fZ/0BnmVb5pCCusFRmX8IFcLQVleQ1fS7bGL8Cq3mJa+8x48B3K8pY
 /F0F5C8V6yjGr2kD02RS4KYoDfJZbJqSs4+Iwim04UiwsDJYpf4uybhvqV5bpnwYAM5XRnS+MWnuepRGAA9DBh+0zzySCPCdPVk=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 12:25 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.141 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 03 Dec 2023 08:23:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.141-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

