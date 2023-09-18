Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B717A4C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjIRPcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjIRPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:32:12 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D119D;
        Mon, 18 Sep 2023 08:29:50 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0ecb9a075so35778615ad.2;
        Mon, 18 Sep 2023 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050776; x=1695655576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TcK2t6orh1EBIUoT45jrwcH4x+exKHrNKtJwz71VShQ=;
        b=kitzVkfqihUf9NXddRVfao6a1KZKyL25smk5DBkbJ4n7tjYmGwDH4wlR/h4zh5xT2i
         6nQoK6A+dYbug8EL0CE3ohScQQrdRk5ypg/tlhzpWfR4WrnVGoI8EzN9Jqqx0F0SPglR
         OGHlRUDYf+yHiaR0vUSRPgVkzZlRh34Hr4g32SakaSNuvTxErkeqaDybOv24WIEcF+4z
         7OkwLsInVfmrxkeCgoD6i/1IhXDzv0XwKjNIEioryncx7B+7TIrmUTSvET+FTLUIny3G
         qbfXFKJTq0alB8r+geqqVjrUjknPViWOjVz57CfZl/pZnqxKlbgBWq8/1n5iTN1p0Vtq
         yE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050776; x=1695655576;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TcK2t6orh1EBIUoT45jrwcH4x+exKHrNKtJwz71VShQ=;
        b=pJUFAmVBLsfHLe9W7ypT6VZYzUEd6Sxq/H4Z2O6KyvtcV3+iuhjIGMDnakcX7QP+Ak
         y9S2bKDoaVF04A84HPMf6904V/8dtEui8JIePJ6OvKU0LvNTBVI5hnJopbsOg8WcV6mf
         tD3val931qJ06XASE1b8WRNYjMXrxmu4zjSyu0XrV358PazuV0Nv8Mpg1tcO4sM9t3t3
         wvP6OUYBpJhJnZvxIyztGMFUCwl48Tfmzewi00iKZc5Cj+X9OFJunR4WS6FRaFtSkJog
         6mYsYYXY0Zfo5qKaiQjFXew04F0LtVn0nxsdtXpmGfb/mxzgmsywJ/VbyGvDCVVB+i5+
         ptWA==
X-Gm-Message-State: AOJu0YwBshF1uJGLZE+CvKYFT71k0uHSAsIkXZ1nZqcsZQ6PNX7ZE0MM
        P+D5iWbKrVM9EzN0bDyVSOR7t8jUd4c=
X-Google-Smtp-Source: AGHT+IHq9LjcJZJmJJ3LIDcepIKl0Bqkv+agRsCbEynqkALKSmB6c4US6nDUdbeychk378UeS0oLlQ==
X-Received: by 2002:a05:6e02:13e9:b0:34a:9ad3:e043 with SMTP id w9-20020a056e0213e900b0034a9ad3e043mr10254654ilj.29.1695046964161;
        Mon, 18 Sep 2023 07:22:44 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w30-20020a63935e000000b005501b24b1c9sm6800203pgm.62.2023.09.18.07.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:22:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <c52acbd0-e8e3-83e7-d87b-939b47aa39c1@roeck-us.net>
Date:   Mon, 18 Sep 2023 07:22:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Michael Wu <michael@allwinnertech.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230914003154.27977-1-michael@allwinnertech.com>
 <ZQgm/Lb4iZtWrWbs@kuha.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] usb:typec:tcpm:support double Rp to Vbus cable as sink
In-Reply-To: <ZQgm/Lb4iZtWrWbs@kuha.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 03:31, Heikki Krogerus wrote:
> On Thu, Sep 14, 2023 at 08:31:54AM +0800, Michael Wu wrote:
>> The USB Type-C Cable and Connector Specification defines the wire
>> connections for the USB Type-C to USB 2.0 Standard-A cable assembly
>> (Release 2.2, Chapter 3.5.2).
>> The Notes says that Pin A5 (CC) of the USB Type-C plug shall be connected
>> to Vbus through a resister Rp.
>> However, there is a large amount of such double Rp connected to Vbus
>> non-standard cables which produced by UGREEN circulating on the market, and
>> it can affects the normal operations of the state machine easily,
>> especially to CC1 and CC2 be pulled up at the same time.
>> In fact, we can regard those cables as sink to avoid abnormal state.
>>
>> Message as follow:
>> [   58.900212] VBUS on
>> [   59.265433] CC1: 0 -> 3, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
>> [   62.623308] CC1: 3 -> 0, CC2: 3 -> 0 [state TOGGLING, polarity 0, disconnected]
>> [   62.625006] VBUS off
>> [   62.625012] VBUS VSAFE0V
>>
>> Signed-off-by: Michael Wu <michael@allwinnertech.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index d962f67c95ae6..beb7143128667 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -519,7 +519,8 @@ static const char * const pd_rev[] = {
>>   
>>   #define tcpm_port_is_sink(port) \
>>   	((tcpm_cc_is_sink((port)->cc1) && !tcpm_cc_is_sink((port)->cc2)) || \
>> -	 (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1)))
>> +	 (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1)) || \
>> +	 (tcpm_cc_is_sink((port)->cc1) && tcpm_cc_is_sink((port)->cc2)))
>>   
>>   #define tcpm_cc_is_source(cc) ((cc) == TYPEC_CC_RD)
>>   #define tcpm_cc_is_audio(cc) ((cc) == TYPEC_CC_RA)
> 
> This look OK to me, but I would still like to wait for comments from
> Guenter - just in case.
> 

Look at the conditions. Reordered, we end up with
	(tcpm_cc_is_sink((port)->cc1) && !tcpm_cc_is_sink((port)->cc2)) ||
	(tcpm_cc_is_sink((port)->cc1) && tcpm_cc_is_sink((port)->cc2))
which simplifies to
	tcpm_cc_is_sink((port)->cc1)
making the complete expression
	tcpm_cc_is_sink((port)->cc1) ||
	(tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1))
which simplifies further to
	tcpm_cc_is_sink((port)->cc1) || tcpm_cc_is_sink((port)->cc2)

The simplified expression doesn't conflict with other detections, so I am
ok with it. It might be worthwhile adding a comment to the code, though,
explaining the reason.

Guenter

> thanks,
> 

