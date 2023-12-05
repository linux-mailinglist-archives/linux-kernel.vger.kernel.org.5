Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B140805C34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442420AbjLEPp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346310AbjLEPp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:45:56 -0500
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7857D85
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:46:02 -0800 (PST)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTPS
        id ASgnr21LzWcCIAXcXriopq; Tue, 05 Dec 2023 15:46:01 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id AXcWr0ml6M0U2AXcWr188B; Tue, 05 Dec 2023 15:46:00 +0000
X-Authority-Analysis: v=2.4 cv=BuKOfKb5 c=1 sm=1 tr=0 ts=656f45b8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=c601a17RXwP2wWhsnozrzA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=WzuJIX3iUC1USL5IvykA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=NHebt4j7s8OHV/xuSCmvZsKFeNjOFLQ9DgYPRv6+6O8=; b=agnQBn/dUEGSq49ZF5VM6/Hc5V
        oNj2qa1gF12KYyLZcjOYvrvEAXdz1UHWYuUXA4oJin0nC6v4u/1qHh0/J8C20uocjWAJaUdZcqlzo
        Gm8t1qk/21heW3MfKbeq2WcLwEfrJ+uDVZMJjYY++n3rm1uzrJttTuIo3HH9QwCsiPMDM0g2sezyQ
        2X/DPIH+2da/DguJp2tjp5t8QckBJxTk7FCSLO5l1N3zZHKXaDwYBOq9Lg90v9iNOTjrN7n0b7Lvx
        HQRS0xoN1uZzJkkS2PIX9kWPywG7ZNmG6eaG1zhI2xX8yRpzDKuh1CJGoUvm8vkNqFMKe/o0nYcWQ
        fu9IL+8w==;
Received: from 187.184.159.186.cable.dyn.cableonline.com.mx ([187.184.159.186]:42509 helo=[192.168.0.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1rAXcV-000tVE-31;
        Tue, 05 Dec 2023 09:46:00 -0600
Message-ID: <30ea9d68-e49e-4727-88aa-547b1b0feebf@embeddedor.com>
Date:   Tue, 5 Dec 2023 09:45:57 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] wifi: ath11k: Use DECLARE_FLEX_ARRAY() for
 ath11k_htc_record
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
 <20231127-flexarray-htc_record-v1-4-6be1f36126fd@quicinc.com>
 <4f2a486c-c6de-43e4-8bb6-bdd3f819b0a9@embeddedor.com>
 <c5555ad6-6991-4fca-864f-355d2fae9ae1@quicinc.com>
 <87edg0pt17.fsf@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <87edg0pt17.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.159.186
X-Source-L: No
X-Exim-ID: 1rAXcV-000tVE-31
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.159.186.cable.dyn.cableonline.com.mx ([192.168.0.10]) [187.184.159.186]:42509
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPzVhlvubBjxQHu1+cSrQVykQIkIGUUxZ1zGkQOWeFWI9XUGM7xGtliS3mFQ8XhCosDQt+yunIqDUeFl2/tm2Nnsf3eYzKvNJgazgvNED2VjziGQSJ83
 jl1pdKugZ4S3H+aZx+r/yNPA+lrYRi6zJ7ay1R+pcCackvpUKUmMoJrV8nrLYXyYOF5Pa/s1mGzpS1XHejnUoz6FbyO43oxXp0JlQxiIQ4GdZJiApQyTC91T
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 09:29, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 11/27/2023 8:23 AM, Gustavo A. R. Silva wrote:
>>
>>>
>>>
>>> On 11/27/23 10:14, Jeff Johnson wrote:
>>>> Transform the zero-length array in ath11k_htc_record into a proper
>>>> flexible array via the DECLARE_FLEX_ARRAY() macro. This helps with
>>>> ongoing efforts to globally enable -Warray-bounds.
>>>>
>>>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>>> ---
>>>>    drivers/net/wireless/ath/ath11k/htc.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
>>>> index 84971cc9251c..e0434b29df70 100644
>>>> --- a/drivers/net/wireless/ath/ath11k/htc.h
>>>> +++ b/drivers/net/wireless/ath/ath11k/htc.h
>>>> @@ -151,7 +151,7 @@ struct ath11k_htc_credit_report {
>>>>    struct ath11k_htc_record {
>>>>    	struct ath11k_htc_record_hdr hdr;
>>>>    	union {
>>>> -		struct ath11k_htc_credit_report credit_report[0];
>>>> +		DECLARE_FLEX_ARRAY(struct ath11k_htc_credit_report, credit_report);
>>>>    	};
>>>
>>> Why not removing the `union` and just do a direct transformation [0] -> [ ] ?
>>
>> No reason other than staying consistent with ath10k.
>> Will see if Kalle has an opinion on this.
> 
> Yeah, I don't see the need for the union and I removed it in the pending
> branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=a2faeea1fe0635563187e7821a6d0baf7b40f2c6
> 
> Does it look ok?
> 

Nope.

A direct transformation is just fine:

-	union {
-		struct ath11k_htc_credit_report credit_report[0];
-	};
+	struct ath11k_htc_credit_report credit_report[];

There is no need for DFA in this situation.

Thanks
--
Gustavo
