Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E78877D737
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240891AbjHPAvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240949AbjHPAvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:51:07 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A5982121
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 17:51:05 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id W0l6q2CO3DKaKW4kaqMHzW; Wed, 16 Aug 2023 00:51:04 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id W4kZqBC8kyB3AW4kZqHBMl; Wed, 16 Aug 2023 00:51:03 +0000
X-Authority-Analysis: v=2.4 cv=UZlC9YeN c=1 sm=1 tr=0 ts=64dc1d77
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=CGo6wCm4IADRok0f:21 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10
 a=z8Z5iky-Q3P00n-VfiYA:9 a=QEXdDO2ut3YA:10 a=tNK2v2ls7fuFGmW9SST8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:Subject
        :From:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ymVDh2vVYAFrzF7WLvlKXgvKijVcMrrqDbKZfN/hxtI=; b=pyiUu4GK8H7pB0uHxbs4Eevl0k
        Jot9BuhrT1A6Y3NQAcz81wAh/v/lLw6/ML2bX4kEHY/rAlzwFAT4z6RzN8zK3IeNlV/bf2i7y75KJ
        Ur3O/5KhgPvpGxP4HOnFgBbm6nCGblOdY5qSFX94Zsml0ITF974XKlyHtW2jB75kQwJ6DE8AryIXt
        r6lywhCLb6m1kmDULn19IrEHbBTN+yMHI+lRoyAJd8CKVwPlkzhncujHn/jIj4SPVg+K2e3+IIg55
        X2LVgTXHSq/ww3qYr6UFGLqWaEeZ5eY8kR06bSWSKNRqcCRKXN5eSo27OGYDIN0x/JOhTLPuRafRv
        FyAPYb7g==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:43022 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qW4kY-001ica-34;
        Tue, 15 Aug 2023 19:51:02 -0500
Message-ID: <6e3fddfe-2d31-72fa-ac2b-3b7fa4e6fe08@embeddedor.com>
Date:   Tue, 15 Aug 2023 18:52:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [RFC] wifi: mwifiex: Asking for some light on this, please :)
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
X-Exim-ID: 1qW4kY-001ica-34
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:43022
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE3tsdRnh+b6iGAKQnE7NvCVjyePUx2unbrwljjJoEkud5gl58xBMRI/V0EyDVbyARkT4lEoASG87yulnGyURdDRzzuUzFtjurcrQUN++7uhE7v2ELwW
 +Dac3iuT41g3/xXGONv/LhRkckN3Rg4oUqcoxMBOowgR0tVD5IjlgxoEe0vPo7CB/WmBFm6f6EsrDgh8+cESfgrdW/3shk22aAvSawEOB0uymGNjai1tncCk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While working on flex-array transformations I ran into the following
implementation:

drivers/net/wireless/marvell/mwifiex/fw.h:775:
struct mwifiex_ie_types_rxba_sync {
	struct mwifiex_ie_types_header header;
	u8 mac[ETH_ALEN];
	u8 tid;
	u8 reserved;
	__le16 seq_num;
	__le16 bitmap_len;
	u8 bitmap[1];
} __packed;

`bitmap` is currently being used as a fake-flex array and we should
transform it into a proper flexible-array member.

However, while doing that, I noticed something in the following function
that's not clear to me and I wanted to ask you for feedback:

drivers/net/wireless/marvell/mwifiex/11n_rxreorder.c:907:
void mwifiex_11n_rxba_sync_event(struct mwifiex_private *priv,
				 u8 *event_buf, u16 len)
{
	struct mwifiex_ie_types_rxba_sync *tlv_rxba = (void *)event_buf;
	u16 tlv_type, tlv_len;
	struct mwifiex_rx_reorder_tbl *rx_reor_tbl_ptr;
	u8 i, j;
	u16 seq_num, tlv_seq_num, tlv_bitmap_len;
	int tlv_buf_left = len;
	int ret;
	u8 *tmp;

	mwifiex_dbg_dump(priv->adapter, EVT_D, "RXBA_SYNC event:",
			 event_buf, len);
	while (tlv_buf_left >= sizeof(*tlv_rxba)) {
		tlv_type = le16_to_cpu(tlv_rxba->header.type);
		tlv_len  = le16_to_cpu(tlv_rxba->header.len);
		if (tlv_type != TLV_TYPE_RXBA_SYNC) {
			mwifiex_dbg(priv->adapter, ERROR,
				    "Wrong TLV id=0x%x\n", tlv_type);
			return;
		}

		tlv_seq_num = le16_to_cpu(tlv_rxba->seq_num);
		tlv_bitmap_len = le16_to_cpu(tlv_rxba->bitmap_len);
		mwifiex_dbg(priv->adapter, INFO,
			    "%pM tid=%d seq_num=%d bitmap_len=%d\n",
			    tlv_rxba->mac, tlv_rxba->tid, tlv_seq_num,
			    tlv_bitmap_len);

		rx_reor_tbl_ptr =
			mwifiex_11n_get_rx_reorder_tbl(priv, tlv_rxba->tid,
						       tlv_rxba->mac);
		if (!rx_reor_tbl_ptr) {
			mwifiex_dbg(priv->adapter, ERROR,
				    "Can not find rx_reorder_tbl!");
			return;
		}

		for (i = 0; i < tlv_bitmap_len; i++) {
			for (j = 0 ; j < 8; j++) {
				if (tlv_rxba->bitmap[i] & (1 << j)) {
					seq_num = (MAX_TID_VALUE - 1) &
						(tlv_seq_num + i * 8 + j);

					mwifiex_dbg(priv->adapter, ERROR,
						    "drop packet,seq=%d\n",
						    seq_num);

					ret = mwifiex_11n_rx_reorder_pkt
					(priv, seq_num, tlv_rxba->tid,
					 tlv_rxba->mac, 0, NULL);

					if (ret)
						mwifiex_dbg(priv->adapter,
							    ERROR,
							    "Fail to drop packet");
				}
			}
		}

		tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
		tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
		
What's the relation between tlv_len, sizeof(*tlv_rxba) and tlv_bitmap_len?

Isn't `sizeof(*tlv_rxba) + tlv_len` and `tlv_len + sizeof(*tlv_rxba)`
double-counting some fields in `struct mwifiex_ie_types_rxba_sync`?

Shouldn't this be something like this, instead (before the flex-array
transformation, of course):

-               tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_len);
-               tmp = (u8 *)tlv_rxba + tlv_len + sizeof(*tlv_rxba);
+               tlv_buf_left -= (sizeof(*tlv_rxba) + tlv_bitmap_len - 1);
+               tmp = (u8 *)tlv_rxba + tlv_bitmap_len + sizeof(*tlv_rxba - 1);


		tlv_rxba = (struct mwifiex_ie_types_rxba_sync *)tmp;
	}
}

Thanks in advance for any feedback!

--
Gustavo
