Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3327EFCEE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjKRBSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjKRBSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:18:15 -0500
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BB8A0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:18:11 -0800 (PST)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
        by cmsmtp with ESMTPS
        id 48ParvwXfKOkL49yMr6yyA; Sat, 18 Nov 2023 01:18:10 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id 49yLrMq0nnCfv49yMrbZ5W; Sat, 18 Nov 2023 01:18:10 +0000
X-Authority-Analysis: v=2.4 cv=KKpJsXJo c=1 sm=1 tr=0 ts=655810d2
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=XFdaU8tal97uqFnNbpwA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hhRvX3KXz/8AkEk+OrqEncluUTlqt9mXbv+0o5iH0oc=; b=E7GJrUg5+IiB92oB18U99HLHTX
        +QEaYtWucbDoZ9AsxNRuV0Hj3IFCHCVhUn3cEb4C4En6t9mU4S42a4FH8fLL15/VRNXSRkDu+ZEEK
        XUseWMyYO5uHdz3XL9BP7qX916KO3Ua6oexyVVahExJFtMkmpBvK1oB4UTdfqzDf0xoOmbOR1hx5L
        EavRqZ0my4Ez1vVeXEKRU7eaRTQKSKYlP3dIraX8Gw/MBZivsHn3j68BD/IqO/w2yh4cpTZsgg7DD
        tb9cZoVt94Vxcfmxw31jgbTKy+3T2QmSUz7WaBqaz5zX1KIP4F3PCoDUQhXQ/FQNYI2xtFT+4PXar
        lC/uUCjA==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:55590 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <re@w6rz.net>)
        id 1r49yJ-001zmw-0W;
        Fri, 17 Nov 2023 18:18:07 -0700
Subject: Re: [PATCH 5.15 000/244] 5.15.139-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231115203548.387164783@linuxfoundation.org>
In-Reply-To: <20231115203548.387164783@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <953bcc5f-a1bf-81a7-4307-09c115752156@w6rz.net>
Date:   Fri, 17 Nov 2023 17:18:04 -0800
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
X-Exim-ID: 1r49yJ-001zmw-0W
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:55590
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMC89L08ZKwWyVJDwvaFGQcx9FYBlGTufgkq6wbRIfwXOo8j0DtYM0q1yXaxOPRQXEvUtD9G5SsPRGwmP3H7CHT4nC5SwSdiX1boICJQBheuKVqN8I9u
 jQSp+ueQQmQ0Tc1HTCMYG43NF3vWCO8cFzivxuLdorUSQvTN5AKbl27ONKpD/SgZMyLc0EE8FK4Ap8i6yjiQrLuRB3QievC8Ugk=
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/23 12:33 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.139 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 17 Nov 2023 20:34:45 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.139-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

