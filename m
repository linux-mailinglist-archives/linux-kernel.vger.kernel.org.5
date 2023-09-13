Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3258579DFDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjIMGSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbjIMGSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:18:10 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05EA172E;
        Tue, 12 Sep 2023 23:18:06 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38D6HuuB060351;
        Wed, 13 Sep 2023 01:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694585876;
        bh=KTEy4fLTR0uFXToGRqCZmDU06j1oqTsEPOhr5SqQt1Y=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Fh8KV2D3DXUvT7B5UrdWGZ7kNtekZyl4eZoshrfgu3ExQcWGq/AHI1kGQlxTkrTa0
         FDhh7hvnmWOHEQmtDiseLsA1Q/1hR8EQBnoHdK5NmLfcrf7NzPJFyHoF+wJo+Phy+9
         G0HGy6LiEwDhCreBw5o8Wy8G6BcAnnGqN+ADrCl0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38D6HuCc013445
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Sep 2023 01:17:56 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 13
 Sep 2023 01:17:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 13 Sep 2023 01:17:56 -0500
Received: from [10.24.69.199] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38D6Hol5073331;
        Wed, 13 Sep 2023 01:17:51 -0500
Message-ID: <73ec102b-94de-e5ca-f425-8228bf5e2511@ti.com>
Date:   Wed, 13 Sep 2023 11:47:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [EXTERNAL] Re: [PATCH net-next v2 1/2] dt-bindings: net: Add
 documentation for Half duplex support.
Content-Language: en-US
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Simon Horman <horms@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20230911060200.2164771-1-danishanwar@ti.com>
 <20230911060200.2164771-2-danishanwar@ti.com>
 <20230911164628.GA1295856-robh@kernel.org>
 <0c23d883-0a79-ee7c-332c-c6580f8691df@ti.com>
 <90b3e6cc-7246-4d02-bd0f-2ce7847bc261@lunn.ch>
From:   MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <90b3e6cc-7246-4d02-bd0f-2ce7847bc261@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/23 20:46, Andrew Lunn wrote:
>> Sure Rob, I will change the description to below.
>>
>>     description:
>>       Indicates that the PHY output pin (COL) is routed to ICSSG GPIO
> 
> The PHY has multiple output pins, so i would not put COL in brackets,
> but make it explicit which pin you are referring to.
> 

Sure, I will remove the brackets and make it explicit.

>>       pin (PRGx_PRU0/1_GPIO10) as input and ICSSG MII port is capable
>>       of half duplex operations.
> 
> "input and so the ICSSG MII port is"
> 

I think "input so that the ICSSG MII port is" will be better.

The description would look something like below,

  description:
    Indicates that the PHY output pin COL is routed to ICSSG GPIO pin
    (PRGx_PRU0/1_GPIO10) as input so that the ICSSG MII port is
    capable of half duplex operations.

I will post the next version with this change.

>        Andrew

-- 
Thanks and Regards,
Danish
