Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29A8764F84
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjG0JXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbjG0JWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:22:55 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E799430F7;
        Thu, 27 Jul 2023 02:13:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36R9ClEM057559;
        Thu, 27 Jul 2023 04:12:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690449167;
        bh=UMJv1zhoAkuL+8u7yVRzA38imljTc6TwiPqib+okbo8=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=qI4Ii7B9LfPg5YAAYuqWAHEIl/pxy/t8IW4+x9b0rlY5EK32Fo0BPAkUic67smXET
         LGaYw/fEfnVi2VkIqNGDzCgxZRWfQxMUy9ke+nZmiD1nRJNJ8UifD9licp0RZvH40l
         /lqgqEPlrviU5D5OaR60lCVFRFigZdL5IY9DF/oU=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36R9ClCk015693
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jul 2023 04:12:47 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 27
 Jul 2023 04:12:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 27 Jul 2023 04:12:47 -0500
Received: from [10.249.135.225] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36R9Cesi026479;
        Thu, 27 Jul 2023 04:12:41 -0500
Message-ID: <354e3bb2-268c-e7ed-ead0-a68a05e2d591@ti.com>
Date:   Thu, 27 Jul 2023 14:42:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [EXTERNAL] Re: [PATCH v11 06/10] net: ti:
 icssg-prueth: Add ICSSG ethernet driver
Content-Language: en-US
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
 <20230724112934.2637802-7-danishanwar@ti.com>
 <20230725210939.56d77726@kernel.org>
 <9b11e602-6503-863a-f825-b595effd5e1d@ti.com>
 <20230726083707.623da581@kernel.org>
From:   "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20230726083707.623da581@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/2023 9:07 PM, Jakub Kicinski wrote:
> On Wed, 26 Jul 2023 16:01:23 +0530 Md Danish Anwar wrote:
>> I think MAX_SKB_FRAGS is OK. If the available pool = MAX_SKB_FRAGS we should be
>> able to wake the queue.
> 
> MAX_SKB_FRAGS only counts frags and you also need space to map the head, no?
> 
> In general we advise to wait until there's at least 2 * MAX_SKB_FRAGS
> to avoid frequent sleep/wake cycles. But IDK how long your queue is,
> maybe it's too much.
> 
>> No I don't think any lock is required here. emac_set_port_state() aquires lock
>> before updating port status. Also emac_ndo_set_rx_mode_work() is scheduled by a
>> singlethreaded workqueue.
> 
> if (netif_running()) outside of any locks is usually a red flag, but if
> you're confident it's fine it's fine :)

Sure Jakub. I will keep these as it is.

-- 
Thanks and Regards,
Md Danish Anwar
