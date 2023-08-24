Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CA078716A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241567AbjHXOY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241564AbjHXOX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:23:57 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED861BC5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:23:55 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-34ca6863743so5322645ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1692887034; x=1693491834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l6Q37NHJfSNnXNIPUrsHPxEdErq9UphzW/lTqAGq/n0=;
        b=gOYohoJ6FrkWvto0A1/NwMQM5zfHYyGdtwHTQdwlBUywfkbW35i43wIpCTAUjGnd8d
         D/yihkX4B7qc3t6uYfLiISNSq9TVNeQOe/lIgW271zLBHx6xPobiX01kSjjPCiBdtUob
         NsvPgfpfIf8MuYoiHkAabh+axuzQMRVdMa/4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692887034; x=1693491834;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l6Q37NHJfSNnXNIPUrsHPxEdErq9UphzW/lTqAGq/n0=;
        b=gwWzg40GnWltBtoecCZ1f3+kJ6YtJi7KPN9Rr8VeVoPcPRkgMY8+hcu9nvGNhzZq08
         RtnPo3qtHkPFhHGkd17lRdv215ad0RTTTUabDPM/xtLuDx6GQaoKb4LXObzOd+sJm0NG
         lBJ+lYKzHqoRBV9rQ9/AIMZHT6Cfqy0G0Pt0M5x0buIalX4Jmb98H5PbJUirw44zR4Ko
         TCcXt5SWnVeIP3Gb+22e/Spvtn7XpOMP6DkEQ+8faMfkGVmVymNFiRmV/Tq8ScSw2Mau
         3/Jm1ZiPBlK3ldUmtzwdeg5OLizfMfbTpxknM0SDW/RZ+Ujkd/mF4TWsICGYtUjQS25w
         DP9w==
X-Gm-Message-State: AOJu0Ywuz7QYQmS3qGiGVhL3v/iYMOb4Y1GmROSDvzKBJLtivh29WauW
        +SYJfpwQ6TYzvtQtMLpLbSoL0uT084kEOaD/H2s=
X-Google-Smtp-Source: AGHT+IEVyyH/ktlrcmopIDZEzBk6VO9cbAfc9aKy/+LaHLAeJBRH8/+/D93jvczKrxo52XAhvMGIzg==
X-Received: by 2002:a92:c00f:0:b0:349:67b0:6045 with SMTP id q15-20020a92c00f000000b0034967b06045mr15481796ild.3.1692887034663;
        Thu, 24 Aug 2023 07:23:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l3-20020a922803000000b00348cb9adb38sm4583652ilf.7.2023.08.24.07.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 07:23:54 -0700 (PDT)
Message-ID: <4328e2ca-7cec-4043-6c4f-e6a8a37c1b0f@linuxfoundation.org>
Date:   Thu, 24 Aug 2023 08:23:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: linux-next: manual merge of the nolibc tree with the mm-stable
 tree
To:     paulmck@kernel.org, Willy Tarreau <w@1wt.eu>
Cc:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <thomas@t-8ch.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230817133053.76d9f850@canb.auug.org.au>
 <28aeee7b-2de5-4f39-8eb5-3e3486eeed1b@t-8ch.de> <ZOb9OuFh/2pmkRv+@1wt.eu>
 <18989954-981e-46bb-a60b-973c1c58fd86@paulmck-laptop>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <18989954-981e-46bb-a60b-973c1c58fd86@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 05:45, Paul E. McKenney wrote:
> On Thu, Aug 24, 2023 at 08:48:26AM +0200, Willy Tarreau wrote:
>> Hi Thomas,
>>
>> On Thu, Aug 24, 2023 at 08:41:18AM +0200, Thomas Weißschuh wrote:
>>> Hi everybody,
>>>
>>> On 2023-08-17 13:30:53+1000, Stephen Rothwell wrote:
>>>> Today's linux-next merge of the nolibc tree got a conflict in:
>>>>
>>>>    tools/include/nolibc/stdio.h
>>>>
>>>> between commit:
>>>>
>>>>    08d959738a95 ("selftests: line buffer test program's stdout")
>>>>
>>>> from the mm-stable tree and commits:
>>>>
>>>>    65ff4d19f792 ("tools/nolibc/stdio: add setvbuf() to set buffering mode")
>>>>    2e00a8fc4f47 ("tools/nolibc: setvbuf: avoid unused parameter warnings")
>>>>
>>>> from the nolibc tree.
>>>>
>>>> I fixed it up (I just used the latter version of this file) and can
>>>> carry the fix as necessary. This is now fixed as far as linux-next is
>>>> concerned, but any non trivial conflicts should be mentioned to your
>>>> upstream maintainer when your tree is submitted for merging.  You may
>>>> also want to consider cooperating with the maintainer of the conflicting
>>>> tree to minimise any particularly complex conflicts.
>>>
>>> how do we want to handle this one?
>>>
>>> A small note to Linus in the PRs to him on how to resolve it seem
>>> reasonable to me.
>>> But I'm fairly new to the process.
>>
>> My understanding is that Stephen's fix is still in his tree. We may indeed
>> need to add a note to Linus in the PR about this one and the other one.
> 
> Yes, this is the usual approach.  The note to Linus normally includes the
> URL for Stephen's email.  I usually also do the merge myself, publish
> a branch to it, and include the name of that branch in my pull request
> to Linus.  Linus usually prefers to resolve the merge conflicts himself,
> but my merge gives him something to compare against.
> 

Right. This is how resolve these types of merge conflicts. I will add
note to Linus about this one and the other one with vfs.

thanks,
-- Shuah

