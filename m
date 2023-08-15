Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9777CFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbjHOQIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 12:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238452AbjHOQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 12:07:50 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE85C5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:07:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-686f74a8992so803072b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 09:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1692115667; x=1692720467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UMKm67He05h24Txxg1/AURd1FsY44qXVcXZxvPVybZY=;
        b=ymuIvAlCTGJu2UMghmJxyC5LIaBaMDPVRn6hEipva+70/Gco/Yz10PAT/TeKH41w3a
         qhJT4WiR16wemFgVY0or+iDZU+iXrgNTOULHgCCoS4/GwspTtb8TATbEJjtdVQYGl6Se
         jyuGkowLtcvhaUGVJAk9ujHeJ6bzUaudQFqDfSaDZFpBCBeCvlLCs1J6J2emsFkVSWxP
         aTU87i9u8gy4xa6szS5NCM0x4DfP9FsCOjxS13vOa0o+Ok7KaAXqNLvMYyeDxfmnOlMy
         9670fWa50wcSwcxIvM3ngKf8pdahkvpd7nZZMA6R7kUlSr9lFEgi6penpK6LoIJrymw3
         C43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692115667; x=1692720467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UMKm67He05h24Txxg1/AURd1FsY44qXVcXZxvPVybZY=;
        b=j6EvId6VVKx+jCfRBKNyxhl4IUX+Z3MOa9oVVvnTgJYMZpgfr0+OKFJJWnSDg12soN
         frmIpUGduUbXhtSzmNsbPvQHyjeb9mNmN4TTU1Fi3yx5gF6o9DwCUGGtre1m7Dt1O4sC
         J4xi445cYSeNQwdHOQShZcsL6IhV06cCB7G+aFkKrLfWmWF5kobEHIcntqUv88yEco+D
         nCM3wq+M17yUmmNpGxdCq+y9vqH2YCPj/d4p8yQyuQDOWmk1DWIYbGn52Ba9oQnrzZvB
         Mj5XMeolDkLOL7cspxgG5Cex4S30RnW9WBj3k/Pz3arZSz1oL61X5VpHruPAu58IZqxy
         d8iA==
X-Gm-Message-State: AOJu0YzG+o4b42EBeVA5FltFH1t79UeSfk7bMWccElgYTLAx90RZy/5G
        zERMyKe51nVeCfwr+BQG5Dg9qA==
X-Google-Smtp-Source: AGHT+IGCPhuG+fLQNjnvXlrKDzm+p3MkO03T2Gvyr1BkvQzHUgg2vTNZVBnV24TDUo8opcZjK9PFnQ==
X-Received: by 2002:a05:6a20:160c:b0:13e:1d49:723c with SMTP id l12-20020a056a20160c00b0013e1d49723cmr17366468pzj.2.1692115667484;
        Tue, 15 Aug 2023 09:07:47 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id c10-20020a63724a000000b0056416526a5csm10179832pgn.59.2023.08.15.09.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 09:07:46 -0700 (PDT)
Message-ID: <48f834c2-b283-4b02-9407-4a0842d4ed72@kernel.dk>
Date:   Tue, 15 Aug 2023 10:07:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230815091931.4dd2b277@canb.auug.org.au>
 <8c946512-0cc4-fbc5-ca36-0e2c6d636eb2@huaweicloud.com>
 <c39a3bff-01b9-4007-80ac-00ce2b11a902@kernel.dk>
 <CAPhsuW7ck4Bb8NVUdgZZJqzNCYMgT9rspKshr2Zi=8xo2cQLaw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAPhsuW7ck4Bb8NVUdgZZJqzNCYMgT9rspKshr2Zi=8xo2cQLaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/23 9:58 AM, Song Liu wrote:
> On Tue, Aug 15, 2023 at 11:08?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 8/14/23 9:21 PM, Yu Kuai wrote:
>>> Hi,
>>>
>>> ? 2023/08/15 7:19, Stephen Rothwell ??:
>>>> Hi all,
>>>>
>>>> In commit
>>>>
>>>>    71070e7bd25d ("md/raid10: fix a 'conf->barrier' leakage in raid10_takeover()")
>>>>
>>>> Fixes tag
>>>>
>>>>    Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
>>>>
>>>> has these problem(s):
>>>>
>>>>    - Target SHA1 does not exist
>>>
>>> Sorry about this, the commit was picked from previous md-next branch,
>>> and I didn't know that it will change...
>>
>> It's most likely not your fault, I'm guessing Song rebased that branch
>> and this is why the sha changed. Song?
> 
> Yeah, it is my fault. I am really sorry for this issue.
> 
>>
>>> Is there any way that I can fix this ?
>>
>> Only way to fix this is if I rewind my branch and Song updates his
>> branch to not have this issue, and then sends a new pull request.
> 
> Yes please. Let's fix this.

Please send a new one, I've dropped the old one.

-- 
Jens Axboe

