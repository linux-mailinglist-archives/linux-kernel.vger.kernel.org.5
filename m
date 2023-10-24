Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634867D5BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 21:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344251AbjJXTul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbjJXTuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 15:50:39 -0400
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F410C6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 12:50:37 -0700 (PDT)
Received: from eig-obgw-6007a.ext.cloudfilter.net ([10.0.30.247])
        by cmsmtp with ESMTPS
        id vLJuqY461L9AgvNQCq02rn; Tue, 24 Oct 2023 19:50:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id vNQBq6qG05ZLUvNQCqBzbC; Tue, 24 Oct 2023 19:50:36 +0000
X-Authority-Analysis: v=2.4 cv=S57KfagP c=1 sm=1 tr=0 ts=6538200c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=_mNlVl-r0hj7kTaC:21 a=IkcTkHD0fZMA:10 a=bhdUkHdE2iEA:10 a=wYkD_t78qR0A:10
 a=uwMjjtW2jUbwP7mzfGYA:9 a=QEXdDO2ut3YA:10 a=N_l3Vs37sht3-TxgB6J7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:Cc:To:
        Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=g54kz6I2OxMrqzBsVAyW+xfzdHVn9xE3lpEyC5lhvJs=; b=OzZcSIgm+yEGFVLC3R0m8HijPQ
        lhLIjWcJvlYi/ttwdT02zDdt8r9JXRcveNlKlsLuW9I7KEx90YSSUkyBAJxIasNaoBw5eXEBqryHR
        TEfhawSfU7CSH/BkMqiMQyhXqNl3Fs58s+/XfkacYUo82q8kdpPPOM216HjPlf0GtmJqbFruaT5fA
        mznRgRxTTfbSlBfcUdwb5pu6XgiDLRHx80NEsNF0uQF9GT1UA8/CP4SAcN926YU7vwzs0IYOE5kaz
        qt6BR19MBBqj/VrGVPM93VlENWousMPGOcHUPdyW/6t60Vlk0T0YSHn9aFAImWY5q6MEKhderrafn
        iSBqr1TQ==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:48784 helo=[192.168.15.10])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qvNQB-001ZQp-1F;
        Tue, 24 Oct 2023 14:50:35 -0500
Message-ID: <626ae2e7-66f8-423b-b17f-e75c1a6d29b3@embeddedor.com>
Date:   Tue, 24 Oct 2023 13:50:34 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [RFC - is this a bug?] wifi: ath10k: Asking for some light on this,
 please :)
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
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
X-Exim-ID: 1qvNQB-001ZQp-1F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.10]) [187.162.21.192]:48784
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfNaxEG85vN4YnmZuttcFSRwuJF9RS1aUAXd+ljHjiLquJs1zLbb80MZkaEV5iZDlBoSJAY/b6i1+4y5opzKlcbukfLiNwimAz9So+JCvOCUDTQMEqET8
 WTqkYVHd8e7cZcoTt47/Tfm8AblRq6HVgNgV0O5eiTDxwAwhB7la0bqfvboP+vaV2aZztmmAq5DRbxPx8RlHpKV+53ALOIkqDRFCZAxBbws2rudx4mNUGNN/
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

While working on tranforming one-element array `peer_chan_list` in
`struct wmi_tdls_peer_capabilities` into a flex-array member

7187 struct wmi_tdls_peer_capabilities {
...
7199         struct wmi_channel peer_chan_list[1];
7200 } __packed;

the following line caught my attention:

./drivers/net/wireless/ath/ath10k/wmi.c:
8920         memset(skb->data, 0, sizeof(*cmd));

Notice that before the flex-array transformation, we are zeroing 128
bytes in `skb->data` because `sizeof(*cmd) == 128`, see below:

$ pahole -C wmi_10_4_tdls_peer_update_cmd drivers/net/wireless/ath/ath10k/wmi.o
struct wmi_10_4_tdls_peer_update_cmd {
	__le32                     vdev_id;              /*     0     4 */
	struct wmi_mac_addr        peer_macaddr;         /*     4     8 */
	__le32                     peer_state;           /*    12     4 */
	__le32                     reserved[4];          /*    16    16 */
	struct wmi_tdls_peer_capabilities peer_capab;    /*    32    96 */

	/* size: 128, cachelines: 2, members: 5 */
};

So, after the flex-array transformation (and the necessary adjustments
to a few other lines of code) we would be zeroing 104 bytes in
`skb->data` because `sizeof(*cmd) == 104`, see below:

$ pahole -C wmi_10_4_tdls_peer_update_cmd drivers/net/wireless/ath/ath10k/wmi.o
struct wmi_10_4_tdls_peer_update_cmd {
	__le32                     vdev_id;              /*     0     4 */
	struct wmi_mac_addr        peer_macaddr;         /*     4     8 */
	__le32                     peer_state;           /*    12     4 */
	__le32                     reserved[4];          /*    16    16 */
	struct wmi_tdls_peer_capabilities peer_capab;    /*    32    72 */

	/* size: 104, cachelines: 2, members: 5 */
	/* last cacheline: 40 bytes */
};

This difference arises because the size of the element type for the
`peer_chan_list` array, which is `sizeof(struct wmi_channel) == 24 `

$ pahole -C wmi_channel drivers/net/wireless/ath/ath10k/wmi.o
struct wmi_channel {
	__le32                     mhz;                  /*     0     4 */
	__le32                     band_center_freq1;    /*     4     4 */
	__le32                     band_center_freq2;    /*     8     4 */

[..]
                                                /*    20     4 */

	/* size: 24, cachelines: 1, members: 6 */
	/* last cacheline: 24 bytes */
};

is included in `sizeof(*cmd)` before the transformation.

So, my question is: do we really need to zero out those extra 24 bytes in
`skb->data`? or is it rather a bug in the original code?

Thanks!
--
Gustavo

