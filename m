Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF109799F85
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 21:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjIJTmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 15:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjIJTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 15:42:21 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A65610F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 12:42:17 -0700 (PDT)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTP
        id fNopquHhuEoVsfQK0qUEWR; Sun, 10 Sep 2023 19:42:16 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id fQJzqJJP0vIoMfQJzqFVIL; Sun, 10 Sep 2023 19:42:16 +0000
X-Authority-Analysis: v=2.4 cv=DJWcXgBb c=1 sm=1 tr=0 ts=64fe1c18
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10
 a=nIpKAo32jCGvhA34BA0A:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R0ZkwvmadZPhU2Uje1oI+7gCWM2CIHpfPotoQ+RZbnQ=; b=Uz7MgwSrSrWK0u0kDLuaE4CBQ4
        JbWRdZ2IGZcUHMQWdQi4lg94p/NUjwaL+1PttpHrEkN4PiGMhVYByqBj+7r8cTEE4HF69/2NoFBoi
        1/Z6bNd2ndo9ONlq2h8EradZlFI6tKt+nXgc+xJMPbBovYra59u+yOdPcL0B+DgbJT38TxTGQA4bK
        Vd4VEZCSR867Nc9H3eN9IwfwsBfxKzNvVavYPgeKU/U1Mpwe4RhRet+D8ikFNs8hVb4fCqXqVnx4d
        PDsXV3dsL4M/g5lkiwsA+XvtwKC0V+GPDJnoEjpLjzO7jcrqsGY6akiBzCE35oGOYY1QZey+4g1ru
        RG/7Onjg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:51270 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qfQJz-001cPn-0n;
        Sun, 10 Sep 2023 14:42:15 -0500
Message-ID: <f830b4b0-3d5f-cde8-65d7-e3bee8a40d96@embeddedor.com>
Date:   Sun, 10 Sep 2023 13:43:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [gustavoars:testing/fam01-next20230817] BUILD SUCCESS WITH
 WARNING dbd3e479335bc8b09ea540102109ac38b0a73336
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <202308181544.cTQDCUcQ-lkp@intel.com>
 <d8fd6210-84eb-6d32-6486-1d90c86186ca@embeddedor.com>
 <ZOqykd6tVGip+Swy@rli9-mobl>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZOqykd6tVGip+Swy@rli9-mobl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qfQJz-001cPn-0n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:51270
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPi8Fn/COJCusvpi6qp8XG9ulsvO+Mjmtc12xxBl8B8mWuzAbOqoYjgCbs9VOqlCZ/v/JET4cuxnanNf/dk2jr/ozq+/KU/l27mKUF5lgtQfAD+zO2x0
 ExpAp5mI2wAledOF87LpWB0kA2s9aIfXIPTjgWKdSr1zGxH5CAUvy5b1S9MDnqNkVMlU6Fj5Jctbge7Q6e16qomA5afvBX1RjRNbmLg+LFv8HpM73EPUBksQ
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/26/23 20:18, Philip Li wrote:
> On Mon, Aug 21, 2023 at 11:26:17AM -0600, Gustavo A. R. Silva wrote:
>> Hi there!
>>
>> It'd be great to add to these reports the versions of the compilers you are using
>> to build the kernel.
>>
>> It's not uncommon that some compiler versions contain bugs. And in cases where kernel
>> developers are aware of those issues, knowing the exact version used to build the
>> kernel will help us determine whether the issues reported may be false positives or
>> not.
>>
>> Maybe just one line at the beginning mentioning the versions:
>>
>> `GCC 13.2.0 and Clang 16.0.0 builds`
> 
> Thanks Gustavo for the input, we will add detail version of compiler in the
> summary report.
> 
> We will start with the line you suggested, and later will look for a way
> to add it to the warning line since multiple gcc/clang could be involved
> in one round test.

Thank you! :)
--
Gustavo
