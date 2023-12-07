Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D918E808930
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441853AbjLGN3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjLGN3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:29:21 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC1AA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:29:27 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2ca1e6a94a4so9665511fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 05:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701955766; x=1702560566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S/a+lo/i7Sn7Axq1O/3z2JRGx5rn0ORT1DBmQ8MScBU=;
        b=MMx0tYN6xzIiU51xV+pZKIgySXopYlpb7rzUs9+HTWQ6KL0FkPpd3mYixu0hQg1KPV
         kHop7Cf3/Qgtu57KnCNjnDQjGlp3GuuMBj4Xo3UneEBvOqxDo3SgS6azF+M3iBXPxZHz
         ByIqMcQXCtskGGHTifXMJG39ILWmVf9ZSO8BrZ0x5dYvqnaQgyEhDyywpwsHRuiBNye6
         BaVgii1SN2tsvzq5kaBIe+9LvIe7hrUVr62KTuk61cUlUhe1fR1nIXFFcgQ0B3MiR/yq
         Cf5/PkY3VjwIIxE4CfQdxEo9zV1zg0ftica62F4m6r6WyJI3smToMZ/S9Bm68rCvaokf
         l+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701955766; x=1702560566;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S/a+lo/i7Sn7Axq1O/3z2JRGx5rn0ORT1DBmQ8MScBU=;
        b=K7eKCnBy+2v/OfbA7pldXVwigv8bmyPjbMAIe0MxiS043H3uKPFg2HMm5VO4hT3cCS
         38dWfUEJ4CioqE02RR/aEhN7GYUgJFtDMJrtJHEgX/mcRjCmcgYjQdkHXz+9I7VzUxj0
         ORlbMh0q6Ynf6fcZ8LziG2rBxliqacNRANWwhnQS1noojHrnAWuJBbHMXDqlWK8hy46e
         5luQUyrtdcEKwxPMZuTjJXQtibKZZYBgSKVmMnMiVl162vu0gaCh6gQTZCdPsuhMtV5K
         suY5oKMS4U27NDcPuDd0Cq1FxEXW56z8WQCv5fhofVd61OFQYh4Gg8u4aQk2VfjnJZW2
         qknw==
X-Gm-Message-State: AOJu0YywzZ4XtCNb0moI1JtyTdPXD25kBssaDLZE57lCIxy69HG3Si9p
        fWqNdz9kmAzPqlhtSLb5Prw=
X-Google-Smtp-Source: AGHT+IFoslo6cvpRwmPfpAtY1gBrzQKEdQU4A7nfXcRBiTJqKaEDhXJJfUOWplbOtja2vLjLuR7cRw==
X-Received: by 2002:a2e:88c1:0:b0:2c9:ec1b:7004 with SMTP id a1-20020a2e88c1000000b002c9ec1b7004mr1424490ljk.11.1701955765460;
        Thu, 07 Dec 2023 05:29:25 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id v16-20020a2e9250000000b002c9f3e0a075sm241621ljg.55.2023.12.07.05.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 05:29:24 -0800 (PST)
Message-ID: <70cbf708-72a6-4413-8181-99441f676d57@gmail.com>
Date:   Thu, 7 Dec 2023 15:29:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] regulator: event: Add regulator netlink event support
Content-Language: en-US, en-GB
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20231205105207.1262928-1-naresh.solanki@9elements.com>
 <46b1d303-8104-4298-bd43-a649634f5393@gmail.com>
 <CABqG17jwAw6zqy9FLtZ3ppwLT+3fAQ21bGfMr4Xt5eTDm-jQMw@mail.gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <CABqG17jwAw6zqy9FLtZ3ppwLT+3fAQ21bGfMr4Xt5eTDm-jQMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 12/7/23 14:39, Naresh Solanki wrote:
> Hi Matti,
> 
> 
> On Thu, 7 Dec 2023 at 13:42, Matti Vaittinen <mazziesaccount@gmail.com> wrote:
>>
>> Hi Naresh,
>>
>> On 12/5/23 12:52, Naresh Solanki wrote:
>>> This commit introduces netlink event support to the regulator subsystem.
>>>
>>> Changes:
>>> - Introduce event.c and regnl.h for netlink event handling.
>>> - Implement reg_generate_netlink_event to broadcast regulator events.
>>> - Update Makefile to include the new event.c file.
>>>
>>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>>
>> Thanks! I have somehow missed the earlier patches (or just don't
>> remember seeing them). I _really_ like the idea of sending the regulator
>> events as netlink multicasts!
>>
>> ...

>>> + */
>>> +#define REGULATOR_EVENT_UNDER_VOLTAGE_WARN   0x2000
>>> +#define REGULATOR_EVENT_OVER_CURRENT_WARN    0x4000
>>> +#define REGULATOR_EVENT_OVER_VOLTAGE_WARN    0x8000
>>> +#define REGULATOR_EVENT_OVER_TEMP_WARN               0x10000
>>> +#define REGULATOR_EVENT_WARN_MASK            0x1E000
>>> +
>>> +struct reg_genl_event {
>>> +     char reg_name[32];
>>> +     uint64_t event;
>>> +};
>>
>> Do you think we could and / or should separate the event type and event
>> severity to own attributes here? I wonder if we will see more
>> 'severities' of events in the future. I see we have currently some
>> activity for deciding if a regulator event should result for example a
>> "data storage protection" by shutting down storage hardware before a
>> back-up capacitor runs out of energy. Maybe we see more cases where the
>> user-space needs to decide whether to run a (partial) system shutdown or
>> do some other action based on regulator events.
>>
>> I have a feeling that there will be "actions" which are common (like
>> system shutdown or data flushing) and could utilize some generic
>> user-space daemon - maybe the severity is something such a generic
>> daemon could use to decide if shutdown/flush/whatsoever is needed? If
>> so, being able to add new severities may be needed - and duplicating
>> event flags for all severities may not scale.
>>
>> OTOH, it's not that hard to append new netlink attributes to the end of
>> the message to give user-space a hint regarding what should be done. In
>> that sense this is not something I would insist - just wonder if you see
>> it sensible?
> 
> When I wrote the code, I kept in mind to make sure to receive all events
> from regulators so that userspace application (in my case BMC
> application which does power sequence) has regulator events information.
> Hence I assumed that its upto userspace application to decide on corrective
> action based on events of interest.

I do also think it probably is. However, do you see cases where the 
action to be taken is a result of a hardware-design. Maybe in such cases 
the information like "critical under-voltage, please shut down the 
system" could originate from the board designer's drawing-table, end up 
in board device-tree, be read by the drivers/kernel and then be sent to 
a user-land with suitable severity information indicating that an action 
should be taken. I am just speculating if we could have a more generic 
user-space application which took care of this instead of always writing 
a system-specific user-space application.

> At the same time I think having it in a way which is very generic & meets
> requirement of many use case would be better.
> 
> Please correct me if my understanding is inaccurate.
> As I understand from your inputs, receiving severity information along
> with event would help application decide corrective information insteading
> of decoding regulator events.

My current idea was just to treat existing regulator notifications as a 
event + severity. For example:

REGULATOR_EVENT_UNDER_VOLTAGE and
REGULATOR_EVENT_UNDER_VOLTAGE_WARN

would send netlink message with same event 'type' attribute 
(REGULATOR_EVENT_UNDER_VOLTAGE) but with different severity attributes:

REGULATOR_SEVERITY_ERROR Vs. REGULATOR_SEVERITY_WARN.

Still, as I wrote, I am not sure this is too important. I don't know if 
any 'action' decisions can be done based on currently existing 
ERROR/WARNING severities - and the netlink message API can be later 
extended by adding new attributes. So, please treat my message just as a 
fuel for thought - I'm sure you have better insight to the use of these 
notifications than I do :)

>>> +
>>> +/* attributes of reg_genl_family */
>>> +enum {
>>> +     REG_GENL_ATTR_UNSPEC,
>>> +     REG_GENL_ATTR_EVENT,    /* reg event info needed by user space */
>>> +     __REG_GENL_ATTR_MAX,
>>> +};
>>> +
>>> +#define REG_GENL_ATTR_MAX (__REG_GENL_ATTR_MAX - 1)
>>> +
>>> +/* commands supported by the reg_genl_family */
>>> +enum {
>>> +     REG_GENL_CMD_UNSPEC,
>>> +     REG_GENL_CMD_EVENT,     /* kernel->user notifications for reg events */
>>> +     __REG_GENL_CMD_MAX,
>>> +};
>>> +
>>> +#define REG_GENL_CMD_MAX (__REG_GENL_CMD_MAX - 1)
>>> +
>>> +#define REG_GENL_FAMILY_NAME         "reg_event"
>>> +#define REG_GENL_VERSION             0x01
>>> +#define REG_GENL_MCAST_GROUP_NAME    "reg_mc_group"
>>
>> I am wondering what will the user-space handlers look like? Do we think
>> that there will be a 'I am interested in _all_ regulator multicast
>> events' type of listener, or do we think there will be listeners who
>> would like to listen only for a subset of regulator netlink notifications?
>>
>> Asking this just because I wonder if we should be prepared for more than
>> one regulator multicast group? Do you think that an ability to say "Hey,
>> I'd like to listen for under-voltage events only" or "I would like to
>> get all temperature-related notifications" should/could be supported by
>> more specific multicast groups or is that just over-engineering at this
>> point?
> Current implementation is such that all events will be sent.
> But I agree with you that it is not something desired as sometimes
> application might not be interested in all events.
> Also I'm not sure on multicast group, as currently only one group
> exist for regulator event & how adding additional group would help.
> 

Again, this might be my delusion :) Once upon a time I wrote a 
(downstream) netlink interface for sending certain specific purpose 
measurement results to the user-space. I have a faint memory from those 
days that it was possible to specify the multicast groups of interest at 
socket bind() - time. In this way "multiplexing" the messages would be 
done by kernel and user-space code could only listen the messages of 
interest? Maybe there are caveats I am not aware of though.

>> It has been a long while since I wrote netlink code. So, if this makes
>> no sense to you it's probably me who is overlooking something.
> I'm aligned to make sure regulator netlink serves wider purpose &
> hence your inputs are highly valuable.
> 
> Based on inputs provided by you(please add if missed anything):
> 1. Add an attribute severity & set it if event is of critical nature like:
>      under-voltage, over-current, event_fail & *any others* ?.
> 2. Ability to receive specific set of regulator events instead of all events.

Yes. These were my points to consider - but you / Mark are free to use 
your judgement on if this makes any sense or not. I am not confident 
enough these are necessary "features" to really push for them.

In any case, I do like this ambition! Do you plan to write open-source 
user-space tool(s) for listening these events as well?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

