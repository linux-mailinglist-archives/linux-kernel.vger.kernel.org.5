Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD1C7CBC61
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbjJQHgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjJQHgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:36:04 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72596FB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:36:01 -0700 (PDT)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTPS
        id sWmiqn78jR4H2secSqgb1a; Tue, 17 Oct 2023 07:36:01 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id secRqmfbbEXBTsecSqBs5L; Tue, 17 Oct 2023 07:36:00 +0000
X-Authority-Analysis: v=2.4 cv=fo7P2X0f c=1 sm=1 tr=0 ts=652e3960
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=nVRhpLHY2Gk3QZ1Fk7gA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8bJZpA7ILEDgqxVq07v9VPVB3RYKGHWOhwh9REdQwgc=; b=4H3ahtNLgnYzG0B2NOK71FUQ7R
        7sQIAn830kHuDOBLCc/YRjImHEq1JmuKup7sOdrxWyVjA+MW9xYYFABh9bcNGa7LTde0YU0km1zzK
        l0KeIdHj674K0x7n34ouaA8qckj1gaFeZ+DCmLF+DmGdNN0uaKt2k2k0B5F4mWznu8nIqc5YsoQpC
        qqeMAmmhw0wFdBY1ydZF2U/KuKguMliWU2bUSpq9789LSQlSyFUec6vVsOulqpYHxZlXvt59mR6Oj
        CX6M/YigdhGSn98f5H2it+HRKp27O0RtgdAmoUCbcbu1VNrAU4fSfttza6H8DeI/lqXPLtxfHibj6
        7ijfjUNg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:51592 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <re@w6rz.net>)
        id 1qsecQ-001ZGF-0S;
        Tue, 17 Oct 2023 01:35:58 -0600
Subject: Re: [PATCH 6.1 000/131] 6.1.59-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231016084000.050926073@linuxfoundation.org>
In-Reply-To: <20231016084000.050926073@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <82ff6eff-81b2-4f65-7858-5d1e0a51bbbc@w6rz.net>
Date:   Tue, 17 Oct 2023 00:35:52 -0700
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
X-Exim-ID: 1qsecQ-001ZGF-0S
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:51592
X-Source-Auth: re@w6rz.net
X-Email-Count: 38
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGa2cLOtZdPv+5KXU8iQn/stP/pR5owyZ+/3s8K59HubZSWgmcpP0t2hktg6JGJSx0jCJQhMjW3yfjuNIW/ftdnNJE1MrxymfMn1SP2SZo0yt+NsU9Ja
 lhdVjbhdvIBBvJUyom8Zc+EYvNWpBrB2JStKcqH/wdiE3Rt1R6O1nTYVZh5nJX79dxoqPCTJbobncUooar+oQ9VxFqWYTCcBfXU=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/23 1:39 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.59 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 18 Oct 2023 08:39:40 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.59-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

