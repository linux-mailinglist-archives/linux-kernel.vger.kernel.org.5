Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E4E8089AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442388AbjLGN7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjLGN7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:59:21 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFF010E3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:59:25 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a196f84d217so108939166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701957563; x=1702562363; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DPsXzDV6JwRzL+DkmxcZw8UT7hkVmirSZphsQjqScdM=;
        b=p3zZRoWT+5BPMHhpA9+027npLYlo26hdVmd3vQBYeqXKUppEntlPVChWra3edq5l8f
         mmdBkt6uphxOu10J9bE6lfsgsyNPLzjruhcnvacBn0eBX2bPg73zrt8lqXjQdieWB2jS
         sAaVXVDTGB1ofbt/usg8cW94SlYXswG1XFmjzTv21pcK/OrovRMgvkAAuKtA/Pj+maLA
         CFrTaLY/1MVS01L55Z7FZriYUWjjF7BkHWk1UIFhXCZPUUkW1xQkUlOvslrmlOU/Io3+
         7JpEkxDUEV13iDLqY7xOd2b9XkIpDUDRZZAe6+RPHNlYODhtqJ01jmTLdhc6AIdlB00Q
         qHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701957563; x=1702562363;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPsXzDV6JwRzL+DkmxcZw8UT7hkVmirSZphsQjqScdM=;
        b=IPmfbWldBD5ZDISFiRiXcLn4QaI0LF7GdxlcY+kKo8wT2IG2rBC9HVUon4C4BK9h4L
         CYLdxRadzhB7iMfieHSfBlUhbWzcFuBJYx89XKtd7qG0vzHMp6IdWtoEaUDF1B0S1u9Q
         iIotxKHHkmihMhPbgBxih61kiiBnlIm2urSWKCucVB8wZCEHjb+ZTNhgB74+B7dpE1/i
         AuxdkX/hlHZ50f48uiOfExSkx8NrhS378k47SoXbQzSLyTggSec0iGs5N+qtbubHcihP
         WZB63QY7yfnaCzaVcvs0UYKH8QeMkwghrZuES/BaKu+45fo916haBK3XfeJEtI1ZKHWK
         jh9w==
X-Gm-Message-State: AOJu0YydGNwaVq0WOo416gx8WEah77qQSzFZ0FxGhSvWu0k/9iYzjFAM
        hsR4Reux0PoEldKUutJv+Z7FSg==
X-Google-Smtp-Source: AGHT+IEGg1k3SmI1U5aCP2MjuWWrbFJl0vb0yBlDXRdmkLar6JTn7VT590KhI918BLH0/PGYLLYTaQ==
X-Received: by 2002:a17:906:2b46:b0:9dd:7ccf:77f8 with SMTP id b6-20020a1709062b4600b009dd7ccf77f8mr1222275ejg.20.1701957563649;
        Thu, 07 Dec 2023 05:59:23 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906a41a00b00a1da2c9b06asm862918ejz.42.2023.12.07.05.59.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 05:59:23 -0800 (PST)
Message-ID: <1a5019f2-6b32-4960-b494-50434d7659f0@linaro.org>
Date:   Thu, 7 Dec 2023 14:59:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: dt-bindings: ov8856: add missing second link
 frequency in example
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231205084835.15871-1-krzysztof.kozlowski@linaro.org>
 <ZW8DFbz3DqthC6fU@kekkonen.localdomain>
 <ZW8Mz3OWE1ELlFRC@kekkonen.localdomain>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZW8Mz3OWE1ELlFRC@kekkonen.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 12:43, Sakari Ailus wrote:
> On Tue, Dec 05, 2023 at 11:01:41AM +0000, Sakari Ailus wrote:
>> Hi Krzysztof,
>>
>> Thanks for the patch.
>>
>> On Tue, Dec 05, 2023 at 09:48:35AM +0100, Krzysztof Kozlowski wrote:
>>> Bindings and Linux driver require two link frequencies, so correct the
>>> example:
>>>
>>>   ov8856.example.dtb: camera@10: port:endpoint:link-frequencies:0: [360000000] is too short
>>>
>>> Fixes: 066a94e28a23 ("media: dt-bindings: media: Use graph and video-interfaces schemas")
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  Documentation/devicetree/bindings/media/i2c/ov8856.yaml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
>>> index 57f5e48fd8e0..bd1a55d767e7 100644
>>> --- a/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
>>> +++ b/Documentation/devicetree/bindings/media/i2c/ov8856.yaml
>>> @@ -126,7 +126,7 @@ examples:
>>>                  wcam_out: endpoint {
>>>                      remote-endpoint = <&mipi_in_wcam>;
>>>                      data-lanes = <1 2 3 4>;
>>> -                    link-frequencies = /bits/ 64 <360000000>;
>>> +                    link-frequencies = /bits/ 64 <360000000 180000000>;
>>
>> There indeed seems to be a problem with the example as far as the bindings
>> are concerned but the primary issue seems to be in the bindings. Both of
>> these frequencies have significance from driver point of view only while
>> the device itself supports a (wider) range.
>>
>> How about removing maxItems and items from the bindings instead?
> 
> There's also a similar issue with lanes: 1, 2 and 4 are supported.

ack

Best regards,
Krzysztof

