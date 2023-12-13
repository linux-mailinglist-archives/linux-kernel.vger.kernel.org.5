Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9CC811FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 21:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233922AbjLMUTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 15:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjLMUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 15:19:05 -0500
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623C6DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 12:19:12 -0800 (PST)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
        by cmsmtp with ESMTPS
        id DV6prKhu58HteDVhIrdo5B; Wed, 13 Dec 2023 20:19:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id DVhGrhPVz0xkrDVhHrclZ0; Wed, 13 Dec 2023 20:19:11 +0000
X-Authority-Analysis: v=2.4 cv=N7U6qkxB c=1 sm=1 tr=0 ts=657a11bf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=e2cXIFwxEfEA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=djptEZvh-aCtj6NnK-4A:9 a=QEXdDO2ut3YA:10 a=phs4urI-Bf8A:10
 a=AjGcO6oz07-iQ99wixmX:22 a=TjNXssC_j7lpFel5tvFf:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MNKjR+nK7XAlYd1Revlfq3lvgfnQG7K4VqUh9Q42Zkw=; b=i/zlG+7rBUFg3HiC7AaC7BkSrL
        dvm5MV6SWrR+n6B3+30hllQlXABFs7tFcC+Sy9F/MPR/yfYoZSQqYusra36mx79NX4DA+ZGdppozY
        YhUJMZaLqOHGlSx9mEKj4LiIAXkU8q90l9/MeSf1y3mH5OfufR1kra60xIFdpJY1DzYf47RaGhTqa
        q07ctrvqI9sL++WtDAf1euCA5Sn7yierFNfNjJH6GL3L5Qd50jxsYhGFnNwLZVSK6MtG2qTIOE5B7
        hwW0p/Z4Ibqpb8fSLP+eyIkWNAqvdtkcJc3UiAeRUVW5e4gRLvv/pkta7MNkgLhL8QG9RS1cCIbbl
        Ps+3TrUA==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36860 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1rDVhG-003Rqk-1B;
        Wed, 13 Dec 2023 14:19:10 -0600
Message-ID: <2741782c-48b1-474f-bb89-97a7a6358ed6@embeddedor.com>
Date:   Wed, 13 Dec 2023 14:19:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] wifi: ath10k: remove unused template structs
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
 <20231213-wmi_host_mem_chunks_flexarray-v1-4-92922d92fa2c@quicinc.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-4-92922d92fa2c@quicinc.com>
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
X-Exim-ID: 1rDVhG-003Rqk-1B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:36860
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPv6zdqawhzzpSXBxDIXHn8VnRBRPwHX8r5q0Yu7WHzsDBIDuTWXrFNlCOLrizbONlmrH9V3qxzOKPblVSkZctigd4SIme1cOzA81pYjlmns401p51uP
 PiERYlXZf34kO8a9yVfiQg5WW8H8s3TNCuC2RTfd481yZBQatYgOsU3USkrY+qxwaQbShLfnA0X8pJpCsswYSUIoWHz871dLh4RVgqzOJHJ/BiGxcWPZmxbP
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
> Currently both the wmi_bcn_tmpl_cmd and wmi_prb_tmpl_cmd structs
> define:
> 	  u8 data[1];
> 
> Per the guidance in [1] both instances of this should be flexible
> arrays. However during conversion it was discovered that neither of
> these structs are actually used, so just remove them.
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
>   drivers/net/wireless/ath/ath10k/wmi.h | 24 ------------------------
>   1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
> index 37a7d421bd86..e16410e348ca 100644
> --- a/drivers/net/wireless/ath/ath10k/wmi.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi.h
> @@ -5782,30 +5782,6 @@ struct wmi_bcn_prb_info {
>   	/* app IE */
>   } __packed;
>   
> -struct wmi_bcn_tmpl_cmd {
> -	/* unique id identifying the VDEV, generated by the caller */
> -	__le32 vdev_id;
> -	/* TIM IE offset from the beginning of the template. */
> -	__le32 tim_ie_offset;
> -	/* beacon probe capabilities and IEs */
> -	struct wmi_bcn_prb_info bcn_prb_info;
> -	/* beacon buffer length */
> -	__le32 buf_len;
> -	/* variable length data */
> -	u8 data[1];
> -} __packed;
> -
> -struct wmi_prb_tmpl_cmd {
> -	/* unique id identifying the VDEV, generated by the caller */
> -	__le32 vdev_id;
> -	/* beacon probe capabilities and IEs */
> -	struct wmi_bcn_prb_info bcn_prb_info;
> -	/* beacon buffer length */
> -	__le32 buf_len;
> -	/* Variable length data */
> -	u8 data[1];
> -} __packed;
> -
>   enum wmi_sta_ps_mode {
>   	/* enable power save for the given STA VDEV */
>   	WMI_STA_PS_MODE_DISABLED = 0,
> 
