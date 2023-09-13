Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B9679F51B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjIMWkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjIMWkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:40:51 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4C51BCB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 15:40:47 -0700 (PDT)
Received: from eig-obgw-5010a.ext.cloudfilter.net ([10.0.29.199])
        by cmsmtp with ESMTP
        id gWFqqQqYFez0CgYX2qrgmL; Wed, 13 Sep 2023 22:40:24 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id gYXNqN6iMYg1hgYXOqvSg2; Wed, 13 Sep 2023 22:40:46 +0000
X-Authority-Analysis: v=2.4 cv=KsReZEaN c=1 sm=1 tr=0 ts=65023a6e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=cSeO5zFBqQ4rU4dyzkgA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8T7Xdszc5U8nXHM3E2wFGHWKhObikfvAxj+n8Nz0olA=; b=PZozIUeSBfckTX/U21w4kUyj0t
        fJS9KB2vZpJnEbZe0GGEBeY7yAjPJAbt69vo5stLpfPGHMw2fiRkf/5fgBqWzlSUSBVOy6tEvdKIb
        FySImd+b97QJH3C9zeTCi2CYY6Vg8de3ApvtjCQ759oelekyaWi/7yIu5qWrdjMB2HL1yRH5IwrzG
        1AYlV2Fqy0N4c9YiCYJYupURTAV4ZCcf/O9aZ7T5h93Ny4ExeaC2wmlJm2IOaXme38g/TwqqjcnT+
        0Cah6BVBs47ybhO8IUF8Or09pXZs4jrYS7tGO3cin2o2NYaX4warbgVKZ9AuBJ8TBob049ZSLDwKk
        SjTycfDw==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56798 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qgYXN-0026AZ-03;
        Wed, 13 Sep 2023 17:40:45 -0500
Message-ID: <8cf58a8a-5410-4d3f-eb1a-e5bb6ce36023@embeddedor.com>
Date:   Wed, 13 Sep 2023 16:41:41 -0600
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
 <9ea1b028-8ac7-61b0-90e2-d240d52aaffb@embeddedor.com>
 <7a9f7631b7352d7f9ce07bdc53cfc92065cb11a3.camel@perches.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <7a9f7631b7352d7f9ce07bdc53cfc92065cb11a3.camel@perches.com>
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
X-Exim-ID: 1qgYXN-0026AZ-03
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:56798
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDpM/6MShO4BCY2xbudJ4+5VJ6ccEeXwHYtt6ze6PCWrUjC4uq1vwyZNnXZizRMxtvrXhPro/3m1iRLQu42Wb4yjDsNTs4W44EOns33fWkhOaPPArhb6
 lCtsQ5HhkPmbLFSQLihShLpYnJ4OpMuMrgbQ47QC8u/WPY8fKcLG3UDlvQrjM66KiLy2mRA0sk3YZMVeiDu3QCVDt/bNrKXTiJlB+qoT/jvK0e/h2CDYqyS1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/23 16:34, Joe Perches wrote:
> On Wed, 2023-09-13 at 16:32 -0600, Gustavo A. R. Silva wrote:
>>
>> On 9/13/23 16:25, Joe Perches wrote:
>>> On Wed, 2023-09-13 at 16:14 -0600, Gustavo A. R. Silva wrote:
>>>>
>>>> On 9/13/23 14:37, Joe Perches wrote:
>>>>> vmalloc() and vzalloc() functions have now 2-factor multiplication
>>>>> argument forms vmalloc_array() and vcalloc(), correspondingly.
>>>>>
>>>>> Add alloc-with-multiplies checks for these new functions.
>>>>>
>>>>> Simplify the original codes repeated else to use a hash.
>>>>>
>>>>> Link: https://github.com/KSPP/linux/issues/342
>>>>>
>>>>> Original-patch-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>>>>
>>>> Why don't you wait for a response or a v2 from the original
>>>> submitter?
>>>
>>> Because there really is no need to wait.
>>
>> By the way, did you test it?
> 
> Yes, against arch/s390/include/asm/idals.h

I don't see any instances of vmalloc() or vzalloc() in that file.

--
Gustavo
