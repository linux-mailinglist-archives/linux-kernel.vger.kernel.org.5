Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24E75DFF8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 07:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjGWFJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 01:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWFJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 01:09:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB2810E7;
        Sat, 22 Jul 2023 22:09:14 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-5216569f9e3so5156684a12.0;
        Sat, 22 Jul 2023 22:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690088953; x=1690693753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KglQgMbRlKTqODEIIOL/flrqvJ7lLQMAGylCxt4/neU=;
        b=ni+aLBlmW+HggRhGUw67SPgBHPFuxEvkpw8VKR4i74K6u5t6dLSWSURh9pcmY4dgMl
         oMhSXnPqYz2SflbOGj+FoDDQU04t6kabGavq08Zlr6Sx3GAjKnK0LcNeaqCg30vyt24f
         gAwBxYrRQEv9iDkpg/cViUGFoDUNaCPUEYfIGZvuvyME0MyexFF++J7h9CMr6kxFrNo4
         m9QTMrVHJGEVg/LI76G23a+DltXA94laKNlDN1lmbr8yL6fp6ZdxghDc2qV9CmpGx4VF
         x2ESeooJFl13hb542QNZjyOJYuxan3toKZUlV/+ddlcSAAO359jPefzcNIPP4qNWrY7Z
         dUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690088953; x=1690693753;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KglQgMbRlKTqODEIIOL/flrqvJ7lLQMAGylCxt4/neU=;
        b=NlU/BZwfhTTRgF8SijUwWe1JAfE4Xv9XHwLL37YjkmrE3MbWWWIGolPXzvUdguV7Es
         onGnvD06gx+2v2dSUq63SX9/p9QOWbyhGSiGjeOYhXGGMRQtIucMFbtwJY1GWmFyZm2D
         fjZjt5rEi83v5P3NAKnP0VNorgp9Vdoa6fTx8vuSB6K6KAySU2OM4c1LbGhLFRFU1pQH
         NsI49XyzZKwmo24VJgMqkaS1ajojTClO9sfFZlCgSDH+G7OLCLCz9yzjmO6yXyrT/F7a
         U/SdnR99KCxM8b9pYwz98HGY5teeIFyZD5OZr17z0uNDs7Gno8fGVSq24ldusiHHEvPD
         eJpA==
X-Gm-Message-State: ABy/qLaIp/Lt2s+ek+ksxCZ76hb47wJWJQIIaqSvuB2kIqQ7aCoDVp1s
        HN+ACc7iPRHgUYefLPtNuaq1cD7olI6zSw==
X-Google-Smtp-Source: APBJJlFcF1tobm4kLvzySpBTN70OFQgWpHOzNOg6F0vgM+GgCXK+SH2sqEVCes46Qi5z6j7tY9a1Vg==
X-Received: by 2002:a05:6402:742:b0:522:1dcb:c355 with SMTP id p2-20020a056402074200b005221dcbc355mr2627220edy.16.1690088952740;
        Sat, 22 Jul 2023 22:09:12 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7c04a000000b0050488d1d376sm4286995edo.0.2023.07.22.22.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 22:09:12 -0700 (PDT)
Message-ID: <739ea3c7-7181-183c-799d-a3f9403c7f66@gmail.com>
Date:   Sun, 23 Jul 2023 07:09:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] iio: add MCP4728 I2C DAC driver
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1689857295.git.andrea.collamati@gmail.com>
 <3d08130fcb093fea3f755848690db9b2c8e1cb75.1689857295.git.andrea.collamati@gmail.com>
 <20230720201311.0142db3d@jic23-huawei>
From:   Andrea Collamati <andrea.collamati@gmail.com>
In-Reply-To: <20230720201311.0142db3d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 7/20/23 21:13, Jonathan Cameron wrote:
>> +static const char *const mcp4728_vref_modes[] = {
>> +	"vdd_ext",
>> +	"internal",
>> +};
>> +
>> +static int mcp4728_get_vref_mode(struct iio_dev *indio_dev,
>> +				 const struct iio_chan_spec *chan)
>> +{
>> +	struct mcp4728_data *data = iio_priv(indio_dev);
>> +
>> +	return data->channel_data[chan->channel].ref_mode;
>> +}
>> +
>> +static int mcp4728_set_vref_mode(struct iio_dev *indio_dev,
>> +				 const struct iio_chan_spec *chan,
>> +				 unsigned int mode)
>> +{
>> +	struct mcp4728_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	data->channel_data[chan->channel].ref_mode = mode;
>> +
>> +	if (mode == MCP4728_VREF_EXTERNAL_VDD &&
>> +	    data->channel_data[chan->channel].g_mode == MCP4728_GAIN_X2) {
>> +		dev_warn(&data->client->dev,
>> +			 "CH%d: Gain x2 not effective when vref is vdd, force to x1",
>> +			 chan->channel);
> Even better if you don't present the option at all and wrap it up in the
> standard ABI of _scale
>
I think that the solution could be:

- Removing custom ABI (vref/gain)

- Initialize them at device tree level using two 4-elements arrays.

- Finally using the same approach of https://github.com/torvalds/linux/blob/c2782531397f5cb19ca3f8f9c17727f1cdf5bee8/drivers/iio/dac/mcp4725.c#L462 where after having  synced current parameters stored in EEPROM they are updated with the ones specified in dts.


Best regards

                       Andrea


