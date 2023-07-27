Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90AF764524
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjG0Eww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjG0Ewl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:52:41 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69CF2D5A;
        Wed, 26 Jul 2023 21:52:32 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36R4q3wl040175;
        Wed, 26 Jul 2023 23:52:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690433524;
        bh=b0XLCYPeMxL5GqXwy8aDkOrIMz6Dbp7sZF1xTbGQpqk=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=FKF99HOSHKYtw3Zq962zpPazvFR4SAaXEBT1aZw8vpaqZMFR/TkuGLoBShZAj6giN
         H7w4v2jC5QV3SjyQmca05s7i7A/g4K/jl3x2RV7ZuwjN/fKkOGZE0O/L5B9AWHWa3H
         Y5lAEwuQSZntFdocQ5nto1H1xY2R3F0zCprlxsPo=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36R4q3XW055887
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Jul 2023 23:52:03 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 26
 Jul 2023 23:52:03 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 26 Jul 2023 23:52:03 -0500
Received: from [10.249.135.225] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36R4pv9h127551;
        Wed, 26 Jul 2023 23:51:58 -0500
Message-ID: <17b67407-0507-8978-0d6b-04578ca6b812@ti.com>
Date:   Thu, 27 Jul 2023 10:21:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v11 07/10] net: ti:
 icssg-prueth: Add ICSSG Stats
To:     Jakub Kicinski <kuba@kernel.org>
CC:     MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
 <296b0e98-4012-09f6-84cd-6f87a85f095f@ti.com>
 <20230726083915.1323c501@kernel.org>
Content-Language: en-US
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20230726083915.1323c501@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2023 9:09 PM, Jakub Kicinski wrote:
> On Wed, 26 Jul 2023 16:06:06 +0530 Md Danish Anwar wrote:
>>> Are the bucket sizes configurable? Can we set the bucket sizes
>>> to standard RMON ones and use ethtool RMON stats?
>>
>> The bucket sizes are not configurable. Bucket size is read from hardware and is
>> fixed. I don't think we can configure bucket size and use ethtool RMON stats.
>> It's better to dump bucket sizes via ethtool -S.
> 
> The buckets in the ethtool API are up to the device to define.
> Driver returns bucket ranges via struct ethtool_rmon_hist_range
> from struct ethtool_ops::get_rmon_stats.

Sure Jakub I will try to implement this using ethtool_ops::get_rmon_stats.

-- 
Thanks and Regards,
Md Danish Anwar
