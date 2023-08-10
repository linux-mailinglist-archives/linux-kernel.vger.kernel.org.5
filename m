Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598807771F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbjHJH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbjHJH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:56:18 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D48AE4D;
        Thu, 10 Aug 2023 00:56:17 -0700 (PDT)
Received: from [192.168.0.2] (unknown [95.91.208.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 028F961E5FE04;
        Thu, 10 Aug 2023 09:55:30 +0200 (CEST)
Message-ID: <d23de35f-8d55-4f80-a6ce-281f83fd4243@molgen.mpg.de>
Date:   Thu, 10 Aug 2023 09:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: rtc: nuvoton: Add DT compatible
To:     Mia Lin <mimi05633@gmail.com>
Cc:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, KWLIU@nuvoton.com, JJLIU0@nuvoton.com,
        KFLIN@nuvoton.com, mylin1@nuvoton.com, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
References: <20230809095112.2836-1-mimi05633@gmail.com>
 <20230809095112.2836-2-mimi05633@gmail.com>
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230809095112.2836-2-mimi05633@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mia,


Thank you for your patch. It’d be great if you mentioned nct3015y in the 
commit message summary/title. Maybe:

dt-bindings: rtc: Add compatible nct3015y to nuvoton,nct3018y

Am 09.08.23 um 11:51 schrieb Mia Lin:
> Add DT compatible "nuvoton,nct3015y" to select

What do you mean by “to select”?

Also, maybe add how you tested this.

> Signed-off-by: Mia Lin <mimi05633@gmail.com>
> ---
>   Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> index 4f9b5604acd9..67fc60fd395c 100644
> --- a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> +++ b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
> @@ -15,7 +15,9 @@ maintainers:
>   
>   properties:
>     compatible:
> -    const: nuvoton,nct3018y
> +    enum:
> +      - nuvoton,nct3018y
> +      - nuvoton,nct3015y

Would sorting the list be useful?

>     reg:
>       maxItems: 1


Kind regards,

Paul
