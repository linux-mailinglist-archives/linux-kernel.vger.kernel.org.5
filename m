Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FCF7AB699
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjIVQ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIVQ6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:58:30 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4CB194
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:58:23 -0700 (PDT)
Received: from eig-obgw-6010a.ext.cloudfilter.net ([10.0.30.248])
        by cmsmtp with ESMTP
        id jjIGqYCrEDKaKjjTzqD3JM; Fri, 22 Sep 2023 16:58:23 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id jjTyq4hsVySCujjTyqOZyt; Fri, 22 Sep 2023 16:58:22 +0000
X-Authority-Analysis: v=2.4 cv=ea8uwpIH c=1 sm=1 tr=0 ts=650dc7ae
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=P7XfKmiOJ4/qXqHZrN7ymg==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=82YB-BmEshB4s5qE:21 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=wYkD_t78qR0A:10
 a=M5GUcnROAAAA:8 a=jZVsG21pAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=QyXUC8HyAAAA:8 a=cm27Pg_UAAAA:8
 a=JPoDtM7TZ6yJWmQF7qYA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22
 a=3Sh2lD0sZASs_lUdrUhf:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=AjGcO6oz07-iQ99wixmX:22
 a=xmb-EsYY8bH0VWELuYED:22 a=QbVwxleSvN6QbbUpbDEe:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OFRJLSn67ylmUTDesqnwR89r8xipKnIGHe/ry8CSlXk=; b=HbLP1eegN06YX5GDIsBoF0TU0H
        cl2eMr0D7OYH+lFQXEZQMW7UVNXdh6ShvGci2bt6xeHph6Wuo05Kv1L3HcBkbZ1VeLc/4nBVy/WIS
        uAgWkfv4PYAMMsGnJuGjmTZAFgBU3R16zl9uD/WsSaATzgrtXX6wCqUkdJTHUiky9/NP9dGWrf/GA
        5OdEfFsceqPWo2jxX5P0zVxExXiYVBbJtBRxjEaoREJ1LbLasVmvBgTmVXqlVivoDt2YKKWb8f/QH
        LaHq95/KscNTOVelKeG/st5RCugAQ6rOknbXzdGwqEpNkbZDbFpQKf7rM6AM/6OuzxEBcE5hUP0N9
        69IAWJWw==;
Received: from [94.239.20.48] (port=48068 helo=[192.168.1.98])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qjjTw-003SsD-0v;
        Fri, 22 Sep 2023 11:58:20 -0500
Message-ID: <1c639919-342a-cccc-1cad-772455b72656@embeddedor.com>
Date:   Fri, 22 Sep 2023 18:59:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] sky2: Make sure there is at least one frag_addr
 available
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        Mirko Lindner <mlindner@marvell.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230922165036.gonna.464-kees@kernel.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20230922165036.gonna.464-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 94.239.20.48
X-Source-L: No
X-Exim-ID: 1qjjTw-003SsD-0v
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.1.98]) [94.239.20.48]:48068
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfDIxqmK3lWK8wL1rRRtBLpGbi9Q58Y/HFNyAnwCMv1GFB0u5OIfxHbgFBaEkaYJwwM5Ls6SwRbe7OFHzjietRnF4r0W2alaG4GfvAnegQ27fGEBgxezW
 IQLOPKD2d6bJwJHBBHTbxgm9ZheV1wAePnxJnDqqa2uA1hhAJsHyWMgfeZvSFQBOU4IrNGXfbDm9uI0VeIv/+70+dCu8bQvnVLZzvIGmCYa4cLyAvfB42AgV
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/22/23 10:50, Kees Cook wrote:
> In the pathological case of building sky2 with 16k PAGE_SIZE, the
> frag_addr[] array would never be used, so the original code was correct
> that size should be 0. But the compiler now gets upset with 0 size arrays
> in places where it hasn't eliminated the code that might access such an
> array (it can't figure out that in this case an rx skb with fragments
> would never be created). To keep the compiler happy, make sure there is
> at least 1 frag_addr in struct rx_ring_info:
> 
>     In file included from include/linux/skbuff.h:28,
>                      from include/net/net_namespace.h:43,
>                      from include/linux/netdevice.h:38,
>                      from drivers/net/ethernet/marvell/sky2.c:18:
>     drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':
>     include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
>       416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
>           |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
>      1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
>           |                 ^~~~~~~~~~~~~~
>     In file included from drivers/net/ethernet/marvell/sky2.c:41:
>     drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
>      2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
>           |                         ^~~~~~~~~
> 
> With CONFIG_PAGE_SIZE_16KB=y, PAGE_SHIFT == 14, so:
> 
>    #define ETH_JUMBO_MTU   9000
> 
> causes "ETH_JUMBO_MTU >> PAGE_SHIFT" to be 0. Use "?: 1" to solve this build warning.
> 
> Cc: Mirko Lindner <mlindner@marvell.com>
> Cc: Stephen Hemminger <stephen@networkplumber.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: netdev@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/
> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
> v2 - improve commit message, add Ack
> v1 - https://lore.kernel.org/netdev/20230920202509.never.299-kees@kernel.org/
> ---
>   drivers/net/ethernet/marvell/sky2.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/sky2.h b/drivers/net/ethernet/marvell/sky2.h
> index ddec1627f1a7..8d0bacf4e49c 100644
> --- a/drivers/net/ethernet/marvell/sky2.h
> +++ b/drivers/net/ethernet/marvell/sky2.h
> @@ -2195,7 +2195,7 @@ struct rx_ring_info {
>   	struct sk_buff	*skb;
>   	dma_addr_t	data_addr;
>   	DEFINE_DMA_UNMAP_LEN(data_size);
> -	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
> +	dma_addr_t	frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT ?: 1];
>   };
>   
>   enum flow_control {
