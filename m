Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A227C8928
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 17:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbjJMPxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 11:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjJMPxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 11:53:37 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92112B7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:53:34 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a29359c80bso20138339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697212414; x=1697817214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1ab2WuFIKFA3ma0ZjQfVChX06Ccj0lK7DdwFjTIGBA=;
        b=bMCaOVPLmjdUUJk41icyyKvHf1jHZrvZQoTWQ4b1Ya5gbBeRrnMoRTgUwfP4imhfvI
         MbwEz9u096CsLR/j76Wn9e4rzzt2v0fbiJcIlhO9U/HgNNJqagGnkqiwz+Fek/TbMqOK
         bKacmQD095tA5wDxDPeRrSLk3sKybZsOg5nkSr6h/4iOJtyLmMTLuz5SYx2q/TzJwGNK
         CVJ+PJI9v1mR2ssV4Uevdktyw6xc0zV+lAlK1mAYCMVGg5kMegq4I4FLcxjuodOGLjoN
         Iqwv4QtiuCX8wLvZAXStKGMyR8tfCvh6yjsBKuQLf/flv/DozNgCZU2PRevqWvUWp14H
         ADLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697212414; x=1697817214;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a1ab2WuFIKFA3ma0ZjQfVChX06Ccj0lK7DdwFjTIGBA=;
        b=dZw29/XeRLULbdpxEISLf7EnLXEiLTSyrx57o4Ww/Ikg59j1WzedhGVGgWkIBl11Og
         fmWHrSh4HSnmQ0WXP+YdcPjVUzBB6sqZIb8Pps/chJHmvki6dmtLMnmwD1elzxcas8Sz
         jjq7wNauW66sZSBMlfoiNFTtF07W0SkMoae0tJKlb/I19z0RRcTtQ9UwVonhDkRvlqUx
         MXq+gGFifieBQV1dr0CspB2E/MaAPYymTBK1dDsWc9Hn6ViQiRdVzy1MAD6jNI50lhMO
         u/K1WD9hlXQLct7Jo/Fsf7IcgXgmJehLdgJf49vBu3omB57lW6Oh11Nn8pFdL5wj7Zpk
         B1Jg==
X-Gm-Message-State: AOJu0YwHADAM+XMxOVuPFgiBkTdbLJ7wpPLA3WwGCNZNh56UPANrMMv9
        dPRZBIu7bb7/MXeJLafnnHWecA==
X-Google-Smtp-Source: AGHT+IGD+Y6udldFEfNzSbeSH4ZSFKpxb16IumSgm5Ax2wKNRo/VZ1i60Er7mUo8Y6PAYB6BQM7MWg==
X-Received: by 2002:a05:6602:368c:b0:792:7c78:55be with SMTP id bf12-20020a056602368c00b007927c7855bemr26797941iob.0.1697212413928;
        Fri, 13 Oct 2023 08:53:33 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id d24-20020a6b6818000000b007911db1e6f4sm4935706ioc.44.2023.10.13.08.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 08:53:33 -0700 (PDT)
Message-ID: <f1a37128-004b-4605-81a5-11f778cd5498@kernel.dk>
Date:   Fri, 13 Oct 2023 09:53:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Content-Language: en-US
To:     Christian Brauner <brauner@kernel.org>,
        Dan Clash <daclash@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, paul@paul-moore.com,
        linux-fsdevel@vger.kernel.org, dan.clash@microsoft.com,
        audit@vger.kernel.org, io-uring@vger.kernel.org
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-karierte-mehrzahl-6a938035609e@brauner>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231013-karierte-mehrzahl-6a938035609e@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/23 9:44 AM, Christian Brauner wrote:
> On Thu, 12 Oct 2023 14:55:18 -0700, Dan Clash wrote:
>> An io_uring openat operation can update an audit reference count
>> from multiple threads resulting in the call trace below.
>>
>> A call to io_uring_submit() with a single openat op with a flag of
>> IOSQE_ASYNC results in the following reference count updates.
>>
>> These first part of the system call performs two increments that do not race.
>>
>> [...]
> 
> Picking this up as is. Let me know if this needs another tree.

Since it's really vfs related, your tree is fine.

> Applied to the vfs.misc branch of the vfs/vfs.git tree.
> Patches in the vfs.misc branch should appear in linux-next soon.

You'll send it in for 6.6, right?

-- 
Jens Axboe

