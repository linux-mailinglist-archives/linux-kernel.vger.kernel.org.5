Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B4D759264
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGSKKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGSKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:10:21 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4BCD1723;
        Wed, 19 Jul 2023 03:10:20 -0700 (PDT)
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id D83DB140782;
        Wed, 19 Jul 2023 10:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1689761419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7z7jIvUFcXoNmOObOfrGS4onALLyXZz1+AOjei4YhGg=;
        b=S9MhZpvNJXHPmB+GsAv7qt+b3U7JgcV2uiPS45toZBoEt43rgtdy6Pcr3ExZqVaNiLoZbM
        8Cs6DeRMfwCKYcglUGAWHnniTDXZ8cs2MCmoJMhpEiOq8E7UejqtBgLh6AWLnAXM25Kds5
        FW9N4KBqmNJYNdNG3BspqYqPPzWzugM=
Message-ID: <1f8cbc00-9602-486d-b3c9-9c82f3b6c8df@postmarketos.org>
Date:   Wed, 19 Jul 2023 13:10:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] arm64: dts: qcom: sdm630: Add support for modem
 remoteproc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230719093458.2668842-1-alexeymin@postmarketos.org>
 <2c1c69bf-3cd5-4d68-43db-696ce0f15197@linaro.org>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <2c1c69bf-3cd5-4d68-43db-696ce0f15197@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2023 12:45, Krzysztof Kozlowski wrote:
> On 19/07/2023 11:34, Alexey Minnekhanov wrote:
>> Modem subsystem in SDM630/660 is similar to MSM8998 and
>> device tree node for it is based on the one from msm8998.dtsi.
>>
>> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
>> ---
>>
>> V3: Use memory-region property to specify memory regions, instead
>>      of using "mba" and "mpss" subnodes.
>>
>> V2 link: https://lore.kernel.org/lkml/20230621175046.61521-3-alexeymin@postmarketos.org/
>>
>>   arch/arm64/boot/dts/qcom/sdm630.dtsi | 59 ++++++++++++++++++++++++++++
>>   1 file changed, 59 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>> index 2136ded22f7e..797625cf78ac 100644
>> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>> @@ -1032,6 +1032,65 @@ data-pins {
>>   			};
>>   		};
>>   
>> +		remoteproc_mss: remoteproc@4080000 {
>> +			compatible = "qcom,sdm660-mss-pil";
> 
> Missing bindings so standard comment:
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

Bindings are already in linux-next/master since 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ed50ac266f67829d4732c8ca61ef1953c2cc63d0 
.

And I did check DTS against bindings, it spat 2 warnings about new 
remoteproc node, which do not make much sense to me:

   DTC_CHK arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
   .../arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb: 
remoteproc@4080000: qcom,halt-regs:0: [43] is too short
         From schema: 
.../Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
   .../arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb: 
remoteproc@4080000: memory-region: [[45], [46]] is too short
         From schema: 
.../Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml

because I do not understand where the limitation to number of items for 
"qcom,halt-regs" or "memory-regions" come from.

-- 
Regards,
Alexey Minnekhanov
postmarketOS developer
