Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DB177D750
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbjHPBFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240914AbjHPBFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:05:02 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF02121
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:04:59 -0700 (PDT)
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
        by cmsmtp with ESMTP
        id W3Vwq2uuTDKaKW4y3qMf8P; Wed, 16 Aug 2023 01:04:59 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id W4y2qz1uBMmPRW4y2qPYR5; Wed, 16 Aug 2023 01:04:58 +0000
X-Authority-Analysis: v=2.4 cv=Zvv+lv3G c=1 sm=1 tr=0 ts=64dc20ba
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=OWjo9vPv0XrRhIrVQ50Ab3nP57M=:19 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19
 a=CGo6wCm4IADRok0f:21 a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=wYkD_t78qR0A:10
 a=-CxxCmWrHlzNBdYEcfkA:9 a=QEXdDO2ut3YA:10 a=tNK2v2ls7fuFGmW9SST8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2i1IKbwyq4nmaQGUx4rtQmCpr+E2DER/NqyPi/Lp9mA=; b=hEMtrgxc6PeY85pBLbSne6CJLU
        Gv/U2izM/t/70F7hxmRjJIn1j1Ko+66CTDW/cw9+qjXRolEwska9jT5FEhd07futnHqKzokFQaQA7
        oavqIYyMYgmekwdXHHfmUAaMQitzVrH1YxLTzhmmn3MAEo8HohRGb8EBDuUaL7U5VAmHp0Ws97wWg
        BOMaZxaVfs0gwauP6+G0WCdK+UGnx4mAtwVrQCyywRTMlkJ4NuX6G19nOaitkBYelP0Y+itb+d46l
        Mh5U+HqCV7g/e3L32z5DrKIj2G6aNjEgvFZaNSxoVcQPbOYyIeSLc7rW4g93ctfi5mqmezrRb7MM7
        oyXn830w==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:49498 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qW4y1-001tFE-1r;
        Tue, 15 Aug 2023 20:04:57 -0500
Message-ID: <e4969e7e-e9d7-67c2-a24e-c9e9be655570@embeddedor.com>
Date:   Tue, 15 Aug 2023 19:06:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] wifi: mwifiex: Asking for some light on this, please :)
Content-Language: en-US
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Brian Norris <briannorris@chromium.org>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
References: <6e3fddfe-2d31-72fa-ac2b-3b7fa4e6fe08@embeddedor.com>
In-Reply-To: <6e3fddfe-2d31-72fa-ac2b-3b7fa4e6fe08@embeddedor.com>
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
X-Exim-ID: 1qW4y1-001tFE-1r
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:49498
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOW3PPKdVScmYFjMX+PHrm+l56/l53ZDtHy8JM9mBbcMrGUqO94Xl20zD4IogOBCYiPps8dqoXo/0FHo1oidOIypV0/PxvgrCB3RdYdy25m/A/Psm5hN
 pvJHQcs93opbX3tQbVEAXqvB0+8CJWF1BlS6qSAq6YI5rDB3MUCDSNhRsPSWLID7pWP1JhSxwjqYDyhGXldM8yHwv8dvpyIgTz8aXWnwhTU2UC/r+2ss6Ots
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/23 18:52, Gustavo A. R. Silva wrote:

> +               tmp = (u8 *)tlv_rxba + tlv_bitmap_len + sizeof(*tlv_rxba - 1);

I meant:

	tmp = (u8 *)tlv_rxba + tlv_bitmap_len + sizeof(*tlv_rxba) - 1;

--
Gustavo
