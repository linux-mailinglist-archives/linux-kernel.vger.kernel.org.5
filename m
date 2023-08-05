Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4929A77124B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjHEVKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHEVKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:10:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03737F3
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:10:46 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bf91956cdso423303466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691269844; x=1691874644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Te/iuHusfR0sKZcOV1o10/BbIF4/9EQr1cV9bQ+zMAA=;
        b=A4jiRySvUj9KFHw3mJ8Ljc0XzHgBEIg6Qsdnu2ivSFoLgjJqEPvhmbCXBO82qbCjuh
         XgqvhPQEWiub8ol4Te+2bhuLt+gawSFmo3aU07dbt5/XfJxBECNX9N8XUcn/QWRQI3tv
         dSYI0+2fooby+xpsjNdh0AaV2WxbwLotenEIcFTLQtwYqZ7J+fX3uD3tZiHpBV+Tdq06
         8nI2JMXrlY18yxJQmZXoFtTDr6BzvBQTKKGiZaNnl/5cq0nJ/I73jtrBagvW40R2090U
         oLw67U/yiqaWCt7wTzk9izFQ3O1SCiG6rkQaTHiM6KQCq00y47wkYLwbruiwDpVCz39+
         QIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691269844; x=1691874644;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Te/iuHusfR0sKZcOV1o10/BbIF4/9EQr1cV9bQ+zMAA=;
        b=dLFhZcFJ58cF2leBVRkNxvcK8myNPNT2kCrnTyaT/xuPO5sJYAw3P19W/HkPrWv7FR
         kEbCJgrkVV++CGhQO1G8P3gmAMAxvOHjbauFJf9UxoEgyKE7E6OUk4y/zh2tV0RKQZW7
         mTZVd+UbiWTYfkTGQPuZh8ZVt3OF+6/HjWTti2SM2CTZALf8wLhElsT06p9Fs4ob6Jwm
         afK9OEkxIVjIoifZf8TdQwnC9PcqPVNXFqHVpuQpr3+EqcI2Dhd4OnCT+D64u428+CA8
         oWigjmVEUXWDFi3G4v+UCeavHS4LrDPSIx20ST0spgui2VDIGtkZhqW6pgFP6uI6IUd0
         /NjA==
X-Gm-Message-State: AOJu0YwqbxA+DvVnOEPN1hxXy99CA38UBizMTRFJqI17p1YDsCGxGiSZ
        9If70+P+mPtf83yswvevQbGI9A==
X-Google-Smtp-Source: AGHT+IFqJSazSoqvAvxX9mRgx7+oZ2LN3CzLXMX1HNes/QFXBiiDV7pmQ8/iMUTNvjP0bgMKXb7DlQ==
X-Received: by 2002:a17:906:3001:b0:992:33ba:2eb4 with SMTP id 1-20020a170906300100b0099233ba2eb4mr4383582ejz.71.1691269844379;
        Sat, 05 Aug 2023 14:10:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906244800b00992b2c55c67sm3147806ejb.156.2023.08.05.14.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 14:10:43 -0700 (PDT)
Message-ID: <a9fb188c-8e88-8e80-2795-7f7504c35fcd@linaro.org>
Date:   Sat, 5 Aug 2023 23:10:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] dt-bindings: media: Add OV5642
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>, Fabio Estevam <festevam@denx.de>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230801234047.136099-1-festevam@denx.de>
 <20230801234047.136099-2-festevam@denx.de>
 <20230802-outreach-national-92083a670b58@spud>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230802-outreach-national-92083a670b58@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2023 17:25, Conor Dooley wrote:
> Hey, 
> 
> On Tue, Aug 01, 2023 at 08:40:47PM -0300, Fabio Estevam wrote:
>> Add DT bindings for OmniVision OV5642 Image Sensor.
>>
>> Signed-off-by: Fabio Estevam <festevam@denx.de>
> 
> Thanks for doing this. It looks good to me, although I got a complaint
> from git while applying it locally:
> Applying: dt-bindings: trivial-devices: Remove the OV5642 entry
> Applying: dt-bindings: media: Add OV5642
> /stuff/linux/.git/worktrees/linux-dt/rebase-apply/patch:119: trailing whitespace.
>   
> warning: 1 line adds whitespace errors.
> 
> I think you can probably squash both patches and add a

Yes, they should be squashed, otherwise it is not really bisectable.
Compatible disappears after first patch... and the first patch does not
have any sense on its own. Even if this is not trivial device, removing
it without documentation is not the way.



Best regards,
Krzysztof

