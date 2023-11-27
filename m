Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94C7FA368
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjK0Ott (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjK0Otr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:49:47 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7FFA1;
        Mon, 27 Nov 2023 06:49:52 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507e85ebf50so5811186e87.1;
        Mon, 27 Nov 2023 06:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701096591; x=1701701391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOQKvfpY0DGJC1g0BayKPczKP7ZYbRdjmTgXJyhyTVw=;
        b=X0MXHjx63VXfqlmdDiQGnjkOJMt19dD2LVzJZ2DTR9+0znst2hAJ8gGz+AzZlPjae+
         h0DT1AmCAHkODEcEmxetIF94iWTfHl3O8QPMaXFxITUt6jGNq8GJ0Y7XfLgBuGg4vQtw
         uzdmcYdMq7QR2E1UqdVLr8T5Yezj0uV4Wu4xaVJII0Gf3Rp7HrxsdJoS2DSXK6kfO8D3
         B8ijRV8eoHWb21F06QrigkLf3H37ndK26U40xi2F2m1a3GpHdRMjv/5Msr/LfZm9pk5M
         c0mnyDj89iVpUIscHc0s/9b7LwxNisHpqMC4tE/onS1N27Zex+znst9MzDm9VMxbmJ8h
         Zp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701096591; x=1701701391;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOQKvfpY0DGJC1g0BayKPczKP7ZYbRdjmTgXJyhyTVw=;
        b=EE0trt/0vI3UEvXLneIChtNc+slIvC8n7msnR+D/2K8Al5aFKYtwbh1kr+5otqaNVl
         xF+xpkscvqwhEedwLh5d0Hr+tn2Wnb9w3rEkFmTQNWxNNp5PdFaez6Jw3HUCmMEOzcOU
         VLxFRY/A1Yjk/QVzXasZUZIjh2j7GnrP06/udGbGzYe2fvT2YYLH45nxQ+wkiuZHRvc1
         zgBAPBGSW9HVYmSkx8EbpwUVsCMiXQJZG8Pl9zGuJR3dibtexJZxaNo8zpzOZvKzQ6Dg
         ADEzQxoduCYlg+I+3QEUfv9mdnJAPulxI+0A9nSl/3UMtu+G0YSFRddxMugJLD8rMjym
         JHVQ==
X-Gm-Message-State: AOJu0YzapirctpnZ2za/aYHFj1mnUEEN5e5tRUzVhXaKL/EKBgHXhEgg
        j7im+2sKl73/a3Xzu/F22uw=
X-Google-Smtp-Source: AGHT+IH5ZtFQb+fTKiO1c2V4yiAk0AuFn6zOfh5DtBZIP1YXWsY4BKdIZp1XDBMm4gnOzqs7kQt4Gw==
X-Received: by 2002:a05:6512:ac2:b0:50b:a720:8ae4 with SMTP id n2-20020a0565120ac200b0050ba7208ae4mr7146108lfu.36.1701096590794;
        Mon, 27 Nov 2023 06:49:50 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f8:1500::2? (dc78bmyyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:16f8:1500::2])
        by smtp.gmail.com with ESMTPSA id w4-20020ac24424000000b004fb7848bacbsm1484770lfl.46.2023.11.27.06.49.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:49:50 -0800 (PST)
Message-ID: <bb332c07-6cf6-4f38-99f5-657a48c332d9@gmail.com>
Date:   Mon, 27 Nov 2023 16:49:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
Content-Language: en-US, en-GB
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20231124145338.3112416-1-o.rempel@pengutronix.de>
 <2023112403-laxative-lustiness-6a7f@gregkh>
 <ZWC/hKav0JANhWKM@finisterre.sirena.org.uk>
 <2023112458-stature-commuting-c66f@gregkh>
 <ZWDGGqsCq9iSnHtO@finisterre.sirena.org.uk>
 <2023112435-dazzler-crisped-04a6@gregkh>
 <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <CANhJrGPop=tL8y+chvPwMpSZYF1pkeWeRp3xL+7JsuY=U0fyag@mail.gmail.com>
 <2023112722-headdress-kissing-8c9f@gregkh>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <2023112722-headdress-kissing-8c9f@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/23 15:08, Greg Kroah-Hartman wrote:
> On Mon, Nov 27, 2023 at 02:54:21PM +0200, Matti Vaittinen wrote:
>> pe 24. marrask. 2023 klo 19.26 Greg Kroah-Hartman
>> (gregkh@linuxfoundation.org) kirjoitti:
>>>
>>> On Fri, Nov 24, 2023 at 05:32:34PM +0100, Oleksij Rempel wrote:
>>>> On Fri, Nov 24, 2023 at 03:56:19PM +0000, Greg Kroah-Hartman wrote:
>>>>> On Fri, Nov 24, 2023 at 03:49:46PM +0000, Mark Brown wrote:
>>>>>> On Fri, Nov 24, 2023 at 03:27:48PM +0000, Greg Kroah-Hartman wrote:
>>>>>>> On Fri, Nov 24, 2023 at 03:21:40PM +0000, Mark Brown wrote:
>>>>>>
>>>>>>>> This came out of some discussions about trying to handle emergency power
>>>>>>>> failure notifications.
>>>>>>
>>>>>>> I'm sorry, but I don't know what that means.  Are you saying that the
>>>>>>> kernel is now going to try to provide a hard guarantee that some devices
>>>>>>> are going to be shut down in X number of seconds when asked?  If so, why
>>>>>>> not do this in userspace?
>>>>>>
>>>>>> No, it was initially (or when I initially saw it anyway) handling of
>>>>>> notifications from regulators that they're in trouble and we have some
>>>>>> small amount of time to do anything we might want to do about it before
>>>>>> we expire.
>>>>>
>>>>> So we are going to guarantee a "time" in which we are going to do
>>>>> something?  Again, if that's required, why not do it in userspace using
>>>>> a RT kernel?
>>>>
>>>> For the HW in question I have only 100ms time before power loss. By
>>>> doing it over use space some we will have even less time to react.
>>>
>>> Why can't userspace react that fast?  Why will the kernel be somehow
>>> faster?  Speed should be the same, just get the "power is cut" signal
>>> and have userspace flush and unmount the disk before power is gone.  Why
>>> can the kernel do this any differently?
>>>
>>>> In fact, this is not a new requirement. It exist on different flavors of
>>>> automotive Linux for about 10 years. Linux in cars should be able to
>>>> handle voltage drops for example on ignition and so on. The only new thing is
>>>> the attempt to mainline it.
>>>
>>> But your patch is not guaranteeing anything, it's just doing a "I want
>>> this done before the other devices are handled", that's it.  There is no
>>> chance that 100ms is going to be a requirement, or that some other
>>> device type is not going to come along and demand to be ahead of your
>>> device in the list.
>>>
>>> So you are going to have a constant fight among device types over the
>>> years, and people complaining that the kernel is now somehow going to
>>> guarantee that a device is shutdown in a set amount of time, which
>>> again, the kernel can not guarantee here.
>>>
>>> This might work as a one-off for a specific hardware platform, which is
>>> odd, but not anything you really should be adding for anyone else to use
>>> here as your reasoning for it does not reflect what the code does.
>>
>> I was (am) interested in knowing how/where the regulator error
>> notifications are utilized - hence I asked this in ELCE last summer.
>> Replies indeed mostly pointed to automotive and handling the under
>> voltage events.
>>
>> As to what has changed (I think this was asked in another mail on this
>> topic) - I understood from the discussions that the demand of running
>> systems with as low power as possible is even more
>> important/desirable. Hence, the under-voltage events are more usual
>> than they were when cars used to be working by burning flammable
>> liquids :)
>>
>> Anyways, what I thought I'd comment on is that the severity of the
>> regulator error notifications can be given from device-tree. Rationale
>> behind this is that figuring out whether a certain detected problem is
>> fatal or not (in embedded systems) should be done by the board
>> designers, per board. Maybe the understanding which hardware should
>> react first is also a property of hardware and could come from the
>> device-tree? Eg, instead of having a "DEVICE_SHUTDOWN_PRIO_STORAGE"
>> set unconditionally for EMMC, systems could set shutdown priority per
>> board and per device explicitly using device-tree?
> 
> Yes, using device tree would be good, but now you have created something
> that is device-tree-specific and not all the world is device tree :(

True. However, my understanding is that the regulator subsystem is 
largely written to work with DT-based systems. Hence supporting the 
DT-based solution would probably fit to this specific use-case as source 
of problem notifications is the regulator subsystem.

> Also, many devices are finally moving out to non-device-tree busses,
> like PCI and USB, so how would you handle them in this type of scheme?

I do readily admit I don't have [all ;) ] the answers. I also think that 
if we add support for prioritized shutdown on device-tree-based systems, 
people may eventually want to use this on non device-tree setups too. 
There may also be other use-cases for prioritized shutdown (Don't know 
what they would be though).

For now I would leave that to be the problem of the folks who need non 
device-tree systems when (if) this needs realizes. Assuming there was 
the handling of priorities in place, the missing piece would then be to 
find out the place to store this hardware specific priority information. 
If this is solved for the non DT cases, then the DT-based and non 
DT-based solutions can co-exist.

Just a suggestion though. I am not working on under-voltage "stuff" 
right now.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

