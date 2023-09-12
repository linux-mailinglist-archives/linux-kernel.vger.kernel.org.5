Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A479CEA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjILKpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbjILKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:44:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012F6173F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:44:22 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-4013454fa93so61907065e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694515461; x=1695120261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTdB5rC+L5kos1kCslFKv4V1nc0NwlzHiB+VYtRjbQc=;
        b=z4KIkp6XMOTMxNyr3FL9Mzhx7069FjE6Zo5nrIkzoOOtbU8g74afb3SUs2Q/YTq2DD
         nQAYTGUE7ZzTC7YzyQ8zehiyfu84dV7hOLo5A2lu58Up9HEuQtqE8wIDHnLjkIo5Fykb
         oLG0qM9KhDeZyP34Y9UlqUR6A53nZJi372hTsqpq6DFyDAgTOia+8G3NQ9Pp9ldTCjCY
         v+8Jj3k6USQCvYif+rTnMjA25J4pg8r+26pxgrl7S+56EOExvmeKvoLRTZEKyExTL90N
         uVPvkAJ/5DH6wbqP8rdpQnEluIFlwyTTsY5FqWN6uYfUAL2hF1Cy5FK2EtJ6bMb2YCIh
         7k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694515461; x=1695120261;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTdB5rC+L5kos1kCslFKv4V1nc0NwlzHiB+VYtRjbQc=;
        b=nLXMgny8fZWCxnh7CLU8/haXGlrEBYZCMkhD64CkmbDRNheRovJKeOewODlzYNSr2v
         /8cJwyPcPEkLlrV4is1wRYjTBjypNQG90twH72m7q47/HaSBEBklutO98qyb1ZItKub7
         8/7Bbv4kQdGn2HTM12zr0RXOtyhkdoAoJlL9SxY6FHN2Faf2TwS74j59cPFbvLySTb8z
         yak11AKLQsYOlP9r8hZi+Y47bifBGR7XwsJggxgBKmrnkDxZ4iPogp9PQYUu+I5anbya
         aR4BFBU/gIJBqxS3/vv660boDQFuHX/zGQUVu7wlcrWOdI7/zBTRgWuHzc3zaFYqmc4q
         FG0w==
X-Gm-Message-State: AOJu0YxI3NryxPxJdh+4P4T1+S8DyBsDiQy+r472MTJ8Re50CzHlZ6/k
        ZKS4ob3bsG4MhO4ft51cugWKnA==
X-Google-Smtp-Source: AGHT+IFmUaPSQB1JDPwcp1glXmxNaOdHNMq/RaW2YxMYKhbLuySY6XL9AWTg+d2k7jPQno0pliAtWg==
X-Received: by 2002:a05:600c:d5:b0:401:bf56:8bb2 with SMTP id u21-20020a05600c00d500b00401bf568bb2mr9996207wmm.10.1694515460799;
        Tue, 12 Sep 2023 03:44:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v11-20020a1cf70b000000b00401d8810c8bsm15728900wmh.15.2023.09.12.03.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 03:44:20 -0700 (PDT)
Message-ID: <56c84195-8cb3-df39-ffd2-f9eb8a445cf6@linaro.org>
Date:   Tue, 12 Sep 2023 12:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 00/14] add support MDP3 on MT8195 platform
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Moudy Ho <moudy.ho@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230912075805.11432-1-moudy.ho@mediatek.com>
 <c0bd7428-1330-58c5-64d2-78af479dfcf4@collabora.com>
 <CAGXv+5FhsKVGwoJxLP=-gV+rSHbQ8DUX0YACy0mPxYw+MC85=g@mail.gmail.com>
 <d8bfbb5f-07a7-4beb-ac1c-049825caf934@collabora.com>
 <CAGXv+5EJ6W6XCJR3busZ0HVQjLytZvzMMjUhhpR5g6Jc8sJQ+A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAGXv+5EJ6W6XCJR3busZ0HVQjLytZvzMMjUhhpR5g6Jc8sJQ+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 12:28, Chen-Yu Tsai wrote:
> On Tue, Sep 12, 2023 at 5:43 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 12/09/23 11:37, Chen-Yu Tsai ha scritto:
>>> On Tue, Sep 12, 2023 at 5:00 PM AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com> wrote:
>>>>
>>>> Il 12/09/23 09:57, Moudy Ho ha scritto:
>>>>> Changes since v4:
>>>>> - Rebase on v6.6-rc1
>>>>> - Remove any unnecessary DTS settings.
>>>>> - Adjust the usage of MOD and clock in blending components.
>>>>>
>>>>> Changes since v3:
>>>>> - Depend on :
>>>>>     [1] https://patchwork.kernel.org/project/linux-media/list/?series=719841
>>>>> - Suggested by Krzysztof, integrating all newly added bindings for
>>>>>     the mt8195 MDP3 into the file "mediatek,mt8195-mdp3.yaml".
>>>>> - Revise MDP3 nodes with generic names.
>>>>>
>>>>> Changes since v2:
>>>>> - Depend on :
>>>>>     [1] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711592
>>>>>     [2] MDP3: https://patchwork.kernel.org/project/linux-mediatek/list/?series=711618
>>>>> - Suggested by Rob to revise MDP3 bindings to pass dtbs check
>>>>> - Add parallel paths feature.
>>>>> - Add blended components settings.
>>>>>
>>>>> Changes since v1:
>>>>> - Depend on :
>>>>>     [1] MDP3 : https://patchwork.kernel.org/project/linux-mediatek/list/?series=698872
>>>>>     [2] MMSYS/MUTEX: https://patchwork.kernel.org/project/linux-mediatek/list/?series=684959
>>>>> - Fix compilation failure due to use of undeclared identifier in file "mtk-mdp3-cmdq.c"
>>>>>
>>>>> Hello,
>>>>>
>>>>> This patch is used to add support for MDP3 on the MT8195 platform that
>>>>> contains more picture quality components, and can arrange more pipelines
>>>>> through two sets of MMSYS and MUTEX respectively.
>>>>>
>>>>> Moudy Ho (14):
>>>>>     arm64: dts: mediatek: mt8183: correct MDP3 DMA-related nodes
>>>>>     arm64: dts: mediatek: mt8195: add MDP3 nodes
>>>>
>>>> Please send the DTS patches separately, those go through a different maintainer.
>>>
>>> I thought most people prefer the _full_ view in a patchset?
>>>
>>
>> Yeah but those going through a different maintainer makes it more straightforward
>> to pick; besides, essentially, you can also get a full view with dt-bindings
>> patches instead of devicetrees, as the latter are "constructed from" bindings
>> anyway.
> 
> Sure, but testing, especially by people not in the recipients or CC list,
> is a bit painful when the full set of patches isn't bundled together.
> Having them bundled together shows what the submitter tested and makes
> it easier for others to reproduce.
> 
> AFAIK other ARM platforms have been sending patches all grouped together.
> It's MediaTek that has been different, as they normally have (for Chromebooks)
> a system integration engineer handling the device tree stuff, while component
> driver owners just handle the drivers, and by extension, the DT bindings.
> 
>> Moreover, it would be definitely nice to add a link to the devicetree series
>> in the cover letter of this series, so that people *do* get a full overview
>> by checking both series :-)
> 
> Most maintainers seem to know what to do: apply the subset destined for
> their tree. At least the subsystems that frequently deal with DT-based
> platforms anyway.

Most, but not all. Some maintainers take entire set - including DTS -
which is not what we want, because *DTS, as a hardware description, must
be independent of driver changes*. Most notably Greg and netdev folks
grab everything. Keeping it together with driver changes brings
confusion and feeling that there are dependency.

Please don't do this.

Best regards,
Krzysztof

