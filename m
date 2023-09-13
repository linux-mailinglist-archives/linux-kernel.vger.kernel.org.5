Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8C179DD30
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237902AbjIMAiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbjIMAiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:38:20 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09D41706
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:38:16 -0700 (PDT)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTP
        id g8DIqSb9IQFHRgDtYqS4CP; Wed, 13 Sep 2023 00:38:16 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
        by cmsmtp with ESMTPS
        id gDtXqTSRt4G7BgDtXqF4S7; Wed, 13 Sep 2023 00:38:15 +0000
X-Authority-Analysis: v=2.4 cv=UMrOoQTy c=1 sm=1 tr=0 ts=65010477
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=RKbCEY-9GWW1vOMDYy8A:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=nmWuMzfKamIsx3l42hEX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
        Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vdl7qFLPsRViF1fmhdZdxl6hEuXggZMA/jDCKc4zM2I=; b=hA+UJOnDjSwGmHy/C3bGSzqMsR
        Jh9oZT4gK3flGsFyMNYGNIhgKBQN1tr39jlaEM1gjfdgHGDXnS53UIKOCkOdkjGkHVYBnkFVIFELW
        sgWG6+RMCqEDmVjxuE1qYqJ9fRJs/gfKs72+ZiA39Ef5ptOZ7bQnRlglOSmToJvMQNt79I/GiTt7q
        sJPqqYEcTdF35OPtbgrf72GLHav0iaas2IntcJT/wnRK6X5aQkclxV4+o3+WU6oGsdWbraNfYquPa
        I67RrRtrAGn9vxieVU2fQCSqflSIomhZO5gccFFGGnKFZFZcODE62CoZmk9MBnpzrhIvP3ib50Spx
        NyaJI3WA==;
Received: from c-73-162-232-9.hsd1.ca.comcast.net ([73.162.232.9]:55164 helo=[10.0.1.47])
        by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <re@w6rz.net>)
        id 1qgDtV-003tzg-0f;
        Tue, 12 Sep 2023 18:38:13 -0600
Subject: Re: [PATCH 6.4 000/737] 6.4.16-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230911134650.286315610@linuxfoundation.org>
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
From:   Ron Economos <re@w6rz.net>
Message-ID: <69d717f1-3771-6b1e-4e76-570af2055e7d@w6rz.net>
Date:   Tue, 12 Sep 2023 17:38:10 -0700
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
X-Exim-ID: 1qgDtV-003tzg-0f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-232-9.hsd1.ca.comcast.net ([10.0.1.47]) [73.162.232.9]:55164
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org:  HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFGS4azxzLqmE2vJoWMD2SVxstayowR1n4gAFSwx87CwoVrIAiK61Fn2BPWiz63Ni4PZDP/3UMPNiMrMa3cawFPLS36k5RXdrUwzB0/qdaPbfYvlzOh2
 4rv8V0Ew3tBoIsF58kKOoTxBsU2FWtfKt6HY66JeIM7bKOyiY8fmAytVIftwvA56794oEzusnVh9VhgYEBTT77IfdilsawNqbPw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 6:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.4.16 release.
> There are 737 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 13 Sep 2023 13:44:56 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Built and booted successfully on RISC-V RV64 (HiFive Unmatched).

Tested-by: Ron Economos <re@w6rz.net>

