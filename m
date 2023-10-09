Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F3F7BEBA4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377879AbjJIUdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377408AbjJIUdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:33:15 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBE3A3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:33:13 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id pvy9qvmMkMZBkpwwDqF81H; Mon, 09 Oct 2023 20:33:13 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id pwwCqHejI5eE1pwwCqYZrZ; Mon, 09 Oct 2023 20:33:13 +0000
X-Authority-Analysis: v=2.4 cv=HsVlpmfS c=1 sm=1 tr=0 ts=65246389
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=ChtT1rbVDKAm23ceNSMA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kxVhA3iC5cF5Bpjygso+wLdoa0I8qR+aXtKisYTFkO4=; b=BDCqxgX5mHTlxmoSawnMTQPioU
        x9gE69dpbf0AoFnqb2FawoK+ktCWQuSYHRJ/2153sjUeTW7sy/+e985SeviIrRNc51IX2U9Qw8ZiP
        QEmTnerYBSWt3XBaLFEpJnEqZ0kuRYBSnxIsO76fKJ67WNxZR/8H8TfeMP+IE1WYzxiEz8XddM1wx
        tO4h1cds4iwHygj9stQw0HPfbasaSOGLVwMxA6CD0y0ot1dl+XXtSya1suWmesPIgGrwALQshpBmR
        5A4AO149tqY4yiJG13smvQBxEykXjXM3LvoUZfDgKiEbpDzVqw+FMFAM3cJD+M6KMHhlYXhy/4jfi
        NuueI7xg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:46948 helo=[192.168.15.7])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.1)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qpwwB-000iUk-1l;
        Mon, 09 Oct 2023 15:33:12 -0500
Message-ID: <169f782e-9cc4-49bc-9618-ca6acc526e37@embeddedor.com>
Date:   Mon, 9 Oct 2023 14:33:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] hostap: Add __counted_by for struct
 prism2_download_data and use struct_size()
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZSRXXvWMMkm7qqRW@work> <202310091253.665A9C9@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202310091253.665A9C9@keescook>
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
X-Exim-ID: 1qpwwB-000iUk-1l
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.7]) [187.162.21.192]:46948
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHizR+ql65LJsls5M3ZCwd2fT+pXLVLeu2vDANZ0yxfzRJ+5veoNKTQVdecigvfx9a/8Ya1Od+H5QE75cfdVO6BfpC6yq7fXbg2K5gvfOuYnhlZK+S2s
 hCppsga8r+65Ooiy+F/K06WwL889kUnjiZyOrA45kMoFWS30amIBzsV97kEYMtrEFQ6mFYjBvl7ANPGH1ejIYBW9XJd4QXB84zwmQLRe0qDREWpUYBaqp2M0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/23 21:54, Kees Cook wrote:
> On Mon, Oct 09, 2023 at 01:41:18PM -0600, Gustavo A. R. Silva wrote:
>> Prepare for the coming implementation by GCC and Clang of the __counted_by
>> attribute. Flexible array members annotated with __counted_by can have
>> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
>> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
>> functions).
>>
>> While there, use struct_size() helper, instead of the open-coded
>> version, to calculate the size for the allocation of the whole
>> flexible structure, including of course, the flexible-array member.
>>
>> This code was found with the help of Coccinelle, and audited and
>> fixed manually.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/net/wireless/intersil/hostap/hostap_download.c | 3 +--
>>   drivers/net/wireless/intersil/hostap/hostap_wlan.h     | 2 +-
>>   2 files changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/intersil/hostap/hostap_download.c b/drivers/net/wireless/intersil/hostap/hostap_download.c
>> index 3672291ced5c..5e5bada28b5b 100644
>> --- a/drivers/net/wireless/intersil/hostap/hostap_download.c
>> +++ b/drivers/net/wireless/intersil/hostap/hostap_download.c
>> @@ -732,8 +732,7 @@ static int prism2_download(local_info_t *local,
>>   		goto out;
>>   	}
>>   
>> -	dl = kzalloc(sizeof(*dl) + param->num_areas *
>> -		     sizeof(struct prism2_download_data_area), GFP_KERNEL);
>> +	dl = kzalloc(struct_size(dl, data, param->num_areas), GFP_KERNEL);
>>   	if (dl == NULL) {
>>   		ret = -ENOMEM;
>>   		goto out;
>> diff --git a/drivers/net/wireless/intersil/hostap/hostap_wlan.h b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
>> index c25cd21d18bd..f71c0545c0be 100644
>> --- a/drivers/net/wireless/intersil/hostap/hostap_wlan.h
>> +++ b/drivers/net/wireless/intersil/hostap/hostap_wlan.h
>> @@ -617,7 +617,7 @@ struct prism2_download_data {
>>   		u32 addr; /* wlan card address */
>>   		u32 len;
>>   		u8 *data; /* allocated data */
>> -	} data[];
>> +	} data[] __counted_by(num_areas);
>>   };
> 
> Should this be considered a v2 of:
> https://lore.kernel.org/linux-hardening/94848cc3-6f5c-46d7-8cc7-98a4f10865b3@embeddedor.com/
> 
> ?

Oops... sorry, I forgot I had reviewed this patch of yours.

> 
> Yours is more complete since it includes the struct_size() change...
> 

Should I resend this explicitly marking it as a v2?

--
Gustavo
