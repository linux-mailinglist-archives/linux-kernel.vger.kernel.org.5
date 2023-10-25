Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE217D5F56
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjJYBHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjJYBHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:07:05 -0400
Received: from omta034.useast.a.cloudfilter.net (omta034.useast.a.cloudfilter.net [44.202.169.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7218D7D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:07:02 -0700 (PDT)
Received: from eig-obgw-6009a.ext.cloudfilter.net ([10.0.30.184])
        by cmsmtp with ESMTPS
        id vLipqHLNmjtZ3vSMQqsYsC; Wed, 25 Oct 2023 01:07:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id vSMOqrMS4Ok5SvSMOqza4j; Wed, 25 Oct 2023 01:07:01 +0000
X-Authority-Analysis: v=2.4 cv=E+DeGIRl c=1 sm=1 tr=0 ts=65386a35
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=_mNlVl-r0hj7kTaC:21 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10
 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8 a=_Wotqz80AAAA:8 a=jR2mby-O1imw8BYHV3QA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=pIW3pCRaVxJDc-hWtpF8:22
 a=buJP51TR1BpY-zbLSsyS:22 a=N_l3Vs37sht3-TxgB6J7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jgueludWkZgknBALxo52tKnH1XcORBXqsInq+hMs+AA=; b=cVl4Aqq/QtjRsb9reVAKMjUA4b
        JxcileGUcoYCD5yZH1ZltbFYWLZHYo+EiooYvbdsktidvQqdNwWQxu9GLFzQd2VSKbGU5AO3TmHSa
        0OMAd7+7NRrRfcS+bDX/+jUSSb/MwVrTH7jQNRZCKEa/SXldSeJ1/H0BLtvEgyR7JGGVQ4YWnCWCJ
        klr2NqBRUoy6vu/GSdrXewRjfTA4ifuHKV8sCelFrzmJateexgzbTw2y8/NTSAg+RwXQbR7Hynmpl
        CyeTj6OFXGqO0PAeDC74NNODEmtLVuOiCgW7m4vZ6BeLDuPKEO6AxLmQ4HiVIRSFEreVNdZ2UUsiW
        zXMsqVgg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48400 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qvSMO-001oyw-0H;
        Tue, 24 Oct 2023 20:07:00 -0500
Message-ID: <e19b9dcc-99d0-414d-95ef-69149daedaa9@embeddedor.com>
Date:   Tue, 24 Oct 2023 19:06:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC - is this a bug?] wifi: ath10k: Asking for some light on
 this, please :)
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
References: <626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com>
In-Reply-To: <626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qvSMO-001oyw-0H
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:48400
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNtuwLBPl6wmdNH6KS5nH2RSUT9ofJUgI5XpvomS4hy6siAYd00MFr4PNgNO37EOFxE42FYnKrJMVsHRkdFUXNFSSxyd7GgMNzIjAJjHQdagy/B5RsSG
 khXEJBQKhHs+XhAhTpan/ZkX3Jd+sqfsbsgLwZasqjivJVzC7V6+BtPQnsrt/AcE9nLkGDZihdR56JgpO1Gm5BzYNYc6+hQbGM96aSKDdYFO7w3SmS7pumgG
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+CC Manikanta Pubbisetty ]

As Johannes[1] pointed out, this `memset()` is probably unnecessary:

./drivers/net/wireless/ath/ath10k/wmi.c:
8920         memset(skb->data, 0, sizeof(*cmd));

However, the same exact issue[2] is present at the line below inside
function `ath10k_wmi_alloc_skb()`:

drivers/net/wireless/ath/ath10k/wmi.c:
1799         memset(skb->data, 0, round_len);


Thanks
--
Gustavo

[1] https://lore.kernel.org/linux-hardening/26b15f4702cef17fe70b496a62f03735874bd16a.camel@sipsolutions.net/
[2] https://lore.kernel.org/linux-hardening/07e9bb04-f9fc-46d5-bfb9-a00a63a707c0@embeddedor.com/

On 10/24/23 13:50, Gustavo A. R. Silva wrote:
> Hi all,
> 
> While working on tranforming one-element array `peer_chan_list` in
> `struct wmi_tdls_peer_capabilities` into a flex-array member
> 
> 7187 struct wmi_tdls_peer_capabilities {
> ...
> 7199         struct wmi_channel peer_chan_list[1];
> 7200 } __packed;
> 
> the following line caught my attention:
> 
> ./drivers/net/wireless/ath/ath10k/wmi.c:
> 8920         memset(skb->data, 0, sizeof(*cmd));
> 
> Notice that before the flex-array transformation, we are zeroing 128
> bytes in `skb->data` because `sizeof(*cmd) == 128`, see below:
> 
> $ pahole -C wmi_10_4_tdls_peer_update_cmd drivers/net/wireless/ath/ath10k/wmi.o
> struct wmi_10_4_tdls_peer_update_cmd {
>      __le32                     vdev_id;              /*     0     4 */
>      struct wmi_mac_addr        peer_macaddr;         /*     4     8 */
>      __le32                     peer_state;           /*    12     4 */
>      __le32                     reserved[4];          /*    16    16 */
>      struct wmi_tdls_peer_capabilities peer_capab;    /*    32    96 */
> 
>      /* size: 128, cachelines: 2, members: 5 */
> };
> 
> So, after the flex-array transformation (and the necessary adjustments
> to a few other lines of code) we would be zeroing 104 bytes in
> `skb->data` because `sizeof(*cmd) == 104`, see below:
> 
> $ pahole -C wmi_10_4_tdls_peer_update_cmd drivers/net/wireless/ath/ath10k/wmi.o
> struct wmi_10_4_tdls_peer_update_cmd {
>      __le32                     vdev_id;              /*     0     4 */
>      struct wmi_mac_addr        peer_macaddr;         /*     4     8 */
>      __le32                     peer_state;           /*    12     4 */
>      __le32                     reserved[4];          /*    16    16 */
>      struct wmi_tdls_peer_capabilities peer_capab;    /*    32    72 */
> 
>      /* size: 104, cachelines: 2, members: 5 */
>      /* last cacheline: 40 bytes */
> };
> 
> This difference arises because the size of the element type for the
> `peer_chan_list` array, which is `sizeof(struct wmi_channel) == 24 `
> 
> $ pahole -C wmi_channel drivers/net/wireless/ath/ath10k/wmi.o
> struct wmi_channel {
>      __le32                     mhz;                  /*     0     4 */
>      __le32                     band_center_freq1;    /*     4     4 */
>      __le32                     band_center_freq2;    /*     8     4 */
> 
> [..]
>                                                 /*    20     4 */
> 
>      /* size: 24, cachelines: 1, members: 6 */
>      /* last cacheline: 24 bytes */
> };
> 
> is included in `sizeof(*cmd)` before the transformation.
> 
> So, my question is: do we really need to zero out those extra 24 bytes in
> `skb->data`? or is it rather a bug in the original code?
> 
> Thanks!
> -- 
> Gustavo
> 
> 
