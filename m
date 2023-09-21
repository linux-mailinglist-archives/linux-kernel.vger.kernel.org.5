Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A9B7A9066
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 03:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjIUBQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 21:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUBQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 21:16:18 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8298FDE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 18:16:11 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
        by cmsmtp with ESMTP
        id j76yqyDvbyYOwj8IcqfQUo; Thu, 21 Sep 2023 01:16:10 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id j8IbqLb0zjxwjj8IcqFIqW; Thu, 21 Sep 2023 01:16:10 +0000
X-Authority-Analysis: v=2.4 cv=B7qqbchM c=1 sm=1 tr=0 ts=650b995a
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=XNLVCjSSWbVrjixA0bgA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PZ4vBUkC/xVBSr++6sHD+qEJULVjjozCngo4jWWFAYU=; b=KY/MmFOPz7/07paIfh8cMuB+gO
        0uOSw+k29jK/MEsiXALOrdj8zegi7Kn4fvvA6dsz+KJA7dYAWVtS3DHkBwcmhL8lGQ7qDvRzYykW1
        N4gBPhVoP14jPn0OAXkr8+2oWmsyW/PnSM2yXQo8hdsK37mm3CahqjALvC6baumtVAb8x098L2ofS
        rbKEsG92C2y0h47vjx69DbvA6zI36n7GEcNFnpVsgS+9mXu0t8g8PFB1EytJBICGgowu2kJHiod9A
        I6O3cxa63lLAiZjnnVeyXbb0zW2wqCFHvIXhPqxeUu7qH2NELQaRqoHj8tBYeBsUa+3jio4ry1kE4
        yIC+NFwg==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:41372 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qj8IZ-0028iK-21;
        Wed, 20 Sep 2023 19:16:07 -0600
Subject: Re: [PATCH 6.5 000/211] 6.5.5-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230920112845.859868994@linuxfoundation.org>
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <b5ce6624-e434-7d41-4abb-8d911188f0a3@w6rz.net>
Date:   Wed, 20 Sep 2023 18:16:05 -0700
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
X-Exim-ID: 1qj8IZ-0028iK-21
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:41372
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOEuuMCiiJklkYMkgptP8Vb0PaBouIMTnTyxqX8+eyu13D4Ms/JN+HJXyMqeJwWqbBgon35PXqvj+vkNHOXU4L2667ey1aLZXPd6TxLnWdz8+jI6KxZj
 bgQA90Nsh0rVQRw3bln44ECwR9l+ytKS9cpIDAX482FjnpZzBeTmpDcewB5XPJUElOlg+tQTFgwexa/cK2pmn3cT+NlnJU36hL0=
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 4:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.5.5 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.5.5-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.5.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

