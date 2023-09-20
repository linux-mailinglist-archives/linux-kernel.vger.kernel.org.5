Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF097A833E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjITNYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjITNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:24:54 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E1391;
        Wed, 20 Sep 2023 06:24:47 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38KDObDw034054;
        Wed, 20 Sep 2023 08:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1695216277;
        bh=BlKg6vL328+Dp8aG1/tzq86FfOzqQNPttnvhLbHaa3A=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tDzh/0vdpqYHX58DulY0zSPnDAsGpHMdBT9DYnP2UlJxxFy7oYdErQuo43HBp+rgn
         skF8e8uXBgLloR7G2jJd3hZVKffG10JBXnns0gnCImVhV+u5zorVlJzbnb9dM6ncNT
         FOV3TAncJ1tpACi4VRMtWRrlbnT1cBPHBuLsK1Z4=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38KDOboO031386
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 Sep 2023 08:24:37 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Sep 2023 08:24:37 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Sep 2023 08:24:37 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38KDOaNR002744;
        Wed, 20 Sep 2023 08:24:36 -0500
Message-ID: <917947a7-85bc-10d3-106d-d9f22f169870@ti.com>
Date:   Wed, 20 Sep 2023 08:24:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am654-base-board: Add I2C I/O
 expander
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230920053834.21399-1-r-gunasekaran@ti.com>
Content-Language: en-US
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <20230920053834.21399-1-r-gunasekaran@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/23 12:38 AM, Ravi Gunasekaran wrote:
> AM654 baseboard has two TCA9554 I/O expander on the WKUP_I2C0 bus.
> The expander at address 0x38 is used to detect daughter cards.
> Add a node for this I/O expander.
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
> Changes from v1:
> ---------------
> * Moved the expander node @38 to appear before the one at address 39.
> * Removed the label pca9554_1 for the node as it is not used.
> 

LGTM,

Reviewed-by: Andrew Davis <afd@ti.com>

> v1: https://lore.kernel.org/all/20230919050340.16156-1-r-gunasekaran@ti.com/
> 
>   arch/arm64/boot/dts/ti/k3-am654-base-board.dts | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> index f5c26e9fba98..1637ec5ab5ed 100644
> --- a/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am654-base-board.dts
> @@ -369,6 +369,13 @@
>   		ti,enable-vout-discharge;
>   	};
>   
> +	gpio@38 {
> +		compatible = "nxp,pca9554";
> +		reg = <0x38>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +
>   	pca9554: gpio@39 {
>   		compatible = "nxp,pca9554";
>   		reg = <0x39>;
> 
> base-commit: dfa449a58323de195773cf928d99db4130702bf7
