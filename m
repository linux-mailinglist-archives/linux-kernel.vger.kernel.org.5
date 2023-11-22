Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFCD7F3CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjKVEEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVEEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:04:31 -0500
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE69BC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:04:27 -0800 (PST)
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
        by cmsmtp with ESMTPS
        id 5WS2rkPYOhqFd5eTSrnrLQ; Wed, 22 Nov 2023 04:04:26 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 5eTRrPpg511XZ5eTSrDL7Q; Wed, 22 Nov 2023 04:04:26 +0000
X-Authority-Analysis: v=2.4 cv=Z+v/oVdA c=1 sm=1 tr=0 ts=655d7dca
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=ekcPnwKpBOpVc3CNEFsA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dZd0iL+YeL2vCrHxa0z4k0wFMO8wOysNrqRBOkXpC50=; b=T9J3YtavTgPXryHzdYBfn8NEbK
        MZsC0I8snspER8SHGIIl+PRU31AbZrcydvx+NzsxRqk0zFcobJYsVEO1k6sLmxTI8vj6YICT3VUrB
        9VuUJKrhgN2BSpav7JnxPPn2Z565k9AvLhZgvZ9oYoxp+cEFaaBdRq9d/kWXNRnnCVmpRp/vhWbcd
        0qyFgaEiGyVTqJJ6iq+sD2I9cGtIRRSkK2mcu/Rz8fdn1W5WYjhuJog7FT/27a/XynunJREGDoj6z
        pmrvpkN7QZCxpUDf4+K3ifJAGUqIv9rnl76aGf+fHoId+iQhZ+03Z6FWL5Y1g03Kc10QZMLLtcwzS
        PhACHzEA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48188 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r5eTR-004DIf-17;
        Tue, 21 Nov 2023 22:04:25 -0600
Message-ID: <7e58f7a0-440f-4067-87e2-381f05bfce2b@embeddedor.com>
Date:   Tue, 21 Nov 2023 22:04:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warnings after merge of the kspp-gustavo tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231122144814.649823ac@canb.auug.org.au>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231122144814.649823ac@canb.auug.org.au>
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
X-Exim-ID: 1r5eTR-004DIf-17
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:48188
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfB074yFHE8lbO4aniJk0W3jOdGqLhmFEERDfNx9NrQRytSrwgzlVxeLu9qehrUvZNI+YhCdvAAXBYf7Ezq9dhecpXxpPlJe1uNDi866pY34zrFCaxW14
 Mq1CwokYjy+lfKHAHWU62Zab8L/h5KJ20ZNdk/LLRHHB78vwFrgllK2x15Zk5km3/2tUfcql3IOHlkiU8Df6CBiSrKzhwhkCbjIegRDgOhuscCrNsB5Ui61j
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/23 21:48, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the kspp-gustavo tree, today's linux-next build (sparc64
> defconfig) produced these warnings:
>

[..]

> mm/mempolicy.c:2890:26: note: destination object 'str' of size [0, 9223372036854775807]
> mm/mempolicy.c:2890:26: note: destination object 'str' of size [0, 9223372036854775807]
> mm/mempolicy.c:3007:26: warning: writing 1 byte into a region of size 0 [-Wstringop-overflow=]
>   3007 |                 *--flags = '=';
>        |                 ~~~~~~~~~^~~~~
> mm/mempolicy.c:2890:26: note: destination object 'str' of size [0, 9223372036854775807]
>   2890 | int mpol_parse_str(char *str, struct mempolicy **mpol)
>        |                    ~~~~~~^~~
> 
> This is using gcc v11.1.0
> 

This doesn't show up with more recent compilers because it was an issue in GCC.

--
Gustavo
