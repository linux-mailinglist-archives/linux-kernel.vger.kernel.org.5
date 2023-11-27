Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E4C7FA64D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbjK0QYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbjK0QYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:24:15 -0500
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EC012C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:24:20 -0800 (PST)
Received: from eig-obgw-5008a.ext.cloudfilter.net ([10.0.29.246])
        by cmsmtp with ESMTPS
        id 7XTIrxI9h8Hte7ePErEwSb; Mon, 27 Nov 2023 16:24:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id 7ePDrxGd4kUbt7ePDry2WP; Mon, 27 Nov 2023 16:24:19 +0000
X-Authority-Analysis: v=2.4 cv=WpU4jPTv c=1 sm=1 tr=0 ts=6564c2b3
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=yGeM7+xMb5a5VK1DGQx1ew==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=wYkD_t78qR0A:10 a=COk6AnOGAAAA:8
 a=VwQbUJbxAAAA:8 a=cZ1y5YrqKnYO-lcvaXwA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ajao1Jnn7rZAIQCXWTuZsvkXWk7j/Z+TfVN0RYSP0wU=; b=pcYsISPEpb1XsR9h0DjQubZKyp
        o7tiByOzumhzWSjaNc/69UOljmCQD1wJa5Go6tX9aWp9twlNfAIFdtsKNKEhS2aJZG7NfZ6qTlkOW
        Rknzcs6/QYUrTIWs7VTw+QG6XSR86qZy0LZPW6KUFDyUlFCB+jnRTzuW9X2c5EG4pCPtXg6c0dmuN
        D/Yq/DIdbUZO+eQgllqVRKuM2iJBDoEPv+F01qkZ4fWbX2fE1i6LAr5Ff6gt6dzMF8TRk2eAAWB0L
        FeLPAsZzUWF0ouV2jS6IuoBJVaiHyz85ucq7KGpQUNr6w2ujnsPK1UXHxu9+h1CQ3B9GIyym2QXVs
        STGGsM4A==;
Received: from 187.184.157.122.cable.dyn.cableonline.com.mx ([187.184.157.122]:35864 helo=[192.168.0.9])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1r7ePC-003aet-1f;
        Mon, 27 Nov 2023 10:24:18 -0600
Message-ID: <99b98f17-3cb2-4658-b183-a0c9d6709d6f@embeddedor.com>
Date:   Mon, 27 Nov 2023 10:24:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] wifi: ath10k: Use DECLARE_FLEX_ARRAY() for
 ath10k_htc_record
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231127-flexarray-htc_record-v1-0-6be1f36126fd@quicinc.com>
 <20231127-flexarray-htc_record-v1-2-6be1f36126fd@quicinc.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231127-flexarray-htc_record-v1-2-6be1f36126fd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.184.157.122
X-Source-L: No
X-Exim-ID: 1r7ePC-003aet-1f
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187.184.157.122.cable.dyn.cableonline.com.mx ([192.168.0.9]) [187.184.157.122]:35864
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfF4CGBvFPUu/0C3fGHRdszfXKOyyDbsER9lg3FLXXi9fnuQb9DXPnF58TcGKoWgMLpnllpdS9OoM7EG8vPWdeT3FTy+NVT7Zr3Iiv9ZiwRJ1GLlOejXU
 53QW0zfeUwlDvuK3T9HbWxEL6+7v24kj5YlHIVwN9fEMKkLc11k3WWi6H9UIlD+QBrMh/DuQ/fSwMcPjNjuB4bLBHnSlUoSrdQEoStMjTVwoDcdatseE/jcR
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/23 10:14, Jeff Johnson wrote:
> Transform the zero-length arrays in ath10k_htc_record into proper
> flexible arrays via the DECLARE_FLEX_ARRAY() macro. This helps with
> ongoing efforts to globally enable -Warray-bounds.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>   drivers/net/wireless/ath/ath10k/htc.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/htc.h b/drivers/net/wireless/ath/ath10k/htc.h
> index 9cbb901d35e5..c6c392f8630c 100644
> --- a/drivers/net/wireless/ath/ath10k/htc.h
> +++ b/drivers/net/wireless/ath/ath10k/htc.h
> @@ -246,9 +246,9 @@ struct ath10k_htc_lookahead_bundle {
>   struct ath10k_htc_record {
>   	struct ath10k_ath10k_htc_record_hdr hdr;
>   	union {
> -		struct ath10k_htc_credit_report credit_report[0];
> -		struct ath10k_htc_lookahead_report lookahead_report[0];
> -		struct ath10k_htc_lookahead_bundle lookahead_bundle[0];
> +		DECLARE_FLEX_ARRAY(struct ath10k_htc_credit_report, credit_report);
> +		DECLARE_FLEX_ARRAY(struct ath10k_htc_lookahead_report, lookahead_report);
> +		DECLARE_FLEX_ARRAY(struct ath10k_htc_lookahead_bundle, lookahead_bundle);
>   	};
>   } __packed __aligned(4);
>   
> 
