Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A54579E01A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 08:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238441AbjIMGiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 02:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbjIMGiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 02:38:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD31738
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:38:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-401c90ed2ecso69983125e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 23:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694587080; x=1695191880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8My5CApiKeaXtXgjQmnhwf9UqSWZovhHM2oxjC1BrHk=;
        b=bvXDKjOJ+jepwhbNBqxbEvYEA5Sugze8WUJINIYuk/W9St58tnOimo5IKvNxlIhNcY
         ULV4VJ1yFhCfK03BVLedNmc+416Wk1BaH15kpfFef2F74bYC9tCD26+ICf1jt9Rew7nq
         CO1nVlRL1L2D3J3KkXr/14UBi1HlUuH2rda4f/+rqB4AoNHT58Q+I9xN0e7OOXiCtxfa
         VF1W+VUMKBQG6nFaB54I3XM1YQrtnHiuQE6Lpn2TsKG8RefzZlaq/9mU7dT5KLURo5mB
         WgCvoNDz5ObGdKZGaY9qSzM0xIvsqnRojiVgLUZFCScSW72yDtUfHzMb8+0HLMAax4hO
         RERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694587080; x=1695191880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8My5CApiKeaXtXgjQmnhwf9UqSWZovhHM2oxjC1BrHk=;
        b=SkipWAQiHvVc18v+I0vUwXU9gmNUh7U+J0OZN4ppaQzpsTH/spkPf3MtEyn6Yj3Yh0
         LiUumW6tIL1zvYDCGoZHVE8F4kH2fpgKWSeWx0PuOle7O8QR8/pBNW2kfS1YqW/g63Y0
         gjAH0OM8HzjTZrxwzrMd9XWQjMVopCNMQyVPsEAzqcYhYs50cx8atVzSgJD3rCmuJ4Mn
         JN73tYIPRCVhyRVGnsFO62iQiFVb2aoImsMohIVc/d5HpjDUQXMWvjRrE2hbsU0BeLOT
         vBVphyB3Ib72icjRGJiuLo+ZCz4QGGt7KDkh4hCPF6MFi+6JhW3mHGSIsM76tvmVYMrj
         jiqg==
X-Gm-Message-State: AOJu0YzGhpKeOA1/ViTkBiNYuRBW1RbkATw28A2ScbUQ8bNo0V0XQUu7
        Z22n4LTE0GXJmVa5dIVpyeMx3g==
X-Google-Smtp-Source: AGHT+IEZ2F60h3ihjAJYnXxW24cqpT3tWenIsbGIseVxLMVNVbBJ9+q+xwzYR0l2cvMniL752UbZhQ==
X-Received: by 2002:a7b:c414:0:b0:402:fe6d:6296 with SMTP id k20-20020a7bc414000000b00402fe6d6296mr1282354wmi.9.1694587080118;
        Tue, 12 Sep 2023 23:38:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003ff3b964a9asm1029639wmd.39.2023.09.12.23.37.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 23:37:58 -0700 (PDT)
Message-ID: <0e63b264-1023-7b97-dfc1-91dd6ecef1c0@linaro.org>
Date:   Wed, 13 Sep 2023 08:37:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 2/3] dt-binding: mediatek: integrate MDP RDMA to one
 binding
To:     =?UTF-8?B?TW91ZHkgSG8gKOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230912075651.10693-1-moudy.ho@mediatek.com>
 <20230912075651.10693-3-moudy.ho@mediatek.com>
 <83b3f2eb-84e3-2daa-c63c-14b6792a1db5@linaro.org>
 <69ce225d04b1ed3890365c6f684bdbdb5c540e16.camel@mediatek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <69ce225d04b1ed3890365c6f684bdbdb5c540e16.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 05:04, Moudy Ho (何宗原) wrote:
> On Tue, 2023-09-12 at 10:16 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 12/09/2023 09:56, Moudy Ho wrote:
>>> Due to the same hardware design, MDP RDMA needs to
>>> be integrated into the same binding.
>>>
>>
>> Please use subject prefixes matching the subsystem. You can get them
>> for
>> example with `git log --oneline -- DIRECTORY_OR_FILE` on the
>> directory
>> your patch is touching.
>>
>> This applies to entire patchset. It is not dt-binding, but dt-
>> bindings.
>>
>>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>>> ---
>>>  .../display/mediatek/mediatek,mdp-rdma.yaml   | 88 -------------
>> ------
>>>  .../bindings/media/mediatek,mdp3-rdma.yaml    |  5 +-
>>>  2 files changed, 3 insertions(+), 90 deletions(-)
>>>  delete mode 100644
>> Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
>> rdma.yaml
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
>> rdma.yaml
>> b/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
>> rdma.yaml
>>> deleted file mode 100644
>>> index dd12e2ff685c..000000000000
>>> ---
>> a/Documentation/devicetree/bindings/display/mediatek/mediatek,mdp-
>> rdma.yaml
>>> +++ /dev/null
>>> @@ -1,88 +0,0 @@
>>> -# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> -%YAML 1.2
>>> ----
>>> -$id: 
>> http://devicetree.org/schemas/display/mediatek/mediatek,mdp-rdma.yaml#
>>> -$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> -
>>> -title: MediaTek MDP RDMA
>>> -
>>> -maintainers:
>>> -  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
>>> -  - Philipp Zabel <p.zabel@pengutronix.de>
>>> -
>>> -description:
>>> -  The MediaTek MDP RDMA stands for Read Direct Memory Access.
>>> -  It provides real time data to the back-end panel driver, such as
>> DSI,
>>> -  DPI and DP_INTF.
>>> -  It contains one line buffer to store the sufficient pixel data.
>>> -  RDMA device node must be siblings to the central MMSYS_CONFIG
>> node.
>>> -  For a description of the MMSYS_CONFIG binding, see
>>>
>> -  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
>> for details.
>>> -
>>> -properties:
>>> -  compatible:
>>> -    const: mediatek,mt8195-vdo1-rdma
>>> -
>>> -  reg:
>>> -    maxItems: 1
>>> -
>>> -  interrupts:
>>> -    maxItems: 1
>>> -
>>> -  power-domains:
>>> -    maxItems: 1
>>> -
>>> -  clocks:
>>> -    items:
>>> -      - description: RDMA Clock
>>
>> This is different and you did not explain it in commit msg.
>>
>> Another difference - mboxes. Looks like you did not test your DTS...
>>
>> Best regards,
>> Krzysztof
>>
> Hi Krzysztof,
> 
> Sorry for the inconvenience.
> The property you mentioned was removed on [3/3]. This incorrect
> configuration went unnoticed because I passed the test with the entire
> series.
> It will be recified in the next version.

Please describe any differences (lost properties etc) in commit msg with
some explanation.

Best regards,
Krzysztof

