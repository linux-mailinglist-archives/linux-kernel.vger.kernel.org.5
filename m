Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208CC784A58
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 21:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjHVTXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 15:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjHVTXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:23:16 -0400
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5E8E7D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 12:22:54 -0700 (PDT)
Received: from eig-obgw-5001a.ext.cloudfilter.net ([10.0.29.139])
        by cmsmtp with ESMTP
        id YEgHqVB5SEoVsYWxfq75F9; Tue, 22 Aug 2023 19:22:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id YWxeqbbqEgfmkYWxfqPNHo; Tue, 22 Aug 2023 19:22:43 +0000
X-Authority-Analysis: v=2.4 cv=e/wV9Il/ c=1 sm=1 tr=0 ts=64e50b03
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=CGo6wCm4IADRok0f:21 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10
 a=OLL_FvSJAAAA:8 a=KglALiZi9yS_aej7KwsA:9 a=QEXdDO2ut3YA:10 a=_-8_qfib8kIA:10
 a=brCE4AJZ6IkA:10 a=oIrB72frpwYPwTMnlWqB:22 a=tNK2v2ls7fuFGmW9SST8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yTwFwQLON/mCOJCuD4xBpsbxIm/xROwU5APzBlzHzhQ=; b=btcbHZwh8ORAtplat9BcZlX++x
        /5+fnkFmJHhNW+7wPEP8vkT5Ok1o2LR0ZYGLflFlNc4u+OEB2qETt8dwwGLgpbhBA8uSaUc4hmwm4
        ApovrGgdcMweb0IL3Nkvuw2AUIhryYbJahrAb4zbk0YmAcr7dSd6pOPkmeXyy5L5R11NcB/lx/eUX
        IkkwIPo1bixl4yXpHfQyVO1MeYgXhOyRN4JXJFv/IRgoHgkFcI25+tuu6A7BKWBVBkpmL5+abQ+nH
        mLDClRZtoBkVk4bZyXbCRtl9SPMFx98CA+i5CNn+u5CmkW9Q+dGqsd3oTFritB2IkGk7RUXHP8LNL
        1DOhPx2g==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:52038 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qYWxe-003lKS-0I;
        Tue, 22 Aug 2023 14:22:42 -0500
Message-ID: <3837e9ad-4d3b-40ae-a2f8-a051973ca3e5@embeddedor.com>
Date:   Tue, 22 Aug 2023 13:23:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] wifi: mwifiex: Asking for some light on this, please :)
To:     Dan Williams <dcbw@redhat.com>,
        Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
References: <6e3fddfe-2d31-72fa-ac2b-3b7fa4e6fe08@embeddedor.com>
 <abc9d7abface4b9f651fc354ebaaf30ecf6e2783.camel@redhat.com>
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <abc9d7abface4b9f651fc354ebaaf30ecf6e2783.camel@redhat.com>
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
X-Exim-ID: 1qYWxe-003lKS-0I
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:52038
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfLz3rtuZ80DMnDlLqSWGBo85l0UGGFLRY8Qg+w57mqSePwxD52r+UJWzq499+dVq8afuGdWVec6uCRYJGeFtQ0oepXEvJCciH0kCyF+Ltk8QRTV/qea1
 Br5nAsRH2M2LkbAOsPTnrnRVZz8BfwW4z4xPHRd1Et9rieK9b3IBiOafx5360T9jBmP2vlyBAZvU6h/yK4pVKfikpIvgZwiF7Fi7pbI0SmVu64P4lCVc6SiJ
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

Thanks a lot for the feedback!

Please, see my comments below.

On 8/22/23 11:00, Dan Williams wrote:
> On Tue, 2023-08-15 at 18:52 -0600, Gustavo A. R. Silva wrote:
>> Hi all,
>>
>> While working on flex-array transformations I ran into the following
>> implementation:
>>
>> drivers/net/wireless/marvell/mwifiex/fw.h:775:
>> struct mwifiex_ie_types_rxba_sync {
>>          struct mwifiex_ie_types_header header;
>>          u8 mac[ETH_ALEN];
>>          u8 tid;
>>          u8 reserved;
>>          __le16 seq_num;
>>          __le16 bitmap_len;
>>          u8 bitmap[1];
>> } __packed;
>>
>> `bitmap` is currently being used as a fake-flex array and we should
>> transform it into a proper flexible-array member.
>>
>> However, while doing that, I noticed something in the following function
>> that's not clear to me and I wanted to ask you for feedback:
>>
>> drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:907:
>> void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
>>                                   u8 *event_buf, u16 len)
>> {
>>          struct mwifiex_ie_types_rxba_sync *tlv_rxba = (void *)event_buf;
>>          u16 tlv_type, tlv_len;
>>          struct mwifiex_rx_reorder_tbl *rx_reor_tbl_ptr;
>>          u8 i, j;
>>          u16 seq_num, tlv_seq_num, tlv_bitmap_len;
>>          int tlv_buf_left = len;
>>          int ret;
>>          u8 *tmp;
>>
>>          mwifiex_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
>>                           event_buf, len);
>>          while (tlv_buf_left >= sizeof(*tlv_rxba)) {
> 
>>                  tlv_type = le16_to_cpu(tlv_rxba->header.type);
>>                  tlv_len  = le16_to_cpu(tlv_rxba->header.len);
> 
>>                  if (tlv_type != TLV_TYPE_RXBA_SYNC) {
>>                          mwifiex_dbg(priv->adapter, ERROR,
>>                                      "Wrong TLV id=0x%x\n", tlv_type);
>>                          return;
>>                  }
>>
>>                  tlv_seq_num = le16_to_cpu(tlv_rxba->seq_num);
>>                  tlv_bitmap_len = le16_to_cpu(tlv_rxba->bitmap_len);
> 
> This seems superfluous since couldn't the bitmap_len be calculated from
> the tlv_len and sizeof(*tlv_rxba)? But whatever, sure.
> 
> Seems like there should be some input validation here to ensure that
> tlv_bitmap_len and tlv_len don't overrun event_buf's memory though, if
> the firmware is hosed or malicious.
> 
> But that's not your problem since you're not touching this code.
> 
>>                  mwifiex_dbg(priv->adapter, INFO,
>>                              "%pM tid=%d seq_num=%d bitmap_len=%d\n",
>>                              tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
>>                              tlv_bitmap_len);
>>
>>                  rx_reor_tbl_ptr =
>>                          mwifiex_11n_get_rx_reorder_tbl(priv, tlv_rxba->tid,
>>                                                         tlv_rxba->mac);
>>                  if (!rx_reor_tbl_ptr) {
>>                          mwifiex_dbg(priv->adapter, ERROR,
>>                                      "Can not find rx_reorder_tbl!");
>>                          return;
>>                  }
>>
>>                  for (i = 0; i < tlv_bitmap_len; i++) {
>>                          for (j = 0 ; j < 8; j++) {
>>                                  if (tlv_rxba->bitmap[i] & (1 << j)) {
>>                                          seq_num = (MAX_TID_VALUE - 1) &
>>                                                  (tlv_seq_num + i * 8 + j);
>>
>>                                          mwifiex_dbg(priv->adapter, ERROR,
>>                                                      "drop packet,seq=%d\n",
>>                                                      seq_num);
>>
>>                                          ret = mwifiex_11n_rx_reorder_pkt
>>                                          (priv, seq_num, tlv_rxba->tid,
>>                                           tlv_rxba->mac, 0, NULL);
>>
>>                                          if (ret)
>>                                                  mwifiex_dbg(priv->adapter,
>>                                                              ERROR,
>>                                                              "Fail to drop packet");
>>                                  }
>>                          }
>>                  }
>>
>>                  tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
> 
> Now we have to subtract the size of the whole TLV (including the header
> and flexarray) from the remaining bytes in event_buf.
> 
> But this looks pretty sketchy. Marvell TLVs have a header (the TL of
> the TLV) and header->len says how long the V is. Most Marvell kernel
> driver code (mwifiex, libertas, etc) does something like this:
> 
> 	pos += ssid_tlv->header + ssid_tlv->header.len;
> 
> but tlv_rxba is much more than just the header; I think this code is
> going to *over* count how many bytes were just consumed.
> 
> I'm not the only one thinking it's sketchy:
> 
> https://www.spinics.net/lists/linux-wireless/msg174231.html
> 
>>                  tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
>>                  
>> What's the relation between tlv_len, sizeof(*tlv_rxba) and tlv_bitmap_len?
>>
>> Isn't `sizeof(*tlv_rxba) + tlv_len` and `tlv_len + sizeof(*tlv_rxba)`
>> double-counting some fields in `struct mwifiex_ie_types_rxba_sync`?

OK. So, based on your feedback, it seems that my assumptions were correct.

So, first I'll send the following fix:

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 391793a16adc..9eade3aa2918 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -965,8 +965,8 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
                         }
                 }

-               tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
-               tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
+               tlv_buf_left -= (sizeof(tlv_rxba->header) + tlv_len);
+               tmp = (u8 *)tlv_rxba + tlv_len + sizeof(tlv_rxba->header);
                 tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;
         }
  }

Then, I'll do the flex-array transformation on top of the fix above:

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index 9eade3aa2918..cb5a399cd56a 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -918,7 +918,7 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,

         mwifiex_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
                          event_buf, len);
-       while (tlv_buf_left >= sizeof(*tlv_rxba)) {
+       while (tlv_buf_left > sizeof(*tlv_rxba)) {
                 tlv_type = le16_to_cpu(tlv_rxba->header.type);
                 tlv_len  = le16_to_cpu(tlv_rxba->header.len);
                 if (tlv_type != TLV_TYPE_RXBA_SYNC) {
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index f2168fac95ed..8e6db904e5b2 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -779,7 +779,7 @@ struct mwifiex_ie_types_rxba_sync {
         u8 reserved;
         __le16 seq_num;
         __le16 bitmap_len;
-       u8 bitmap[1];
+       u8 bitmap[];
  } __packed;

  struct chan_band_param_set {

This happilly results in no binary output differences before/after changes. :)

Finally, to top it off, I can send this sanity check:

diff --git a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
index cb5a399cd56a..237d0ee3573f 100644
--- a/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
+++ b/drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c
@@ -929,6 +929,13 @@ void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,

                 tlv_seq_num = le16_to_cpu(tlv_rxba->seq_num);
                 tlv_bitmap_len = le16_to_cpu(tlv_rxba->bitmap_len);
+               if (sizeof(*tlv_rxba) + tlv_bitmap_len > tlv_buf_left) {
+                      mwifiex_dbg(priv->adapter, ERROR,
+                                   "TLV size (%ld) overflows event_buf (%d)\n",
+                                  sizeof(*tlv_rxba) + tlv_bitmap_len,
+                                  tlv_buf_left);
+                       return;
+               }
                 mwifiex_dbg(priv->adapter, INFO,
                             "%pM tid=%d seq_num=%d bitmap_len=%d\n",
                             tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,

I wanted to used `sizeof(*tlv_rxba) + tlv_bitmap_len` here instead of
`sizeof(tlv_rxba->header) + tlv_len` to avoid any issues in case there
is any (buggy) discrepancy between `tlv_len` and `tlv_bitmap_len`.
This is when for some (weird) reason
	`tlv_len - (sizeof(*tlv_rxba) - sizeof(tlv_rxba->header)) != tlv_bitmap_len`

What do you think?

Thanks!
--
Gustavo


>>
>> Shouldn't this be something like this, instead (before the flex-array
>> transformation, of course):
>>
>> -               tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
>> -               tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
>> +               tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_bitmap_len - 1);
>> +               tmp = (u8 *)tlv_rxba + tlv_bitmap_len + sizeof(*tlv_rxba - 1);
> 
> If my assertion about tlv->header.len is correct then we can do:
> 
> tlv_buf_left -= sizeof(tlv_rxba->header) + tlv_len;
> tmp = (u8 *)tlv_rxba + sizeof(tlv_rxba->header) + tlv_len;
> 
>>
>>
>>                  tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;
> 
> This is silly; instead of tmp we could do:
> 
> u16 bytes_used;
> 
> ...
> 
> bytes_used = sizeof(tlv_rxba->header) + tlv_len;
> tlv_buf_left -= bytes_used;
> tlv_rxba += bytes_used;
> 
> (with appropriate casting).
> 
> Dan
> 
>>          }
>> }
>>
>> Thanks in advance for any feedback!
>>
>> --
>> Gustavo
>>
> 
