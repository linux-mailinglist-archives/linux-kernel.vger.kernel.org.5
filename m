Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7F770334
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjHDOgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHDOgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:36:33 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D59E46B1;
        Fri,  4 Aug 2023 07:36:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-77acb04309dso80389939f.2;
        Fri, 04 Aug 2023 07:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691159791; x=1691764591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=TKJ2V5kvC0P3r3j3dHnNVuMTuMvDDPe1G/NKRCyaBkk=;
        b=nWZ/ofIxhi4qB82vipTMTp6m5jkxTHUs9vKutlYtEJ7kTYkFeh8iHhawP0M55KQJ6G
         r20sdr1K4EXecAaIwWELOHzyWAwqU5lqnsV79ibI90udGbR5j/18/bPQZavMd5Z63wU7
         lhGH1mljMeO+EY3IZuKLgc80Uf8YpkSold0rTRad7ulkSgJr3bQV3sdeWIzC1mS8fpJn
         +Mjm6KZQqw29ynuMwXbPV8P7Eq5sMVH50sjECHhUj6495vHCeHRbPa6jzEkehrfU1m6r
         oUssVc7EE1C0+eX9+WyzwFNMmEKbYjvym1Htdf8a0VFpCYMLKNbd97lFJnbNjWU2Id2A
         6Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691159791; x=1691764591;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TKJ2V5kvC0P3r3j3dHnNVuMTuMvDDPe1G/NKRCyaBkk=;
        b=bUhxbfY9PgYnG4A03If64xaMoGedp5JUY3aGTItLYBD9l7fpAaRJNqxYLcyOIWcA6/
         41lcFy3JXmbK1xcMJSNLcWhWO15wqyfZSiOPbiRjzEMuyauTm3k5xA3hgd9lHQUtTYjx
         YHF4FlI6XyHq7TVbLrcVQW7GwQqo8Ck7aiFNhFhHjhSwbcK1Okc11wvfhLzJ4K/6SJfn
         22LP8uUb8TeqUNwkB84VxTrmntmhdOafxssgGrOZHy1ZHoToUfrPzAVTcRt/gFl8jUhS
         VJZHsV1wuCOBrQUIDruBMilGHZFmNk8u5Q3ABHAT23Oxq1ASkMj4Dqh23Xh2Dq76nAy1
         frow==
X-Gm-Message-State: AOJu0YzWbKcOxHk5QQJv3Xq5YyZpgXPdCrbUOhgIh4Vbr4qK35OPdmYM
        KPnagnONXF0ot6f1sgBwt5I=
X-Google-Smtp-Source: AGHT+IGMiT1DF75ZcZ58xyib4T5JB6DssZYm5zcGAJ/TQREPl90qDc9qYbtzWJgQ/Hh35YbbBWOblA==
X-Received: by 2002:a5d:8595:0:b0:790:f397:4321 with SMTP id f21-20020a5d8595000000b00790f3974321mr2793943ioj.1.1691159791164;
        Fri, 04 Aug 2023 07:36:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cw4-20020a05663849c400b0042b149aeccdsm614387jab.104.2023.08.04.07.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Aug 2023 07:36:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <26307de6-6941-3682-7028-02eb82143166@roeck-us.net>
Date:   Fri, 4 Aug 2023 07:36:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] usb: typec: tcpm: IS_ERR_OR_NULL check for
 port->partner
Content-Language: en-US
To:     Ladislav Michl <oss-lists@triops.cz>, Jimmy Hu <hhhuuu@google.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        kyletso@google.com, badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230804084928.1153600-1-hhhuuu@google.com>
 <ZMzDwEBwJSB5k5Ci@lenoch>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <ZMzDwEBwJSB5k5Ci@lenoch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/23 02:24, Ladislav Michl wrote:
> Hi Jimmy,
> 
> On Fri, Aug 04, 2023 at 08:49:28AM +0000, Jimmy Hu wrote:
>> port->partner may be an error or NULL, so we must check it with
>> IS_ERR_OR_NULL() before dereferencing it.
>>
>> Move the check to the beginning of the tcpm_handle_vdm_request function.
>>
>> Fixes: 5e1d4c49fbc8 ("usb: typec: tcpm: Determine common SVDM Version")
>> Signed-off-by: Jimmy Hu <hhhuuu@google.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index 829d75ebab42..2c6a0af155ab 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -1683,10 +1683,6 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
>>   			      (VDO_SVDM_VERS(typec_get_negotiated_svdm_version(typec)));
>>   		break;
>>   	case CMDT_RSP_ACK:
>> -		/* silently drop message if we are not connected */
>> -		if (IS_ERR_OR_NULL(port->partner))
>> -			break;
>> -
>>   		tcpm_ams_finish(port);
>>   
>>   		switch (cmd) {
>> @@ -1792,6 +1788,12 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
>>   	u32 response[8] = { };
>>   	int i, rlen = 0;
>>   
>> +	/* silently drop message if we are not connected */
> 
> ...comment moved.
> 
>> +	if (IS_ERR_OR_NULL(port->partner)) {
>> +		dev_warn(port->dev, "port partner is an error or NULL\n");
> 
> But code is actually not silent. Also, does the verbsity make sense? And
> if it does, is knowing what error port->partner is containing usefull?
> 

Not only that, it also changes behavior radically from ignoring certain messages
while not connected or after partner registration failed to rejecting all VDM
messages, even those not requiring any partner data. It now also ignores all VDM
messages if the state machine is not in READY state. This is a significant functional
change which needs _much_ more explanation than provided in the patch description.

Guenter

