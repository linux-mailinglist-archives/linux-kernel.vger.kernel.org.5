Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5495175FA29
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjGXOtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjGXOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:49:43 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A56B10C0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:49:42 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-78706966220so34758539f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690210181; x=1690814981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HekVCFoY6PgTbs6qruQnobqeJ8w585D3P+8yNHa/vKI=;
        b=Cqzlt0E4dDO9JHjGZqNzPcPd66+T4Da5ecIKVQwH/RyCYXHjOGz7kr+ymrq8wy4aTX
         13PCTOZR1NqTdQpEWqJmMTj4OS8tvR1ocH8jwkNtaycRRLIk6smWWZeETgxtrU39tHkL
         cxdeuWcdqg6j2hTCFcBJFwiofOFYUTCG3cuNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690210181; x=1690814981;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HekVCFoY6PgTbs6qruQnobqeJ8w585D3P+8yNHa/vKI=;
        b=eQK5rLHJZn7Hp3owdgM1jJfAjuwSA1audpM6EzZyVgIq87MuUk/InfBNXweJyTS8dF
         sYPr8kNas2i6/f/00rLo/gmRJLdnCWy/U+LDtYyXx+kaROtBcKj/Iw+MRBgWFmrfeIj5
         kL7LKz5jqLvOrvnTf/hrBTnLzHwvkoyp3uZxB5fhfyaEAk7auO7wyyCwrcZPFlv6FSfW
         UDLviVJV2RigxO6IDca4uYQ/XBH7Ygv9f2mSdmmp7u5nVoVVZGdvJS+fpNgYfrFOSDEa
         cTIgYNCw/0UyqiPAAsbZj+/+UKm3G5qhYlBzCGAmYiWWqqaP1QR9LtGpZ2KciCC/p6vw
         5K5g==
X-Gm-Message-State: ABy/qLZcRfz/SD/I6V+LHE8UvVZe8RLiuABdg8wnL4DcrsV3nxq8FuPR
        hSm2B/OPjDZCvphw2VG+0WGAEqoAqpf7R9FVvZjNjA==
X-Google-Smtp-Source: APBJJlFtOLCKTgjaSiaIiht+RsJIBSdSWSHPCOS2xkAfMgskFfkHiFRYPYUx1IalSdBaRjoJafJ79g==
X-Received: by 2002:a6b:b4d5:0:b0:788:2d78:813c with SMTP id d204-20020a6bb4d5000000b007882d78813cmr7876542iof.0.1690210181332;
        Mon, 24 Jul 2023 07:49:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id n11-20020a6bf60b000000b00786ea00bdb5sm3336573ioh.2.2023.07.24.07.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 07:49:41 -0700 (PDT)
Message-ID: <5d9f724d-4c45-f843-04b3-60a907b9b127@linuxfoundation.org>
Date:   Mon, 24 Jul 2023 08:49:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Upcoming nolibc pull request for the next merge window
Content-Language: en-US
To:     paulmck@kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop>
 <20230722130120.6e4c0eab@canb.auug.org.au>
 <2c54d017-226e-41c3-a767-a607942ecba5@paulmck-laptop>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <2c54d017-226e-41c3-a767-a607942ecba5@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/23 22:48, Paul E. McKenney wrote:
> On Sat, Jul 22, 2023 at 01:01:20PM +1000, Stephen Rothwell wrote:
>> Hi Paul,
>>
>> On Fri, 21 Jul 2023 10:39:48 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>>
>>> This is just to let you know that Willy and I are adding co-maintainers
>>> for nolibc.  Shuah Khan will join me as administrative maintainer,
>>> and will be sending the pull request to you for the next merge window.
>>>
>>> Similarly, Thomas Weißschuh will be joining Willy as technical maintainer
>>> for nolibc.  With luck, this won't affect you, but in case you come across
>>> a nolibc issue, please reach out to Thomas as well as Willy, Shuah,
>>> and myself.  There will of course be an update to the MAINTAINERS file
>>> in the near future, but just to let you know in the meantime.
>>
>> Would it make sense to add a separate nolibc branch to linux-next (and
>> no longer merge it into the rcu branch?  Or are there dependencies
>> between the two?
> 
> Dependencies between nolibc and RCU are extremely rare, so it might well
> make sense to have a separate branch.
> 
> Maybe nolibc/next from either the -rcu tree or Shuah's tree?  Shuah,
> would something else work better for you?
> 

We probably have to add linux-kselftest nolibc and rcu nolibc since
we are planning to alternating pull requests?

Paul, you and I have to make sure we don't have duplicate patches
in our nolibc branches.

thanks,
-- Shuah




