Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE0B76FDB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjHDJpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjHDJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:45:39 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740A849EE
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 02:45:36 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e2a6a3768so2398160a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 02:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691142335; x=1691747135;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1xPeMw/tdJ7IioEcDvwAyboMLZ4pz6UEfuXX/4uGyxA=;
        b=FLyAljQ1t8b3Xk/pCIKYZrMFdYexo+hFibSNEUp2p3wd64yBa2ddbVuCdDrlswKKlx
         +tSS4CUQ1j8xWfs/JLtTG0hZmgDZOoJcRz/AvsNvA8uA4o7Ubo9dEDD5yrYtIOn20Qj0
         gbelwu6DcDfbQRUyKbYb6Iio0eb2WVn4o0WSswkPqcnGMmYZumCBnFZj+cAP+Trxdjpf
         We1i0/GrNkkIfZmIt1B6hrEr0Z+Fl/QiC2l9ZxPJQVc/oYLW6VQF+ZKYZEV2nKnq4T2k
         QvdENM2dG5mzNO61iE2XdVwJY950YBmDWnP5uB8XQS/mdCP38qao1kbUIk6TXDAXvY8e
         T1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691142335; x=1691747135;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xPeMw/tdJ7IioEcDvwAyboMLZ4pz6UEfuXX/4uGyxA=;
        b=M96ZZbQq/66KE15eFbXQZlKPvXHCnMMxPi0kzDVDWsaV7iWxeuZgwNOHM2N1O6bi4N
         CHkbn8OzAxIRLKgjlXTYUaYpwYTv4Oo0SU6WtXU+9/bALj0otQVv5Sg04sY0/dPRRAXI
         csyR6V3d3rzQsGwtoWNzTVJrwRLLlBUe4zyjZDVLw9IC3XIwibABbNe2yhm+I1pcPIR+
         VCcBcxKjQL0twZBKTSLUZFZRIg9V+UJu9B6XBVlxSwZR0R3PUldFK9/MtfdN8axmhRHb
         lWo2thcQ0LnZKPyyBXQNeSm56r7LS6PCI0xcqEOAXOJV6z5FxpbTXO//mblIyPrIQxMH
         nxjg==
X-Gm-Message-State: AOJu0YxHgrMwSDENRzMi42io+QLtmrqqzIpIz3g+2FGPUdL7zYEX2Gyz
        677R3s9GhNL1P1NmiR+J152xHQ==
X-Google-Smtp-Source: AGHT+IEKy6dK//8+SePubKh4DJRoYWXex01cl/WJEu49hdwZPoBKQhqGx2/J5yCGkCRtvETRm0rtUw==
X-Received: by 2002:aa7:c783:0:b0:522:bae5:282a with SMTP id n3-20020aa7c783000000b00522bae5282amr1270942eds.1.1691142334837;
        Fri, 04 Aug 2023 02:45:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id bc5-20020a056402204500b005230f06de15sm1016539edb.78.2023.08.04.02.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 02:45:34 -0700 (PDT)
Message-ID: <c2cb5781-f2da-eef8-50db-6bfbaaed685e@linaro.org>
Date:   Fri, 4 Aug 2023 11:45:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 6/6] ASoC: dt-bindings: mediatek,mt7986-afe: add audio
 afe document
Content-Language: en-US
To:     =?UTF-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "chenxiangrui@huaqin.corp-partner.google.com" 
        <chenxiangrui@huaqin.corp-partner.google.com>,
        =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsik=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>, "arnd@arndb.de" <arnd@arndb.de>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
References: <20230728090819.18038-1-maso.huang@mediatek.com>
 <20230728090819.18038-7-maso.huang@mediatek.com>
 <a4f071a0-9e41-4de1-6721-f8d47475f41e@linaro.org>
 <5d005f518d974b7912c832101b5cfbde77f57270.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5d005f518d974b7912c832101b5cfbde77f57270.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2023 10:25, Maso Huang (黃加竹) wrote:
> On Fri, 2023-07-28 at 14:51 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 28/07/2023 11:08, Maso Huang wrote:
>>> Add mt7986 audio afe document.
>>>
>>> Signed-off-by: Maso Huang <maso.huang@mediatek.com>
>>
>> Thank you for your patch. There is something to discuss/improve.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>>> +  - assigned-clocks
>>> +  - assigned-clock-parents
>>
>> You should constrain your clocks per variants. I doubt that they are
>> really so flexible/optional on each SoC... or maybe missing clocks
>> are
>> result of unimplemented parts in the driver? But then this should not
>> really affect bindings. Bindings still should require such clocks.
>> Your
>> DTS can always provide a <0>, if needed.
>>
>>
> 
> Hi Krzysztof,
> 
> After internal check, assigned-clocks and assigned-clock-parents are
> not required on this SoC. 
> Maybe we can just drop these two options?

It's separate issue, but yes - why requiring them?

I wrote about missing constraints for your clocks in the bindings.

Best regards,
Krzysztof

