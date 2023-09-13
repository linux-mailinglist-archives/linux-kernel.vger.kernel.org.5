Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE1279EDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjIMQB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjIMQBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:01:55 -0400
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1313790
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:01:50 -0700 (PDT)
Received: from eig-obgw-6006a.ext.cloudfilter.net ([10.0.30.182])
        by cmsmtp with ESMTP
        id g8PCqF7WOyYOwgSJJqdHNS; Wed, 13 Sep 2023 16:01:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id gSJIqiZj9fOE6gSJJqdXy4; Wed, 13 Sep 2023 16:01:49 +0000
X-Authority-Analysis: v=2.4 cv=Od+LszfY c=1 sm=1 tr=0 ts=6501dced
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10 a=DfNHnWVPAAAA:8
 a=anKBZ9voxICiHcaguvcA:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=R837XQEgWoCavH2lMvfa99lqFuQSwQUEWgTQ96SgsPs=; b=MtlZDsH3OMzoszs7u5ZRDLgaCn
        8fwpn3tyX+48w4vwHJ044zrS6ZwzCqnIiDNSuF9XYbSatiVrxiUWwJ93QEU6NBSpMN6RJtB3NpOrs
        1lBnnhXd2hoS8qZa5mLIRlYBcDjGje5OpgnrImtiXCgxMINo/NO2h2gE8bU6+zE+OU4HNGsAoABUz
        Z4nXWa3OTZy34XpZQVUnPTrwNIaB6pT/w3qdplNK13z19G6I8I+dCU2rzTdQC6zyDhl9sIYhzzyxh
        TdEnqWCk/XsbF/Q+8tyy/y6Rn3qvow8RHOnI9m/tx5WPxwRUXJ+BNJKzh9PFUrnmBGKjzEE0ucQOU
        OflkQp6A==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:36608 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qgSJH-000RUx-2w;
        Wed, 13 Sep 2023 11:01:47 -0500
Message-ID: <0f23e4a2-b11b-98bd-c419-d9a9fb7ddb4e@embeddedor.com>
Date:   Wed, 13 Sep 2023 10:02:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] wifi: brcmfmac: Replace 1-element arrays with flexible
 arrays
To:     Juerg Haefliger <juerg.haefliger@canonical.com>, aspriel@gmail.com,
        franky.lin@broadcom.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com
Cc:     linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        marcan@marcan.st, keescook@chromium.org, gustavoars@kernel.org,
        hdegoede@redhat.com, ryohei.kondo@cypress.com
References: <20230913065421.12615-1-juerg.haefliger@canonical.com>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230913065421.12615-1-juerg.haefliger@canonical.com>
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
X-Exim-ID: 1qgSJH-000RUx-2w
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:36608
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfMeizZlYGEMFXvufvaSZiBmaxZI7oImMjOEJEOIBRlVw/ICvqehxqnsF7lc3w3a/H/dBuavrS7J7DQpbf5PCXDcx9JPGoducihVzjnKF8JUgKBQQELCm
 mA9GxdYDxNw6WRccnAMQ/pl/vo0zI8Z1RpyRthBv1TlQ3M+ehSnVzj8t0ftLZsjeaaVgCy5LXchFDRQ4HwRKGMq8Zy0QNyyrsPNGwb7KZjaBvQLF6Q7z3dzD
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/13/23 00:54, Juerg Haefliger wrote:
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
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/fwil_types.h    | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> index bece26741d3a..ed723a5b5d54 100644
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
> +	DECLARE_FLEX_ARRAY(__le32, element);	/* variable length uint32 list */

If no padding is needed, as in the other case, then DFA() is not necessary.
Just remove the 1 from the array declaration:

  struct brcmf_chanspec_list {
         __le32  count;          /* # of entries */
-       __le32  element[1];     /* variable length uint32 list */
+       __le32  element[];      /* variable length uint32 list */
  };

--
Gustavo

>   };
>   
>   /*
