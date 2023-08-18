Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECE6780D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377524AbjHROAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377778AbjHRN7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:59:48 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C91448D
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:59:29 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-56e9b517f85so60476eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692367159; x=1692971959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=duCRu/0LzBoxC3hG6QrfD3VEjxPFyp0C3jaFkBvDicw=;
        b=geST65u8tHo2wtrAG1oaVQqo+p/+zOHXnO855ghHYbygcCDBUavGs3+uGqyWINGwAs
         VJ9Eo1ACnczSNH9CgLM89hioBx0b5JQphjV/flzHkQt51x+eKC+VdOlGZu3kbb0Fx1wU
         +QN4O4hfEMsjdT9OzIzTZRhd1kQurE53UOxLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692367159; x=1692971959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=duCRu/0LzBoxC3hG6QrfD3VEjxPFyp0C3jaFkBvDicw=;
        b=TbY4TmP++svngyDqYhMtpe2IqVIOquLmtnOPqibeKsbe9NM9IDFdmlWF7ASvQWKQOE
         yZHrT4Sgu+WAf21ypqahc4Z7DabZBgQvUTc0JjeJBa/OW4ppBLGMp/VHjB1UjNvngOYx
         Vzv6ZMWBWFEYag6agXm0ukPd9di5ut+whj3JPxQlq4WIBtEqM8iaSO42FmCQZRaUPPKD
         VCI0cjrIOPd6SOZGZHVHPE4tYwTcJl4zkGFX6GcOUzwF97NmWHXRhvUlZgoCKScawc4o
         pUNNwScgJfVD1Zx6p5KFWnehaPMdu/HRE+Xp5DAnssURvGGIbwvJR9/zkUI5KkXmHyen
         L+kw==
X-Gm-Message-State: AOJu0YyDXQ+JVB2Z5fItOm5xxrxxj1Xhc2QeGgYKebMhSEthamNleW7/
        fUQ7oUrIAUYBiOP7fu2dr4JBmAGlTJzoLWNxGtQ=
X-Google-Smtp-Source: AGHT+IFdGR90xAoontA+rzv/VDZDgjORqTThJlYTJgKTIx0bZmUyoJhUd3q9RC/LS4ufhZwS9clRcg==
X-Received: by 2002:a4a:eb1a:0:b0:560:b01a:653d with SMTP id f26-20020a4aeb1a000000b00560b01a653dmr3019525ooj.0.1692367159621;
        Fri, 18 Aug 2023 06:59:19 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i14-20020a4aab0e000000b005678320f1f2sm736544oon.13.2023.08.18.06.59.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 06:59:19 -0700 (PDT)
Message-ID: <e08e3dd5-48b8-5da2-5d0c-7d5b70a9e9be@linuxfoundation.org>
Date:   Fri, 18 Aug 2023 07:59:18 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: duplicate patch in the nolibc tree
To:     Christian Brauner <brauner@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230817133811.0a73c624@canb.auug.org.au>
 <e0af8d82-e099-49fa-9fbd-6f6bb63b7706@t-8ch.de>
 <9cfb4fe4-162b-3f26-646b-71bed3493925@linuxfoundation.org>
 <4c037ef2-9159-4528-8ecb-8596cb2a3889@paulmck-laptop>
 <20230817193909.GA30505@1wt.eu>
 <01d517c4-d91b-4426-b7f2-2b1277f21d8c@paulmck-laptop>
 <20230818-anblicken-mitinhaber-11cd07cce0a1@brauner>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230818-anblicken-mitinhaber-11cd07cce0a1@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 07:27, Christian Brauner wrote:
> On Thu, Aug 17, 2023 at 01:41:45PM -0700, Paul E. McKenney wrote:
>> On Thu, Aug 17, 2023 at 09:39:09PM +0200, Willy Tarreau wrote:
>>> On Thu, Aug 17, 2023 at 11:46:57AM -0700, Paul E. McKenney wrote:
>>>> On Thu, Aug 17, 2023 at 12:27:46PM -0600, Shuah Khan wrote:
>>>>> On 8/17/23 10:30, Thomas Weißschuh wrote:
>>>>>> On 2023-08-17 13:38:11+1000, Stephen Rothwell wrote:
>>>>>>> The following commit is also in the vfs-brauner tree as a different commit
>>>>>>> (but the same patch):
>>>>>>>
>>>>>>>     ba859b2e419c ("selftests/nolibc: drop test chmod_net")
>>>>>>>
>>>>>>> This is commit
>>>>>>>
>>>>>>>     49319832de90 ("selftests/nolibc: drop test chmod_net")
>>>>>>>
>>>>>>> in the vfs-brauner tree.
>>>>>>
>>>>>> I think we can drop the patch from the nolibc tree.
>>>>>> The patch is only really necessary in combination with
>>>>>> commit 18e66ae67673 ("proc: use generic setattr() for /proc/$PID/net")
>>>>>> which already is and should stay in the vfs tree.
>>>>>
>>>>> Thomas,
>>>>>
>>>>> Do the rest of the nolibc patches build without this if we were
>>>>> to drop this patch? Dorpping requires rebase and please see below.
>>>>>
>>>>> Willy, Paul,
>>>>>
>>>>> How do we want to handle this so we can avoid rebasing to keep
>>>>> the Commit IDs the same as one ones in Willy's nolibc branch?
>>>>
>>>> The usual way would be for Willy to drop the patch, rebase, and republish
>>>> his branch.  You would then discard the current branch and pull the
>>>> new one.
>>>>
>>>>> I would recommend dropping this commit from vfs-brauner if it
>>>>> doesn't cause problems.
>>>>
>>>> It might be good for nolibc patches to be going through Willy's tree.
>>>
>>> It would indeed be more logical as a general rule. However, here I don't
>>> care as I don't see any issue caused by dropping it, I can adapt to what
>>> is most convenient for most of us.
>>>
>>> Let's maybe just wait a little bit for Christian to suggest what he
>>> prefers then we can adapt.
>>>
>>>> Or does Christian have some situation where it is necessary to make
>>>> a coordinated vfs/nolibc change?
>>>
>>> I don't think there's any need for coordination on this one.
>>
>> It is always good when either option can be make to work.  ;-)
> 
> The patch in the vfs tree will make the test fail so it makes sense to
> have both go in together. I would normally be happy to drop it but I'm
> rather unenthusiastic in this particular case because I replied to this
> almost 5 weeks ago on Thursday, July 13 and since then this has been in
> -next.
> 

I totally understand you being unenthusiastic. Considering summer
vacation schedules and all, emails get missed at times.

I sincerely request you to consider dropping as it is the simpler route
for all involved.

thanks,
-- Shuah
  

