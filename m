Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E070F77B407
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbjHNIXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbjHNIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:22:30 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCD1273A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:21:58 -0700 (PDT)
Received: from [192.168.2.144] (bband-dyn221.178-41-211.t-com.sk [178.41.211.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id B9E2A1F4A4;
        Mon, 14 Aug 2023 10:21:55 +0200 (CEST)
Date:   Mon, 14 Aug 2023 10:21:49 +0200
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: nvmem: SID: Add binding for H616 SID
 controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Message-Id: <DKGDZR.4G4SZ781MVSV2@somainline.org>
In-Reply-To: <830e5e34-f6de-3233-4a12-06c8390169d1@linaro.org>
References: <20230814-sid-h616-v2-0-0267749b4471@somainline.org>
        <20230814-sid-h616-v2-1-0267749b4471@somainline.org>
        <830e5e34-f6de-3233-4a12-06c8390169d1@linaro.org>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Aug 14 2023 at 10:08:38 AM +02:00:00, Krzysztof Kozlowski 
<krzysztof.kozlowski@linaro.org> wrote:
> On 14/08/2023 08:38, Martin Botka wrote:
>>  Add binding for the SID controller found in H616 SoC
>> 
>>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
>>  ---
>>   
>> Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml 
>> | 1 +
>>   1 file changed, 1 insertion(+)
>> 
>>  diff --git 
>> a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml 
>> b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
>>  index 296001e7f498..2ec0a1b8f803 100644
>>  --- 
>> a/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
>>  +++ 
>> b/Documentation/devicetree/bindings/nvmem/allwinner,sun4i-a10-sid.yaml
>>  @@ -27,6 +27,7 @@ properties:
>>             - const: allwinner,sun50i-a64-sid
>>         - const: allwinner,sun50i-h5-sid
>>         - const: allwinner,sun50i-h6-sid
>>  +      - const: allwinner,sun50i-h616-sid
> 
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
> for instructions).
> 
> Best regards,
> Krzysztof
> 
Yea completely forgot. Sorry for that.

Will send v3 tomorrow with proper binding patch using items with enums


