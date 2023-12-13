Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D663281087F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 04:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378329AbjLMDBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 22:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbjLMDBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 22:01:01 -0500
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AFBB2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 19:01:05 -0800 (PST)
Received: from eig-obgw-6005a.ext.cloudfilter.net ([10.0.30.201])
        by cmsmtp with ESMTPS
        id CzYcr3ZwagpyEDFUerVKfS; Wed, 13 Dec 2023 03:01:04 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id DFUdrRiQy8KNvDFUerDKcH; Wed, 13 Dec 2023 03:01:04 +0000
X-Authority-Analysis: v=2.4 cv=dp3Itns4 c=1 sm=1 tr=0 ts=65791e70
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=2SA1H0gNNTX1gE9MOmMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gbNxPHSj4xxqAJgtk4Y4EHrvPUIwaT3LyX2jo27M0xc=; b=RdbMOYnx4EVgtSQWb/yoF9LItL
        gLrvHUV8d/DtDOfuk7wi1T5u8195lKsIvtlZzozs3tytgDcBOPcI2bOA11yiWMBxxpklNmtv8q8UY
        upxnEXPcz5S/lT36ypra38gr7zYJjrs1XME4DHQPI7IM4IIGAzycAohGpVj5fDQ/K+UQEa5+HN7Pk
        +YEXuMKOO/QlitF+/JjHTBrhIoavj1n9AX+DkCphSNcnpoW6Gu5N1l9183WiBdtABkeEtTXWWMV7T
        mIG1XHMYAcOzDaO4IKc/IRZDVP49nr0Q2me0/vkv76bQgtl5h1TPMGzjDk+JuYjJrGmB8PWUc0wBu
        u3WB0KuQ==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:59642 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <re@w6rz.net>)
        id 1rDFUb-002YNG-1B;
        Tue, 12 Dec 2023 20:01:01 -0700
Subject: Re: [PATCH 5.15 000/139] 5.15.143-rc2 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        allen.lkml@gmail.com
References: <20231212120210.556388977@linuxfoundation.org>
In-Reply-To: <20231212120210.556388977@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <be0b6665-5330-255d-31a6-f3bbe4e6b1a0@w6rz.net>
Date:   Tue, 12 Dec 2023 19:00:58 -0800
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
X-Exim-ID: 1rDFUb-002YNG-1B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:59642
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMElA6qn8mfzwV+H3NEK4x5igfGMT7T774qw6H8o8byMY69mhiKvwbo6AGOcxS9SFU86d3wdwIy7oBeIxqZPn6iGazSV7AQZfdN0rOgNSr/BDCEVWtu+
 45pfGENZACywKso5QRbNqsJJHegx8nsQ4FSxJd3IGSqQ/1S7y2Zz8ISnGXixB9ODxB2ENd7DPpSOx9hb/LLf4ShtcP2FEXleMq0=
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 4:04 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.143 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Dec 2023 12:01:32 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.143-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

