Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D863C75744B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjGRGgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjGRGgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:36:31 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC74FC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:36:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so10986322a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689662189; x=1692254189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ch3HwCle8t0HQLKWqULDqCLL1QYxiM3sBmnYW05bGNA=;
        b=U01zHKdAJgiJi/0OYb/CSSfHOz2/zNSoBAEgUiKefZlJG4K2lEaXeNmOo0fd/KjJN/
         GNrXRGOcWeplGdRxDl0UuSX7cxAyV2152b+0zHsyXKNHrGkLFaUaZExpVgohKOoqVp4W
         grOP/ixXRLG1ke2832ZUxGAGdXl1Wgnlg45qQbpqikw3XHdI/+slY81lMGchNjMr4Mbw
         ax11qvPWF7SE+Bip+NwfEfMV4CndoAgBjsGxt6Z7ASxHC2JsFItB+b6khlghBFXKT8qm
         PJ7VqArgSM1vUzwT2i/WLboRubatQVXp4eXsF2sKEDh3YPDEU44ewVx5CyabJNWeuNNb
         fpjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662189; x=1692254189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ch3HwCle8t0HQLKWqULDqCLL1QYxiM3sBmnYW05bGNA=;
        b=O3CnPbDQEJaCELPDHDzWM8VvqejiXxEuSew2RSu3T3vYw0ZZir7d7CQlb5ygcQoDbn
         n1oEpqx5ZRH3AutKyWo1j5KAP5AiKmC9gjfHkqG/8LVHgEN8hoook2uHNGzRMwdC5CvQ
         5oNBGWDAQGZkrz4TMLFpBlRLQsUT1Uw1/zVs5nFRjUwGi0ayvAUwNG5rOPEgdrfKFDlA
         GkzbNcklcx3dB6w6z7s4mgorg77XSx+VvkSfqjIkKO6Loe0PsP3JXVcjb7Z2digaJzBC
         meU96xNgs2hVJhYw4EKaHY+NcQgM5wnnoyXfgDzoKEtDVxMERqot5VexA603zJCguZeo
         U45A==
X-Gm-Message-State: ABy/qLbdkziRpbCLkk1zQ3ayG7gjvqN6vXqHYx9jaqwFPMgUF9NsC2cB
        oM+aWsd3fklV0ERkrMk6/h+DAg==
X-Google-Smtp-Source: APBJJlEhoShmWCQpzx0q+oa55hWslQ8QawZIkwRQeOfACYcBu3IQCG1QXzCrCLzznEGJ4uOW4vc4Pw==
X-Received: by 2002:a05:6402:34c2:b0:51e:5206:d69e with SMTP id w2-20020a05640234c200b0051e5206d69emr13501477edc.10.1689662188884;
        Mon, 17 Jul 2023 23:36:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7d50b000000b0051e2a4edfd5sm722206edq.21.2023.07.17.23.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:36:28 -0700 (PDT)
Message-ID: <6ae63cd6-7e57-d81b-fd08-5699b4e6256b@linaro.org>
Date:   Tue, 18 Jul 2023 08:36:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/4] dt-bindings: soc: mediatek: pwrap: Add compatible
 for MT8188
Content-Language: en-US
To:     =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wenst@chromium.org" <wenst@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230717120300.21388-1-jason-ch.chen@mediatek.com>
 <20230717120300.21388-4-jason-ch.chen@mediatek.com>
 <9e46c996-3e3b-b437-f2c4-2ca86a1c7e6c@linaro.org>
 <054014f207e24e1507199cd9833085346ed8cbd6.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <054014f207e24e1507199cd9833085346ed8cbd6.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 08:34, Jason-ch Chen (陳建豪) wrote:
> Hi Krzysztof,
> 
> On Mon, 2023-07-17 at 21:55 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 17/07/2023 14:02, Jason-ch Chen wrote:
>>> From: jason-ch chen <Jason-ch.Chen@mediatek.com>
>>>
>>> Add MT8188 PMIC Wrapper compatible to binding document.
>>
>> No improvements here - the compatible is already there. Subject has
>> the
>> same issue. Explain what you are doing and why.
> 
> The reason for changing the patch was that while MT8188 uses the same
> pwrap as MT8195, the original code was applicable to 'compatible =
> "mediatek,mt8188-pwrap"'.
> 
> To resolve the DTBS check warning that '['mediatek,mt8188-pwrap',
> 'mediatek,mt8195-pwrap', 'syscon'] is too long', I modified the code as
> per the current patch.

Explain it in commit msg. Fix the subject in new patch.

Best regards,
Krzysztof

