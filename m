Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC3A80D123
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344219AbjLKQXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjLKQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:23:07 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFFF95;
        Mon, 11 Dec 2023 08:23:14 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1d06d4d685aso26653065ad.3;
        Mon, 11 Dec 2023 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702311794; x=1702916594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=scctREUrC/LkD2SWnWUIOcPYbtzwbgiGpESeU3AjQfU=;
        b=Pm/v43+F671kPBh4klwWg9sAT2lgH0Z6w5UyMS/HRrABVe274ZWcDO8oMO4cxL+AAY
         ppC3Ed2BiIMDb1CHglJqO/4ABmGIRiSLptWsM1ZIhaCTueVkmSHMetmohQR+K+w4d9Nh
         Vy8kXy/MLrmSOvGdprssKyo38a9UoogasCyEjlVHuVBALNabz3dl0Z9mLPvYQnJtnGiK
         p+yK6gJCK2dClNCdVA+ep+hiSIdyT2T34LVx2QZhCWMUWm7BI3rTVBJoUGsv43W9+LEV
         UZndHWM0+JNwjpk7rNl93bD0rzOehWgzshOOawNmwpiQEpz7RpwxALSm1g/N63bmazGJ
         qnxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702311794; x=1702916594;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=scctREUrC/LkD2SWnWUIOcPYbtzwbgiGpESeU3AjQfU=;
        b=k9iI342dLfkJR8TTXxsw00iGDI7azZfgx7wmhkuneUUVxZk2Czi26RZ71JyQupGG+m
         8EQFwFHaYLiwvKY6iU62RUSF+1vTni6HzZPScJAdjBF3rEMcuAUpjhaBlofdsRvEhDJW
         qY/bqx+nr7eSjntr40qO77bm9pB4mjMBC2+9W/ZBREAYVHjv1DSIdBFlC0xZ+kbuTJWc
         8T4rcEzvjTobv/ECvIgqEfNFRESm5Fkx5uxagzW2+Oi9+I+c9zIBm4dnRzIYlauo43Gz
         FGGNnFR/Hvsr8QW/5Gp1tH2YSlPBxwNnSH3N6BmV+PjIob5bn2BtwK15KCg7f8V+uJjD
         wiqw==
X-Gm-Message-State: AOJu0Yz0Fc+HsXYBAeKMzliSp9l9z+JqxZRk3+AswXyl0jxuFiZOG7NS
        8hLkaGF6ca6qpuvMxc3txjk=
X-Google-Smtp-Source: AGHT+IHPotAv3uPPqVHvBtseAJHrTG39AWPJ/BxBFYBafRp/1i70x01N951mZeTdiDXCf+2en5KHBA==
X-Received: by 2002:a17:902:d503:b0:1d0:6ffd:f1fb with SMTP id b3-20020a170902d50300b001d06ffdf1fbmr2519816plg.81.1702311793723;
        Mon, 11 Dec 2023 08:23:13 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c3c600b001d07ebef623sm6855028plj.69.2023.12.11.08.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 08:23:13 -0800 (PST)
Message-ID: <991d92dc-9b08-497e-bef1-dde7de2642a0@gmail.com>
Date:   Mon, 11 Dec 2023 13:23:08 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/Kconfig: rust: Patchable function Rust compat
Content-Language: en-US
To:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20231211150753.293883-1-mmaurer@google.com>
 <CANiq72nrCThY3mtHRMncRFDsu8XUmdb=W4WBs5Ua6oNugkDZhA@mail.gmail.com>
 <CAGSQo03EPpPFy9ppE7wjv_NG8P_pRqLN21TvoMnYzA=+Z_gCnw@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CAGSQo03EPpPFy9ppE7wjv_NG8P_pRqLN21TvoMnYzA=+Z_gCnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 13:11, Matthew Maurer wrote:
> [...]
> Sorry, I just realized this was only in a local patch. I hadn't sent
> it previously because,
> as you pointed out, we currently only support one compiler revision.
> 
> I was taking this approach because Android's compilers can have patches
> backported onto them when needed, so our 1.73.0 could have this flag
> and make use
> of it.
>>
>>
>> Speaking of which, I can't find the flag in upstream Rust (i.e.
>> outside the LLVM submodule), and I couldn't find a PR adding it. Could
>> you please add a `Link:` tag to the tracking issue / PR / ... if it is
>> submitted / when it is submitted? Or am I very confused?
> I haven't uploaded it yet. I'm hoping to send it up later today. I can
> wait until it's
> uploaded for a v2 of the patch series so I can link to it directly.

If you can send the patch then it'll be wonderful, no hurries though.

> [...]
> 
> Re: Martin's comments (unfortunately they aren't on the same email so
> I can't reply inline)
> would you like me to file an issue against the R4L repository about
> this before sending a v2?
> I thought that repository was just for staging/discussion, and this
> didn't seem likely to need it.
> 

About issues, commits or PRs I was referring to issues in
`rust-lang/rust`. When we use unstable compiler features in R4L they
get tracked in [1].

Link: https://github.com/Rust-for-Linux/linux/issues/355 [1]
