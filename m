Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74007AF110
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjIZQpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIZQpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:45:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C18AB3;
        Tue, 26 Sep 2023 09:45:07 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38QBhp5F000807;
        Tue, 26 Sep 2023 18:44:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=6RAvXFMIDRjicRx0W/llTbUTzln/zHTfF90xpGsmT4E=; b=7y
        sFnYs+SNWN4Ouk1aC57yIj1VgunNd8kKjTqtsp6CNvR15W1yu+FNyq0F8jz12D5D
        gKrQtXGOlqNsN/YX9I7VClsAcANqO+PTS9ILMUO6k62p680RhksLXhxahmOKMU3M
        Fhx2XCmda5KRQeiUIh6Kgd4gVu1+bITPlPVWWk7C37j1lql9ELu5TBoavtRDDQhH
        Pk3kWHcV+rHuehBo8f9ZW5pzIwLLrxpx5PVUhHzaS7NKiBSaI4mxJQqvr4K/WpCi
        JOQaUivLgoDXyplBuRxDCJB+73dwbUZGWPkl0MO1gCokYVycAkEHYbGokzAtt7br
        gU/gAKzsDYlUBogX15oA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ta9k0b84u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Sep 2023 18:44:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 822CB10005A;
        Tue, 26 Sep 2023 18:44:50 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 76C6C24C44D;
        Tue, 26 Sep 2023 18:44:50 +0200 (CEST)
Received: from [10.252.15.134] (10.252.15.134) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 18:44:50 +0200
Message-ID: <8991b1a2-d9bf-c04d-81e4-5ce60da579ab@foss.st.com>
Date:   Tue, 26 Sep 2023 18:44:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC v2 01/11] iio: introduce iio backend device
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        "Fabrice GASNIER" <fabrice.gasnier@st.com>
References: <20230727150324.1157933-1-olivier.moysan@foss.st.com>
 <20230727150324.1157933-2-olivier.moysan@foss.st.com>
 <7ec3fe6183409c218b97a3359e951731b47fe16d.camel@gmail.com>
 <095f9c64-bcac-e838-ba69-b5df623c444f@foss.st.com>
 <8b63cad8749ceca31d2f50ee36925ce18523620f.camel@gmail.com>
 <9cf91ed4-8d57-6d84-1767-708a296803b9@foss.st.com>
 <7704da82b99730da5f62668246ba4249000a52f9.camel@gmail.com>
 <75287793-a1c1-9b61-73aa-a2cf8d61dac2@foss.st.com>
 <311803c091a70b2c242592eab267079db86f85f9.camel@gmail.com>
 <c25d404fa19c03cafc6dfe70b964369c7c773849.camel@gmail.com>
Content-Language: en-US
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <c25d404fa19c03cafc6dfe70b964369c7c773849.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.15.134]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-26_13,2023-09-26_01,2023-05-22_02
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nuno,

On 9/25/23 08:48, Nuno Sá wrote:
> Hi Olivier,
> 
> On Fri, 2023-09-22 at 10:53 +0200, Nuno Sá wrote:
>> Hi Olivier,
>>
>> Sorry for the delay...
>>
>> On Mon, 2023-09-18 at 17:52 +0200, Olivier MOYSAN wrote:
>>> Hi Nuno
>>>
>>> On 9/11/23 11:39, Nuno Sá wrote:
>>>> On Tue, 2023-09-05 at 12:06 +0200, Olivier MOYSAN wrote:
>>>>> Hi Nuno,
>>>>>
>>>>> On 9/1/23 10:01, Nuno Sá wrote:
>>>>>> Hi Olivier,
>>>>>>
>>>>>> On Thu, 2023-08-31 at 18:14 +0200, Olivier MOYSAN wrote:
>>>>>>> Hi Nuno,
>>>>>>>
>>>>>>> On 7/28/23 10:42, Nuno Sá wrote:
>>>>>>>> Hi Olivier,
>>>>>>>>
>>>>>>>> On Thu, 2023-07-27 at 17:03 +0200, Olivier Moysan wrote:
>>>>>>>>> Add a new device type in IIO framework.
>>>>>>>>> This backend device does not compute channel attributes and does
>>>>>>>>> not
>>>>>>>>> expose
>>>>>>>>> them through sysfs, as done typically in iio-rescale frontend
>>>>>>>>> device.
>>>>>>>>> Instead, it allows to report information applying to channel
>>>>>>>>> attributes through callbacks. These backend devices can be
>>>>>>>>> cascaded
>>>>>>>>> to represent chained components.
>>>>>>>>> An IIO device configured as a consumer of a backend device can
>>>>>>>>> compute
>>>>>>>>> the channel attributes of the whole chain.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>>>>>>> ---
>>>>>>>>>      drivers/iio/Makefile               |   1 +
>>>>>>>>>      drivers/iio/industrialio-backend.c | 107
>>>>>>>>> +++++++++++++++++++++++++++++
>>>>>>>>>      include/linux/iio/backend.h        |  56 +++++++++++++++
>>>>>>>>>      3 files changed, 164 insertions(+)
>>>>>>>>>      create mode 100644 drivers/iio/industrialio-backend.c
>>>>>>>>>      create mode 100644 include/linux/iio/backend.h
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>>>>>>>> index 9622347a1c1b..9b59c6ab1738 100644
>>>>>>>>> --- a/drivers/iio/Makefile
>>>>>>>>> +++ b/drivers/iio/Makefile
>>>>>>>>> @@ -5,6 +5,7 @@
>>>>>>>>>      
>>>>>>>>>      obj-$(CONFIG_IIO) += industrialio.o
>>>>>>>>>      industrialio-y := industrialio-core.o industrialio-event.o
>>>>>>>>> inkern.o
>>>>>>>>> +industrialio-$(CONFIG_IIO_BACKEND) += industrialio-backend.o
>>>>>>>>>      industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>>>>>>>>>      industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>>>>>>>>>      
>>>>>>>>> diff --git a/drivers/iio/industrialio-backend.c
>>>>>>>>> b/drivers/iio/industrialio-
>>>>>>>>> backend.c
>>>>>>>>> new file mode 100644
>>>>>>>>> index 000000000000..7d0625889873
>>>>>>>>> --- /dev/null
>>>>>>>>> +++ b/drivers/iio/industrialio-backend.c
>>>>>>>>> @@ -0,0 +1,107 @@
>>>>>>>>> +// SPDX-License-Identifier: GPL-2.0
>>>>>>>>> +/* The industrial I/O core, backend handling functions
>>>>>>>>> + *
>>>>>>>>> + */
>>>>>>>>> +
>>>>>>>>> +#include <linux/kernel.h>
>>>>>>>>> +#include <linux/device.h>
>>>>>>>>> +#include <linux/property.h>
>>>>>>>>> +#include <linux/iio/iio.h>
>>>>>>>>> +#include <linux/iio/backend.h>
>>>>>>>>> +
>>>>>>>>> +static DEFINE_IDA(iio_backend_ida);
>>>>>>>>> +
>>>>>>>>> +#define to_iio_backend(_device) container_of((_device), struct
>>>>>>>>> iio_backend,
>>>>>>>>> dev)
>>>>>>>>> +
>>>>>>>>> +static void iio_backend_release(struct device *device)
>>>>>>>>> +{
>>>>>>>>> +       struct iio_backend *backend = to_iio_backend(device);
>>>>>>>>> +
>>>>>>>>> +       kfree(backend->name);
>>>>>>>>> +       kfree(backend);
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static const struct device_type iio_backend_type = {
>>>>>>>>> +       .release = iio_backend_release,
>>>>>>>>> +       .name = "iio_backend_device",
>>>>>>>>> +};
>>>>>>>>> +
>>>>>>>>> +struct iio_backend *iio_backend_alloc(struct device *parent)
>>>>>>>>> +{
>>>>>>>>> +       struct iio_backend *backend;
>>>>>>>>> +
>>>>>>>>> +       backend = devm_kzalloc(parent, sizeof(*backend),
>>>>>>>>> GFP_KERNEL);
>>>>>>>>>
>>>>>>>>
>>>>>>>> No error checking.
>>>>>>>>
>>>>>>>> I guess a lot of cleanings are still missing but the important thing
>>>>>>>> I
>>>>>>>> wanted to
>>>>>>>> notice is that the above pattern is not ok.
>>>>>>>> Your 'struct iio_backend *backend'' embeds a 'stuct device' which is
>>>>>>>> a
>>>>>>>> refcounted object. Nevertheless, you're binding the lifetime of your
>>>>>>>> object to
>>>>>>>> the parent device and that is wrong. The reason is that as soon as
>>>>>>>> your
>>>>>>>> parent
>>>>>>>> device get's released or just unbinded from it's driver, all the
>>>>>>>> devres
>>>>>>>> stuff
>>>>>>>> (including your 'struct iio_backend' object) will be released
>>>>>>>> independentof
>>>>>>>> your 'struct device' refcount value...
>>>>>>>>
>>>>>>>> So, you might argue this won't ever be an issue in here but the
>>>>>>>> pattern
>>>>>>>> is still
>>>>>>>> wrong. There are some talks about this, the last one was given at
>>>>>>>> the
>>>>>>>> latest
>>>>>>>> EOSS:
>>>>>>>>
>>>>>>>> https://www.youtube.com/watch?v=HCiJL7djGw8&list=PLbzoR-pLrL6pY8a8zSKRC6-AihFrruOkq&index=27&ab_channel=TheLinuxFoundation
>>>>>>>>
>>>>>>>
>>>>>>> This is a good point. Thanks for pointing it out. Sure, there are
>>>>>>> still
>>>>>>> many things to improve.
>>>>>>>
>>>>>>> I have seen the comment from Jonathan on your "Add converter
>>>>>>> framework"
>>>>>>> serie. I had a quick look at the serie. It seems that we share the
>>>>>>> need
>>>>>>> to aggregate some IIO devices. But I need to read it more carefully to
>>>>>>> check if we can find some convergences here.
>>>>>>
>>>>>> Yeah, In my case, the backend devices are typically FPGA soft cores and
>>>>>> the
>>>>>> aggregate
>>>>>> device might connect to multiple of these backends. That was one of the
>>>>>> reason why I
>>>>>> used the component API where the aggregate device is only configured
>>>>>> when
>>>>>> all the
>>>>>> devices are probed. Similarly, when one of them is unbind, the whole
>>>>>> thing
>>>>>> should be
>>>>>> torn down. Also, in my case, the frontend device needs to do a lot of
>>>>>> setup
>>>>>> on the
>>>>>> backend device so the whole thing works (so I do have/need a lot more
>>>>>> .ops).
>>>>>>
>>>>>> Anyways, it does not matter much what the backend device is and from a
>>>>>> first
>>>>>> glance
>>>>>> and looking at the .ops you have, it seems that this could easily be
>>>>>> supported in the
>>>>>> framework I'm adding. The only things I'm seeing are:
>>>>>
>>>>> Thanks for your feedback. Yes, my feeling is that the API I need for the
>>>>> dfsdm use case, can be covered by the API you propose. I'm not familiar
>>>>> with component API however, as I discovered it in your serie. It is not
>>>>> clear for me how this affects device tree description of the hardware.
>>>>
>>>> Your aggregate device (that we can think of as a frontend device needs to
>>>> properly reference all the backends it needs - in your case I guess it's
>>>> just
>>>> one device). The dts properties I have for now are 'converters' and
>>>> 'converter-
>>>> names'. But one thing that starts to become clear to me is that I should
>>>> probably change the name for the framework. Maybe industrialio-aggregate.c
>>>> if we
>>>> keep the component API (and so the same frontend + backend naming) or just
>>>> industrialio-backend.c (as you have now) if we go with a typical OF lookup.
>>>>
>>>
>>> In my case I have a digital filter peripheral (frontend) linked to
>>> several sigma delta converters (backends). So, here 'converters'
>>> property may be relevant as well. But I agree that a more generic name
>>> seems better for the long term.
>>>
>>> My backend devices need to get a regulator phandle from the device tree.
>>> It seems that the component API does not offer services allowing to
>>> retrieve DT properties for the sub-devices. Tell me if I'm wrong, but I
>>> think this constraint require to change converter framework to a typical
>>> OF lookup.
>>>
>>> Could you please share the structure of your DT for your ad9476 based
>>> example ? This will help me identify the gaps regarding my need.
>>>
>>
>> I might be missing something but there should be no limitation in the component
>> stuff for this. Note your frontend/backend devices are just normal device tree
>> nodes (meaning that they can have all the properties they want as a normal node)
>> and then in the correspondent drivers you handle all the properties. For now,
>> the only FW properties supported in the framework I sent are 'converters' and
>> 'converter-name' which will be used to "create" the aggregate device. This
>> pretty much means that the complete thing should only come up when all the
>> devices you set in DT probe.
>>
>> Of course we can move more properties into the framework if we start to see some
>> generic ones that are almost always present...
>>
>> One thing that Jonathan already mentioned is that the component API works in a
>> away that you can have either 1->1 or 1->N (frontends->backends). So, if you
>> have setups where you have more than one frontend (basically M->N) we need to
>> make sure it still works. In theory (in the component API), I think you can have
>> one backend associated with more than one frontend so we should be able to still
>> get the M->N topology. Of course the "communications link" is always between
>> frontend -> backend.
>>
>> I'll see if I send the devicetree over the weekend (don't have it in my current
>> machine)
>>
>>
> 
> Here it goes the 2 nodes of interest in my testing...
> 
> adc_ad9467: ad9467@0 {
>          compatible = "adi,ad9467";
>          reg = <0>;
> 
>          dmas = <&rx_dma 0>;
>          dma-names = "rx";
> 
>          spi-max-frequency = <10000000>;
>          adi,spi-3wire-enable;
> 
>          clocks = <&clk_ad9517 3>;
>          clock-names = "adc-clk";
> 
>          converters = <&cf_ad9467_core_0>;
> };
> 
> cf_ad9467_core_0: cf-ad9467-core-lpc@44a00000 {
>          compatible = "adi,axi-adc-10.0.a";
>          reg = <0x44A00000 0x10000>;
> 
>          clocks = <&clkc 16>;
> };
> 
> Naturally, converter-names only makes sense when you have more than one backend. But
> see that in 'cf_ad9467_core_0', you are free to place a regulator (as I have a clock)
> as long as you handle it in the backend driver.
> 
> - Nuno Sá

Thanks for the example. This helped me prototyping a dfsdm driver based 
on the converter framework. Regarding device tree and driver update this 
looks fine. I could integrate the API smartly in my frontend (dfsdm) and 
backend (sd modulator).

My prototype executes up to probe. I have noticed however that init 
(backend & frontend) ops are not called in my implementation. I can see 
that init ops are called from bind ops. component_bind_all() calls 
converter bind ops, but component_bind_all() is called from converter 
bind ops. So, I don't understand how initialization can proceed with 
these circular calls. Maybe I missed something here.

The change in the DT has an impact (But moderated) on legacy. Breaking 
the legacy was unavoidable anyway.

DFSDM legacy binding (with two channels)
       dfsdm_pdm1: filter@1 {
         compatible = "st,stm32-dfsdm-adc";
         st,adc-channels = <2 3>;
         st,adc-channel-types = "SPI_R", "SPI_R";
         ...
         io-channels = <&sd_adc2 &sd_adc3>;
       };

DFSDM binding with converter fw
     dfsdm_pdm1: filter@1 {
         compatible = "st,stm32-dfsdm-adc";
         st,adc-channels = <2 3>;
         st,adc-channel-types = "SPI_R", "SPI_R";
         ...
         converters = <&sd_adc2 &sd_adc3>;
       };

I have also the aim to change DFSDM bindings to use IIO generic channels 
bindings (bindings/iio/adc/adc.yaml).

Ideally the DFSDM bindings should looks like this:
       dfsdm_pdm1: filter@1 {
         compatible = "st,stm32-dfsdm-adc";
         channel@2 {
                 reg = <2>;
                 st,adc-channel-types = "SPI_R";
                 ...
                 converters = <&sd_adc2>;
         };
         channel@3 {
                 reg = <3>;
                 st,adc-channel-types = "SPI_R";
                 ...
                 converters = <&sd_adc3>;
         };
       };

But it seems that current framework converter API cannot support this 
topology.

As a fallback solution the following binding may be adopted
       dfsdm_pdm1: filter@1 {
         compatible = "st,stm32-dfsdm-adc";
         channel@2 {
                 reg = <2>;
                 st,adc-channel-types = "SPI_R";
                 ...
         };
         channel@3 {
                 reg = <3>;
                 st,adc-channel-types = "SPI_R";
                 ...
         };
         converters = <&sd_adc2 &sd_adc3>;

In this case the frontend driver needs a mean to map backend and 
channels. It's not the smartest solution, yet. Especially since the use 
of generic channel is quite common.
Perhaps the converter_frontend_add() API needs to be extended to support 
generic channel configuration. Maybe the IIO core should provide the 
related helpers as well. (As far as I know this does not exists).
So, still opened questions ..

That said, I feel confident that the converter framework is a good 
option for the DFSDM use case.

BRs
Olivier

>>>
