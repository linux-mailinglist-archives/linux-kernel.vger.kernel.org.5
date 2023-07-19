Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9589B75960F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjGSM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGSM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:58:46 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [IPv6:2a01:4f8:a0:821d::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7ECE113;
        Wed, 19 Jul 2023 05:58:45 -0700 (PDT)
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 0A721140121;
        Wed, 19 Jul 2023 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1689771524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZXaEtPJDLbqwTbE6VAkPqnP0a7nN9LNuwWiZja50Rc=;
        b=IUtaVQh2MQEl7wAGiw3zPiZfyF6mxoLOAcK2aydcv0iU3STdR1e7Ee2L17tTA5jB3gdH9H
        X59+lfK2nE7MFyjwrEA8xAyAhVWwHexJJRekHcgaxExo69pWEQaZMfWcMN4BcmsGWKpHr/
        Cx08uluq9h8iRgZv7eLNvZlz6vkxf0w=
Message-ID: <a23e7b67-877f-5fc4-754a-4fa1b54b9a1c@postmarketos.org>
Date:   Wed, 19 Jul 2023 15:58:43 +0300
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
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>
References: <20230719093458.2668842-1-alexeymin@postmarketos.org>
 <2c1c69bf-3cd5-4d68-43db-696ce0f15197@linaro.org>
 <1f8cbc00-9602-486d-b3c9-9c82f3b6c8df@postmarketos.org>
 <ebc27dd7-93fe-4d8e-8b8c-4fc1d52cc275@linaro.org>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <ebc27dd7-93fe-4d8e-8b8c-4fc1d52cc275@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.07.2023 13:18, Krzysztof Kozlowski wrote:>>           From schema:
>> .../Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
>>     .../arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb:
>> remoteproc@4080000: memory-region: [[45], [46]] is too short
>>           From schema:
>> .../Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
> 
> This needs fixes. The binding lists expected memory regions and you do
> not have three of them.
> 
> Best regards,
> Krzysztof
> 

According to driver code, dedicated reserved metadata memory region is 
optional. If it is not provided, it is allocated by driver itself using 
dma_alloc_attr() and then passed to modem processor.

I see that MSM8996 and MSM8998 (nearest sdm660 siblings) got their 
dedicated metadata reserved regions in patchset [1]. SDM660 MSS was not 
present at that time and I'm not sure if it is needed for this SoC, 
because downstream device tree for my device does not have this region. 
I can either do similar trick for sdm630.dtsi, or alternatively maybe we 
should fix bindings to indicate that metadata region is optional?

I did quick test: added dedicated reserved metadata region, and 
everything still works fine, it seems, and one DTB check warning was gone.

[1] 
https://lore.kernel.org/all/20230117085840.32356-1-quic_sibis@quicinc.com/

-- 
Regards,
Alexey Minnekhanov
postmarketOS developer
