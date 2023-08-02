Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4081776C873
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjHBIiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232468AbjHBIiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:38:00 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C751A8;
        Wed,  2 Aug 2023 01:37:57 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8BxY_DkFcpk084OAA--.34853S3;
        Wed, 02 Aug 2023 16:37:56 +0800 (CST)
Received: from [10.20.42.201] (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLCPeFcpk1V1FAA--.29839S3;
        Wed, 02 Aug 2023 16:37:54 +0800 (CST)
Subject: Re: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, zhuyinbo@loongson.cn
References: <20230731091059.17323-1-zhuyinbo@loongson.cn>
 <20230731091059.17323-2-zhuyinbo@loongson.cn>
 <20230731-setback-such-61815ee3ef51@spud>
 <041bf8a6-8d91-c2ce-6752-aa7255f946c7@loongson.cn>
 <20230801-whenever-imitation-b2759b212f6b@spud>
 <a5c27913-2a88-d376-0130-22ca8a3d4516@loongson.cn>
 <20230801-varsity-chemo-09cc5e250ded@spud>
 <26adb487-f8c5-9cf4-5b31-070e9161e761@loongson.cn>
 <20230802-jailer-pavilion-84fb17bb3710@wendy>
 <3534f7b9-0e02-28c1-238a-5a6fdbb95e94@loongson.cn>
 <20230802-bunkbed-siamese-57ee53bdf273@wendy>
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
Message-ID: <db7012b2-9156-34ed-ad1f-10a3e5dfe390@loongson.cn>
Date:   Wed, 2 Aug 2023 16:37:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230802-bunkbed-siamese-57ee53bdf273@wendy>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLCPeFcpk1V1FAA--.29839S3
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/8/2 下午3:50, Conor Dooley 写道:
> On Wed, Aug 02, 2023 at 03:44:17PM +0800, Yinbo Zhu wrote:
>> 在 2023/8/2 下午3:22, Conor Dooley 写道:
>>> On Wed, Aug 02, 2023 at 09:38:34AM +0800, Yinbo Zhu wrote:
>>>> 在 2023/8/1 下午11:54, Conor Dooley 写道:
>>>>> On Tue, Aug 01, 2023 at 04:34:30PM +0800, Yinbo Zhu wrote:
> 
>>>>>> Sorry, I may not have described it clearly before, the ls2k500 was only
>>>>>> as a example, actually, Loongson GPIO controllers (2k500,2k1000,eg)come
>>>>>> in multiple variants that are compatible except for certain register
>>>>>> offset values.  So above all offset device property was used to in all
>>>>>> loongson gpio controller.
>>>>>
>>>>> But it would be good to know why they are different. Do they each
>>>>> support some different features, or was there some other reason for
>>>>> making controllers like this?
>>>>
>>>>
>>>> There are no other reasons, just differences in these offset addresses.
>>>
>>> Huh. Do you have a link to a devicetree for the ls2k500?
>>
>>
>> Yes,  there was a link about ls2k500 dts,  but that ls2k500 dts has not
>> yet added a gpio node.  this gpio node will be added later.
> 
> You must have something that you used to test with, no? I don't mind if
> it is not a patch, but rather is some WIP - I'd just like to see user of
> the binding :)


yes, I have a test, for 2k0500, that gpio dts as follows:

                 gpio0:gpio@0x1fe10430 {
                         compatible = "loongson,ls2k-gpio";
                         reg = <0 0x1fe10430 0 0x20>;
                         gpio-controller;
                         #gpio-cells = <2>;
			interrupt-parent = <&liointc1>;
                         ngpios = <64>;
                         loongson,gpio-conf-offset = <0>;
                         loongson,gpio-out-offset = <0x10>;
                         loongson,gpio-in-offset = <0x8>;
                         loongson,gpio-inten-offset = <0xb0>;
			loongson,gpio-ctrl-mode = <0x0>;
                         ...
		  }

                 gpio1:gpio@0x1fe10450 {
                         compatible = "loongson,ls2k-gpio";
                         reg = <0 0x1fe10450 0 0x20>;
                         gpio-controller;
                         #gpio-cells = <2>;
			interrupt-parent = <&liointc1>;
                         ngpios = <64>;
                         loongson,gpio-conf-offset = <0>;
                         loongson,gpio-out-offset = <0x10>;
                         loongson,gpio-in-offset = <0x8>;
                         loongson,gpio-inten-offset = <0x98>;
			loongson,gpio-ctrl-mode = <0x0>;
                         ...
	        }


Thanks,
Yinbo.
> 

