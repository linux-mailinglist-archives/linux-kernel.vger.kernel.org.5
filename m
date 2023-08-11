Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7EA7787B4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 08:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjHKGz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 02:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHKGz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 02:55:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B99213F;
        Thu, 10 Aug 2023 23:55:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-523029050d0so390666a12.0;
        Thu, 10 Aug 2023 23:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691736951; x=1692341751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4jjM96ljo2gWgu4nQWT3dXB9/7Tq5SplO4hPZ2Z6omE=;
        b=NmsF2qCDhQJbspEWQ/5aalMrATaCEvYrenXzrPgDOquDXQAjd9eJK5guI+YPW4ZiMG
         b67Sqfpqrq5qV96DEicx/bRzL++YtPVQPijlHfJVhCtsCNdbbxZBTL7VDpsIwiKXcrpl
         5BcTHmDkmKPkckrXMAN6fMMFUJTcB4FmHir4eq865knPjK0KSdpVTUez2bk2ZmmqPtQd
         qm8sx+mMy++u2wYd3jNZSeXwaXI++bNdo7aw3aCgtKdk5FXC/1yu29hNarAAb6lyysCY
         u1wzDzSYH1vsOWzQrg1Mi3OI1H/vWtODtYtNyW/TLLfVMiWu9xbCeA6Vut1QBHbU65zA
         rufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691736951; x=1692341751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4jjM96ljo2gWgu4nQWT3dXB9/7Tq5SplO4hPZ2Z6omE=;
        b=hpA//j7t8mjX89z2PXcRMpG9JSOjL0SCJbtY/nr4gFxIrktff+Wrvsaf5GDlmFYSa9
         vhEXFfqPZq9q7vUWKwTbYniWVcfWIE0coBFpf5fVIvpEzNxENNgEXuXjI8z84otw3T1C
         cJm9oDag1rPdwPrbVJuyU2nxevs5EkhZdDE8DJMR/cnTcBLMvyA3tLJplfJpu7i2Xo8M
         cydZyCj4JiMHY9s/4FUnyVLfSgq0DO4q01C8g2zOHfxv6NIDJEmMRRJ0LSRRSQoMjcAU
         NMTL1yBtjITxTPPmEw81sO8SHSW+L/8+lN8lgfot75CEnB13vjyU5VSagwScKik+A7M7
         ETCQ==
X-Gm-Message-State: AOJu0YwLF1zyBrs0qw8F45CMWv0PXEdnPQNOfWR1XaDasdVGn8EMMl51
        cnW/WHTB6QU2asIKkI17jfpGmCUffsTv4ycC
X-Google-Smtp-Source: AGHT+IE9z6lqFVjmqsoh8EJjPGXgtRtnBtdoJ4spQOuFH99KJLh5hw91RW6ZbfXIqFQPCMtiS4T+Gw==
X-Received: by 2002:a05:6402:2695:b0:523:3e5b:52da with SMTP id w21-20020a056402269500b005233e5b52damr872882edd.2.1691736951369;
        Thu, 10 Aug 2023 23:55:51 -0700 (PDT)
Received: from [192.168.10.215] ([141.136.93.153])
        by smtp.gmail.com with ESMTPSA id b18-20020aa7d492000000b0052333d7e320sm1650013edr.27.2023.08.10.23.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 23:55:51 -0700 (PDT)
Message-ID: <003003ae-8f28-931c-3d83-bb33b8e28c1d@gmail.com>
Date:   Fri, 11 Aug 2023 10:55:48 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] fpga: bridge: make fpga_bridge_class a static const
 structure
Content-Language: en-US
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
References: <20230810172210.6338-1-ivan.orlov0322@gmail.com>
 <ZNWmhLCeEu07AMPK@yilunxu-OptiPlex-7050>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <ZNWmhLCeEu07AMPK@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/23 07:09, Xu Yilun wrote:
> On 2023-08-10 at 21:22:08 +0400, Ivan Orlov wrote:
>> Now that the driver core allows for struct class to be in read-only
>> memory, move the fpga_bridge_class structure to be declared at build
>> time placing it into read-only memory, instead of having to be
>> dynamically allocated at boot time.
>>
>> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
>> ---
>>   drivers/fpga/fpga-bridge.c | 106 ++++++++++++++++++-------------------
>>   1 file changed, 52 insertions(+), 54 deletions(-)
>>
>> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
>> index a6c25dee9cc1..6e38ddaf16cf 100644
>> --- a/drivers/fpga/fpga-bridge.c
>> +++ b/drivers/fpga/fpga-bridge.c
>> @@ -14,7 +14,6 @@
>>   #include <linux/spinlock.h>
>>   
>>   static DEFINE_IDA(fpga_bridge_ida);
>> -static struct class *fpga_bridge_class;
> 
> Could we still use the forward declaration, to avoid moving too
> much code block.
> 
>>   
>>   /* Lock for adding/removing bridges to linked lists*/
>>   static DEFINE_SPINLOCK(bridge_list_lock);
>> @@ -84,6 +83,53 @@ static struct fpga_bridge *__fpga_bridge_get(struct device *dev,
>>   	return ERR_PTR(ret);
>>   }
>>   
>> +static ssize_t name_show(struct device *dev,
>> +			 struct device_attribute *attr, char *buf)
>> +{
>> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>> +
>> +	return sprintf(buf, "%s\n", bridge->name);
>> +}
>> +
>> +static ssize_t state_show(struct device *dev,
>> +			  struct device_attribute *attr, char *buf)
>> +{
>> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>> +	int state = 1;
>> +
>> +	if (bridge->br_ops && bridge->br_ops->enable_show) {
>> +		state = bridge->br_ops->enable_show(bridge);
>> +		if (state < 0)
>> +			return state;
>> +	}
>> +
>> +	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
>> +}
>> +
>> +static DEVICE_ATTR_RO(name);
>> +static DEVICE_ATTR_RO(state);
>> +
>> +static struct attribute *fpga_bridge_attrs[] = {
>> +	&dev_attr_name.attr,
>> +	&dev_attr_state.attr,
>> +	NULL,
>> +};
>> +ATTRIBUTE_GROUPS(fpga_bridge);
>> +
>> +static void fpga_bridge_dev_release(struct device *dev)
>> +{
>> +	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>> +
>> +	ida_free(&fpga_bridge_ida, bridge->dev.id);
>> +	kfree(bridge);
>> +}
>> +
>> +static const struct class fpga_bridge_class = {
>> +	.name = "fpga_bridge",
>> +	.dev_groups = fpga_bridge_groups,
>> +	.dev_release = fpga_bridge_dev_release,
>> +};
> 
> Insert them between __fpga_bridge_get() and of_fpga_bridge_get() is not
> preferred. See below comments.
> 
>> +
>>   /**
>>    * of_fpga_bridge_get - get an exclusive reference to an fpga bridge
>>    *
>> @@ -99,7 +145,7 @@ struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
>>   {
>>   	struct device *dev;
>>   
>> -	dev = class_find_device_by_of_node(fpga_bridge_class, np);
>> +	dev = class_find_device_by_of_node(&fpga_bridge_class, np);
>>   	if (!dev)
>>   		return ERR_PTR(-ENODEV);
>>   
>> @@ -126,7 +172,7 @@ struct fpga_bridge *fpga_bridge_get(struct device *dev,
>>   {
>>   	struct device *bridge_dev;
>>   
>> -	bridge_dev = class_find_device(fpga_bridge_class, NULL, dev,
>> +	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
>>   				       fpga_bridge_dev_match);
>>   	if (!bridge_dev)
>>   		return ERR_PTR(-ENODEV);
>> @@ -281,39 +327,6 @@ int fpga_bridge_get_to_list(struct device *dev,
>>   }
>>   EXPORT_SYMBOL_GPL(fpga_bridge_get_to_list);
>>   
>> -static ssize_t name_show(struct device *dev,
>> -			 struct device_attribute *attr, char *buf)
>> -{
>> -	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>> -
>> -	return sprintf(buf, "%s\n", bridge->name);
>> -}
>> -
>> -static ssize_t state_show(struct device *dev,
>> -			  struct device_attribute *attr, char *buf)
>> -{
>> -	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>> -	int state = 1;
>> -
>> -	if (bridge->br_ops && bridge->br_ops->enable_show) {
>> -		state = bridge->br_ops->enable_show(bridge);
>> -		if (state < 0)
>> -			return state;
>> -	}
>> -
>> -	return sysfs_emit(buf, "%s\n", state ? "enabled" : "disabled");
>> -}
>> -
>> -static DEVICE_ATTR_RO(name);
>> -static DEVICE_ATTR_RO(state);
>> -
>> -static struct attribute *fpga_bridge_attrs[] = {
>> -	&dev_attr_name.attr,
>> -	&dev_attr_state.attr,
>> -	NULL,
>> -};
>> -ATTRIBUTE_GROUPS(fpga_bridge);
>> -
>>   /**
>>    * fpga_bridge_register - create and register an FPGA Bridge device
>>    * @parent:	FPGA bridge device from pdev
>> @@ -359,7 +372,7 @@ fpga_bridge_register(struct device *parent, const char *name,
>>   	bridge->priv = priv;
>>   
>>   	bridge->dev.groups = br_ops->groups;
>> -	bridge->dev.class = fpga_bridge_class;
>> +	bridge->dev.class = &fpga_bridge_class;
>>   	bridge->dev.parent = parent;
>>   	bridge->dev.of_node = parent->of_node;
>>   	bridge->dev.id = id;
>> @@ -407,29 +420,14 @@ void fpga_bridge_unregister(struct fpga_bridge *bridge)
>>   }
>>   EXPORT_SYMBOL_GPL(fpga_bridge_unregister);
>>   
>> -static void fpga_bridge_dev_release(struct device *dev)
>> -{
>> -	struct fpga_bridge *bridge = to_fpga_bridge(dev);
>> -
>> -	ida_free(&fpga_bridge_ida, bridge->dev.id);
>> -	kfree(bridge);
>> -}
>> -
> 
> How about put the fpga_bridge_class definition here?
> 
> Thanks,
> Yilun

Hi Yilun,

Thank you for the review, I agree that forward declaration is better in 
this case. I'll send you the V2 after making suggested changes.

--
Kind regards,
Ivan Orlov
