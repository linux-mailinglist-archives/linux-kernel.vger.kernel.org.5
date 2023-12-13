Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967FD811FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbjLMURP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:17:14 -0500
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E7ADB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:17:20 -0800 (PST)
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
        by cmsmtp with ESMTPS
        id DT57rQKoSL9AgDVfUr2XH6; Wed, 13 Dec 2023 20:17:20 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id DVfTrHEr2M0U2DVfUrwGT9; Wed, 13 Dec 2023 20:17:20 +0000
X-Authority-Analysis: v=2.4 cv=BuKOfKb5 c=1 sm=1 tr=0 ts=657a1150
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=zq1JsgicG58flh9ZypQA:9 a=QEXdDO2ut3YA:10 a=phs4urI-Bf8A:10
 a=AjGcO6oz07-iQ99wixmX:22 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=egfqI6Be/HRfAvxJFdozcRY+cHCT1gxshiIRm0qO+vk=; b=YGdLgmpR4EdamO7f9efq6zMrQt
        AbMdZEQ1d5xNrO+efpMjxdOuqVfeH8oR8jPFvX1O0H5kFcC/0E7rECecsMd/Wk4wK+gW0sgDkXd8r
        WIvIaVSzRxetnw0/fIWOSt6CaqDkIn29FabqWyjRQ1yTVW51V4uzoM2iP/mWQIqnYzzoloASKtVMk
        f6Al2+tXS0J67AQS/3zTE5YSr116/jFibF3oyc8jhxRUguQCWiIsYn+k7tzdc96I6knAfHM5gFClk
        aWVVJ3vyL57avR5oODjcqsE9iTMxAl4GMDoWkT4ilLFMS6IBuXjfMs/hLISBKBB4CobbOq/WEtLTe
        CyHTeVvg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36860 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1rDVfT-003Rqk-0z;
        Wed, 13 Dec 2023 14:17:19 -0600
Message-ID: <708ed53c-181e-4149-b544-eaf0725d58fc@embeddedor.com>
Date:   Wed, 13 Dec 2023 14:17:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] wifi: ath10k: use flexible arrays for WMI start scan
 TLVs
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-2-92922d92fa2c@quicinc.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-2-92922d92fa2c@quicinc.com>
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
X-Exim-ID: 1rDVfT-003Rqk-0z
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:36860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPrgc2LXKNIh0HJnJkgSFyi/YfX8uSTfGLF+6WSXjMTmpVe2nxUsohnysiIiD5OrJHEDH3MfdOfcmoi6avLvbSTIgvrZSJWBfBicOs7rZh4QGS3woeDy
 a3f+dvhgA3mlTrvvaXD+3eXGn36pU3mHYzY+gScsbzDhVZu1oYRf2exxinMSyaW+pqm3Ha50x1JYdCoUnSmV6RVkEoQmy+S5INKW8j+llgVejxf1sIT1isks
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 11:06, Jeff Johnson wrote:
> Currently ath10k defines the following struct:
> 	struct wmi_start_scan_tlvs {
> 		u8 tlvs[0];
> 	} __packed;
> 
> Per the guidance in [1] this should be a flexible array. However, a
> direct replace to u8 tlvs[] results in the compilation error:
>         flexible array member in a struct with no named members
> 
> This is because C99 6.7.2.1 (16) requires that a structure containing
> a flexible array member must have more than one named member.
> 
> So rather than defining a separate struct wmi_start_scan_tlvs which
> contains the flexible tlvs[] array, just define the tlvs[] array where
> struct wmi_start_scan_tlvs is being used.
> 
> No functional changes, compile tested only.
> 
> [1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>   drivers/net/wireless/ath/ath10k/wmi.c |  8 ++++----
>   drivers/net/wireless/ath/ath10k/wmi.h | 11 ++---------
>   2 files changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
> index 88befe92f95d..4d5aadbc7159 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.c
> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
> @@ -6927,14 +6927,14 @@ void ath10k_wmi_put_start_scan_common(struct wmi_start_scan_common *cmn,
>   }
>   
>   static void
> -ath10k_wmi_put_start_scan_tlvs(struct wmi_start_scan_tlvs *tlvs,
> +ath10k_wmi_put_start_scan_tlvs(u8 *tlvs,
>   			       const struct wmi_start_scan_arg *arg)
>   {
>   	struct wmi_ie_data *ie;
>   	struct wmi_chan_list *channels;
>   	struct wmi_ssid_list *ssids;
>   	struct wmi_bssid_list *bssids;
> -	void *ptr = tlvs->tlvs;
> +	void *ptr = tlvs;
>   	int i;
>   
>   	if (arg->n_channels) {
> @@ -7012,7 +7012,7 @@ ath10k_wmi_op_gen_start_scan(struct ath10k *ar,
>   	cmd = (struct wmi_start_scan_cmd *)skb->data;
>   
>   	ath10k_wmi_put_start_scan_common(&cmd->common, arg);
> -	ath10k_wmi_put_start_scan_tlvs(&cmd->tlvs, arg);
> +	ath10k_wmi_put_start_scan_tlvs(cmd->tlvs, arg);
>   
>   	cmd->burst_duration_ms = __cpu_to_le32(0);
>   
> @@ -7041,7 +7041,7 @@ ath10k_wmi_10x_op_gen_start_scan(struct ath10k *ar,
>   	cmd = (struct wmi_10x_start_scan_cmd *)skb->data;
>   
>   	ath10k_wmi_put_start_scan_common(&cmd->common, arg);
> -	ath10k_wmi_put_start_scan_tlvs(&cmd->tlvs, arg);
> +	ath10k_wmi_put_start_scan_tlvs(cmd->tlvs, arg);
>   
>   	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi 10x start scan\n");
>   	return skb;
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
> index 833ce0251a2c..52a409ff94e7 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
> @@ -3218,23 +3218,16 @@ struct wmi_start_scan_common {
>   	__le32 scan_ctrl_flags;
>   } __packed;
>   
> -struct wmi_start_scan_tlvs {
> -	/* TLV parameters. These includes channel list, ssid list, bssid list,
> -	 * extra ies.
> -	 */
> -	u8 tlvs[0];
> -} __packed;
> -
>   struct wmi_start_scan_cmd {
>   	struct wmi_start_scan_common common;
>   	__le32 burst_duration_ms;
> -	struct wmi_start_scan_tlvs tlvs;
> +	u8 tlvs[];
>   } __packed;
>   
>   /* This is the definition from 10.X firmware branch */
>   struct wmi_10x_start_scan_cmd {
>   	struct wmi_start_scan_common common;
> -	struct wmi_start_scan_tlvs tlvs;
> +	u8 tlvs[];
>   } __packed;
>   
>   struct wmi_ssid_arg {
> 
