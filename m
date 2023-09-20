Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 053847A751D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 10:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjITIBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 04:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjITIBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:01:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514459D;
        Wed, 20 Sep 2023 01:01:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D36766028F5;
        Wed, 20 Sep 2023 09:00:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695196858;
        bh=PsIofxIPZNjYZmIKPLLXiYlycMUtqIzWITre7uRwShk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=UfP3WtYgSXYxgzyyDcqokruv6kxMz2WhLkLxTKLYFi/4J3N2j1k+PRH+DhiX4ysiX
         QXjww+1y1DOE5Y3C/xYAfeudfxwC+f7tjyJfeGMWNyC9w2XfF56Wyc6DsQONoEAXKQ
         xAEZbxt3+n9j2hBa9n/dPD4XTaBwmwfcYP5d+jG+JEKIsjnWAu5w3ttGyGT7/Twp6+
         RX90spJ54bO667w96pVKjBrJa+nS4fhbXug66JmleygAzjXiuLdrtYhThBH1rVBDBD
         rbfNJ0ij6VwhFJn3omnzkf7RjRnBM21PzMtuyrq66kmcyHUs/VW2kjZN4TEIOVl0YZ
         MKZO/XdpPikjw==
Message-ID: <a068c2d1-6ddf-2090-b6e7-f6135a5e1af1@collabora.com>
Date:   Wed, 20 Sep 2023 10:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 05/12] regulator: dt-bindings: mt6358: Add MT6366 PMIC
To:     Rob Herring <robh@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc:     Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230919104357.3971512-1-wenst@chromium.org>
 <20230919104357.3971512-6-wenst@chromium.org>
 <20230919195752.GA85007-robh@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230919195752.GA85007-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/23 21:57, Rob Herring ha scritto:
> On Tue, Sep 19, 2023 at 06:43:48PM +0800, Chen-Yu Tsai wrote:
>> From: Zhiyong Tao <zhiyong.tao@mediatek.com>
>>
>> The MediaTek MT6366 PMIC is similar to the MT6358 PMIC. It is designed
>> to be paired with the MediaTek MT8186 SoC. It has 9 buck regulators and
>> 29 LDO regulators, not counting ones that feed internally and basically
>> have no controls. The regulators are named after their intended usage
>> for the SoC and system design, thus not named generically as ldoX or
>> dcdcX, but as vcn33 or vgpu.
>>
>> The differences compared to the MT6358 are minimal:
>> - Regulators removed: VCAMA1, VCAMA2, VCAMD, VCAMIO, VLDO28
>> - Regulators added: VM18, VMDDR, VSRAM_CORE
>>
>> Add a binding document describing all the regulators and their supplies.
>>
>> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
>> [wens@chromium.org: major rework and added commit message]
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>> ---
>> Changes since v2:
>> - Merged all the propertyPatterns together; the if-then sections now
>>    only block out invalid properties
>>
>> Changes since v1:
>> - Replaced underscores in supply names to hyphens
>> - Merged with MT6358 regulator binding
>> - Added MT6358 fallback compatible to MT6366 regulator
>>
>> Changes since Zhiyong's last version (v4) [1]:
>> - simplified regulator names
>> - added descriptions to regulators
>> - removed bogus regulators (*_sshub)
>> - merged vcn33-wifi and vcn33-bt as vcn33
>> - added missing regulators (vm18, vmddr, vsram-core)
>> - cut down examples to a handful of cases and made them complete
>> - expanded commit message a lot
>>
>> [1] https://lore.kernel.org/linux-arm-kernel/20220823123745.14061-1-zhiyong.tao@mediatek.com/
>>
>>   .../regulator/mediatek,mt6358-regulator.yaml  | 120 +++++++++++++++---
>>   1 file changed, 104 insertions(+), 16 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
>> index c5f336318ec2..05e381899d08 100644
>> --- a/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
>> +++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6358-regulator.yaml
>> @@ -16,14 +16,18 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    const: mediatek,mt6358-regulator
>> +    oneOf:
>> +      - const: mediatek,mt6358-regulator
>> +      - items:
>> +          - const: mediatek,mt6366-regulator
>> +          - const: mediatek,mt6358-regulator
> 
> Would the mt6366 regulator driver(s) function with the mt6358 driver
> unchanged? If not, then not really much point in having the fallback.
> 

It would, because there's chip id verification inside and would still
automatically select the right regulator info, even if there's no mt6366
specific compatible.

Cheers,
Angelo

