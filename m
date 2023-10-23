Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744007D3F72
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 20:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbjJWSnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 14:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjJWSnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 14:43:03 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C31310B;
        Mon, 23 Oct 2023 11:43:01 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ca6809fb8aso23328945ad.1;
        Mon, 23 Oct 2023 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698086581; x=1698691381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/weOLyJtPWlh5siUgFN5Itg3AwgyF2jPHeNmSxivo64=;
        b=QpeTSdHRT331FATcm/TOj7lovLOqa+qBOGU1ueUE63a1bu/g+N1R3MmXOJtFg0bo7v
         BdCPt+oDlJA2xaHqLEBF2aJBcbNSdG68Wk/nEz6JAw01/3VE31bm5vdNjhTBQCdQqUp4
         zRCS1SY8dHPklYVTo3CCrHIsrIl3L4BuGZK+vQByypyEexk1hmtzIlmpQdZzk5QYngyJ
         sXQrwLrzoF2dawwOhr4jf79QJlWG171b8uU3/t7Nl6nf6/UEUU0GuD7tcaL8puVQcBBd
         dsTrJ/Hc4hcZiJOcfcRb//3rnP/CPDo9HT4ouSjWz/BQ0+PzUBYscAzG/OSRvBPchh11
         FUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698086581; x=1698691381;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/weOLyJtPWlh5siUgFN5Itg3AwgyF2jPHeNmSxivo64=;
        b=TUlIaR6p+535sZDo4TQuB3gBScHAwt6bE6bjisw40NiGkta+Vte9sEwmatAWwvdrEP
         qwsrFaQTZ5TzKJfFFyr++wZtY4rZzjhzn04o5l2f5sy4+lT7q3yK1Ci/sQcalFJwRxMG
         ygRZUgYBZymflAwa+2GkhQc5PoGMRNly9mOHJ0Gs/Odoqcirm50h+BvHNjprcGOwtiO+
         ssKBW0+51sBI5cisLotlHw8ghVPChHyV4XrV5aJrc3WDwR4HAgP8jY33Zz3UiHhG1hWe
         qAYkuoSeAiuoim9Wbya41O/aSXOIbQysbS7drAqdj9VzgbvyShT395Q6rSLg/298IF1V
         e4Ng==
X-Gm-Message-State: AOJu0Yw+/4RZblUoDsxclOd0TJUw7z2SrHdgSeHpn5/NkrsX/njlC9Sd
        hMxjBs8CeBTdxfkuAVUVGJg=
X-Google-Smtp-Source: AGHT+IEZD90O8n0Vj11F0UcDsagtID81H9xP0zBmAnLN9X3dVPcTNym3zFvCwwvylZStx4FAQ/jzVw==
X-Received: by 2002:a17:902:c215:b0:1c7:3558:721a with SMTP id 21-20020a170902c21500b001c73558721amr7044165pll.58.1698086580961;
        Mon, 23 Oct 2023 11:43:00 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c94600b001c9c3c377f2sm6238806pla.203.2023.10.23.11.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Oct 2023 11:43:00 -0700 (PDT)
Message-ID: <f53536ca-ec5b-4cdc-a340-e9c739ee30c4@gmail.com>
Date:   Mon, 23 Oct 2023 15:42:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/rust: depend on !RETHUNK
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
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
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231023174449.251550-3-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/23 14:44, Miguel Ojeda wrote:
> The Rust compiler does not support the equivalent of
> `-mfunction-return=thunk-extern` yet [1]. Thus, currently, `objtool`
> warns about it, e.g.:
> 
>      samples/rust/rust_print.o: warning: objtool: _R...init+0xa5c:
>      'naked' return found in RETHUNK build
> 
> The support in `rustc` for `-Zfunction-return` has been submitted and
> is being reviewed [2]. It adds the needed LLVM function attributes and,
> with it, I got a RETHUNK kernel build with Rust enabled that does not
> print the `objtool` related warnings, boots in QEMU and can load a kernel
> loadable module.
> 
> In any case, until proper/complete support is added to `rustc`, make it
> a hard restriction until the mitigation is in place.
> 
> This may have an impact for developers that may not need/care about the
> mitigation in the Rust side (e.g. Ubuntu offers Rust as a "technology
> preview" [3]), but given we are getting closer to having the first actual
> in-tree Rust kernel users, it seems like the right time to disallow
> it. This should also avoid confusion [4].

I'll mention that I've tested boots, both in bare metal and QEMU, with
`RUST=y` and `RETHUNK=y` and they were alright regardless of `objtool`
warnings. Although, if you had an issue in the past then I'd like to know
about it.
