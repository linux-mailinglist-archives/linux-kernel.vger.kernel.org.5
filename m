Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB1751F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 12:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjGMKnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 06:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjGMKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 06:43:14 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B61FEA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:43:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3110ab7110aso662406f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 03:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689244991; x=1691836991;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vjSQrGgpifABN2+Tqa28IPOmkn8g3hXtcUjb3gjMzpE=;
        b=g5GkO/ls/kYH9vWlBFZrSm+lN6F5ll50WGXLMxcUf0uESccn6r+sqGeZZZkcCF4762
         0vk6djImGyZBdB4RhUsWdpRXzOQAAytOD+W+bOm3VElr/zv9KecSNq0SUBWcornzKG70
         suRx4XdHuPMnELtb2s2VSYkrL5bnRzMQh9NpOpiOy9Lwi8qsaOIpOnYyf/YLTEf0lBY3
         +PNiys4Oqs+Y3tYuRwccE+3b3zoipoaWVQi75OP1EnihbQRfn4vNDBjEJaMRyFp5O3OG
         YebU/exORsqOI70tHQmpBbebBsMI0t+WfOq4dn4V09XuTtc4ebWGFDG10cXbDYPPgYYn
         bvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689244991; x=1691836991;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vjSQrGgpifABN2+Tqa28IPOmkn8g3hXtcUjb3gjMzpE=;
        b=NV8NaDqJWARa6TSI7HDuvzzNHORqKI+cRh20QAXLlKpMtPEJ9IL4aX+0zKNC4rXktT
         6Z4b8vKHpez5z7vk7Of3Z2Ngt7AuPzWulHKqoihA37D+Hxh1e8nHdwQV2YU3Gj9GsOzj
         Z3wohExO0XqM6w/Z5aUZ/XpavZZ+1FhYrGzv6eiVbkuohGhKoif7tQbHZQQ1NoJFAitg
         aM9cERjPpUy1EGna9O22bvaMdxWmJTBwzxJ2R9SyzVp2IY2Cn9Nbz4VJtAgmzNDx9OZ7
         iNJzLnkpyx1yz/9kRs3oqm91vi9NM7sg2ou0gW03mEYCc0kkn1R/ZJHRZgq/AMKpKo8G
         XhbQ==
X-Gm-Message-State: ABy/qLbZ8lfs5KqdRfcueZaRH0JwB40o9ooGSnXUAGgAF+tXR5GcirMg
        9cA/J0ovAQoPb5FlMS1hUlBkYA==
X-Google-Smtp-Source: APBJJlEPziON1PD3aE57V4CJY4W5KzhUlKzeMzf4BNM8sBOOvTnEwKfgIq9PPdsa/SEsivNw3tYFFw==
X-Received: by 2002:a05:6000:11c3:b0:313:f29f:5eb3 with SMTP id i3-20020a05600011c300b00313f29f5eb3mr1206111wrx.32.1689244991501;
        Thu, 13 Jul 2023 03:43:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k3-20020a5d66c3000000b00314398e4dd4sm7562311wrw.54.2023.07.13.03.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 03:43:10 -0700 (PDT)
Message-ID: <4fdc7ee1-e612-9be2-55b7-bb8ee9cdb161@linaro.org>
Date:   Thu, 13 Jul 2023 12:43:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCHv2 2/2] ARM: dts: at91: sam9x60: fix the SOC detection
Content-Language: en-US
To:     Durai.ManickamKR@microchip.com, Hari.PrasathGE@microchip.com,
        Balamanikandan.Gunasundar@microchip.com,
        Manikandan.M@microchip.com, Varshini.Rajendran@microchip.com,
        Dharma.B@microchip.com, Nayabbasha.Sayed@microchip.com,
        Balakrishnan.S@microchip.com, Cristian.Birsan@microchip.com,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        davem@davemloft.net, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kavyasree.Kotagiri@microchip.com,
        Horatiu.Vultur@microchip.com, robh+dt@kernel.org, andrew@lunn.ch,
        michael@walle.cc, Jerry.Ray@microchip.com, conor+dt@kernel.org,
        jesper.nilsson@axis.com, andre.przywara@arm.com, ada@thorsis.com,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        gregkh@linuxfoundation.org, linux-spi@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20230713095111.335346-1-durai.manickamkr@microchip.com>
 <20230713095111.335346-3-durai.manickamkr@microchip.com>
 <204ad135-5358-35d0-2df2-9495acf0432d@linaro.org>
 <9a29d928-d1e6-ea55-c5dc-0a884978b8df@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <9a29d928-d1e6-ea55-c5dc-0a884978b8df@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 12:28, Durai.ManickamKR@microchip.com wrote:
> 
> On 13/07/23 15:33, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 13/07/2023 11:51, Durai Manickam KR wrote:
>>> Remove the dbgu compatible strings in the UART submodule of the
>>> flexcom for the proper SOC detection.
>> Why?
>>
>>> Fixes: 99c808335877 (ARM: dts: at91: sam9x60: Add missing flexcom definitions)
>> If this is a bugfix, then please clearly describe the bug and its impact.
> Please check the coverletter (PATCHv2 0/2) for the real problem. But 
> will try to explain the bug a bit more in the next set of patches.

Commit should stand on its own. Cover letters are usually not part of
the commits.

Best regards,
Krzysztof

