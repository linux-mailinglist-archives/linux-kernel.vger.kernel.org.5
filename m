Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D4B7F8D46
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 19:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjKYStK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 13:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKYStJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 13:49:09 -0500
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D0DF0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 10:49:15 -0800 (PST)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTPS
        id 6upirrcp98Hte6xiMr0YaM; Sat, 25 Nov 2023 18:49:14 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id 6xiLrWrT3GKIc6xiMr4Eb6; Sat, 25 Nov 2023 18:49:14 +0000
X-Authority-Analysis: v=2.4 cv=E+beGIRl c=1 sm=1 tr=0 ts=656241aa
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
        bh=CvR69hzFW0VzaNdZzTdr7NaBcjgFTzDNimu3gFPYlsE=; b=cRpTAjApbBCdBG+/0CZ2IMURcg
        Z4bJK4CwaDLkv1LHJsKnT1qF9UhtsRWBwkAbie2bDudJqYhKYUfPhxdqW29jtRZoVm/sm7zIXiTaW
        69UI80aE6so1DDdcpxRsVKTHwxpnHZ6ywCXPCVY99ECU5xFSU0O+VwouSQmlKBmfa+gOdw6r/kUtE
        quE6Ur9j0jkDFLxiQhjtpsCmo2O10g3THKjzS4j1qL/KRgsY4S+odE9sFna8Z2crF6EtJy20ORTkH
        eezQSx5UmkcZizzizXa0Okzh87qCBH82btRHsuHfr5j4xMZoWb7XsBgJiRtyavGxQJjxpV/Xp+OtB
        l450KTog==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:56846 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <re@w6rz.net>)
        id 1r6xiJ-000JPb-23;
        Sat, 25 Nov 2023 11:49:11 -0700
Subject: Re: [PATCH 6.1 000/369] 6.1.64-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
References: <20231125163140.940904812@linuxfoundation.org>
In-Reply-To: <20231125163140.940904812@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <934455d9-9e53-9205-77ad-8715371ed891@w6rz.net>
Date:   Sat, 25 Nov 2023 10:49:09 -0800
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
X-Exim-ID: 1r6xiJ-000JPb-23
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:56846
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPvwIDqIfC4dKBE9mdILLQxNo4da6r6xQJBjoqf4L4BvW+TRr4BQTD4YWpAdVxBdN/6rzr3WuZJqj/EcI/En28O/PzTYiJScycfNz//XoGpjFIs0np3P
 gx+4XmZA5KWSR6BwNVgav5oW3A2Ao10qzrYGxatnr1XWxJeOYQZ8eqqVi5Sm4YmArrskotaz2Ne/Y1hR9g6FwHm9cOhnW1/q7vo=
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/23 8:33 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.64 release.
> There are 369 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 27 Nov 2023 16:30:48 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.64-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

