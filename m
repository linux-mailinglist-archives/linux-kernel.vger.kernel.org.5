Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAC675FAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 17:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjGXPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjGXPhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 11:37:54 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CF3121
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:37:53 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-348de7bc865so40045ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690213072; x=1690817872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ubyWWp3JDkrwZeqi5Xn45ylTONSJQWG0iUvDjrZ77hI=;
        b=igS3EJXZs0XWAhkIi98LodZyuRZojFVGt57/h6sRuWj/PJOLHATvECyIRP/2SjbiQM
         pf5w2insFGeNQcKJa1Vpbpb4VUc2Py+SjP4cRmP16oisf5nrzxX5sz2BzE7US9+HjBbb
         FBHLU5Axl1ONXz7+ru3tmF4v69PCgRy8whY70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690213072; x=1690817872;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubyWWp3JDkrwZeqi5Xn45ylTONSJQWG0iUvDjrZ77hI=;
        b=OFldPSOa1DnvL6g/un7zi/fkHSWzGVO0hNeCpiaZVlty21Or237D/qNWvc8+CKHwou
         9lNQMlYsovuayw6W9fIGszukfwmPMR9BemXsePLoyjNAdnR+uXPl1a+DiUdhfHJoaleG
         a1/jO4G90iHdwUHHb6Gh1i1Qz8Pl/T4em1BW4prjdK0lKNwhAUdUo8FPNlqhGEF/PzM7
         EtoTCfJxAlnhZbLxZE5ms0hT8D4xJDiF60n1z62HfWoonybkepLoLzZAk3GibbSjTTKb
         2hVfxma0+6aTvkb3Va065+btqjCTVK73gJ16gx8Euh8PcCCiTWlO66cYHFk+jhLL9OXI
         Ax7w==
X-Gm-Message-State: ABy/qLbCoXZ7izacyfEQqrOLu+4uz9kh2NR5n0cmInUFKTObgvjPRo77
        2lbjUQMytmz5WeiALRPAxZoqTYlmtqLgS/IV3xasKQ==
X-Google-Smtp-Source: APBJJlFKjpa/uPPqEvqgU07iMSzZ9tS0kAHR9BISz5uwB+t44c8h6bTzR9oWnvAgkvH/pWDhqveIBw==
X-Received: by 2002:a92:4b0b:0:b0:348:d465:4a36 with SMTP id m11-20020a924b0b000000b00348d4654a36mr2152227ilg.1.1690213072513;
        Mon, 24 Jul 2023 08:37:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z11-20020a92cecb000000b00341c0710169sm3036333ilq.46.2023.07.24.08.37.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 08:37:52 -0700 (PDT)
Message-ID: <5cc3d6df-42b0-8275-705f-405dc48f3711@linuxfoundation.org>
Date:   Mon, 24 Jul 2023 09:37:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Upcoming nolibc pull request for the next merge window
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop>
 <20230722130120.6e4c0eab@canb.auug.org.au>
 <2c54d017-226e-41c3-a767-a607942ecba5@paulmck-laptop>
 <5d9f724d-4c45-f843-04b3-60a907b9b127@linuxfoundation.org>
 <b15fa4c4-cb1f-4bf6-af04-5d549f326f95@paulmck-laptop>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <b15fa4c4-cb1f-4bf6-af04-5d549f326f95@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/23 09:31, Paul E. McKenney wrote:
> On Mon, Jul 24, 2023 at 08:49:40AM -0600, Shuah Khan wrote:
>> On 7/21/23 22:48, Paul E. McKenney wrote:
>>> On Sat, Jul 22, 2023 at 01:01:20PM +1000, Stephen Rothwell wrote:
>>>> Hi Paul,
>>>>
>>>> On Fri, 21 Jul 2023 10:39:48 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>>>
>>>>> This is just to let you know that Willy and I are adding co-maintainers
>>>>> for nolibc.  Shuah Khan will join me as administrative maintainer,
>>>>> and will be sending the pull request to you for the next merge window.
>>>>>
>>>>> Similarly, Thomas Weißschuh will be joining Willy as technical maintainer
>>>>> for nolibc.  With luck, this won't affect you, but in case you come across
>>>>> a nolibc issue, please reach out to Thomas as well as Willy, Shuah,
>>>>> and myself.  There will of course be an update to the MAINTAINERS file
>>>>> in the near future, but just to let you know in the meantime.
>>>>
>>>> Would it make sense to add a separate nolibc branch to linux-next (and
>>>> no longer merge it into the rcu branch?  Or are there dependencies
>>>> between the two?
>>>
>>> Dependencies between nolibc and RCU are extremely rare, so it might well
>>> make sense to have a separate branch.
>>>
>>> Maybe nolibc/next from either the -rcu tree or Shuah's tree?  Shuah,
>>> would something else work better for you?
>>>
>>
>> We probably have to add linux-kselftest nolibc and rcu nolibc since
>> we are planning to alternating pull requests?
>>
>> Paul, you and I have to make sure we don't have duplicate patches
>> in our nolibc branches.
> 
> If the duplicate patches all have the same SHA-1 hashes, we should be
> good, right?  Or am I missing something subtle here?
> 

You are right - no duplication. We are good.

Stephen, would you like me to send a formal request to add
linux-kselftest nolibc to next?

thanks,
-- Shuah

