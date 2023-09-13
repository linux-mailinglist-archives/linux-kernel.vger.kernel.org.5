Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B10979F4FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjIMWbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjIMWbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:31:15 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D095D1BCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:31:11 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id gWFqqQqYFez0CgYNlqrd9t; Wed, 13 Sep 2023 22:30:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id gYO6qMq5KYg1hgYO6qvD7E; Wed, 13 Sep 2023 22:31:10 +0000
X-Authority-Analysis: v=2.4 cv=KsReZEaN c=1 sm=1 tr=0 ts=6502382e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=9Wy5krdKfovwESRZh5cA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QaQjYSYz+08NszscbInOSpnia7nnfStZkEWPyxFRuu8=; b=RNz0kNkd4lbR/X+iKN4o4UnTak
        54KkYRSvlcLbQhgZnyTnEKDC6Ej6QVTUfJPtVK0NRzzgr09gUPbprtbU5+VAHYkH4JJ3eTgg+cdBy
        L1S3w/HjjQ9vO2AKAemYtUgFj8d9XJgtLG+pcbuANz+3xGWPqpTxvysJKONq3cB1iIrTRTp1du9fB
        FYhpDKaYe6GBxAPvOTuux+4DwrmHiKHkcQQtarGAn1nFGeDD/96gBfsdDw7hjCtrxZ0C/JmaswXUs
        aK8cJh8ujneMGzX+PopbbhKa+3rbGUjuBhxQiRQpM/PyzAfQEed2JLSIqxvxwjhctMGsvoRy7jBEZ
        hP34iqWw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:38368 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qgYO5-001xlC-1O;
        Wed, 13 Sep 2023 17:31:09 -0500
Message-ID: <9ea1b028-8ac7-61b0-90e2-d240d52aaffb@embeddedor.com>
Date:   Wed, 13 Sep 2023 16:32:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] checkpatch: Add a couple new alloc functions to alloc
 with multiplies check
Content-Language: en-US
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Gustavo Silva <gustavoars@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1694636817.git.joe@perches.com>
 <edb667e19211652a32ef6069159bb85dbc3bcdfc.1694636817.git.joe@perches.com>
 <968f8168-1a0f-c916-86fb-fe4d89bb6250@embeddedor.com>
 <5d5e987a4a1a624f1d8a99a2b7f76c7c3db70241.camel@perches.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <5d5e987a4a1a624f1d8a99a2b7f76c7c3db70241.camel@perches.com>
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
X-Exim-ID: 1qgYO5-001xlC-1O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:38368
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGFqwtMr9cBszgiM3q5CXR5mr98G/PW2Xf7PYTS/6lxApH7qiO+GF6nxF6aWEJtG6wFu4knUGkElExkMzPER1Njb886VEM3/26lHKMuoHmR38m4x7WAe
 98olM2mQo3THFtA8ZAlbSjkcC4hcB0JfHaUEPq83KmL7GSpXuvwLRqGcVLNAiMik31hth8I4eWz8pIiWFGIDxnnGlHvEpAmo8W/JK8VjtRxITOSrNCtDZf1x
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/23 16:25, Joe Perches wrote:
> On Wed, 2023-09-13 at 16:14 -0600, Gustavo A. R. Silva wrote:
>>
>> On 9/13/23 14:37, Joe Perches wrote:
>>> vmalloc() and vzalloc() functions have now 2-factor multiplication
>>> argument forms vmalloc_array() and vcalloc(), correspondingly.
>>>
>>> Add alloc-with-multiplies checks for these new functions.
>>>
>>> Simplify the original codes repeated else to use a hash.
>>>
>>> Link: https://github.com/KSPP/linux/issues/342
>>>
>>> Original-patch-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>
>> Why don't you wait for a response or a v2 from the original
>> submitter?
> 
> Because there really is no need to wait.

By the way, did you test it?

--
Gustavo
