Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F26C7BAEB6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 00:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjJEWQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 18:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJEWQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 18:16:21 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A72C9E;
        Thu,  5 Oct 2023 15:16:21 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6c7b3adbeb6so1037938a34.0;
        Thu, 05 Oct 2023 15:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696544180; x=1697148980; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2CLq7Ru6JO/XafGfaqX2puFSQKrvbgIFrK81byfRpEo=;
        b=KHfcGq/rY9BdaK1fLy43ICzGVHeMwWEDylzuaJU/gP4caIGLqFPj2udH9Imvb+JZIq
         MWDT7qCPK+uX7eRvB5U7i5U4HKJesdJltLS+an1OFD71u8b400+0rTjRQZozbOXr3HxP
         RbwZuP/DNa8KcdOseYd9A8iG/N/jT5KAyGFdzv8RC1ZpnFK6mU23eV+GR5MdlkrPIWbY
         XjBBGym6iJHr7f2ZoA8okNLKgRpl/1tA9uCW/az75vH+UsW0oturb41DG1g575LdEiRw
         hqkyRqdlWNfQX+M4aEh3nQZNHVNjLDoi7COkqSYTvm+7QBmybKjyMNSQkuqqsVQHQGxN
         gZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696544180; x=1697148980;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CLq7Ru6JO/XafGfaqX2puFSQKrvbgIFrK81byfRpEo=;
        b=BMN7pkrqb1MlJH40DQDjJA086ybQ/EeF12aY1DluaTByKeCG4MFgP7HYKiuuBRNARK
         nD02TJQ5hQdLC/NgQK/0C19hOFBEo4CrsjRNk9e6LI/pETH2tR0KNam/CKNLydeukh/Y
         +wOK5Ovz/KjBt6ZLqGIl5FCk3JQTLwuzvTD5yCCVRQrg+zfxq6IuK3UtEUo7XgP8C4XJ
         TsO7zTBgD1xHcVw7T43vHzgykXd8ptuC4JQXyXU/NqhmDdh7Uey9JRZbfuAXPHbCrkFa
         VTfHY10rO2c5aTuY5HLmVgvPnoCGQNBeYoR1Lul+WyoduWCihWZoHQEqKM0bd19GPLb4
         flrA==
X-Gm-Message-State: AOJu0YxEBFhcNOmkv4OkYcZSv4xoh9qNKmYDng1WRhkbL0iznbOUq/53
        VRR6lfEYsZaQsjMyV5wzHto=
X-Google-Smtp-Source: AGHT+IH98BqVGyK/k/oU7Mne+jf+9iNkFlEiTtZVtuB6Ggmo93JAZng1BoL01sTi3Kvov6V5PrYkIA==
X-Received: by 2002:a05:6358:938f:b0:139:5a46:ea7e with SMTP id h15-20020a056358938f00b001395a46ea7emr6326524rwb.28.1696544180255;
        Thu, 05 Oct 2023 15:16:20 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id w25-20020a639359000000b00553dcfc2179sm1950515pgm.52.2023.10.05.15.16.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 15:16:19 -0700 (PDT)
Message-ID: <fe189597-7cd5-493c-ac10-082ff50b3a1a@gmail.com>
Date:   Thu, 5 Oct 2023 19:16:14 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] rust: Respect HOSTCC when linking for host
Content-Language: en-US
To:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <20231005214057.759089-1-mmaurer@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20231005214057.759089-1-mmaurer@google.com>
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

On 10/5/23 18:39, Matthew Maurer wrote:
> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined,
> resulting in build failures in hermetic environments where `cc` does not
> exist. This includes both hostprogs and proc-macros.
> 
> Since we are setting the linker to `HOSTCC`, we set the linker flavor to
> `gcc` explicitly. The linker-flavor selects both which linker to search
> for if the linker is unset, and which kind of linker flags to pass.
> Without this flag, `rustc` would attempt to determine which flags to
> pass based on the name of the binary passed as `HOSTCC`. `gcc` is the
> name of the linker-flavor used by `rustc` for all C compilers, including
> both `gcc` and `clang`.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
