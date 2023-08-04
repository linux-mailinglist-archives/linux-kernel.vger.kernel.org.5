Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D620E7707BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjHDSWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjHDSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:22:37 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D755E49F3;
        Fri,  4 Aug 2023 11:22:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 374IMPva040610;
        Fri, 4 Aug 2023 13:22:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691173345;
        bh=F8K5cUTvld04CL5vcXqBPUPFORkHeOOdJkv6hOqGz2o=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=mGV3iX/w7EcXQpX44iNBlJLu/MFEdYceVt6YURL5TVzmN9Yo40nmqOdD1o5s/WPHT
         UtAQg32xRQulFt1731b6xsngDVEyeNH/nXof+DVW+pnVLcEpsIBi58SLTItmli95/g
         oR0Pn1yIumEbN4xKlpYN4et08oRAlyiYLI2kqXbs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 374IMPZo129852
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 13:22:25 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 13:22:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 13:22:24 -0500
Received: from [10.249.132.69] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 374IMKEo102852;
        Fri, 4 Aug 2023 13:22:21 -0500
Message-ID: <b9eb80b6-4908-9979-df3c-7859471dcfe8@ti.com>
Date:   Fri, 4 Aug 2023 23:52:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/2] Add HDMI support for AM68-SK Board
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <r-ravikumar@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230803081800.368582-1-j-choudhary@ti.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230803081800.368582-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03-Aug-23 13:47, Jayesh Choudhary wrote:
> AM68-SK base board has one DP and one HDMI port.
> This series add support for HDMI peripheral for the same.
> 
> Jayesh Choudhary (2):
>   arm64: dts: ti: k3-j721s2-main: Add DSS node
>   arm64: dts: ti: k3-am68-sk-base-board: Add HDMI support

Both the patches look good to me!

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

> 
>  .../boot/dts/ti/k3-am68-sk-base-board.dts     | 138 ++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi    |  46 ++++++
>  2 files changed, 184 insertions(+)
> 
