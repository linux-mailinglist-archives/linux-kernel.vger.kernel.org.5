Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC20D78C3FF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234833AbjH2MNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjH2MMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:12:50 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84D461AA;
        Tue, 29 Aug 2023 05:12:44 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8Axueq64O1kg8EcAA--.48847S3;
        Tue, 29 Aug 2023 20:12:42 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx5sy44O1kn3NmAA--.31049S3;
        Tue, 29 Aug 2023 20:12:41 +0800 (CST)
Subject: Re: [PATCH v4 1/2] gpio: dt-bindings: add more loongson gpio chip
 support
To:     Conor Dooley <conor@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230823033427.23072-1-zhuyinbo@loongson.cn>
 <20230823033427.23072-2-zhuyinbo@loongson.cn>
 <20230823-certainty-grimace-a8365c0cfb02@spud>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <a6eb9a3d-83b2-c344-13bb-29a25937117f@loongson.cn>
Date:   Tue, 29 Aug 2023 20:12:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230823-certainty-grimace-a8365c0cfb02@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx5sy44O1kn3NmAA--.31049S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/23 下午11:08, Conor Dooley 写道:
> On Wed, Aug 23, 2023 at 11:34:26AM +0800, Yinbo Zhu wrote:
>> This patch was to add loongson 2k0500, 2k2000 and 3a5000 gpio chip
>> dt-bindings support in yaml file.
>>
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>>   .../bindings/gpio/loongson,ls-gpio.yaml       | 23 +++++++++++++++----
>>   1 file changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> index fb86e8ce6349..97472f1529a0 100644
>> --- a/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> +++ b/Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
>> @@ -11,9 +11,24 @@ maintainers:
>>   
>>   properties:
>>     compatible:
>> -    enum:
>> -      - loongson,ls2k-gpio
>> -      - loongson,ls7a-gpio
>> +    oneOf:
>> +      - enum:
>> +          - loongson,ls2k-gpio
>> +          - loongson,ls2k0500-gpio0
>> +          - loongson,ls2k0500-gpio1
>> +          - loongson,ls2k2000-gpio0
>> +          - loongson,ls2k2000-gpio1
>> +          - loongson,ls2k2000-gpio2
>> +          - loongson,ls3a5000-gpio
>> +          - loongson,ls7a-gpio
> 
>> +      - items:
>> +          - enum:
>> +              - loongson,ls2k1000-gpio
>> +          - const: loongson,ls2k-gpio
>> +      - items:
>> +          - enum:
>> +              - loongson,ls7a1000-gpio
>> +          - const: loongson,ls7a-gpio
> 
> Are there going to be more controllers that are compatible with
> "ls7a-gpio"? If not, you can simplify both of these to have 2 const:
> entries, like:
> 
>        - items:
>            - const: loongson,ls2k1000-gpio
>            - const: loongson,ls2k-gpio
> 
>        - items:
>            - const: loongson,ls7a1000-gpio
>            - const: loongson,ls7a-gpio
> 
> Either way,
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>


okay, I got it.

Thanks,
Yinbo
> 

