Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E675BB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjGUAZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGUAZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:25:18 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B512D47;
        Thu, 20 Jul 2023 17:25:11 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a3efebcc24so979614b6e.1;
        Thu, 20 Jul 2023 17:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689899110; x=1690503910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o65wHm+GCCRza8lHZdua95nzqOaSV3elekh8FSqfMec=;
        b=he35k3gYDV3/T18SyxesYpTF79XCzMit5Mflh87neU1B/a1ZD6Vg0yTRQhJWseEmii
         IOnW/hP/9yDwu+sQG9Kpdt8OWyfM/LiXpItgBhcHXyAc/KXskdlkWFPKAi4G/Xzin3eB
         2ksDE7eUeq/YBLiT8WfRU4YBgRssQsvsZdTgCzTUiSjrM7ECTVdXFz8oElu1jwkW1QYX
         tfse5bMDaEzeL1c77gbxzsjXvuypGJkPGGl2i2TfTqiqGeIwEJyZ0eJXVBmy364ZFiZ5
         9Ne7lk2gPWKjZ5Y+MjGADIF+5sXCVuxlbGWdcA/yjXva4A39YNiBhgxBTnD7/FR7h3Uk
         qMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689899110; x=1690503910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o65wHm+GCCRza8lHZdua95nzqOaSV3elekh8FSqfMec=;
        b=SEqMKl1yyYpR7I2B4JJHBY9HCPesJX4fpiKoDEljxjlLB0UOv0b0aCNOxlYmtp7yxf
         R+HhqsH/ImPOkrL48ly6rSZoI9T5j1uZLUunfLP1EhYeLbZi+DfSU8pgGF01OuUNM712
         1OYz11V21ZV3vfMcBC0boSDQtZLtp9O+6ntuaioMOvSlVcOoNzEE3oMlTPJe84DdaRnr
         qoqSC08W2CIW13u8f6UB0soHRIGcs2QiFd7gfzi2VO8b4Wh9843O06rAsEH+fA3FEr7+
         VLfQ2l3MyBoWbxJliDavTIfD4JULPQBQP9COJGtseepaLHVV7igGb5NEm+ht53JULZMj
         YV4A==
X-Gm-Message-State: ABy/qLaCbZIS+TXM7YZBSHU8fsij2BW/7pnFMjbfm/lqEKe+nInDEKSn
        LPIg0xgiVDxXf3036ur0oQM=
X-Google-Smtp-Source: APBJJlE2iCU5PAJBViPjnlnGrjW6IhYY6WnyvxFsdZ3M4JyYuRiyjvk1LZFFVM/bSoh2APPZean3qA==
X-Received: by 2002:a05:6808:1115:b0:3a1:d1d9:d59c with SMTP id e21-20020a056808111500b003a1d1d9d59cmr451461oih.33.1689899110197;
        Thu, 20 Jul 2023 17:25:10 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t25-20020a056808159900b0039ee1de4e6esm928210oiw.38.2023.07.20.17.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 17:25:09 -0700 (PDT)
Message-ID: <cc7c9fea-a435-af8c-ca78-d0e5d852d0c8@gmail.com>
Date:   Wed, 19 Jul 2023 16:04:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] rust: init: make guards in the init macros
 hygienic
Content-Language: en-US
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Asahi Lina <lina@asahilina.net>
References: <20230719141918.543938-1-benno.lossin@proton.me>
 <20230719141918.543938-4-benno.lossin@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230719141918.543938-4-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/23 11:20, Benno Lossin wrote:
> Use hygienic identifiers for the guards instead of the field names. This
> makes the init macros feel more like normal struct initializers, since
> assigning identifiers with the name of a field does not create
> conflicts.
> Also change the internals of the guards, no need to make the `forget`
> function `unsafe`, since users cannot access the guards anyways. Now the
> guards are carried directly on the stack and have no extra `Cell<bool>`
> field that marks if they have been forgotten or not, instead they are
> just forgotten via `mem::forget`.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
