Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FA37F9518
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 20:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjKZTmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 14:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKZTl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 14:41:59 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DDFD;
        Sun, 26 Nov 2023 11:42:05 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54af61f2a40so2921410a12.3;
        Sun, 26 Nov 2023 11:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701027724; x=1701632524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KOCmptmAB6UfkXSt722yHurhoVbq5oDNcrfXA2j4bCc=;
        b=mOW9z3IUmrCRd9R9WeXuCRzgUJIP6yCkhZJEQzqRN+XiBk3rKcVnWlJ5u92wcluXpi
         YLAqFXdspmX0vGQct0Tpxoxtqa4GlsX6NQAMLE2oH9IA/ikmYabGAIiYHlrtE4XoLZmf
         z/dr/7vZyzj1RySFbLokTrCeROQXbgI3LY4/uZ1CVxKy4qLSmsy014f0wRVUVszG5B61
         KHUGMpqDzHLIG7hXvcXrvzNJdVQEv15+/gwr3Uv+k0SbkIly2NOp7lURdymynZpmnlF1
         Ql6GPdh7+muC71GZFcStpjlHO8dfshilFAgCerW4e0qpJLaGvUg/F7cXcJF3eMzsa4R3
         VXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701027724; x=1701632524;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KOCmptmAB6UfkXSt722yHurhoVbq5oDNcrfXA2j4bCc=;
        b=F2Ua71XzCtzt2r5sDBD45S+lHfOISAx04qiVFlgM08nb0i+ViYourzS4Cghj3qKJfK
         vYuLTyAvj3a0nDiRUh4spzZZp6jPgovcC+PSOc7lEN269KkSAUdnCkYr2XaKI521eDCD
         6O7t3EM9uBc4bh7NEmFa9sCWYbsfyHwSjmVFYRTHD2nOoqifZfvZ3rdLZUK+WakIyo+b
         k/E1/AnFe4fqvO4nbZHZ2RWkJPgNyOuqgTiuQNHFDWRChPEdXbbD0ukMFCl4dbdJvcHJ
         qydGf0SzxUMGsNDuZfI7/jRBHYz7N2pCikGnar7ga+YfOD7RCIOYqI9HjpaqCnl4xwQ5
         KeXg==
X-Gm-Message-State: AOJu0Yy6hscXlMjyvijAC/8faGbU0occcVGbFAMZQXRu+Gq31DgCk5t3
        XekHy7WngY+TzX5TPU3Hi3MgOXmEqyrLvA==
X-Google-Smtp-Source: AGHT+IGNsndX0mZDL6xhaZhqeXodkDKJ/F3YGdtCKQMqY6FLRc5fAqBMaSEmL1AE1zinOIU4z40h3A==
X-Received: by 2002:a50:fb0e:0:b0:54b:d16:4c4a with SMTP id d14-20020a50fb0e000000b0054b0d164c4amr4559109edq.6.1701027723530;
        Sun, 26 Nov 2023 11:42:03 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:cab4:d2c1:ac38:6635? (2a02-a466-68ed-1-cab4-d2c1-ac38-6635.fixed6.kpn.net. [2a02:a466:68ed:1:cab4:d2c1:ac38:6635])
        by smtp.gmail.com with ESMTPSA id t18-20020a056402021200b0053dec545c8fsm4438506edv.3.2023.11.26.11.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 11:42:03 -0800 (PST)
Message-ID: <56823ff4-69fa-4c92-8912-51fbfd71403a@gmail.com>
Date:   Sun, 26 Nov 2023 20:42:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] introduce priority-based shutdown support
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>
References: <20231124163234.GC819414@pengutronix.de>
 <2023112453-flagstick-bullring-8511@gregkh>
 <20231124185725.GA872366@pengutronix.de> <2023112520-paper-image-ef5d@gregkh>
 <20231125085038.GA877872@pengutronix.de>
 <2023112506-unselfish-unkind-adcb@gregkh>
 <ZWHM0lRPOp/efyD5@finisterre.sirena.org.uk>
 <2023112541-uptown-tripping-05f3@gregkh>
 <ZWIWBhBN8AmK7tAJ@finisterre.sirena.org.uk>
 <2023112504-cathedral-pulmonary-83ce@gregkh>
 <ZWMaMIGUo9DeyEH+@finisterre.sirena.org.uk>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <ZWMaMIGUo9DeyEH+@finisterre.sirena.org.uk>
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

Ha ha,

Funny discussion. As a hardware engineer (with no experience in 
automotive, but actual experience in industrial applications and 
debugging issues arising from bad shutdowns) let me add my 5ct at the end.

Op 26-11-2023 om 11:14 schreef Mark Brown:
> On Sat, Nov 25, 2023 at 07:58:12PM +0000, Greg Kroah-Hartman wrote:
>> On Sat, Nov 25, 2023 at 03:43:02PM +0000, Mark Brown wrote:
>>> On Sat, Nov 25, 2023 at 02:35:41PM +0000, Greg Kroah-Hartman wrote:
> 
>>>> That would be great, but I don't see that here, do you?  All I see is
>>>> the shutdown sequence changing because someone wants it to go "faster"
>>>> with the threat of hardware breaking if we don't meet that "faster"
>>>> number, yet no knowledge or guarantee that this number can ever be known
>>>> or happen.
> 
>>> The idea was to have somewhere to send notifications when the hardware
>>> starts reporting things like power supplies starting to fail.  We do
>>> have those from hardware, we just don't do anything terribly useful
>>> with them yet.
> 
>> Ok, but that's not what I recall this patchset doing, or did I missing
>> something?  All I saw was a "reorder the shutdown sequence" set of
>> changes.  Or at least that's all I remember at this point in time,
>> sorry, it's been a few days, but at least that lines up with what the
>> Subject line says above :)
> 
> That's not in the series, a bunch of it is merged in some form (eg, see
> hw_protection_shutdown()) and more of it would need to be built on top
> if this were merged.
> 
>>>> Agreed, but I don't think this patch is going to actually work properly
>>>> over time as there is no time values involved :)
> 
>>> This seems to be more into the area of mitigation than firm solution, I
>>> suspect users will be pleased if they can make a noticable dent in the
>>> number of failures they're seeing.
> 
>> Mitigation is good, but this patch series is just a hack by doing "throw
>> this device type at the front of the shutdown list because we have
>> hardware that crashes a lot" :)
> 
> Sounds like a mitigation to me.
> 
>>> It feels like if we're concerned about mitigating physical damage during
>>> the process of power failure that's a very limited set of devices - the
>>> storage case where we're in the middle of writing to flash or whatever
>>> is the most obvious case.
> 
>> Then why isn't userspace handling this?  This is a policy decision that
>> it needs to take to properly know what hardware needs to be shut down,
>> and what needs to happen in order to do that (i.e. flush, unmount,
>> etc.?)  And userspace today should be able to say, "power down this
>> device now!" for any device in the system based on the sysfs device
>> tree, or at the very least, force it to a specific power state.  So why
>> not handle this policy there?
> 
> Given the tight timelines it does seem reasonable to have some of this
> in the kernel - the specific decisions about how to handle these events
> can always be controlled from userspace (eg, with a sysfs file like we
> do for autosuspend delay times which seem to be in a similar ballpark).

I'd prefer not to call the HW broken in this case. The life of hardware 
(unlike software) continues during and after power down. That means 
there may be requirements and specs for it to conform to during those 
transitions and states. Unlike broken hardware, which does not conform 
to its specs. Typically, a HDD that autoparks its heads to a safe 
position on its last rotation energy, that's not broken, that's 
carefully designed.

That said, I agree with Greg, if there is a hard requirement to shutdown 
safely to prevent damage, the solution is not to shutdown fast. The 
solution is to shutdown on time.

In fact, if the software needs more energy to shutdown safely, any 
hardware engineer will consider that a requirement. And ask the 
appropriate question: "how much energy do you need exactly?". There are 
various reasons why that can not be answered in general. The most funny 
answer I ever got (thanks Albert) being: "My software doesn't consume 
energy".
Now, we do need to keep in mind that storing J in a supercap, executing 
a CPU at GHz, storing GB data do not come free. So, after making sure 
things shutdown in time, it often pays off to shorten that deadline, and 
indeed make it faster.

Looking at the above discussion from the different angles:
1) The hardware mentioned does not need to shutdown (as said, it doesn't 
need to be unmounted). It needs to be placed into a safe state on time. 
And the only thing here that can know for the particular hardware what 
is a safe state, is the driver itself.
2) To get a signal (Low Power Warning) to the driver on time, the 
PREEMPT_RT kernel seems like a natural choice.
3) To me (but hey who am I) it makes sense to have a generic mechanism 
from drivers to transition to their safe state if they require that.
4) I wouldn't worry about drivers fighting for priority, these systems 
are normally "embedded" with fixed hardware. Otherwise there is no way 
to calculate shutdown energy required and do proper hardware design.
