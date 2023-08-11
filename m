Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2603779080
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbjHKNMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjHKNMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:12:46 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [5.144.164.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10F426A0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:12:44 -0700 (PDT)
Received: from [192.168.2.144] (bband-dyn221.178-41-211.t-com.sk [178.41.211.221])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id D6FF33ECF7;
        Fri, 11 Aug 2023 15:12:40 +0200 (CEST)
Date:   Fri, 11 Aug 2023 15:12:34 +0200
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH 2/3] nvmem: sunxi_sid: Add support for H616 SID
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Message-Id: <Y0A8ZR.WOK201QL3WRP1@somainline.org>
In-Reply-To: <20230811121754.3a4dc270@donnerap.manchester.arm.com>
References: <20230811-sid-h616-v1-0-d1dfc9f47b19@somainline.org>
        <20230811-sid-h616-v1-2-d1dfc9f47b19@somainline.org>
        <20230811121754.3a4dc270@donnerap.manchester.arm.com>
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



On Fri, Aug 11 2023 at 12:17:54 PM +01:00:00, Andre Przywara 
<andre.przywara@arm.com> wrote:
> On Fri, 11 Aug 2023 13:02:35 +0200
> Martin Botka <martin.botka@somainline.org> wrote:
> 
> Hi Martin,
> 
>>  Add support for the H616 SID controller.
> 
> thanks for upstreaming this!
> 
>> 
>>  The config can be reused from A64.
>> 
>>  Signed-off-by: Martin Botka <martin.botka@somainline.org>
>>  ---
>>   drivers/nvmem/sunxi_sid.c | 1 +
>>   1 file changed, 1 insertion(+)
>> 
>>  diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
>>  index a970f1741cc6..df6fb5e0b724 100644
>>  --- a/drivers/nvmem/sunxi_sid.c
>>  +++ b/drivers/nvmem/sunxi_sid.c
>>  @@ -216,6 +216,7 @@ static const struct of_device_id 
>> sunxi_sid_of_match[] = {
>>   	{ .compatible = "allwinner,sun50i-a64-sid", .data = 
>> &sun50i_a64_cfg },
>>   	{ .compatible = "allwinner,sun50i-h5-sid", .data = 
>> &sun50i_a64_cfg },
>>   	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg 
>> },
>>  +	{ .compatible = "allwinner,sun50i-h616-sid", .data = 
>> &sun50i_a64_cfg },
> 
> You don't need a new compatible string, then.
> Just use
>   compatible = "allwinner,sun50i-h616-sid", 
> "allwinner,sun50i-a64-sid";
> in the DT, and add that combo to the binding, then you don't need any
> driver patches at all - with the added benefit of that already working
> with existing kernels.
I added it cause H5 and A83T were added after their DT binding was in 
and they also use A64 config.
But I will drop this patch and use a64 compatible if that is the 
prefered way :)
> 
> Though I wonder if that has really only 256 bytes of fuses? Do we 
> have any
> evidence of that?
Datasheet has 0 info regarding this. The way i got the size and offset 
was to check the vendor code.
The values matched A64.
> 
> Cheers,
> Andre
> 
>>   	{/* sentinel */},
>>   };
>>   MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
>> 
> 


