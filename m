Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2067877D3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240116AbjHOUBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbjHOUBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 16:01:08 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CF819A5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 13:01:05 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id VhTgqjtR0QFHRW0DxqpsgY; Tue, 15 Aug 2023 20:01:05 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id W0DvqmE6i7mx6W0DwqOZ7G; Tue, 15 Aug 2023 20:01:04 +0000
X-Authority-Analysis: v=2.4 cv=WL9s41gR c=1 sm=1 tr=0 ts=64dbd980
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=oJ9PYmwjtwEP0x7K7oIA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kziO47HPQuhKHz+UpmkJYDreIKaiytaoh9bnZL4wAkw=; b=VnwTqfL7dR4usa5rfPauKONeeX
        Wl5EYbK52+P3bmtKgRKzz7pjXe6oT4A09HnIe2XY78b8NMu76nRsVje/sKG8Tsgh0xwToBbzwhr5g
        jCd41DCpyIRnDRSI0BgA8Hshd/yTRS/pS7EU7LCN1n7q0HQ13W+Ucy/pfhcUt7c6fdbFfUj4cKf3J
        Wtwk9ZJ7y0TU4nn6JKAf9+nC0n5sw/3g09omUg5Vp3eN/A44xo9h3rw+n+xlzZ9meaJ4Y63YfqeLd
        MsM7wQ4T6FACSqPMJSiK+Ql1lClEwwKXBJ8ucxCxIaeGqInvjom7HNDzJYo0TwRY/Te8nOs0XWudL
        7RZLQDjg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:56372 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qW0Dv-0020iA-16;
        Tue, 15 Aug 2023 15:01:03 -0500
Message-ID: <563e99c0-c9be-5903-c2cd-d2680a8ee6e9@embeddedor.com>
Date:   Tue, 15 Aug 2023 14:02:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] alpha: Replace one-element array with flexible-array
 member
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZMpZZBShlLqyD3ax@work>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <ZMpZZBShlLqyD3ax@work>
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
X-Exim-ID: 1qW0Dv-0020iA-16
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:56372
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfCpsFyq6S1r2OPq4Q59QK9YHNiZGCQza/CGgIweUpAuoJJ93vxKrBdtCWQcV7G0gSgOImcFI9B/awWTXt2Qo/M1FOByIUjsiyKrhrEONhiTUwCf5VkvH
 oiGBIH1LCPIsPXkw6iTtDX4HH+BQ6s1YTIhw8v4m2UgIy2mldk+nBG8adzWhK6V8/HGLg/F7RcbiLYeCJZt/74jQm5qdQI3/OovMHdqV6WDuED6fYjHdQDfT
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On 8/2/23 07:25, Gustavo A. R. Silva wrote:
> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct osf_dirent with flexible-array
> member.
> 
> This results in no differences in binary output.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>   arch/alpha/kernel/osf_sys.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
> index d98701ee36c6..5db88b627439 100644
> --- a/arch/alpha/kernel/osf_sys.c
> +++ b/arch/alpha/kernel/osf_sys.c
> @@ -97,7 +97,7 @@ struct osf_dirent {
>   	unsigned int d_ino;
>   	unsigned short d_reclen;
>   	unsigned short d_namlen;
> -	char d_name[1];
> +	char d_name[];
>   };
>   
>   struct osf_dirent_callback {
