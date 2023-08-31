Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D778F3BA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbjHaUCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjHaUCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:02:38 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9711B;
        Thu, 31 Aug 2023 13:02:35 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34df0976c3bso3991945ab.2;
        Thu, 31 Aug 2023 13:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693512155; x=1694116955; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=fwRxBWWBbkN10ubdKW/uHCOV/7q0O2q4Ji9kDfhQu84=;
        b=h9/xjoSyR1qHEhNr0sivmBraSTXlXTqMtK1hOuZFTl709M2Mx1sYALfIZBUbXBDBb8
         hVjTJkmmH4g9lvQXdzeAfYiJzg0uitN39uMv7hYrEXgKvQmXbea4u3VaFM8/c9tgqZEw
         ufCdsCiIhS0EU4ysW5pSoDpohHqOXVq03AcU9GuF3zs4h8459n9dnn8KPk45gCXJP+uu
         zP2HIeYzaRksms2l/cBQoE2vNWwLmnnD9ofwvhw5MEYowp3dpwt8TQx+Zm11aSvPv8qM
         z1G7ZW6fnhcFC9JJLHPqeZWmoQv3J5x/ZyOD60rG2LOhqIhOTwoxqyMSDU1ktf7olAVW
         KlKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693512155; x=1694116955;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwRxBWWBbkN10ubdKW/uHCOV/7q0O2q4Ji9kDfhQu84=;
        b=RHh6VvQ4+WpP2vgysYfbXDLfLX5J1mxyfkLEtHLWrqnw//vLUtWFMA9RU2bqWJdFoU
         HWR19I+l+EaqTxfAe2CkToiSDcNX0yukI7H7atmeBUVNGgo8/NucQ0MPeUXSyeKv/Ewl
         s0O7O9Dx21efsVo05bDDqT0aMkSkHKI5JH/PBiLZDHena/LvpLQJXaKuh3EDeB0Z0fnT
         LKopA3R5Yv4pdSODWD993U/kWUPeQdP57tPJ1GMRaU3BBSCr6Jb8iO+u0Uf8iWVbW9p4
         OwcxLsdOmJpEYU1c0ktT06zSgMofbrJuTd9nvJnUiCQC/mLmAy/tFpOJV999N2CKzUPe
         sf9A==
X-Gm-Message-State: AOJu0YydOyrefE9Ff31WhWTdYf/Wazn8DRgwSWqweLQ7dyKETpKfozeN
        OAkRWc3NYQ0Bn8qxYPsNoAwlfYpjobY=
X-Google-Smtp-Source: AGHT+IEJAj1pVkTefkkj7cJhPthe9gp589Jjo5zciu/foCLyUTwmj3iH5J50ebb0rIRx3e8jlH0SIg==
X-Received: by 2002:a92:dd09:0:b0:34d:f0b9:97ff with SMTP id n9-20020a92dd09000000b0034df0b997ffmr567138ilm.5.1693512154718;
        Thu, 31 Aug 2023 13:02:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x10-20020a92d30a000000b003423af2fda6sm606478ila.83.2023.08.31.13.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 13:02:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6883223f-20ec-e5be-8015-256198f1305f@roeck-us.net>
Date:   Thu, 31 Aug 2023 13:02:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] hwmon: add POWER-Z driver
Content-Language: en-US
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20230831-powerz-v2-1-5c62c53debd4@weissschuh.net>
 <ca72a21b-af05-c754-99a0-34d913edf304@roeck-us.net>
 <ecb91dd0-1b0e-4227-b4ab-79f85a93f43a@t-8ch.de>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ecb91dd0-1b0e-4227-b4ab-79f85a93f43a@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 11:03, Thomas Weißschuh wrote:
> Hi Guenter,
> 
> thanks for your review!
> 
> Ack to most of your points.
> 
>> [..]
> 
>>> +
>>> +#define DRIVER_NAME	"powerz"
>>> +#define POWERZ_EP_CMD_OUT	0x01
>>> +#define POWERZ_EP_DATA_IN	0x81
>>> +
>>> +struct powerz_sensor_data {
>>> +	u8 _unknown_1[8];
>>> +	__le32 Vbus;
>>
>> CHECK: Avoid CamelCase: <Vbus>
>> #160: FILE: drivers/hwmon/powerz.c:18:
>> +	__le32 Vbus;
>>
>> Please run your patches through checkpatch --strict.
> 
> I did. Weird that it didn't show. I'll investigate.
> (And fix it)
> 
>>
>>> +	__le32 Ibus;
>>> +	__le32 Vbus_avg;
>>> +	__le32 Ibus_avg;
>>> +	u8 _unknown_2[8];
>>> +	u8 temp[2];
>>> +	__le16 cc1;
>>> +	__le16 cc2;
>>> +	__le16 dp;
>>> +	__le16 dm;
>>> +	u8 _unknown_3[6];
>>> +} __packed;
>>> +
> 
>> [..]
> 
>>> +static int powerz_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>>> +		       int channel, long *val)
>>> +{
>>> +	struct usb_interface *intf = to_usb_interface(dev->parent);
>>> +	struct usb_device *udev = interface_to_usbdev(intf);
>>> +	struct powerz_sensor_data *data;
>>> +	struct powerz_usb_ctx *ctx;
>>> +
>>> +	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
>>> +	if (!ctx)
>>> +		return -ENOMEM;
>>> +
>>
>> I think it would be much better to allocate ctx once as part of
>> struct powerz_priv and keep it around. Sure, that means that this
>> function requires a lock, but I don't see that as problem (and who
>> knows how the device reacts to multiple pending usb transactions).
>>
>> You'd need to allocate transfer_buffer separately because it needs to be
>> dma aligned, but that should not be a problem either.
> 
> What is your opinion on making the transfer buffer the first member of
> struct powerz_priv? It would simplify the code and still provide a
> DMA-capable buffer.
> 

Sure, works for me.

>> [..]
> 
>>> +static int powerz_probe(struct usb_interface *intf, const struct usb_device_id *id)
>>> +{
>>> +	struct usb_device *udev = interface_to_usbdev(intf);
>>> +	struct powerz_priv *priv;
>>> +	struct device *parent;
>>> +	const char *name;
>>> +	int ret;
>>> +
>>> +	parent = &intf->dev;
>>> +
>>> +	priv = devm_kzalloc(parent, sizeof(*priv), GFP_KERNEL);
>>> +	if (!priv)
>>> +		return -ENOMEM;
>>> +
>>> +	name = devm_hwmon_sanitize_name(parent, udev->product ?: DRIVER_NAME);
>>
>> Why not just use DRIVER_NAME ? This would be much more consistent.
> 
> I liked the more detailed name better.
> But if you prefer otherwise I'll simplify it.
> 

I think it just confuses users because it isn't well defined.

Thanks,
Guenter

