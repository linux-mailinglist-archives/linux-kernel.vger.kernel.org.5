Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E2F7CFE27
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346359AbjJSPlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346324AbjJSPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:40:58 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439FB13E
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:40:55 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-3574c225c14so10410105ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697730054; x=1698334854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DEnVh39G2MAZ987aIaVUYRG5XCyY7oegMKrJw/1orDU=;
        b=uzXkV7cjvaVodluXe6r7PjchUiTcjp99p1vLRgfX1Dzlo5UusIbkIv348yTshly5QD
         F3GK1P4mEXkgFKDe25nh6g3wJYaRcLnNGsu2p1g2JLy/f+PB1NFXYaCYUVGa9vAt7xrG
         06gr3GfLyhkqwldgdGmxfV/DY4xUt3nnpRvP2UBSodyhEssPq76F0yvC6E9XXO+0m4dS
         2q5Fuh/1uHLzM3N20Fg74MFXVdkSs0XOaHibdGiINLyKsKBJDB9COCqmDVMVV7KoHyPQ
         UE6uxCVCtmmKLvBxTAzJXcWrzpFW4NmaSamdwbGUXQaVqnEVNHpLgDy8pxFY+nM1+/h7
         NvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697730054; x=1698334854;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DEnVh39G2MAZ987aIaVUYRG5XCyY7oegMKrJw/1orDU=;
        b=l+wGkDVLHTetb1mqdbwEN+DfxWURSMOAwogw/w/c9+HY7PzrBXdvYC7TyPXjL4crpk
         uo4RHyDaReNF8KJHsgY8guvJ3/XtcTeuDULCZ1VS3tQ6Z05vSdZgK2rI66gzrF6Wqk5n
         rO8FK3/VCjLwBJY+YNihi0syDwJdzcQWhVDSQpofAGMFYo85K0EJ8Tr4t7t3dv5tWqsh
         nM3I8AENX4bDVNm1nJc0zCdOPAbTdMWCBhno6BtgapFA7uUAwXMYP10mnbZFzzjpJDIb
         2oG3ABwbv+XqNyIyRQKOFeyYQA+/nm1/KA3yxFdv5MMyscRWoFqqbSGdYZ20epHIXglk
         rjgA==
X-Gm-Message-State: AOJu0YzfG6lk8MF0KkJW0iOBiU9YVepi30dSIV38WRLPxkoNNuKU8wBy
        QE0PX/2eNMYDnwfiPmeEMtZPUw==
X-Google-Smtp-Source: AGHT+IFjQ3qpZyxj51SibTF8YykdYd4Gbz5spT1Xb9tdSDNeWvrpy8xIcdHmWjN10zegDqEeGeibwg==
X-Received: by 2002:a92:d686:0:b0:351:54db:c1bb with SMTP id p6-20020a92d686000000b0035154dbc1bbmr2603572iln.0.1697730054404;
        Thu, 19 Oct 2023 08:40:54 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i22-20020a056638381600b0045bc0378faasm2000238jav.29.2023.10.19.08.40.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 08:40:53 -0700 (PDT)
Message-ID: <11debbc9-de33-4466-a997-c8f49d27fd18@kernel.dk>
Date:   Thu, 19 Oct 2023 09:40:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/11] io_uring: Initial support for {s,g}etsockopt
 commands
Content-Language: en-US
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Breno Leitao <leitao@debian.org>, sdf@google.com,
        asml.silence@gmail.com, willemdebruijn.kernel@gmail.com,
        pabeni@redhat.com, martin.lau@linux.dev, krisman@suse.de,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, io-uring@vger.kernel.org
References: <20231016134750.1381153-1-leitao@debian.org>
 <7bb74d5a-ebde-42fe-abec-5274982ce930@kernel.dk>
 <20231019083305.6d309f82@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231019083305.6d309f82@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/23 9:33 AM, Jakub Kicinski wrote:
> On Thu, 19 Oct 2023 08:58:59 -0600 Jens Axboe wrote:
>> On 10/16/23 7:47 AM, Breno Leitao wrote:
>>> This patchset adds support for getsockopt (SOCKET_URING_OP_GETSOCKOPT)
>>> and setsockopt (SOCKET_URING_OP_SETSOCKOPT) in io_uring commands.
>>> SOCKET_URING_OP_SETSOCKOPT implements generic case, covering all levels
>>> and optnames. SOCKET_URING_OP_GETSOCKOPT is limited, for now, to
>>> SOL_SOCKET level, which seems to be the most common level parameter for
>>> get/setsockopt(2).
>>>
>>> In order to keep the implementation (and tests) simple, some refactors
>>> were done prior to the changes, as follows:  
>>
>> Looks like folks are mostly happy with this now, so the next question is
>> how to stage it?
> 
> Would be good to get acks from BPF folks but AFAICT first four patches

Agree, those are still missing. BPF folks, do patches 1-2 look OK to
you?

> apply cleanly for us now. If they apply cleanly for you I reckon you
> can take them directly with io-uring. It's -rc7 time, with a bit of
> luck we'll get to the merge window without a conflict.

I'll tentatively setup a branch for this just to see if we run into
anything on the merge front. Depending on how the BPF side goes, I can
rebase/collect reviews/whatever as we go.

-- 
Jens Axboe

