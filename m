Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD277EE8BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 22:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjKPVSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 16:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKPVSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 16:18:08 -0500
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D96B9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 13:18:04 -0800 (PST)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTPS
        id 3iLLrNqTFhqFd3jkSr5nKw; Thu, 16 Nov 2023 21:18:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 3jkQrgEipqmEo3jkRrG6YD; Thu, 16 Nov 2023 21:18:03 +0000
X-Authority-Analysis: v=2.4 cv=P+8pOwMu c=1 sm=1 tr=0 ts=6556870b
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=cm27Pg_UAAAA:8 a=CB8ylYM2jayAzffc3msA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z7VN5fe7q4a712jMshNesYxaBgFBwUjNIQyqspWv/5g=; b=V2mSew9FN/FY6qQBitJwrrvBWx
        egEJQgRKNQ7oQeoB7qzWxi8d7kDHxlcUi0laaO2uapZQn1kqX2BBhTuOi5F4Tm1aVGZ///ZTEBIao
        Zh/9FlQMbAc5oKvjMx5lRbCAdB+GQfj+t/RPy7NAAdcTj65yoaW+AQZux7QGhiM2s/ucnU+mF+3z+
        JTPf+oMEbE+dSkC9/CC7yC60ER+wwtRdBh5f5C6GiCKEL9ShkfsLWGLLDvIDu7UZEueYdMMjrGHMV
        iUzAPggDiCKVY9wEC7EZT+XUCLgALD3ao9CrAMpXLZ8Ozkouxq5sF5oqVWqvDaES2kJK2fHq/02iM
        H5a+KsZQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48450 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r3jkQ-00371x-0t;
        Thu, 16 Nov 2023 15:18:02 -0600
Message-ID: <43bf5965-84c4-420e-91fc-7a0973c27d76@embeddedor.com>
Date:   Thu, 16 Nov 2023 15:18:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] xen: privcmd: Replace zero-length array with
 flex-array member and use __counted_by
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <ZVZlg3tPMPCRdteh@work> <202311161307.9422E1896B@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202311161307.9422E1896B@keescook>
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
X-Exim-ID: 1r3jkQ-00371x-0t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:48450
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfAcLnDMmgxzRLU4mh3fQdQxBQ3YekV4tEcRdA0IBDtPlUnZ/tRwC3W375iLwMX/SSSri99O8TIZFdh9zLz2HbPCDfw1qWjGElFCq2lv3peQJiG84c1sO
 WUdsrB5lS6xLGAmjasxzvPvvUHOcRDT4x6dNW8ATxLRfAEejzVhXViINXDAUMd/WwUIvpMWbub+evvW5ggxRVaQMUnehUoqf/iJUqZgU+wcoy1BiOIHQd/Yn
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/16/23 15:08, Kees Cook wrote:
> On Thu, Nov 16, 2023 at 12:54:59PM -0600, Gustavo A. R. Silva wrote:
>> Fake flexible arrays (zero-length and one-element arrays) are deprecated,
>> and should be replaced by flexible-array members. So, replace
>> zero-length array with a flexible-array member in `struct
>> privcmd_kernel_ioreq`.
>>
>> Also annotate array `ports` with `__counted_by()` to prepare for the
>> coming implementation by GCC and Clang of the `__counted_by` attribute.
>> Flexible array members annotated with `__counted_by` can have their
>> accesses bounds-checked at run-time via `CONFIG_UBSAN_BOUNDS` (for array
>> indexing) and `CONFIG_FORTIFY_SOURCE` (for strcpy/memcpy-family functions).
>>
>> This fixes multiple -Warray-bounds warnings:
>> drivers/xen/privcmd.c:1239:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
>> drivers/xen/privcmd.c:1240:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
>> drivers/xen/privcmd.c:1241:30: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
>> drivers/xen/privcmd.c:1245:33: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
>> drivers/xen/privcmd.c:1258:67: warning: array subscript i is outside array bounds of 'struct ioreq_port[0]' [-Warray-bounds=]
>>
>> This results in no differences in binary output.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Looks right to me. I can see the allocation:

Yep, I always check for that; in particular, the 'counter' assignment. :)

Do you want me to mention it in the changelog text?

> 
>          size = struct_size(kioreq, ports, ioeventfd->vcpus);
>          kioreq = kzalloc(size, GFP_KERNEL);
>          if (!kioreq)
>                  return ERR_PTR(-ENOMEM);
> 
>          kioreq->dom = ioeventfd->dom;
>          kioreq->vcpus = ioeventfd->vcpus;
> 
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!
--
Gustavo
