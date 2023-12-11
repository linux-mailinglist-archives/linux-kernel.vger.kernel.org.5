Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5B480CF84
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343924AbjLKP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343898AbjLKP2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:28:14 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABBAE4;
        Mon, 11 Dec 2023 07:28:20 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so2458161a12.0;
        Mon, 11 Dec 2023 07:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702308500; x=1702913300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QX/pQldXLuonw195e6/ahk3+iQHzJpP5HF8v/aVVoFc=;
        b=R0vcsfvXUY5jVjkEb6xpn3xIUElpO3qp8fI4eEtvIJw2XoruBhrfQiwEJUxgtretUM
         TJtr82Frv5ozpicPyxNIh0iKKZUX6qOJZJxzIMsGPy9o+UNJ+TcGMaupqz8RIZUIEKX0
         N9O2lj7YaEEzi5modl63E8k3hDtNMEVp0kxY3KQuZeX3bzm+zGuSBqe34nSKrBvj8BbK
         itTAG3oaiz5kPgTmxRIzcAa72upShhcjERSzkPSup/9vgeM/cLW1GZshW3ATLahmDuyq
         ELbZWOP6zTO5i93xoHwsj00WZVKQEwppqP5UTNQ6d5DL1sov2vZLJsIVWGiUQT0F6uXn
         QPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702308500; x=1702913300;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QX/pQldXLuonw195e6/ahk3+iQHzJpP5HF8v/aVVoFc=;
        b=BMPtc8hMw+ydZYpJXESRnvHmbZf857msl7pRlRZE5b1I6q+znlrD/oxIkbdICY4AAg
         3f7Hi//GpxY5yztuHjLEn7992E6b1BmWn3t3FykcFBplpnJ4d5k86r9Yp70TWEoH0vGr
         VRgE8WM0y5F+4Zpk5SHsOt2R4hhRtLjxfQj/QTrrNZffoeDUfGircWTVQrcf73uTfS75
         OJ3aAblYA/jshG0dKqnd95lI2ikz6iEB4wvjgrDleiswv460R/ABw1P5LSFfu9wltkmq
         HX0UH41QA4mZqiP7D9Eebu6JlE5iG3+t7gsuVcUsgZvc+QYLnj2LbIBJw0dICSsJ12Yc
         Dm7A==
X-Gm-Message-State: AOJu0Yw0OWre4pvfEk1IFITldrSFdhgJjsZPLrzJE/KetFVz0atY9lgY
        QQ1Bz6Ih1DIQOK3ZkK6Ei/w=
X-Google-Smtp-Source: AGHT+IH5l1GEbzeajDKZgF4FWeKvBfekspdMPd8ulXl6VW0YptbdCsyoqiz/cWy2lMzvvfbElrBP0Q==
X-Received: by 2002:a17:90a:d318:b0:286:bc9c:327c with SMTP id p24-20020a17090ad31800b00286bc9c327cmr1918761pju.22.1702308500303;
        Mon, 11 Dec 2023 07:28:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bs9-20020a632809000000b0059b2316be86sm6435498pgb.46.2023.12.11.07.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 07:28:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <37fc9395-1ef4-4e79-af4e-5d8b9090ec99@roeck-us.net>
Date:   Mon, 11 Dec 2023 07:28:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: sht3x: read out sensor serial number
Content-Language: en-US
To:     Stefan Gloor <code@stefan-gloor.ch>
Cc:     jdelvare@suse.com, corbet@lwn.net, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231204165004.8491-1-code@stefan-gloor.ch>
 <20231204165004.8491-3-code@stefan-gloor.ch>
 <69065f64-1448-4513-bdda-a25a913e914d@roeck-us.net>
 <20231211151216.yehwa27daveq57jo@thinkpad>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231211151216.yehwa27daveq57jo@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 07:12, Stefan Gloor wrote:
> On Mon, Dec 11, 2023 at 06:31:27AM -0800, Guenter Roeck wrote:
>> On Mon, Dec 04, 2023 at 05:50:04PM +0100, Stefan Gloor wrote:
>>>   
>>> +#ifdef CONFIG_DEBUG_FS
>>> +
>>> +static void sht3x_debugfs_init(struct sht3x_data *data)
>>> +{
>>> +	char name[32];
>>> +	struct dentry *sensor_dir;
>>> +
>>> +	data->debugfs = debugfs_lookup("sht3x", NULL);
>>> +	if (IS_ERR_OR_NULL(data->debugfs))
>>> +		data->debugfs = debugfs_create_dir("sht3x", NULL);
>>> +
>>> +	snprintf(name, sizeof(name), "i2c%u-%02x",
>>> +		 data->client->adapter->nr, data->client->addr);
>>> +	sensor_dir = debugfs_create_dir(name, data->debugfs);
>>> +	debugfs_create_u32("serial_number", 0444,
>>> +			   sensor_dir, &data->serial_number);
>>> +}
>>> +
>>> +#else
>>> +
>>> +static void sht3x_debugfs_init(struct sht3x_data *data)
>>> +{
>>> +}
>>> +
>>> +#endif
>>
>> debugfs doesn't need if/else or error handling.
>>
> Do you mean the IS_ERR_OR_NULL? I included that to get rid of the
> "debugfs directory already exists" message when using multiple sensors.
> 

A much easier way to do that would be to create the directory in the init function,
and to use a static variable to point to it. Note that you'll also need need an
explicit exit function to remove it when the driver is unloaded.

Thanks,
Guenter

