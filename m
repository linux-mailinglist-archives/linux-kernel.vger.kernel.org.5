Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FAC7608FC
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjGYFCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbjGYFCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:02:47 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAE510FA;
        Mon, 24 Jul 2023 22:02:43 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36P52POM051600;
        Tue, 25 Jul 2023 00:02:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690261345;
        bh=8tsGss9ZaAHkl2BcsSKP5NQv9l4QJ46CMPLo6eiCYFw=;
        h=Date:CC:Subject:To:References:From:In-Reply-To;
        b=IovmN6cB1rHzYf2DH48XbUmEWAxwB09+WdBaxcQwUZUxOiB40/owFA74uVO1p4p3L
         aAHDJqslWqu2ze1C6l/TNoDMKSuzn034hczYznNiU9etRmnKYdhtUtmdAmY93tzA7O
         WcHnmO3HddsaYWZzPu7TO2brWx6tnjJHbZOe2nHc=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36P52Pl6018147
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Jul 2023 00:02:25 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 25
 Jul 2023 00:02:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 25 Jul 2023 00:02:24 -0500
Received: from [172.24.227.9] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36P52KOi020907;
        Tue, 25 Jul 2023 00:02:21 -0500
Message-ID: <77bfe66a-3689-7988-42df-aa10848d0abe@ti.com>
Date:   Tue, 25 Jul 2023 10:32:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <afd@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G
 ports with GESI
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
References: <20230710075551.1109024-1-s-vadapalli@ti.com>
 <20230724175830.mdly3o44xvqlzvf3@agreeable>
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20230724175830.mdly3o44xvqlzvf3@agreeable>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/07/23 23:28, Nishanth Menon wrote:
> On 13:25-20230710, Siddharth Vadapalli wrote:
> [...]
> 
>> +	rgmii4_pins_default: rgmii4-pins-default {
> 
> Could you make sure that the node names matches up with the json-schema
> conversion:
> https://lore.kernel.org/all/169021456020.3622493.10284534202541859578.robh@kernel.org/

I will update the node name and post the v3 patch.

-- 
Regards,
Siddharth.
