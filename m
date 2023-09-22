Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681147AA7DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 06:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjIVEd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 00:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjIVEdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 00:33:24 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537111A3;
        Thu, 21 Sep 2023 21:33:18 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38M4XA8l054449;
        Thu, 21 Sep 2023 23:33:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695357190;
        bh=sPi8IWhsurZuVI4C0oDweJzzyHYzgz84oN1PgJCbQZQ=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=icvzly8+WQnxm0GrkC/fXz2J5XiuAEF0G4vxem7vLfgCGqSPRh0nKEB7UUTeW33Yz
         aSef1mP4RxlCcS71zE+ja8SMdgKGzY969LfuSI8PzC7zxohW1i2lpgRQM/ahoE9Qam
         7uRLjHUDR6vL2gfYiQvML5rXGF31dNQJS5OG9W7Y=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38M4XAFe024296
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Sep 2023 23:33:10 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 21
 Sep 2023 23:33:10 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 21 Sep 2023 23:33:09 -0500
Received: from [10.24.69.199] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38M4X5qM034427;
        Thu, 21 Sep 2023 23:33:06 -0500
Message-ID: <0d520999-f556-a982-6ea1-9fe831e8f3ea@ti.com>
Date:   Fri, 22 Sep 2023 10:03:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/4] arm64: dts: ti: k3-am654-idk: Add ICSSG Ethernet
 ports
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        <afd@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>
References: <20230921060913.721336-1-danishanwar@ti.com>
 <20230921060913.721336-4-danishanwar@ti.com>
 <a39316d6-8804-4dc4-b5d8-a2dfd82b972e@lunn.ch>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <a39316d6-8804-4dc4-b5d8-a2dfd82b972e@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/23 21:44, Andrew Lunn wrote:
>> +	/* Dual Ethernet application node on PRU-ICSSG0 */
>> +	/* Dual Ethernet application node on PRU-ICSSG1 */
> 
> Not relevant to this patch, but to the ongoing discussions around
> adding switchdev support.
> 
> Are these two PRU-ICSSG instances completely separate? It is
> physically impossible to combine these four ethernet ports in one
> acceleration domain? It will always be two separate switches, and if
> frames need to go from one switch to the other it happens in software?
> 

Yes Andrew, these PRU-ICSSG instances are completely separate.
AM654x-IDK has 3 PRU-ICSSG instances (ICSSG0, ICSSG1, ICSSG2). Each
instance has two slices i.e. two physical ports. Totaling the ports
count to 6. The two slices of a single ICSSG instance can be combined in
the same acceleration domain. However ICSSG ports of different instances
can not be combined together.

The switching in firmware can only happen between two ports in the same
instance. To do switching between ports of different ICSSG instance,
switching will be required to be done in software.

>        Andrew

-- 
Thanks and Regards,
Danish
