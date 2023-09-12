Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D13379D1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjILNFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbjILNF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:05:26 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1DF1735
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:03:54 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id fnYQqe02FDKaKg33ZqjMfb; Tue, 12 Sep 2023 13:03:53 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id g33Yq0AWt7Hing33YqFMo9; Tue, 12 Sep 2023 13:03:52 +0000
X-Authority-Analysis: v=2.4 cv=Lq+Bd1Rc c=1 sm=1 tr=0 ts=650061b8
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=k6frhbBqBDcGtiXH-40A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=UqBx1R2wMm2RoGj/B6RNErCyrGurYSfQwxpjM8HqpfI=; b=kY0ZgdeRKJlbmY61MapYx7sK5V
        3VC5OrYIzoG8p3qIAXsJUvd5dRdffDB3Pcr57Fu4UU4aDjT0fELm0ZP05ELWoGbXsUvJiw1Un3fYd
        1MGiuvZQJn1ivKPgK/euJjg0VJU1MQRu+CMWuH/CHTnShYqyYEVcrYkqdWR74rfdQwI+Ipqw5wdl4
        1XZHbiBLfuMmhnixbL4a5NW+hgJo5hm6TJinfYFSraZdDE4krOkyopbzBHf/CzlLVrwKT3nBg4fkr
        xykmZ1iYBkQQiYqfGNNhOp3ona7nOkT8Wfa4CC7QcfYsfbl02LZ3cp7AFGzdmxb2lwx/ycK0NLbAq
        6aixQlmg==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:55088 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qg33W-0042LH-1C;
        Tue, 12 Sep 2023 07:03:50 -0600
Subject: Re: [PATCH 6.5 000/739] 6.5.3-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230911134650.921299741@linuxfoundation.org>
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <0ed9f952-3d7b-929d-5347-c185c64fa495@w6rz.net>
Date:   Tue, 12 Sep 2023 06:03:48 -0700
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
X-Exim-ID: 1qg33W-0042LH-1C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:55088
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfN9HfWsduQZGSp0NeBKDgUUljQrix8MBBJ7gd2G5CVTvRnaatle6ipM4oihj2fNWahrICSLWi0CcEXsluIEs265sqHUnllB0DJ1uBIRaJZRp+HwmeskF
 QjRQWcbsy+wta0yVE6yBoLwAhbf1bjGz5ioJD0z1tQ3QeWnOmdbrLp7Q0ffkgHajzMQHdTAchbYOoQsXWYwDXmINM+ENtg5b2Ls=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 6:36 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.3 release.
> There are 739 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

