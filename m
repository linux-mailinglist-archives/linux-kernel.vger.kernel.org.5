Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB6E7D033E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346557AbjJSUk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbjJSUkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:40:55 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E389A3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:40:54 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-581edcde26cso70450eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697748053; x=1698352853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqBe46cf+1uCNWo/kZkQ81aBcvgfQlBh32t3mKrqU5A=;
        b=hJkI0gXJCGvtU5WUxlfX7lo+F6a+5ULFqjXrMBzkawXhPTV6vCr4S3GRw0uUhFAZ+r
         dXB3WeYTd1or1wjbdZLdodZ0zKuziXV8qr7VGCXK7Va0tVxe84+9YQGBYW/0PZxA4r2Z
         5hN0MlvpdgE8FMO5pHTPCsQSJSpKdXpgvXgkOVLLn20HgB4pTHzUWqryYlenKlq8wPYP
         rrjZHnfd/wuu00yD7QAemf3ncgce9qAt3mEJ3JFCrZFIPEMLIuIlnYWp0gJkLQ4Auw7+
         qn2r4drcVNn4OSzDQyzGNuNjpBjKHe+aEjQooWYgwOTD31IBR6i+JkEHme/roQrekrR0
         R6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697748053; x=1698352853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HqBe46cf+1uCNWo/kZkQ81aBcvgfQlBh32t3mKrqU5A=;
        b=cAS8TzruKicycZgkVNabGl+6Q9zVR0dg1NJREH5WiI7NPstvJW+mImdfwUerRqVvPv
         yEVWQ7P+IaZvsG//3LcykkNkeB0dK/PY29s+L8PPx6EkJyOe4D0LyQpa/0/RR6+MeVGT
         6DFPAPlSgb5MiYtJUC+sUIHBE0RmHsEqFKep0GbOrk+lDsveMorklr2GpfcLFAkmMutv
         TTrcX4Ny5yoOKjJd0H8EK+/T+fCx/6oQdVhz+mmEA0I8kCNXA1f7CaN1dbNSMqUyMf4T
         fAglpkuG6IiUhf9AKXf4dL7V6UgZ9ap+jaevZGjtnmwtCUN4LFvMkDt6X6qerjkQ5kDn
         u1JA==
X-Gm-Message-State: AOJu0YxOJKsjJ7VoteCNUSRWQG58XRbqmumchDUeWtvyY9f+JiuujuDp
        p9uF18oo7GdPa+dR8eDyGi0=
X-Google-Smtp-Source: AGHT+IFgRxHrJtUJe6V5adEOFj0eHEhBFonyw3wYe+z73eRjXmlDeEHiCHNMm1KdPeHUGwWPOCbGoQ==
X-Received: by 2002:a4a:bb8d:0:b0:581:ed38:5506 with SMTP id h13-20020a4abb8d000000b00581ed385506mr77516oop.4.1697748053515;
        Thu, 19 Oct 2023 13:40:53 -0700 (PDT)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id r2-20020a4aa2c2000000b00584078d1e17sm75950ool.45.2023.10.19.13.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 13:40:53 -0700 (PDT)
Message-ID: <4f36de79-6271-ab6f-19fe-ba189e748b8f@gmail.com>
Date:   Thu, 19 Oct 2023 15:40:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4] driver core: shut down devices asynchronously
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
References: <20230921163443.9224-1-stuart.w.hayes@gmail.com>
 <2023100507-refocus-stooge-08dd@gregkh>
From:   stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <2023100507-refocus-stooge-08dd@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 4:36 AM, Greg Kroah-Hartman wrote:
> On Thu, Sep 21, 2023 at 11:34:43AM -0500, Stuart Hayes wrote:
>> Shut down devices asynchronously, ensuring that each device is shut down
>> before its parents.
>>
>> This can dramatically reduce system shutdown/reboot time on systems that
>> have devices that take many seconds to shut down, such as some NVMe drives.
>> On one system tested, the shutdown time went from 11 minutes without this
>> patch to 55 seconds with the patch.
> 
> That's a nice improvement, but I think we need a lot more testing on a
> wide range of systems before we can take a patch like this.
> 
> Also, what about busses that don't want this type of shutdown?  We allow
> busses to opt-in for async probing, shouldn't that be also done for
> shutting them down to resolve issues for busses that can not handle
> this?
> 
> thanks,
> 
> greg k-h

Yes, I could add something like what is done for async probing, so drivers
have to opt in to async shutdown of their devices.

But I'm not sure how to get it tested on a wide range of systems, other than
than having the patch in the kernel.  What if it defaults to synchronous
shutdown for now, but the option is there so people are able to test async
shutdown by changing an attribute in sysfs?  Then drivers could be patched
later to opt in to async shutdown of their devices by default...?

Thanks for the feedback!
