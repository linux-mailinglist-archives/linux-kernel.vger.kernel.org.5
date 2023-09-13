Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD579E697
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjIMLXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240017AbjIMLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:23:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1361BD1;
        Wed, 13 Sep 2023 04:23:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9D15C660733C;
        Wed, 13 Sep 2023 12:23:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694604223;
        bh=9bbmy55p17H7G4i7jka4gKht9RxZ3/YHdBartMPUciQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Lhb4dsm6d9pEPz7v5Uo6JLQbKBWeuoV5tnibypNvmbZDU8IbCAQcYyW0Igfo4n7fJ
         oGxnqpXd7BuAVmt5NkfJ2wx370twKmDQveLoJK91hulotM9ovn0IhdBxHprEAtfYwv
         0Ek7hDRrvR8d2YiL3d8ymXTzBsjUx7yuVOdRuLLepjyaIZcV4ZzsHV0hpA9iiZ3WSH
         2RYaiXYGhAQnkw6cdpZ2uP4ZahIuyDonfv3v6k8nfNYgfxNocbKRfU7XJDFEldRAzN
         QMuiYqZiMesfiD6gidwb4+RGnVid5/Ecai/Gq5ja+jHYZchVQ3KI2syxQ4IBmqCV++
         hKnuQxynpoNow==
Message-ID: <8da6396f-3cd4-9c78-06d1-2d2f60d9be3c@collabora.com>
Date:   Wed, 13 Sep 2023 13:23:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC v1 1/3] dt-bindings: thermal: mediatek: add mt7988
 compatible
Content-Language: en-US
To:     frank-w@public-files.de, Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230911183354.11487-1-linux@fw-web.de>
 <20230911183354.11487-2-linux@fw-web.de>
 <e93aa8a6-e088-2864-6ffa-050b211be21f@collabora.com>
 <DEAA91BC-C55C-4AAC-BA35-0060A01D289E@public-files.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <DEAA91BC-C55C-4AAC-BA35-0060A01D289E@public-files.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/09/23 12:57, Frank Wunderlich ha scritto:
> Am 13. September 2023 09:49:08 MESZ schrieb AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>:
>> Il 11/09/23 20:33, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> Add compatible string for mt7988.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>> ---
>>>    .../devicetree/bindings/thermal/mediatek,lvts-thermal.yaml       | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
>>> index fe9ae4c425c0..49effe561963 100644
>>> --- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
>>> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
>>> @@ -18,6 +18,7 @@ description: |
>>>    properties:
>>>      compatible:
>>>        enum:
>>> +      - mediatek,mt7988-lvts
>>
>> Are you sure that MT7988 has only one LVTS controller, and that it is global?
> 
> Based on the information i have it is only 1 lvts device (dts node) with 2 internal controllers. Do i need to define it in different way?
> 

In the MediaTek BSP, I can see that the controller at 0x1100a000 is referenced
to as `MT7988_AP_DOMAIN`... this means that this controller effectively is the
LVTS-AP one.

This means that the compatible here should be "mediatek,mt7988-lvts-ap" :-)

Regards,
Angelo

>>>          - mediatek,mt8192-lvts-ap
>>>          - mediatek,mt8192-lvts-mcu
>>>          - mediatek,mt8195-lvts-ap
>>
> 
> 
> regards Frank


