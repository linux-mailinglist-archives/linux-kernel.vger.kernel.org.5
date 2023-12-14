Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042058130A6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 13:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573166AbjLNM5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 07:57:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573145AbjLNM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 07:57:33 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7751BA6;
        Thu, 14 Dec 2023 04:57:39 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a1db6c63028so935949866b.2;
        Thu, 14 Dec 2023 04:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702558658; x=1703163458; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g2GKWz1rRyCNwha7gGcRolq2RILUdPIiIt5FzDdvILQ=;
        b=R55KsC/NDMFJnCucTbjK5g5o6ELzDY2jFcfTZR678xc3Cyqzv4YZEAfkohXIY2IU07
         4dl4paNF15fmPy/hDhPj4ZT9E/ws8+OPCaaEZXSf745M3Mza6oET9Y+g0BvZub2aDCKH
         lHVcwFLKwhyCwvdWLhDXy6mUPqgAe7lfRhv0ubP7boMtSjypehMixvZk41QdZXx2NyM/
         RrI7cu6nbU3pT9XRYB/PtgZUKhsJg+O4JqxnSS1H9uloO3a794NcJJy3ijw+CpFR99tL
         fvRd7A/zUqUO0zZCvA1kM/ZfLPRFL//PzPpphkn4gvi2h/VVWCi4WBOQDKAyhvvQeWZE
         sQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702558658; x=1703163458;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2GKWz1rRyCNwha7gGcRolq2RILUdPIiIt5FzDdvILQ=;
        b=fnXUPG4rDFyD+WBn32ix6SI74MeCIA64XP/p0HXV+lPPaNrNkMYKKigvQvLSrgan10
         MNbXKTPo3YdP8gZiqPPs8p11Tvwi860UvQN6cN91+EMsj8oUE0SdwZB6j5Dg15KVNLF/
         1krsZgZ1qo88P+JxiET/QX7UAh5o9KsNo0nUfOPW7LIffr1jpmWNp+8RPf3hcewuIRI2
         5pr8jvlkydqj+9pqCx9VQ27meRr5TN6di+wabj3Xa+xG1HMpnU9e07DN0K5GMQ0992hK
         yojN3OiqGXLHEB4lTfQdN3puUoUlTGN9DJNONA/VlLBdz9OhodWMxBs259ElAl0enwfS
         Swmw==
X-Gm-Message-State: AOJu0YyTmFIzCznmuAM9dzM5NctEhmlUlOFmuQXcXqXEZeTOfv0smpyU
        EmHXAhpHTWNxtcV3CMLbtlU=
X-Google-Smtp-Source: AGHT+IHtIY7rFcQC93tfnJBXkLGQRNbPQabINCfXb9w5tCgijrk98Ge2WRXokyVfdLbqczA2V1R56A==
X-Received: by 2002:a17:906:4546:b0:a01:fc1b:8197 with SMTP id s6-20020a170906454600b00a01fc1b8197mr4262851ejq.62.1702558657491;
        Thu, 14 Dec 2023 04:57:37 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id ub14-20020a170907c80e00b00a1da5d9a602sm9368347ejc.138.2023.12.14.04.57.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 04:57:36 -0800 (PST)
Message-ID: <375bf803-a5d5-4778-938a-b8218b116375@gmail.com>
Date:   Thu, 14 Dec 2023 14:57:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] iio: adc: ad7173: add AD7173 driver
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231212104451.22522-1-mitrutzceclan@gmail.com>
 <20231212104451.22522-2-mitrutzceclan@gmail.com>
 <20231214123029.000002f1@Huawei.com>
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20231214123029.000002f1@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/14/23 14:30, Jonathan Cameron wrote:
> On Tue, 12 Dec 2023 12:44:36 +0200
> Dumitru Ceclan <mitrutzceclan@gmail.com> wrote:
> 
>> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
>> which can be used in high precision, low noise single channel
>> applications or higher speed multiplexed applications. The Sigma-Delta
>> ADC is intended primarily for measurement of signals close to DC but also
>> delivers outstanding performance with input bandwidths out to ~10kHz.
>>
>> Reviewed-by: Michael Walle <michael@walle.cc> # for gpio-regmap
>> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> Hi
> 
> Given it seems like you'll be doing a v9, one quick comment from me below.
> 
> Jonathan
> 
>> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
>> new file mode 100644
>> index 000000000000..96918b24a10a
>> --- /dev/null
>> +++ b/drivers/iio/adc/ad7173.c
>> @@ -0,0 +1,964 @@
> ...
> 
>> +static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev)
>> +{
> 
> ...
> 
>> +
>> +	if (st->info->has_temp) {
>> +		chan_arr[chan_index] = ad7173_temp_iio_channel_template;
>> +		chan_st_priv = &channels_st_priv_arr[chan_index];
>> +		chan_st_priv->ain =
>> +			AD7173_CH_ADDRESS(chan_arr[chan_index].channel, chan_arr[chan_index].channel2);
>> +		chan_st_priv->cfg.bipolar = false;
>> +		chan_st_priv->cfg.input_buf = true;
>> +		chan_st_priv->cfg.ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
>> +		st->adc_mode |= AD7173_ADC_MODE_REF_EN;
>> +
>> +		chan_index++;
>> +	}
>> +
>> +	device_for_each_child_node(dev, child) {
>> +		chan = &chan_arr[chan_index];
>> +		chan_st_priv = &channels_st_priv_arr[chan_index];
>> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
>> +						     ain, ARRAY_SIZE(ain));
>> +		if (ret) {
>> +			fwnode_handle_put(child);
>> +			return ret;
>> +		}
>> +
>> +		if (ain[0] >= st->info->num_inputs ||
>> +		    ain[1] >= st->info->num_inputs) {
>> +			fwnode_handle_put(child);
>> +			return dev_err_probe(dev, -EINVAL,
>> +					     "Input pin number out of range for pair (%d %d).\n",
>> +					     ain[0], ain[1]);
>> +		}
>> +
>> +		ret = fwnode_property_match_property_string(child,
>> +							    "adi,reference-select",
>> +							    ad7173_ref_sel_str,
>> +							    ARRAY_SIZE(ad7173_ref_sel_str));
>> +
>> +		if (ret < 0)
>> +			ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
>> +		else
>> +			ref_sel = ret;
> Simpler pattern for properties with a default is not to check the error code.
> 
> 		ref_sel = AD7173_SETUP_REF_SEL_INT_REF;
> 
> 		fwnode_property_match_property_String(child, ...
> 
> so only if it succeeds is the value overridden.

Where exactly would the value be overridden, the function does not have
an argument passed for the found index. The function is written to
return either the found index or a negative error.

The proposed pattern would just ignore the returned index and would
always leave ref_sel to default. Am I missing something?

I can see in the thread where it was introduced that you proposed:
"Looking at the usecases I wonder if it would be better to pass in

an unsigned int *ret which is only updated on a match?"

But on the iio togreg branch that was suggested I could the function on,
it does not have that parameter.
