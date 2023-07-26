Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF957633EB
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjGZKge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjGZKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:36:32 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118EF2126;
        Wed, 26 Jul 2023 03:36:30 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36QAaDvp045912;
        Wed, 26 Jul 2023 05:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690367773;
        bh=AsQ7eL3/H2JJHOml5th1RT/qIatR0oms1Ab+63AsSdY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=oO2vlJsRYavoQbpnR7BH7gv/D6zsLsuKLq8VVi5DAQcF5dI92qLsXfFhlduzSrmeH
         ArZM4IJpCeczHcpAVUPJDp8KPKaVcK0Lo5i2oIt3GC/hjn3Gth5hPMbAnAnK6d49+b
         cwvbg8c/vCB7LtynoQBuBk2cuAEcXDjkBhsWlmO4=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36QAaDhR058238
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 05:36:13 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 05:36:13 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 05:36:13 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36QAa7iP077859;
        Wed, 26 Jul 2023 05:36:07 -0500
Message-ID: <296b0e98-4012-09f6-84cd-6f87a85f095f@ti.com>
Date:   Wed, 26 Jul 2023 16:06:06 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v11 07/10] net: ti: icssg-prueth: Add ICSSG
 Stats
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230724112934.2637802-1-danishanwar@ti.com>
 <20230724112934.2637802-8-danishanwar@ti.com>
 <20230725205014.04e4bba3@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230725205014.04e4bba3@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub

On 26/07/23 9:20 am, Jakub Kicinski wrote:
> On Mon, 24 Jul 2023 16:59:31 +0530 MD Danish Anwar wrote:
>> +	/* Rx */
>> +	ICSSG_STATS(rx_packets, true),
>> +	ICSSG_STATS(rx_broadcast_frames, false),
>> +	ICSSG_STATS(rx_multicast_frames, false),
> 
> There is a standard stat for mcast.
> 

Sure. I will add multicast stats via .ndo_get_stats64 instead of ethtool.

>> +	ICSSG_STATS(rx_crc_errors, true),
>> +	ICSSG_STATS(rx_mii_error_frames, false),
>> +	ICSSG_STATS(rx_odd_nibble_frames, false),
>> +	ICSSG_STATS(rx_frame_max_size, false),
>> +	ICSSG_STATS(rx_max_size_error_frames, false),
>> +	ICSSG_STATS(rx_frame_min_size, false),
>> +	ICSSG_STATS(rx_min_size_error_frames, false),
>> +	ICSSG_STATS(rx_over_errors, true),
>> +	ICSSG_STATS(rx_class0_hits, false),
>> +	ICSSG_STATS(rx_class1_hits, false),
>> +	ICSSG_STATS(rx_class2_hits, false),
>> +	ICSSG_STATS(rx_class3_hits, false),
>> +	ICSSG_STATS(rx_class4_hits, false),
>> +	ICSSG_STATS(rx_class5_hits, false),
>> +	ICSSG_STATS(rx_class6_hits, false),
>> +	ICSSG_STATS(rx_class7_hits, false),
>> +	ICSSG_STATS(rx_class8_hits, false),
>> +	ICSSG_STATS(rx_class9_hits, false),
>> +	ICSSG_STATS(rx_class10_hits, false),
>> +	ICSSG_STATS(rx_class11_hits, false),
>> +	ICSSG_STATS(rx_class12_hits, false),
>> +	ICSSG_STATS(rx_class13_hits, false),
>> +	ICSSG_STATS(rx_class14_hits, false),
>> +	ICSSG_STATS(rx_class15_hits, false),
>> +	ICSSG_STATS(rx_smd_frags, false),
>> +	ICSSG_STATS(rx_bucket1_size, false),
>> +	ICSSG_STATS(rx_bucket2_size, false),
>> +	ICSSG_STATS(rx_bucket3_size, false),
>> +	ICSSG_STATS(rx_bucket4_size, false),
> 
> Are the bucket sizes configurable? Can we set the bucket sizes
> to standard RMON ones and use ethtool RMON stats?

The bucket sizes are not configurable. Bucket size is read from hardware and is
fixed. I don't think we can configure bucket size and use ethtool RMON stats.
It's better to dump bucket sizes via ethtool -S.

-- 
Thanks and Regards,
Danish.
