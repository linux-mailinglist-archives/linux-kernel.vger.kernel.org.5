Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB004792704
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjIEQEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354181AbjIEKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:06:37 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD8090;
        Tue,  5 Sep 2023 03:06:32 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3858AxNN016950;
        Tue, 5 Sep 2023 12:06:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=scab9o1vuzKmYp8hok449uqiQ9nrpBKEYFW+Y+rdU14=; b=tb
        Ou5FeDJPawXZtMG2UFCqwaqZTEk80V++0SJmgzfEAFD3d8xhJTB6RXgxYRuE+LfX
        lcf/vmgMAQxVV/aSrtHLESoGKO9c1bL7LC3jeIWWz5mtO3+S90/ni6bqxNZdiASp
        ROOAxWcsT4qpB3Hjq3fZnlcjutiN+pRSmR1Tg9xE/lsZZ6C1xroLneWklLOlT1Ga
        DYURHFjn4tpbc1zIMYPzt81TNxbeaggu4hNdJRSflYycirsPQB6F+B8eOiKBZcw+
        iO5tv9MpholJWiXOSmJ+UZUuM6ccm75sSZypkdP5qYrUKJiedrbaID4QDXZrlfSp
        jZJrQVruCtCtDjNGp+JA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3sutffbfg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 12:06:11 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B2F8B100057;
        Tue,  5 Sep 2023 12:06:10 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA6D82309C3;
        Tue,  5 Sep 2023 12:06:10 +0200 (CEST)
Received: from [10.252.5.4] (10.252.5.4) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 5 Sep
 2023 12:06:10 +0200
Message-ID: <9cf91ed4-8d57-6d84-1767-708a296803b9@foss.st.com>
Date:   Tue, 5 Sep 2023 12:06:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
Content-Language: en-US
From:   Olivier MOYSAN <olivier.moysan@foss.st.com>
In-Reply-To: <8b63cad8749ceca31d2f50ee36925ce18523620f.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.5.4]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_07,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nuno,

On 9/1/23 10:01, Nuno Sá wrote:
> Hi Olivier,
> 
> On Thu, 2023-08-31 at 18:14 +0200, Olivier MOYSAN wrote:
>> Hi Nuno,
>>
>> On 7/28/23 10:42, Nuno Sá wrote:
>>> Hi Olivier,
>>>
>>> On Thu, 2023-07-27 at 17:03 +0200, Olivier Moysan wrote:
>>>> Add a new device type in IIO framework.
>>>> This backend device does not compute channel attributes and does not expose
>>>> them through sysfs, as done typically in iio-rescale frontend device.
>>>> Instead, it allows to report information applying to channel
>>>> attributes through callbacks. These backend devices can be cascaded
>>>> to represent chained components.
>>>> An IIO device configured as a consumer of a backend device can compute
>>>> the channel attributes of the whole chain.
>>>>
>>>> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
>>>> ---
>>>>    drivers/iio/Makefile               |   1 +
>>>>    drivers/iio/industrialio-backend.c | 107 +++++++++++++++++++++++++++++
>>>>    include/linux/iio/backend.h        |  56 +++++++++++++++
>>>>    3 files changed, 164 insertions(+)
>>>>    create mode 100644 drivers/iio/industrialio-backend.c
>>>>    create mode 100644 include/linux/iio/backend.h
>>>>
>>>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>>>> index 9622347a1c1b..9b59c6ab1738 100644
>>>> --- a/drivers/iio/Makefile
>>>> +++ b/drivers/iio/Makefile
>>>> @@ -5,6 +5,7 @@
>>>>    
>>>>    obj-$(CONFIG_IIO) += industrialio.o
>>>>    industrialio-y := industrialio-core.o industrialio-event.o inkern.o
>>>> +industrialio-$(CONFIG_IIO_BACKEND) += industrialio-backend.o
>>>>    industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
>>>>    industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
>>>>    
>>>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
>>>> backend.c
>>>> new file mode 100644
>>>> index 000000000000..7d0625889873
>>>> --- /dev/null
>>>> +++ b/drivers/iio/industrialio-backend.c
>>>> @@ -0,0 +1,107 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/* The industrial I/O core, backend handling functions
>>>> + *
>>>> + */
>>>> +
>>>> +#include <linux/kernel.h>
>>>> +#include <linux/device.h>
>>>> +#include <linux/property.h>
>>>> +#include <linux/iio/iio.h>
>>>> +#include <linux/iio/backend.h>
>>>> +
>>>> +static DEFINE_IDA(iio_backend_ida);
>>>> +
>>>> +#define to_iio_backend(_device) container_of((_device), struct iio_backend,
>>>> dev)
>>>> +
>>>> +static void iio_backend_release(struct device *device)
>>>> +{
>>>> +       struct iio_backend *backend = to_iio_backend(device);
>>>> +
>>>> +       kfree(backend->name);
>>>> +       kfree(backend);
>>>> +}
>>>> +
>>>> +static const struct device_type iio_backend_type = {
>>>> +       .release = iio_backend_release,
>>>> +       .name = "iio_backend_device",
>>>> +};
>>>> +
>>>> +struct iio_backend *iio_backend_alloc(struct device *parent)
>>>> +{
>>>> +       struct iio_backend *backend;
>>>> +
>>>> +       backend = devm_kzalloc(parent, sizeof(*backend), GFP_KERNEL);
>>>>
>>>
>>> No error checking.
>>>
>>> I guess a lot of cleanings are still missing but the important thing I wanted to
>>> notice is that the above pattern is not ok.
>>> Your 'struct iio_backend *backend'' embeds a 'stuct device' which is a
>>> refcounted object. Nevertheless, you're binding the lifetime of your object to
>>> the parent device and that is wrong. The reason is that as soon as your parent
>>> device get's released or just unbinded from it's driver, all the devres stuff
>>> (including your 'struct iio_backend' object) will be released independentof
>>> your 'struct device' refcount value...
>>>
>>> So, you might argue this won't ever be an issue in here but the pattern is still
>>> wrong. There are some talks about this, the last one was given at the latest
>>> EOSS:
>>>
>>> https://www.youtube.com/watch?v=HCiJL7djGw8&list=PLbzoR-pLrL6pY8a8zSKRC6-AihFrruOkq&index=27&ab_channel=TheLinuxFoundation
>>>
>>
>> This is a good point. Thanks for pointing it out. Sure, there are still
>> many things to improve.
>>
>> I have seen the comment from Jonathan on your "Add converter framework"
>> serie. I had a quick look at the serie. It seems that we share the need
>> to aggregate some IIO devices. But I need to read it more carefully to
>> check if we can find some convergences here.
> 
> Yeah, In my case, the backend devices are typically FPGA soft cores and the aggregate
> device might connect to multiple of these backends. That was one of the reason why I
> used the component API where the aggregate device is only configured when all the
> devices are probed. Similarly, when one of them is unbind, the whole thing should be
> torn down. Also, in my case, the frontend device needs to do a lot of setup on the
> backend device so the whole thing works (so I do have/need a lot more .ops).
> 
> Anyways, it does not matter much what the backend device is and from a first glance
> and looking at the .ops you have, it seems that this could easily be supported in the
> framework I'm adding. The only things I'm seeing are:

Thanks for your feedback. Yes, my feeling is that the API I need for the 
dfsdm use case, can be covered by the API you propose. I'm not familiar 
with component API however, as I discovered it in your serie. It is not 
clear for me how this affects device tree description of the hardware. 
So I need to take time to look at existing examples.
I think I need also to try a template implementation of dfsdm use case 
based on your API, to figure out how it could work.

> 
> 1) You would need to use the component API if it's ok. Also not sure if the cascaded
> usecase you mention would work with that API.
> 

The cascaded use case by itself is not a real requirement for dfsdm use 
case. The idea here was to think about future possible needs, and to 
ensure that the solution is scalable enough. So, it is not a strong 
requirement, but we probably need to keep it in mind.

> 2) We would need to add the .read_raw() op. If you look at my RFC, I already have
> some comments/concerns about having an option like that (see there).
> 
> Having said that, none of the above are blockers as 1), I can ditch the component API
> in favour of typical FW/OF lookup (even though the component API makes some things
> easier to handle) and 2), adding a .read_raw() op is not a blocker for me.
> 

Yes, It would be nice to have read_raw(), as this allows to stick to 
existing IIO API for standard IIO attributes. But I guess this should 
not be a problem.

> Alternatively, another (maybe crazy) idea would be to have this framework have the
> really generic stuff (like lookup + generic ops) and build my iio-converter on top of
> it (extending it). You know, some OO fun :). Maybe not worth the trouble though.
> 
> Let's if Jonathan has some suggestions on how to proceed...
> 
> - Nuno Sá
>>>
> 

Olivier
