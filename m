Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17803809CF2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjLHHO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjLHHOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:14:54 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87AC10EB;
        Thu,  7 Dec 2023 23:14:59 -0800 (PST)
Received: from kwepemd100008.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Smj7D0TKPzYspD;
        Fri,  8 Dec 2023 15:14:16 +0800 (CST)
Received: from [10.67.121.2] (10.67.121.2) by kwepemd100008.china.huawei.com
 (7.221.188.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1258.28; Fri, 8 Dec
 2023 15:14:56 +0800
Message-ID: <6572C270.6050101@hisilicon.com>
Date:   Fri, 8 Dec 2023 15:14:56 +0800
From:   Wei Xu <xuwei5@hisilicon.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <xuwei5@hisilicon.com>
Subject: Re: [PATCH] dt-bindings: hisilicon: Merge hi3620-clock into hisilicon,sysctrl
 binding
References: <20231122235059.2966532-1-robh@kernel.org>
In-Reply-To: <20231122235059.2966532-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.121.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100008.china.huawei.com (7.221.188.193)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2023/11/23 7:50, Rob Herring wrote:
> The hi3620-clock binding is simple and always a child of the
> "hisilicon,sysctrl" node, so just add it into the hisilicon,sysctrl
> binding and drop the old txt binding.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to the HiSilicon arm64 dt tree.
Thanks!

Best Regards,
Wei

>  .../arm/hisilicon/controller/sysctrl.yaml     | 17 ++++++++++++++++
>  .../bindings/clock/hi3620-clock.txt           | 20 -------------------
>  2 files changed, 17 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/clock/hi3620-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
> index 5a53d433b6f0..7a221e1c09df 100644
> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
> @@ -82,6 +82,23 @@ properties:
>  
>    ranges: true
>  
> +patternProperties:
> +  '^clock@':
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - hisilicon,hi3620-clock
> +          - hisilicon,hi3620-mmc-clock
> +
> +      reg:
> +        maxItems: 1
> +
> +      '#clock-cells':
> +        const: 1
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/clock/hi3620-clock.txt b/Documentation/devicetree/bindings/clock/hi3620-clock.txt
> deleted file mode 100644
> index dad6269f52c5..000000000000
> --- a/Documentation/devicetree/bindings/clock/hi3620-clock.txt
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -* Hisilicon Hi3620 Clock Controller
> -
> -The Hi3620 clock controller generates and supplies clock to various
> -controllers within the Hi3620 SoC.
> -
> -Required Properties:
> -
> -- compatible: should be one of the following.
> -  - "hisilicon,hi3620-clock" - controller compatible with Hi3620 SoC.
> -  - "hisilicon,hi3620-mmc-clock" - controller specific for Hi3620 mmc.
> -
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -
> -- #clock-cells: should be 1.
> -
> -Each clock is assigned an identifier and client nodes use this identifier
> -to specify the clock which they consume.
> -
> -All these identifier could be found in <dt-bindings/clock/hi3620-clock.h>.
> 
