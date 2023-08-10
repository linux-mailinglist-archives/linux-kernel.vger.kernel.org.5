Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C886577839B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHJW0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjHJW0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:26:11 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF3E2722;
        Thu, 10 Aug 2023 15:26:10 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AMQ1mP040458;
        Thu, 10 Aug 2023 17:26:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691706361;
        bh=55HUxK7PVIfiLmrhpTERa00CrfmbFh3I93FoUoUOH48=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=TGP4/I3V3+rHHDSv9OEKkbn4xCvI1dWLIehXlOR0iOyicj1aAZI/aQEg0oCp9fstC
         P/FaNNR3CceQYERmI/pbrHD/k4lRDvjxONmZM785yqROEedmVevQT980x9Sv2mtTZ5
         QsGUGV5weGAaNk/xdJqoRSraBtZcT+fQUztetmRQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AMQ1dd061677
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 17:26:01 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 17:26:00 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 17:26:01 -0500
Received: from [10.249.48.175] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AMQ0Da071966;
        Thu, 10 Aug 2023 17:26:00 -0500
Message-ID: <750740fb-b6a4-f45e-b8b5-d3400060220d@ti.com>
Date:   Thu, 10 Aug 2023 17:26:00 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j721e: Enable C7x DSP nodes at the
 board level
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, Udit Kumar <u-kumar1@ti.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230809180145.53158-1-afd@ti.com>
From:   Hari Nagalla <hnagalla@ti.com>
In-Reply-To: <20230809180145.53158-1-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 13:01, Andrew Davis wrote:
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
> @@ -436,6 +436,7 @@ &c66_1 {
>   };
>   
>   &c71_0 {
> +	status = "okay";
>   	mboxes = <&mailbox0_cluster4>, <&mbox_c71_0>;
>   	memory-region = <&c71_0_dma_memory_region>,
>   			<&c71_0_memory_region>;
> -- 

series acked.

Acked-by: Hari Nagalla <hnagalla@ti.com>
