Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB407A0B69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 19:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239229AbjINRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239217AbjINRSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 13:18:54 -0400
Received: from omta38.uswest2.a.cloudfilter.net (omta38.uswest2.a.cloudfilter.net [35.89.44.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84681FE6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 10:18:49 -0700 (PDT)
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
        by cmsmtp with ESMTP
        id giInqcVGGQFHRgpzNqkMJ5; Thu, 14 Sep 2023 17:18:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id gpzMqU45IGC22gpzMqKKal; Thu, 14 Sep 2023 17:18:48 +0000
X-Authority-Analysis: v=2.4 cv=VNLOIvDX c=1 sm=1 tr=0 ts=65034079
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=VwQbUJbxAAAA:8
 a=DfNHnWVPAAAA:8 a=anKBZ9voxICiHcaguvcA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=rjTVMONInIDnV1a_A2c_:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=SpbGtZlfHa2aXlFwM4Mq2v6Rd5H4+ybNfEh7tydENP4=; b=VhI8S/jFowxp/xikWbla/xBwMp
        GEBcsFwpAF/ud20r9OjWu9cFvPetEksfHRHjktrenp9DMvsmTPBBiIxQm1Ol8T8RbbfCLQPW/pfhq
        fobo49xMhL0R2LagynwPdiLOdUJfJRyPObeawcWbs+8iSs2zJ6yKEI/dxdbYrV++e6qoXJjr3fGDA
        WHtkOCkg1SGQdqDhBiL4vwB+Az7UObqN0loSCA4QW1fwOmI7fBIMMkNuOeMZdR6jJWK0ub+9YOQTR
        yEE54WxFJaSNGfG3Iww2nPqSH6LbHd+9WzjRb+x1BvzvX84LfjJabOKS0q68WGTN8R4/wvO5vaJ/A
        u1DSwA2Q==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48748 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qgpzK-000Vfy-0q;
        Thu, 14 Sep 2023 12:18:46 -0500
Message-ID: <60903bfb-fe91-ed19-1d77-8fb44cef858c@embeddedor.com>
Date:   Thu, 14 Sep 2023 11:19:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] wifi: brcmfmac: Replace 1-element arrays with flexible
 arrays
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     SHA-cyfmac-dev-list@infineon.com, aspriel@gmail.com,
        brcm80211-dev-list.pdl@broadcom.com, franky.lin@broadcom.com,
        gustavoars@kernel.org, hante.meuleman@broadcom.com,
        hdegoede@redhat.com, keescook@chromium.org, kvalo@kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org, marcan@marcan.st,
        ryohei.kondo@cypress.com, stable@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
 <20230914070227.12028-1-juerg.haefliger@canonical.com>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230914070227.12028-1-juerg.haefliger@canonical.com>
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
X-Exim-ID: 1qgpzK-000Vfy-0q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:48748
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfITrqubb7J08VgxcoevTJlTvIT8eTryGR01HODs2llPG5ryqYVFIcX6xm9xMCCN6t0eOowpMKX6yNQK5J2aaveY+oA6HnCSMgkvlncXXayHFqWMIbZbK
 OEZOfX7GTCRJIPF//Bhf8sZi/K9GdxiO4C3eX412pa8nrjGiBNaL9Ljrx4RTedTbDFEXGeJKU3PQNzfjCGP5tWGN/oIMcaIcBECLYk3vq+KiDgiOWMQ3xK/5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/14/23 01:02, Juerg Haefliger wrote:
> Since commit 2d47c6956ab3 ("ubsan: Tighten UBSAN_BOUNDS on GCC"),
> UBSAN_BOUNDS no longer pretends 1-element arrays are unbounded. Walking
> 'element' and 'channel_list' will trigger warnings, so make them proper
> flexible arrays.
> 
> False positive warnings were:
> 
>    UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:6984:20
>    index 1 is out of range for type '__le32 [1]'
> 
>    UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:1126:27
>    index 1 is out of range for type '__le16 [1]'
> 
> for these lines of code:
> 
>    6884  ch.chspec = (u16)le32_to_cpu(list->element[i]);
> 
>    1126  params_le->channel_list[i] = cpu_to_le16(chanspec);
> 
> Cc: stable@vger.kernel.org # 6.5+
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> 
> ---
> v2:
>    - Use element[] instead of DFA() in brcmf_chanspec_list.
>    - Add Cc: stable tag
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/fwil_types.h    | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> index bece26741d3a..611d1a6aabb9 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> @@ -442,7 +442,12 @@ struct brcmf_scan_params_v2_le {
>   				 * fixed parameter portion is assumed, otherwise
>   				 * ssid in the fixed portion is ignored
>   				 */
> -	__le16 channel_list[1];	/* list of chanspecs */
> +	union {
> +		__le16 padding;	/* Reserve space for at least 1 entry for abort
> +				 * which uses an on stack brcmf_scan_params_v2_le
> +				 */
> +		DECLARE_FLEX_ARRAY(__le16, channel_list);	/* chanspecs */
> +	};
>   };
>   
>   struct brcmf_scan_results {
> @@ -702,7 +707,7 @@ struct brcmf_sta_info_le {
>   
>   struct brcmf_chanspec_list {
>   	__le32	count;		/* # of entries */
> -	__le32	element[1];	/* variable length uint32 list */
> +	__le32  element[];	/* variable length uint32 list */
>   };
>   
>   /*
