Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38ED753BFD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjGNNrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjGNNrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:47:03 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53A5271C;
        Fri, 14 Jul 2023 06:47:01 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a04e5baffcso1552013b6e.3;
        Fri, 14 Jul 2023 06:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689342421; x=1691934421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HD6EwZbQJu1bCBY+rcg6mXiAoH8uR23NwA33Iv9SafM=;
        b=pT1kVQ6XLLU5dt5E+AFNY9QhZuRBQIYTjp1J6S5jlO6nFuZZudojXsRjSdMSjylMAd
         gAJPOW/iRlTqdkc9XggqD53ZtMYT0mYuFAUAM/8xqFCGDYtJlGFwWp0BrdgKdjQpphLz
         Mb1XpiicBDqWgVKV2WUgc9Wz9kheJJyuN+u48GVQhxNanlycVjmAZwXs4LGt75+sLLYe
         HrMEVVTzUMDhL8xsPik+gmHICkO8sjbXy54hda1q7/0yUzfMTXYXCVba1lS7ECUHyybJ
         pKBTfsfnqzmSGza4TQaUCkLGUrHDqfCgGZDyWMjZApQ8KOlnmg74P++ZGxT3Srg1uMty
         iM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342421; x=1691934421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HD6EwZbQJu1bCBY+rcg6mXiAoH8uR23NwA33Iv9SafM=;
        b=d3SeFEL9QHSR+SslOGwvE1xZUK8hQHn+inNOZHtBWLZaN0BK7/FvZpI0eKmtijaWbq
         KXOwNZ7Y+X8Eujdetynw8jozu7VZPLhjvzjfw9C45CR6mu882jRiOf4l5Vq+3OKQg356
         bObyqqMUiCOgRAX3eCheO66kKZvI7bGzUvLyhRfEx2V87d5Y4yKyX6Gpfl+POE/MCfV8
         +psr7JpYA1AVt7BjboTX/AOC9noIhXQh8Eee8SlOK/LwjFwR0tTKAe45MKMQ2fHGMht4
         z9vqbAz+kNXa/alE0okMOEVIEdNfIG1W1/2vJX0G5TKtqtAfSMpPWSz26632VZYEcqtO
         v4Bg==
X-Gm-Message-State: ABy/qLZbxvjjHTvBiJtbLeXnVW0gESLid38C6ASnduEorQilby9bBi9H
        t+grkYR0XGcoLSVm3ZPJeCo=
X-Google-Smtp-Source: APBJJlFbbN9VExbGP8hKwyPAcp1eD3AMx0mXuJb5JT/bX58FKmMu7OuwcKqRfpZi3NBQCmLvHP2opw==
X-Received: by 2002:a05:6808:573:b0:3a3:6536:dd89 with SMTP id j19-20020a056808057300b003a36536dd89mr5292957oig.49.1689342421072;
        Fri, 14 Jul 2023 06:47:01 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id k11-20020a54440b000000b003a1ec14d8c6sm3834259oiw.23.2023.07.14.06.46.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 06:47:00 -0700 (PDT)
Message-ID: <abab244f-afdb-f646-ce82-c5296fe74ce6@gmail.com>
Date:   Fri, 14 Jul 2023 10:46:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] rust: kernel: str: Implement Debug for CString
To:     Asahi Lina <lina@asahilina.net>, Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, asahi@lists.linux.dev,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
References: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
 <20230714094844.2189906-1-aliceryhl@google.com>
 <15a21f18-485d-37d8-0a5e-417702787204@asahilina.net>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <15a21f18-485d-37d8-0a5e-417702787204@asahilina.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/23 09:21, Asahi Lina wrote:
> On 14/07/2023 18.48, Alice Ryhl wrote:
>> Asahi Lina <lina@asahilina.net> writes:
>>> Trivial implementation.
>>>
>>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>>
>> The commit message is a bit short, but the change itself looks fine.
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> It's so trivial I just didn't know what else to write... suggestions
> welcome (for this or next time I have a patch like this) ^^
> 
> ~~ Lina
> 

Just describe what it does, like "cast the `CStr` to an `&str` and call
`fmt::Debug::fmt` with it". I'll add my Reviewed-by, so retain it in
case it's asked to change the commit message.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
