Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D5811FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjLMUOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:14:50 -0500
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C4DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:14:56 -0800 (PST)
Received: from eig-obgw-5006a.ext.cloudfilter.net ([10.0.29.179])
        by cmsmtp with ESMTPS
        id DTAvrMooejtZ3DVdIrt6E6; Wed, 13 Dec 2023 20:15:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id DVd8r1scn1J28DVd9rm1s8; Wed, 13 Dec 2023 20:14:55 +0000
X-Authority-Analysis: v=2.4 cv=Tqz1ORbh c=1 sm=1 tr=0 ts=657a10bf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=uucgfnjzxiVboiWmI4QA:9 a=QEXdDO2ut3YA:10 a=phs4urI-Bf8A:10
 a=AjGcO6oz07-iQ99wixmX:22 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1HyjzJtPl2sUntsAoFxkWgAbY6M7c0HaPJqZRErlf6Y=; b=F19Xfa/fVsko11ZYAAp+fLLgQE
        JKYZf7l5jeio10XKdoJ92Ca6CIbpzzE303mOM8CFzMLyyaaYFNqZorcLQrm3F//jBfGRyM9q+hRw8
        85yPu0ZLN1Q0GNj5Wq4d5zJLjkRV/9hcqK5MaeeRLZ1al/HZ7LJ/EKWPIn7LYl+BqV+NUym24eO5o
        nG1bZsdkm7VNFItpWobUGQCFEJpHzpWyw/14YxHbbaqfGjOfTZoVSKAIdLW2q9Om9sjw86EwnDRoZ
        XfY6tdpgITObdjqjbmfxrL3jq8ChxnJTW2Y4CE8dLMginTZCjjVGXAe4B8FzflF5iQ6CzIkJnywY1
        lugecQPQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:60998 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1rDVd8-003PFj-0p;
        Wed, 13 Dec 2023 14:14:54 -0600
Message-ID: <f5a23931-6c05-4eed-91a5-5b829ad3aa94@embeddedor.com>
Date:   Wed, 13 Dec 2023 14:14:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: ath10k: use flexible array in struct
 wmi_host_mem_chunks
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-1-92922d92fa2c@quicinc.com>
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
X-Exim-ID: 1rDVd8-003PFj-0p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:60998
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHc9MFZrJhF4QpR2l+1T1f369GSnSzAnuo81IDVTsIxnzx7bXvCRWwjBrogEjVyRw9caDMr871AMSNQXiSbm2IGph5oGPfiRjRDt2dCBivg9gLMce3fZ
 ifDr58B9al/ZqnRoLKyRx/v3ObjM8RPlb17jpqR3pfCVELwarl7hfKJ3eTbAl3PdT4J2n6latoAHxIwk/LVk2zXkWEg8G7cKwyayflIu7e1HhMVKqIYalESB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 11:06, Jeff Johnson wrote:
> Currently struct wmi_host_mem_chunks defines:
> 	struct host_memory_chunk items[1];
> 
> Per the guidance in [1] this should be a flexible array. However there
> is a documented requirement:
> 	some fw revisions require at least 1 chunk regardless of count
> 
> To satisfy this requirement, follow the guidance from [2] and wrap the
> array in a union which contains both the flexible array and a single
> instance of the underlying struct. Since the footprint of the struct
> is unchanged, no additional driver changes are required.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/net/wireless/ath/ath10k/wmi.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
> index 9146df98fcee..833ce0251a2c 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
> @@ -3069,7 +3069,10 @@ struct host_memory_chunk {
>   struct wmi_host_mem_chunks {
>   	__le32 count;
>   	/* some fw revisions require at least 1 chunk regardless of count */
> -	struct host_memory_chunk items[1];
> +	union {
> +		struct host_memory_chunk item;
> +		DECLARE_FLEX_ARRAY(struct host_memory_chunk, items);
> +	};
>   } __packed;
>   
>   struct wmi_init_cmd {
> 
