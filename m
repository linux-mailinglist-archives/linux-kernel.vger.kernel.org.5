Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217497D5AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 20:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343871AbjJXSsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 14:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjJXSsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 14:48:43 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890CDD7D;
        Tue, 24 Oct 2023 11:48:40 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b1e46ca282so4765953b3a.2;
        Tue, 24 Oct 2023 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698173320; x=1698778120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DFRAuWK32VTGr08EDsBUV/zh4O1jsXdg+48RuQhbEtQ=;
        b=JFIA/tsmUdlZ1PiPIhtHARJSNTuDiZlV/kAp0Xeh2QHQHm2/ZLj8iZxtP1MduvwU/B
         /t09e0YHwmQimj295PtaUENLJhMQ0QBN6s+7e5gMtjJ6q0kCGgFs+i/xJMNS0W1KSfk/
         oNCSy/y89EKG3IZ5jlOsJZ2iXdAXmwyg6Hdjydhh3rgpte6IGDyZbL3I1wONayC2pJkl
         02EKRIpCCRmzTIGg6//m4sRWAxDIJ90/Uhr89REe6k0ndPsRd12dgYta2U9OEIpWkg9I
         zaCRnGv14G3KEMy4Cn91aQubZXqGME3VR8MFYjp509AeCim0dcftgUCz7Bmr0A1wp2FT
         22bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698173320; x=1698778120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DFRAuWK32VTGr08EDsBUV/zh4O1jsXdg+48RuQhbEtQ=;
        b=bCw/kEFHADIBesASZLKTmQ3Q8WVCPKs11TEthb39HPXgSFSi6+ISmXuc0d6KftS76B
         4HPsTxXgSPDFke+io5eg9YjOZF2ti3Fa2hyqnr4iYFlszowpGNLgs/EZ4FN0CB0c7ifU
         LDIpqdJeL1Wu3snne1k34mcwKh87eBClBfoKVfF4Ih/we+g0k8/IQbrXGK/BXxf9nTbd
         ZwiGycJRh4GHgo+Hxea2UOdt3CvA3O5v7twpCYIiIvHNr4/SCeIkw4sQzyvqhyFXtACh
         WpKNEkioW94mLCT8OV7cCXT1lhs1PzxmQ9q7vqq9v7e/BTfrq69HEoJINyUe16XaT74z
         0uaA==
X-Gm-Message-State: AOJu0YxQ6xQahET/lQrLSVGskl8BKzh8h1qk9ktGyyeAUjW0wdJhNMR4
        BCqtEdp2zu6PMlaqD02L0jc=
X-Google-Smtp-Source: AGHT+IGYqlQhFzyXGwIJxZYzz10J32/aPAHvTNFD/mHPn6Cz/ujm1FsJgr5vpKqfqwNFp0i0LrBu2A==
X-Received: by 2002:a05:6a21:1448:b0:16b:c725:1dc with SMTP id oc8-20020a056a21144800b0016bc72501dcmr3160186pzb.35.1698173319867;
        Tue, 24 Oct 2023 11:48:39 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id h1-20020a625301000000b006be484e5b9asm8297905pfb.188.2023.10.24.11.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 11:48:39 -0700 (PDT)
Message-ID: <cd0eb23b-6c46-4069-ba29-9820c99b8ca8@gmail.com>
Date:   Tue, 24 Oct 2023 15:48:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/rust: depend on !RETHUNK
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>, x86@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20231023174449.251550-1-ojeda@kernel.org>
 <20231023174449.251550-3-ojeda@kernel.org>
 <f53536ca-ec5b-4cdc-a340-e9c739ee30c4@gmail.com>
 <CANiq72nTE_qua9w+EeqiPCukst4876Gi7gHeusFLofYZRoJCDw@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CANiq72nTE_qua9w+EeqiPCukst4876Gi7gHeusFLofYZRoJCDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 19:15, Miguel Ojeda wrote:
> On Mon, Oct 23, 2023 at 8:43 PM Martin Rodriguez Reboredo
> <yakoyoku@gmail.com> wrote:
>>
>> I'll mention that I've tested boots, both in bare metal and QEMU, with
>> `RUST=y` and `RETHUNK=y` and they were alright regardless of `objtool`
>> warnings. Although, if you had an issue in the past then I'd like to know
>> about it.
> 
> These are mitigations -- things do functionally work if they are not
> applied, but you would be vulnerable.
> 
> In other words, it is not like e.g. IBT where you could have noticed
> it breaking by running it normally if you happened to have a supported
> platform.
> 
> Cheers,
> Miguel

'Guess you have a point...

Acked-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
