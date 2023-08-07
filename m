Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA2772FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjHGTtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjHGTtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:49:09 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88821BFE
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 12:48:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-52256241c50so7016238a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 12:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1691437638; x=1692042438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9w+dD7oBoo3Er0Bu1CBuXGCJGgEYD7GFzLamH3ZCcr8=;
        b=ACLAwZ5Q1QYlglJh/cTJUTTmgmubDo2WtPMVNFJIP6B/9pz+vkZY90O9pNMAVM293k
         GF3F2dxluChNVCpjeSG4B9Pfrr58vGW25dKtDK2rwQReKirZt0ep5Y2ANyw63fKb6DPE
         c218tSgxg3HjoEfH1taAVjczofcd5uuOx8ZMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691437638; x=1692042438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9w+dD7oBoo3Er0Bu1CBuXGCJGgEYD7GFzLamH3ZCcr8=;
        b=jpCMZ/d2zEM4XT/B5s7mNeeV3zFQLbxUeBsrKJSSJtBg2OR9r5USuGN4gcYLmffAH2
         0+is/bAjbLJQavsmO626FEoPQY5wmW0OtSiJQZ6agAcmLSac2HU52aXh3DDwBmnKxIcp
         475/FQcuIX4+wCrY9HOZr70EjvKUdHjyCh7BP149sk+WKAElGxiWEYvUUAmXLGiEe3yA
         GY+aiSneLqC1rfarU2ZV2LWLuJhX/A8he/PAIW3bkAcOFIRhcR8oB5vpY77HhlnmTyBY
         AuIbvj2gUQumXE5Oir6cchT7OFISXg484h81YPH7PlLci8SmVv+YfyTGi8N3I0Q9/CyJ
         kDkA==
X-Gm-Message-State: AOJu0YxMp3+PfJqQjPPdEJ3IhV/2IHdrubVboMbjz5bKL2aeM9RFO/qj
        kB5xagXGEafBWRauu9y07tYgXw==
X-Google-Smtp-Source: AGHT+IG+HQvpo71rtv3OpKs0t9vFLDYnAM2od1lnPHOPbGnZQjr2+hSnY38MLF+pnk5+t/FTuQVvig==
X-Received: by 2002:a17:906:1db:b0:993:f2c2:7512 with SMTP id 27-20020a17090601db00b00993f2c27512mr10894304ejj.33.1691437638444;
        Mon, 07 Aug 2023 12:47:18 -0700 (PDT)
Received: from [192.168.1.128] (77.33.185.10.dhcp.fibianet.dk. [77.33.185.10])
        by smtp.gmail.com with ESMTPSA id x13-20020a1709064bcd00b00992b3ea1ee4sm5701924ejv.149.2023.08.07.12.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 12:47:17 -0700 (PDT)
Message-ID: <5eca0ab5-84be-2d8f-e0b3-c9fdfa961826@rasmusvillemoes.dk>
Date:   Mon, 7 Aug 2023 21:47:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/3] lib/vsprintf: Sort headers alphabetically
Content-Language: en-US, da
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-2-andriy.shevchenko@linux.intel.com>
 <ZNEASXq6SNS5oIu1@alley> <ZNEGrl2lzbbuelV7@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZNEGrl2lzbbuelV7@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 16.58, Andy Shevchenko wrote:
> On Mon, Aug 07, 2023 at 04:31:37PM +0200, Petr Mladek wrote:
>> On Sat 2023-08-05 20:50:25, Andy Shevchenko wrote:
>>> Sorting headers alphabetically helps locating duplicates, and
>>> make it easier to figure out where to insert new headers.
>>
>> I agree that includes become a mess after some time. But I am
>> not persuaded that sorting them alphabetically in random source
>> files help anything.
>>
>> Is this part of some grand plan for the entire kernel, please?
>> Is this outcome from some particular discussion?
>> Will this become a well know rule checked by checkpatch.pl?
>>
>> I am personally not going to reject patches because of wrongly
>> sorted headers unless there is some real plan behind it.
>>
>> I agree that it might look better. An inverse Christmas' tree
>> also looks better. But it does not mean that it makes the life
>> easier.
> 
> It does from my point of view as maintainability is increased.
> 
>> The important things are still hidden in the details
>> (every single line).
>>
>> From my POV, this patch would just create a mess in the git
>> history and complicate backporting.
>>
>> I am sorry but I will not accept this patch unless there
>> is a wide consensus that this makes sense.
> 
> Your choice, of course, But I see in practice dup headers being
> added, or some unrelated ones left untouched because header list
> mess, and in those cases sorting can help (a bit) in my opinion.

I agree with Andy on this one. There doesn't need to be some grand
master plan to apply this to the entire kernel, but doing it to
individual files bit by bit does increase the maintainability. And I
really don't buy the backporting argument. Sure, backporting some patch
across the release that does the sorting is harder - but then,
backporting the sorting patch itself is entirely trivial (maybe not the
textual part, but redoing the semantics of it is). _However_,
backporting a patch from release z to release y, both of which being
later than the release x that did the sorting, is going to be _easier_.
It also reduces merge conflicts - that's also why lots of Makefiles are
kept sorted.

It's of course entirely unrelated to moving the declarations of the
provided functions to a separate header file, but IMO both are worth doing.

Rasmus

