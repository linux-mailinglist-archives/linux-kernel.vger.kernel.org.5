Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB1B7A4BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbjIRPWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjIRPWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:22:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EB3CC9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:21:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so2833306a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1695050434; x=1695655234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9zireYzfZqPvtmuSRJPvpYJD83Rj6yAr7QXhkyH79c=;
        b=NFDGMAHRraOLQP7dDl3tliKzHXofkkfKIfbDnwTbBnxVpeiXwYg/yX70sVogp4lGWd
         m4OlfqC7Bu5sJGbfbbQ04T6zZ+Nvrsskma67oriWeaasQp5R2J6Koic9c+bf9RTcfE1N
         FSjO0KW2botLd0+ZXi4Vh9zz0rPtsKX8cGaUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050434; x=1695655234;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9zireYzfZqPvtmuSRJPvpYJD83Rj6yAr7QXhkyH79c=;
        b=lM2tE8ELKd3MZ0on9d2Woz7umjCYk/ugK0Ev2h9LFXvmWamSIrIFpE3I/jT8ZFIhHe
         +HZ/xTEyIL3rT/yi9thBxzvrqPkjF4JkxGcWDCJCR4ZVQzjnrhPj8o+KZFJz9fRrOQ5P
         luGDl0yFPhD9aECB0AqphR3tE85vOWtzQHlEZljQtBEQ0ZHbMg2MDM9IexxtSlqzgueF
         vByI3/LwStVc1c7DdZ1BfNfznD9mQRouBpJYTiVCQnyYybvOZa0X3a9KlE23C53JYgWY
         IdX3vBK+gZH5Ay9wX/bV59Jr0ryZkHEj4KrZ5YRBqw7nWofWqtZpJ2d7FXbBZMxzOZdF
         i+Ug==
X-Gm-Message-State: AOJu0YyaA4fz84recJZP/1vHN1clxVXz6eCUrRqGta7/h4Pgf3cwekmO
        WDrso1qMplT9SKbRmmIZqH063sGjUbBKdWHTI2O0Dg==
X-Google-Smtp-Source: AGHT+IG85HoCQwWQ+0t5nMcdQfG4+rFMbC0pjWDcLyJx5ppNu+YRsczWqfK45z60KXWJ0QobOv5rxA==
X-Received: by 2002:a17:906:fe4a:b0:9a1:e0b1:e919 with SMTP id wz10-20020a170906fe4a00b009a1e0b1e919mr16662172ejb.4.1695048523437;
        Mon, 18 Sep 2023 07:48:43 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id o15-20020a1709061d4f00b009a1e73f2b4bsm6555817ejh.48.2023.09.18.07.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:48:42 -0700 (PDT)
Message-ID: <c6caae28-01fc-2354-6c7a-3f515a0e1402@rasmusvillemoes.dk>
Date:   Mon, 18 Sep 2023 16:48:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 2/2] platform/x86: think-lmi: Use strreplace() to
 replace a character by nul
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Pearson <markpearson@lenovo.com>,
        Mark Gross <markgross@kernel.org>
References: <20230913092701.440959-1-andriy.shevchenko@linux.intel.com>
 <20230913092701.440959-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US, da
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230913092701.440959-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 11.27, Andy Shevchenko wrote:

> @@ -921,7 +913,7 @@ static ssize_t display_name_show(struct kobject *kobj, struct kobj_attribute *at
>  static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>  {
>  	struct tlmi_attr_setting *setting = to_tlmi_attr_setting(kobj);
> -	char *item, *value, *p;
> +	char *item, *value;
>  	int ret;
>  
>  	ret = tlmi_setting(setting->index, &item, LENOVO_BIOS_SETTING_GUID);
> @@ -934,8 +926,7 @@ static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *a
>  		ret = -EINVAL;
>  	else {
>  		/* On Workstations remove the Options part after the value */
> -		p = strchrnul(value, ';');
> -		*p = '\0';
> +		strreplace(value, ';', '\0');

So how do you know that the string contains at most one ';'? Same for
all the other replacements. If that's not guaranteed, this is not at all
equivalent.

Or maybe the result is just used a normal string afterwards, and it
doesn't matter at all how the content after the first ';' has been mangled?

It's certainly not obvious to me that this is correct, but of course I
know nothing about this code.

Rasmus

