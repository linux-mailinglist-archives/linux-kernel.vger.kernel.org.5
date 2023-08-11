Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BA51778D2E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbjHKLLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234926AbjHKLLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:11:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EAEED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:11:22 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977e0fbd742so254903166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691752280; x=1692357080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nkarAxgPawRkHPuqEmVAhp5coc9Enpd1p54z8XhUNR0=;
        b=HhLQHL2q4FMBWaRADl7oilv0xHC0G+ChUtfzHtXBiHo+Y1e0FeA850q5x/X4QtfD41
         oIEdUXY4sqQi/in1/E+jT6CzBXm820hIJ3kL+ITiFb3FzpgBUCt08NXUTYVKaAqS9Lb8
         HM/qOR5DkaOHpFCuLB7lxL3DxsHMD/pZyK40pt3s+45WuS7heXildCR2He+hoy++pgfP
         RGR/2r2h5Ey7GCWu0WykrzqKV23q9IP4lK1qkTtv/O6VqIqThSf2t3AhgS6Ih7whNIZx
         QnxbSQPn0FlzHqDmqApw/GepeHuh+Pfoy/Rh4/swLiuhCS2ZHi2lOwPAYwSQeBOZr9w3
         L4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691752280; x=1692357080;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nkarAxgPawRkHPuqEmVAhp5coc9Enpd1p54z8XhUNR0=;
        b=Vg8OnQ3Vu3KGw+42U4xJvipoPLjFlcMZOrybz3dQsgZRLA9qb10wEeTcK1TixZcYKa
         xD1biZcNnYZwJhnmCgLAzKwWzf/3rYAQQ2jryru9Lgusa1rStvxFvEXKJWVqRc9zMjfs
         q+Hsq7m1Ohj90LS+UxTBLqH2072WbVWhLXeZgWzE9qBK5qK1WciBYGIATJIaJB8N8KRQ
         FtSAQSvj4L3DDXpaZ3mRy+F+/ehNwgwgJkSbPXLxkLMT20F8/4KCFH5If4T6+/vvG2Eb
         EmasiZsvTQguv3hs6qTr7WN2tCWHr2kiqyKh2n5wREeXMAo2OLGYEHy1BjrgiWB92WtK
         ssPA==
X-Gm-Message-State: AOJu0YwV9ZDcqTdqPpgxU6xD4N1u4bIgv+9e0IAlhOzHV4crhRoKiunn
        f/4D8oWVmqdUnLs4WxJMyD/5lg==
X-Google-Smtp-Source: AGHT+IEc0i7P0MMJ5+1AicaVHnO7wGODbep8ygEpRSLo+ZNh1KuLJia4wxP3LD/MeLJDSTKBxVGOrg==
X-Received: by 2002:a17:907:7716:b0:997:eae6:9350 with SMTP id kw22-20020a170907771600b00997eae69350mr1388529ejc.51.1691752280574;
        Fri, 11 Aug 2023 04:11:20 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id kd5-20020a17090798c500b00982d0563b11sm2101067ejc.197.2023.08.11.04.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 04:11:20 -0700 (PDT)
Message-ID: <05aea50f-6692-962e-abe7-765197815f03@linaro.org>
Date:   Fri, 11 Aug 2023 12:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 1/7] nvmem: core: Create all cells before adding the
 nvmem device
Content-Language: en-US
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
 <20230808062932.150588-2-miquel.raynal@bootlin.com>
 <b49f8d07-9de9-48b5-27bd-fce02a82c515@linaro.org>
 <20230808092433.039e2f48@xps-13>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230808092433.039e2f48@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2023 08:24, Miquel Raynal wrote:
> Hi Srinivas,
> 
> srinivas.kandagatla@linaro.org wrote on Tue, 8 Aug 2023 07:56:47 +0100:
> 
>> On 08/08/2023 07:29, Miquel Raynal wrote:
>>> Let's pack all the cells creation in one place, so they are all created
>>> before we add the nvmem device.
>>>
>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>> ---
>>>    drivers/nvmem/core.c | 12 ++++++------
>>>    1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>> index 3f8c7718412b..48659106a1e2 100644
>>> --- a/drivers/nvmem/core.c
>>> +++ b/drivers/nvmem/core.c
>>> @@ -998,12 +998,6 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>>    	if (rval)
>>>    		goto err_remove_cells;
>>>    > -	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>>> -
>>> -	rval = device_add(&nvmem->dev);
>>> -	if (rval)
>>> -		goto err_remove_cells;
>>> -
>>>    	rval = nvmem_add_cells_from_fixed_layout(nvmem);
>>>    	if (rval)
>>>    		goto err_remove_cells;
>>> @@ -1012,6 +1006,12 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>>>    	if (rval)
>>>    		goto err_remove_cells;
>>>    > +	dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>>> +
>>> +	rval = device_add(&nvmem->dev);
>>> +	if (rval)
>>> +		goto err_remove_cells;
>>
>> All the error handling paths are now messed up with this patch, put_device() in error path will be called incorrectly from multiple places.
> 
> I'm not sure what this means. Perhaps I should additionally call
> device_del() after device_add was successful to mimic the
> device_unregister() call from the remove path. Is that what you mean?


This looks perfectly fine, no change required. This also fixes a bug of 
missing device_del() in err path.

pl, Ignore my old comments.

> 
> I also see the layout_np below should be freed before jumping in the
> error section.

you mean missing of_node_put()?

--srini
