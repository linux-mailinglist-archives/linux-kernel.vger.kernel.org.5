Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32897EEA69
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 01:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345608AbjKQAjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 19:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQAjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 19:39:08 -0500
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDB4130
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 16:39:05 -0800 (PST)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTPS
        id 3iTZrNtONhqFd3mszr71so; Fri, 17 Nov 2023 00:39:05 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 3msyrBNFIGKIc3msyr4FwJ; Fri, 17 Nov 2023 00:39:04 +0000
X-Authority-Analysis: v=2.4 cv=E+beGIRl c=1 sm=1 tr=0 ts=6556b628
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10
 a=R-O7WXT0cwsqnUZTtUEA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=sdYu/K9hPh6cEQfK7WAAQTb+r/RBPYy8h5oSJ34Bkqw=; b=ko/QPXOqSFbbsEwEGEjvINiVSJ
        ty8InXkiFCggdtA4TWqli3U2cmbnqp/m1MYhWzhY80DIcawP1Nx5zNqBDcJxagpXdRr9VVtzzrqiD
        MMv8pHHtbiah9TCcjNCCvL5R8xB6QBheAn1ZUBVLz5MhPncngJ+OMItKADqySTG0KYnZkzI/5i6bM
        6pndmY7bZp0WDURywoVKABCyLL+iwuNessp2agSnceYSKPv4jmxkPvyeyWOqHbCIrm95rrWpf2ocR
        gEdpwTlnwWRUeisA+hL0rBdUBYPBRaWydE9OsjBc/ue2Q/dfBYDVetRxHirvm9jQnRhypm2VMNE9m
        9et/CIpQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:50976 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r3msy-001vMo-0C;
        Thu, 16 Nov 2023 18:39:04 -0600
Message-ID: <202281f0-5a18-43ce-8b47-055748dd6d78@embeddedor.com>
Date:   Thu, 16 Nov 2023 18:39:03 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the kspp-gustavo tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20231117113312.31379f74@canb.auug.org.au>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231117113312.31379f74@canb.auug.org.au>
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
X-Exim-ID: 1r3msy-001vMo-0C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:50976
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPSnqvs2eK22QCDn/7riQEhrMa42ToXfvdE5EBoPJ562WNVgttAjc4cxntpq47dSa05svBCxP6SxyCLByRYsyYFS+leSn9x0LvKbCbfO9rTKnAR9+E49
 McxTVQf6Gf6A8SmATg+6KrTnyYsJ1QZSCdvajUj35QkaSPmXtzruC996q9cX8Bac/M5Y7mIWymKpPoor41Ln56q2dcTwnUsA6RR79rvpxs8XI0bywElLZ/Lz
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> arch/powerpc/lib/sstep.c:289:23: error: writing 8 bytes into a region of size 0 [-Werror=stringop-overflow=]
>    289 |                 up[2] = byterev_8(up[1]);
>        |                 ~~~~~~^~~~~~~~~~~~~~~~~~
> arch/powerpc/lib/sstep.c: In function 'emulate_loadstore':
> arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into destination object 'u' of size 16
>    681 |         } u = {};
>        |           ^
> arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into destination object 'u' of size 16
> arch/powerpc/lib/sstep.c:681:11: note: at offset 16 into destination object 'u' of size 16
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>    c94c73da81d7 ("Makefile: Enable -Wstringop-overflow globally")
> 
> I have used te kspp-gustavo tree from next-20231116 for today.
> 
I'll address those issues right away.

Thanks for the report, Stephen.
--
Gustavo



