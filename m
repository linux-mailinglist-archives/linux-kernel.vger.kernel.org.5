Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B076B4F8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 14:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbjHAMoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHAMoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 08:44:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77151FD2;
        Tue,  1 Aug 2023 05:44:19 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso4560058e87.1;
        Tue, 01 Aug 2023 05:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690893858; x=1691498658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6luXjnOL4UWMb4FJX9zuO9FE/E5YxfEl36iSelVa4c=;
        b=SlFkjkMfmEh0jUneuZW2U10pB6Q33WGnT0VGl4bR+6rW99eLlJ2wFCITS+0BZXTYgT
         EkKcUv50/sv8/jtH07gjmwr/HK/9lc0zFHinorSzWU7qOVDKtuJFLJVoo662CYgLE0wd
         W+RLD29pvKI1I3Hmz4JlpA1MHiKrJVldwX0gsoJGstZJOzNOa7516GIAMicdJtW4x9uc
         Rt6DquwgjZWbT9mSJzbqFxrnIaq9Qt9yNy5gnF6bcooHRLEI+YZanjmLNUy9Qk+MHY/m
         Gu1kw4SAafKmS/uKdnShHYrwQGfA/DXOvGDkT5wh7F4uin4q4zAiOgs4HdMF3WIAQi9T
         qCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690893858; x=1691498658;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6luXjnOL4UWMb4FJX9zuO9FE/E5YxfEl36iSelVa4c=;
        b=XNgpWCfzyyvIvcTEEmFyuGUkHLBov9qTMbcjaXgG1ZN4RX2Oow2odoV6imyKOesAEz
         zMRbBcmWkclb9jixkdzno/HNIOa8ZvG+/dYunuUR5qLmYzlaQopWrMNt4Kw4TYam8NXQ
         5ZtEJUsmkobBqh4upuHkHh5ZRgF5XV3rnOUhwqYN4IWXf7ssWq2mELpd4UZD8oHFibjb
         fosMty23SY93VBPb0WENsqzwKEFvfyp/ifhGzkS4tDx00hvYZU46lP4E8saHBJ/jf9S0
         ow6Ra2CTZB5pzltPKqgE6i2Ly8Xp4hpdFhN/Lvo+mdK73R1H+OTI9fs5vqYVpmm1t+q3
         8VXA==
X-Gm-Message-State: ABy/qLZBf/7l/CWo+G5YqsW2NcBRTAQRVGXr14hNOY6D80OtzBPRhlXY
        upaOI+TZE/xB+EKAMAmU5Yk=
X-Google-Smtp-Source: APBJJlHYhz66RVjuzfSMeHujrdx/3uLoId0vY1yuRrV230W6AQ6T4powR9bm4Ezjf/yVuw0wdqZ2bA==
X-Received: by 2002:a05:6512:20c1:b0:4fd:faa3:2352 with SMTP id u1-20020a05651220c100b004fdfaa32352mr1871037lfr.14.1690893857660;
        Tue, 01 Aug 2023 05:44:17 -0700 (PDT)
Received: from [172.16.196.206] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 3-20020ac24843000000b004fe2de20d88sm1401034lfy.232.2023.08.01.05.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 05:44:17 -0700 (PDT)
Message-ID: <ee0341fc-b621-b7c0-4312-be2ad3c29da6@gmail.com>
Date:   Tue, 1 Aug 2023 15:44:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8 7/8] net-next: mvpp2: relax return value check for IRQ
 get
Content-Language: en-US, en-GB
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1690890774.git.mazziesaccount@gmail.com>
 <9738e169d83a96f18de417e62b3cf4c20f51f885.1690890774.git.mazziesaccount@gmail.com>
 <ZMj7Cp3fhN7GmCZp@shell.armlinux.org.uk>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ZMj7Cp3fhN7GmCZp@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/23 15:31, Russell King (Oracle) wrote:
> On Tue, Aug 01, 2023 at 03:04:24PM +0300, Matti Vaittinen wrote:
>> fwnode_irq_get[_byname]() were changed to not return 0 anymore.
>>
>> Drop check for return value 0.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Sorry, but I don't think you've properly considered the effects of your
> patch.

Don't be sorry.

> 
>> @@ -5833,7 +5833,7 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp2_port *port,
>>   			v->irq = of_irq_get_byname(port_node, irqname);
>>   		else
>>   			v->irq = fwnode_irq_get(port->fwnode, i);
>> -		if (v->irq <= 0) {
>> +		if (v->irq < 0) {
> 
> You're making this change based on the assumption that fwnode_irq_get()
> has changed its return values, but I really don't think you've looked
> at the code and considered the return value behaviour of the DT function
> above. Reading it's documentation, it states that of_irq_get_byname()
> may return 0 on IRQ mapping failure.

You're correct. Thanks for spotting this! Seems like I really overlooked 
the behaviour of the of_irq_get_byname().

> So, by making this change, you are allowing IRQ mapping failure in the
> DT path to succeed rather than fail.
> 
>>   			ret = -EINVAL;
>>   			goto err;
>>   		}
>> @@ -6764,7 +6764,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
>>   		err = -EPROBE_DEFER;
>>   		goto err_deinit_qvecs;
>>   	}
>> -	if (port->port_irq <= 0)
>> +	if (port->port_irq < 0)
> 
> Exactly the same problem here, but...
> 
>>   		/* the link irq is optional */
>>   		port->port_irq = 0;
> 
> this is less critical... but still wrong.
> 
> So, given that this patch is basically incorrect...
> 
> NAK.
> 

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

