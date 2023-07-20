Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891E975AD3C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjGTLnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGTLnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:43:37 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46535EC;
        Thu, 20 Jul 2023 04:43:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36KBguBC035143;
        Thu, 20 Jul 2023 06:42:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689853376;
        bh=69LsZo5nd48wahesMf3LFPMsfine13qGJ/Rh3QFyNkY=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=gWsXGcgpn6KmI0FIna0fPGaC5kyji5lbtSE+wdUwaNl8WNogpvzhkA04GGyEbpYbx
         nQuEPCb6LAlKnJPAjUBgpUqRMqH7xmZfT+GfkXAKfr51W8VTaNX9GM1jAmFEnoCdwy
         lYGvZU7azbb3Jn5SGv1FRB8vG7gcFuuxR6EbpUv4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36KBguFf049083
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Jul 2023 06:42:56 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 20
 Jul 2023 06:42:56 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 20 Jul 2023 06:42:56 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36KBgo7G030876;
        Thu, 20 Jul 2023 06:42:51 -0500
Message-ID: <17cd1e70-73bc-78d5-7e9d-7b133d6f464b@ti.com>
Date:   Thu, 20 Jul 2023 17:12:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [EXTERNAL] Re: [PATCH v10 2/2] net: ti: icssg-prueth: Add ICSSG
 ethernet driver
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
References: <20230719082755.3399424-1-danishanwar@ti.com>
 <20230719082755.3399424-3-danishanwar@ti.com>
 <20230719213543.0380e13e@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230719213543.0380e13e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

On 20/07/23 10:05 am, Jakub Kicinski wrote:
> The patch is too big to review.
> 
> Please break it apart separating into individual features, targeting
> around 10 patches in the series. That will make it easier for reviewers
> to take a look at the features in which they have expertise.
> 

Sure Jakub. I will try to break this patch in multiple patches as below.

Patch 1: Introduce Firmware mapping for the driver (icss_switch_map.h)

Patch 2: Introduce mii helper APIs. (icssg_mii_rt.h and icssg_mii_cfg.h). This
patch will also introduce basic prueth and emac structures in icssg_prueth.h as
these structures will be used by the helper APIs.

Patch 3: Introduce firmware configuration and classification APIs.
(icssg_classifier.c, icssg_config.h and icssg_config.c)

Patch 4: Introduce APIs for ICSSG Queues (icssg_queues.c)

Patch 5: Introduce ICSSG Ethernet driver. (icssg_prueth.c and icssg_prueth.h)
This patch will enable the driver and basic functionality can work after this
patch. This patch will be using all the APIs introduced earlier. This patch
will also include Kconfig and Makefile changes.

Patch 6: Enable standard statistics via ndo_get_stats64

Patch 7: Introduce ethtool ops for ICSSG

Patch 8: Introduce power management support (suspend / resume APIs)

However this structure of patches will introduce some APIs earlier (in patch
2,3 and 4) which will be used later by patch 5. I hope it will be OK to
introduce APIs and macros earlier and use them later.

This restructuring will shorten all the individual patches. However patch 5
will still be a bit large as patch 5 introduces all the neccessary APIs as
driver probe / remove, ndo open / close, tx/rx etc.

Currnetly this single patch has close to 4000 insertion and is touching 12
files. After restructring patch 5 will have around 1800 insertions and will
touch only 4 files (icssg_prueth.c, icssg_prueth.h, Kconfig, Makefile). This is
still significant improvement.

Please let me know if this is OK.

Also this patch has Reviewed-By tag of Andrew. Can I carry forward his
Reviewed-By tag in all patches or do I need to drop it?

> See two things which jumped out at me immediately below:
> 
> On Wed, 19 Jul 2023 13:57:55 +0530 MD Danish Anwar wrote:
>> +	ICSSG_STATS(rx_crc_error_frames),
> 
>> +	ICSSG_STATS(rx_max_size_error_frames),
>> +	ICSSG_STATS(rx_frame_min_size),
>> +	ICSSG_STATS(rx_min_size_error_frames),
>> +	ICSSG_STATS(rx_overrun_frames),
> 
>> +	ICSSG_STATS(rx_64B_frames),
>> +	ICSSG_STATS(rx_bucket1_frames),
>> +	ICSSG_STATS(rx_bucket2_frames),
>> +	ICSSG_STATS(rx_bucket3_frames),
>> +	ICSSG_STATS(rx_bucket4_frames),
>> +	ICSSG_STATS(rx_bucket5_frames),
>> +	ICSSG_STATS(rx_total_bytes),
>> +	ICSSG_STATS(rx_tx_total_bytes),
>> +	/* Tx */
>> +	ICSSG_STATS(tx_good_frames),
>> +	ICSSG_STATS(tx_broadcast_frames),
>> +	ICSSG_STATS(tx_multicast_frames),
>> +	ICSSG_STATS(tx_odd_nibble_frames),
>> +	ICSSG_STATS(tx_underflow_errors),
>> +	ICSSG_STATS(tx_frame_max_size),
>> +	ICSSG_STATS(tx_max_size_error_frames),
>> +	ICSSG_STATS(tx_frame_min_size),
>> +	ICSSG_STATS(tx_min_size_error_frames),
>> +	ICSSG_STATS(tx_bucket1_size),
>> +	ICSSG_STATS(tx_bucket2_size),
>> +	ICSSG_STATS(tx_bucket3_size),
>> +	ICSSG_STATS(tx_bucket4_size),
>> +	ICSSG_STATS(tx_64B_frames),
>> +	ICSSG_STATS(tx_bucket1_frames),
>> +	ICSSG_STATS(tx_bucket2_frames),
>> +	ICSSG_STATS(tx_bucket3_frames),
>> +	ICSSG_STATS(tx_bucket4_frames),
>> +	ICSSG_STATS(tx_bucket5_frames),
>> +	ICSSG_STATS(tx_total_bytes),
> 
> Please use standard stats:
> https://docs.kernel.org/next/networking/statistics.html
> 

Sure. I will use standard stats in patch 6.

> And do not duplicate those stats in the ethool -S output.
> 

Sure I will make sure to not duplicate standard stats in driver specific stats
of ethtool -S output.

>> +static const char emac_ethtool_priv_flags[][ETH_GSTRING_LEN] = {
>> +	"iet-frame-preemption",
>> +	"iet-mac-verify",
>> +};
> 
> What are these? We have a proper ethtool API for frame preemption.

I will drop this.

Please let me know if this approach looks ok. I will go ahead and start working
on it. I Will send next revision at the earliest.

-- 
Thanks and Regards,
Danish.
