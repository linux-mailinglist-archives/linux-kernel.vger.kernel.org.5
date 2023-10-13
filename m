Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A787C866A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjJMNLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjJMNK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:10:59 -0400
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C80C9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:10:56 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
        by cmsmtp with ESMTP
        id rHUKq2879nGhUrHwKqHRWL; Fri, 13 Oct 2023 13:10:53 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id rHwJq8DyK1WadrHwKqoxR8; Fri, 13 Oct 2023 13:10:52 +0000
X-Authority-Analysis: v=2.4 cv=HfkH8wI8 c=1 sm=1 tr=0 ts=652941dc
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=L_lNUz4cS6dBDhu22GsA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=26qb5+16SeqCOLG+XYpxPGqDdJwEjhpXWD85WcaRcp8=; b=edCI2YzbzDFU8UYDykJeeTZam+
        SJdNSNMp6UbYsYJVgp90AVtopxvMSK0jPJYvvdMNH8resIWEcNOb2yXwQA3MLz3btI1L/xhpFGfK0
        n5/6LJwC/7xYNvFw1vUq5up6/qKI5wUsdtN31zrEMiCeCvLBqCq9PdeDtBh5K2K10tChBst6aVeXy
        87KBOIIj/gfZDiExTQm8eyj0cd7+NkMFZgZ5o9OVLS7xINTIvsHyLNN/Nodo2IL99KGtpmKsqAm3V
        nC2f3W/rSWK16MIUerfYF5A8ogjUhMUrWvCi4WFmR6Vw8vlB/9dUvklfWhhlPOMgl24Yz7OdXtXtg
        M5p+4Suw==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:51188 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <re@w6rz.net>)
        id 1qrHwH-003zqf-1m;
        Fri, 13 Oct 2023 07:10:49 -0600
Subject: Re: [PATCH 6.1 0/6] 6.1.58-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231012180030.112560642@linuxfoundation.org>
In-Reply-To: <20231012180030.112560642@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <861ad70b-dabd-3e52-bce3-6c09bc949f2e@w6rz.net>
Date:   Fri, 13 Oct 2023 06:10:47 -0700
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
X-Exim-ID: 1qrHwH-003zqf-1m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:51188
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfBQODfOSkT/WPPaKyr1FFdAfUvjrBPYKP0id+ZWq6PndZl4Wj5Mv1oBlvgLDcRrSRV0b4BK21E0zgEFC6hNTqhrIzvIBWWyO9RFEWk+BvWhE8BS7PiCN
 0RyYv+3eGk2hieWw1rQ/CokaaYf8K+bCuw9COWONumAOBXTeb1DMSpqWpHOcVd+OtwyTIKQxLMEDkG0BQJXmNpJqq70NdBiGUXY=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/23 11:00 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.58 release.
> There are 6 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 14 Oct 2023 18:00:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.58-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

