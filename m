Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59A77825EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 10:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjHUI7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjHUI7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 04:59:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A656ACC;
        Mon, 21 Aug 2023 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1692608385; x=1724144385;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=ALOTiRmCfj3769cfKooI7Rfu3TpT5H8i1UavK7RLZeg=;
  b=gJymp0is0IsZVMkhYBvQmXCHoTe4leMPKFQ4vYg5Q0JfCWKlA/ZXLtYn
   C1jhWAXdVmVA+oCyMc7Cp0ynKpcZyQ2JEHQrV7NJcQ+xZOdz+UpnKuls/
   a4c01wTZJxaD98WT/YwwSHZNAEle+8hvA4WmBdsMnihXi3HASdz5Xy2y7
   pdYJ8aO1iVFhLO6JQ9C4BjTHYipzDj9Hu6Lvm5u9JX8oeoPsa6p2wzDUB
   uPEXXq5O1gEABPklml5B8U+3jcTD0syTWyzhUtqE+aKYzI8orfBW6433U
   nF63KZpILxmhzmCp6W3rSaH3QFpcTxU7iFPXdSft9GU7iTEHcNgpzZF8U
   g==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="404612"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Aug 2023 01:59:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 21 Aug 2023 01:59:12 -0700
Received: from [10.159.245.205] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 21 Aug 2023 01:59:09 -0700
Message-ID: <a7b84b23-a1c1-23df-79db-d965ed261223@microchip.com>
Date:   Mon, 21 Aug 2023 10:59:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
Content-Language: en-US, fr-FR
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <tudor.ambarus@linaro.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230728102442.265820-1-varshini.rajendran@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20230728102442.265820-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 at 12:24, Varshini Rajendran wrote:
> Add DT bindings for atmel TDES.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Following my answer to the email thread:
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Thanks, best regards,
   Nicolas

> ---
>   .../devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml  | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> index 3d6ed24b1b00..6a441f79efea 100644
> --- a/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> +++ b/Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> @@ -12,7 +12,11 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: atmel,at91sam9g46-tdes
> +    oneOf:
> +      - const: atmel,at91sam9g46-tdes
> +      - items:
> +          - const: microchip,sam9x7-tdes
> +          - const: atmel,at91sam9g46-tdes
>   
>     reg:
>       maxItems: 1

