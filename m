Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4093C7E2B65
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 18:43:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjKFRnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 12:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjKFRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 12:43:05 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575C7B7;
        Mon,  6 Nov 2023 09:43:03 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so4882985b3a.2;
        Mon, 06 Nov 2023 09:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699292583; x=1699897383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXH5ahRPz8knk5h9KfR4IuZwTMLTaHWDUAgFgEvqapQ=;
        b=QcTJCwh4g3NziEJxK/hSI2wCrOrQTkH7SxsH9a6ovTKxmo0/TmCilz/7Ite3KBcKgK
         Fa4bwMWJI6jSQITsUUIvZ7W8c98Xc9dxtl4FwWjb5FsKpeQTJuRbolCBDalpwAJc+2Yn
         lh82ey979ciOz5xxnqvkUkDqfQei77Qv3T9gkHZwCbDab4a2wnc8GVps+WHDl1Ep01FQ
         QXP+uknd/TRWYUvhfo5MtiUNVLXiVy9/sq4IEnjED2Qq5Zliahykbxut3FFl+dmNpU5+
         vfNxHJYRGuuu28BVcd//jsLNHt0gz+tc8w5/qJ4/1gOhCOzBw899dGpmeh3nxZ8fZjHD
         fHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699292583; x=1699897383;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CXH5ahRPz8knk5h9KfR4IuZwTMLTaHWDUAgFgEvqapQ=;
        b=To8Xt5Xq82k8lRPpKtFyP/gtapWzY+6iUE739kuBdwEaGez7l1iCCZQAor33hU0OPe
         HIhMeDXE67onELGfiIv/JBtX/w4H98q/q/j/cb9b3d/1tLzrpeVx9lM5AhDgoHMacMqB
         Bn8K3+pH70IdpK9CWYq2Dn9i/oR6V8qq7EdgNpu3m6yN5gOhh5S3r4uuCOi5BCo2mL1N
         +/5JHfxDSdDD484aAa7gy9/Ne57PSPlj0fVBcueWQal9taj09eFpcxHH4ECTUfvC4F3w
         38sjRK2er+n61T6/hvZUhERvFUU9bl6lC/1AmV2cePuEH/OB1Oqsl8+AlWM8QHgX0jI0
         RRpA==
X-Gm-Message-State: AOJu0YyYNJfbiAMgVpb+f2q3VTYQpkg7HWgTdPd/paAJ9twGdNS7am96
        X++Ka7UZSwLKhxzzL39jqBbE669GQoc=
X-Google-Smtp-Source: AGHT+IGdwlguaisgUp5xLqOca+yiZGMYX7D1ugesp5ymFRkqq5g+jSkbzdQHAeC4eV9GmySDDqEaYg==
X-Received: by 2002:a05:6a20:ae25:b0:16b:bd0f:ad0d with SMTP id dp37-20020a056a20ae2500b0016bbd0fad0dmr21552292pzb.28.1699292582698;
        Mon, 06 Nov 2023 09:43:02 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 14-20020a17090a01ce00b00273744e6eccsm6319954pjd.12.2023.11.06.09.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Nov 2023 09:43:02 -0800 (PST)
Message-ID: <b2867987-809f-4005-a303-9d8dba8882af@gmail.com>
Date:   Mon, 6 Nov 2023 09:42:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/128] 5.15.138-rc1 review
Content-Language: en-US
To:     Allen Pais <stable.kernel.dev@gmail.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        mizhang@google.com, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Darren Kenny <darren.kenny@oracle.com>
References: <20231106130309.112650042@linuxfoundation.org>
 <2665d8bc-111c-45ca-a473-b1c892867e9c@oracle.com>
 <CAJq+SaCqtQwk+eCgXT9jQU33Ufqr+aOaQq+VsXHCqdc1Qp8Vkg@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <CAJq+SaCqtQwk+eCgXT9jQU33Ufqr+aOaQq+VsXHCqdc1Qp8Vkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/23 09:08, Allen Pais wrote:
>>
>> On 06/11/23 6:32 pm, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 5.15.138 release.
>>> There are 128 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Wed, 08 Nov 2023 13:02:46 +0000.
>>> Anything received after that time might be too late.
>>>
>>
>> I am seeing a build failure with perf:
>>
>> tools/perf/util/evlist.c: In function evlist__add_aux_dummy:
>> tools/perf/util/evlist.c:266:31: error: implicit declaration of function
>> evlist__dummy_event; did you mean evlist__add_sb_eventâ€™?
>> [-Werror=implicit-function-declaration]
>>     266 |         struct evsel *evsel = evlist__dummy_event(evlist);
>>         |                               ^~~~~~~~~~~~~~~~~~~
>>         |                               evlist__add_sb_event
>>
>>
>> I think we should drop these three commits:
>>
>> 20a5799cae7dc perf evlist: Avoid frequency mode for the dummy event
>> 7de783c81c7e7 perf tools: Get rid of evlist__add_on_all_cpus()
>> 141ce9207068e perf evlist: Add evlist__add_dummy_on_all_cpus()
>>
>> Backport was requested here:
>> https://lore.kernel.org/stable/CAL715WLTjMGQrhm6wWqFSeL_Oq-HzoQd5CqewvLRLv0Xbnibgw@mail.gmail.com/
>>
> 
> 
>   Just tested perf build, I see the same errors:
> 
> tools/perf/util/evlist.c: In function 'evlist__add_aux_dummy':
> /linux/tools/perf/util/evlist.c:266:24: error: implicit declaration of
> function 'evlist__dummy_event'; did you mean 'evlist__add_sb_event'?
> [-Werror=implicit-function-declaration]
>    struct evsel *evsel = evlist__dummy_event(evlist);
>                          ^~~~~~~~~~~~~~~~~~~
>                          evlist__add_sb_event
> linux/tools/perf/util/evlist.c:266:24: error: initialization makes
> pointer from integer without a cast [-Werror=int-conversion]

Yep, same here (and on 5.10 as well).
-- 
Florian

