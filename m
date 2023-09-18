Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5277A494A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241780AbjIRMJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241996AbjIRMJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:09:08 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED46E8E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:09:02 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id i6phqUDbNEoVsiD3mqVGBu; Mon, 18 Sep 2023 12:09:02 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id iD3lq83fnWB2viD3lqc8ut; Mon, 18 Sep 2023 12:09:02 +0000
X-Authority-Analysis: v=2.4 cv=HNPQq6hv c=1 sm=1 tr=0 ts=65083dde
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=49j0FZ7RFL9ueZfULrUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nCsS+8kDeErjzm9UgwJIdFzQmv07gfYFiEWxFt+ijPs=; b=zm2/GLJAw2W5pz52xvH4w9ydA0
        Ix00RVPFLou4p6gRW7cDGZ96f8P/jlG5eomM1flKTgkglMtJKgQFCq+wmTuUOOZuoUTVR4zv8/6Tq
        XvnHVFW1vI0Z4TdFqwCTUq5E6x1cgQ+8VzWwgiDeWgWzuuNMfhCaQg0oEiFwR+Qu1N+PPNjkobKsh
        Ontd11oWGkADrl3zUq0Et3O2SDTB1J2wn5U7weUhyxV8QgxjQmzRYwyvfEdiI0d/+UCoeFXzrN2Hq
        UDxf6XfWgxXBOutABgoQRKwHKsYbk6ND9Ej1TY8jqcyQvSfZw8Y4YZDJnxLnPD59xPtcsyGmX1WwH
        QqnJRvAA==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:40840 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qiD3j-000hLX-0s;
        Mon, 18 Sep 2023 06:08:59 -0600
Subject: Re: [PATCH 6.1 000/219] 6.1.54-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230917191040.964416434@linuxfoundation.org>
In-Reply-To: <20230917191040.964416434@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <6c63ed7b-237e-4a90-a15b-cf6e3f60d5a5@w6rz.net>
Date:   Mon, 18 Sep 2023 05:08:57 -0700
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
X-Exim-ID: 1qiD3j-000hLX-0s
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:40840
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLHGB8tElrVeZRdJDfu/YhzrUfTDNQj1LOH6a7SKVoMapzUhUoi0xIRGg1Mvl+srzlZkfhSHwCQT07unY8k50WtYKceD9D/z+cPKABZ1RDDp22RQ3TzI
 z2KW/CM3ASHeCCgWQlcCU0Tt/Y8PV7pcYYRpvfyqzrUO+MYAJwpjpjhRXlKVy39E2Eqi5PrXZH1mJ+FCQYDCk8SrAFb28kPY/Bk=
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/23 12:12 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.54 release.
> There are 219 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 19 Sep 2023 19:10:04 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.54-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

