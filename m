Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08913811FD2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbjLMUTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbjLMUTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:19:39 -0500
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F16BF5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:19:45 -0800 (PST)
Received: from eig-obgw-5002a.ext.cloudfilter.net ([10.0.29.215])
        by cmsmtp with ESMTPS
        id DSgPrMfNOjtZ3DVhyrt95W; Wed, 13 Dec 2023 20:19:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id DVhor1LTuRQmiDVhorAtHU; Wed, 13 Dec 2023 20:19:45 +0000
X-Authority-Analysis: v=2.4 cv=CdcbWZnl c=1 sm=1 tr=0 ts=657a11e1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=_Wotqz80AAAA:8 a=COk6AnOGAAAA:8 a=1Esk1x17uEsZNe3dHhQA:9 a=QEXdDO2ut3YA:10
 a=phs4urI-Bf8A:10 a=AjGcO6oz07-iQ99wixmX:22 a=buJP51TR1BpY-zbLSsyS:22
 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=98lukoNBw6fhWNDa2SxpMcydjo1sjKiYLT9wVXM3PxE=; b=tm6zPjg1Djc4DWouBDS8NxqlFl
        +MTPv0p8Ypf3qJyaUufJApz7iOB3u+VyBzoojFmt/Tfrikqe6Ira0WeJ9Zv3w16hPDVHuXyNzsEbR
        /j3+nbLr2zsgDph8Cjo6kfEfr8qaRgrz8rvZn/92qiSWVvMqqNYp8QmaNceHD4BpBhDCOT6SvIkNH
        kHQac7WZsHpalfetvivcbjDJWK2x16vtBmFEGzpt0gvSU0pyG+ylxEEMX50Vt6TATJoncz9ylhAfW
        mrYrB0trAeJcxi/9VF1KlDzLrh1Ul4kI9HHMoL3zagfUAWIcDkNYfTWTSgIR27JLDgsCG2MijIivk
        k/bJv5WA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36860 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1rDVhn-003Rqk-2r;
        Wed, 13 Dec 2023 14:19:43 -0600
Message-ID: <a015d185-ece0-4608-821d-061d1296d4e7@embeddedor.com>
Date:   Wed, 13 Dec 2023 14:19:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] wifi: ath10k: use flexible array in struct
 wmi_tdls_peer_capabilities
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-5-92922d92fa2c@quicinc.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-5-92922d92fa2c@quicinc.com>
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
X-Exim-ID: 1rDVhn-003Rqk-2r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:36860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfKkKIu6yKz4i99vPfE15QIOm98Iei9ne84nNoJ4u2FRtPjtxcdwb+AkhOcVAVigQGUT8Spw3VGN2LDR4rlJHHJsjL0Q5JO2u60/6cC+UBNyxh3RiaLxc
 hikXfEa2mxBk4K/R14u6GodnYY3HMh61RoMc7VsID+7g8EZjV46wrGYS8tQsQoAYZyo8hUMBL7XxgJp5OROXRRNvq/KnrR3zPtPR/IWC1cEsyCXrcnI3N0CV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 11:06, Jeff Johnson wrote:
> Currently struct wmi_tdls_peer_capabilities defines:
> 	struct wmi_channel peer_chan_list[1];
> 
> Per the guidance in [1] this should be a flexible array, and at one
> point Gustavo was trying to fix this [2], but had questions about the
> correct behavior when the associated peer_chan_len is 0.
> 
> I have been unable to determine if firmware requires that at least one
> record be present even if peer_chan_len is 0. But since that is the
> current behavior, follow the example from [3] and replace the
> one-element array with a union that contains both a flexible array and
> a single instance of the array element. This results in a struct that
> has the same footprint as the original, so no other driver changes are
> required.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> [2] https://lore.kernel.org/linux-wireless/626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com/
> [3] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/net/wireless/ath/ath10k/wmi.h | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
> index e16410e348ca..b64b6e214bae 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
> @@ -7162,7 +7162,13 @@ struct wmi_tdls_peer_capabilities {
>   	__le32 is_peer_responder;
>   	__le32 pref_offchan_num;
>   	__le32 pref_offchan_bw;
> -	struct wmi_channel peer_chan_list[1];
> +	union {
> +		/* to match legacy implementation allocate room for
> +		 * at least one record even if peer_chan_len is 0
> +		 */
> +		struct wmi_channel peer_chan_min_allocation;
> +		DECLARE_FLEX_ARRAY(struct wmi_channel, peer_chan_list);
> +	};
>   } __packed;
>   
>   struct wmi_10_4_tdls_peer_update_cmd {
> 
