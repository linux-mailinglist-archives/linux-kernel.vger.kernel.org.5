Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D15F17516C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjGMD20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbjGMD2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:28:24 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC321FEE;
        Wed, 12 Jul 2023 20:28:23 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a3df1ee4a3so165240b6e.3;
        Wed, 12 Jul 2023 20:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689218902; x=1691810902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zvirk6pjSknQr9tE7lIyyVFEofnm4Z/T4cBm4mnN6Y8=;
        b=gIz652vjtJC/nOm3PVSiJBlsH7VWoagbkHDCCZGsoeQATzPCxoU3faaKZR3ttw9AXr
         ZSng/90RoY6GR3mtwy165KAK0oQLYXJhqC7FiuTBOKU3e2zkmigmHHPlAqRi3kdRPeZ9
         w2vlvNZ3dB0awXh928rz7qmTq8V2yhCj91Cdfxt0y4ajvV3QOO6ohVh2mn5NkSAzEToa
         5zKIn2S2ZLBu5SOU5kCMpd7pigp41p2AV8cfZSNntEkByzMa3zg4bll94K0JlVLc2mBG
         dvMSbrmeY0y7cPU1b/tgKlDedkGUvB0IN4/UQsSwIxdLDbqtVb/DT3JmWLV8lu0NBu7p
         bG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689218902; x=1691810902;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zvirk6pjSknQr9tE7lIyyVFEofnm4Z/T4cBm4mnN6Y8=;
        b=g9x8zmkHVN5aT0NviGAk/NvT3WzvTryjj4zstBiuVgQCqwlB0I5izTYlg52vUw7JkF
         eVtHPAFylYQ4Rs8aa858OdYUwJRD1ZGYSSJQBq+L5KaVV/OeosWBxKsL9TGM/5xmtvK/
         9hCIvau94M8pKBok954POO7cHnyLgiRKqlx1GBLpYYNZTwN4GvAMHaKM/Soe/41dH8b+
         i6irIyTJpiPDrgQwD2qUtHiCKgzHCBVukFT2F1B+OwjgjFl8U19Be7ztgdJy7Dve8yuw
         MNNgqctv/jpa4vt7/zM7dsELlDR7qvM/MukiK1bembmZkj9NRhoUZmJRarL0un+hzHVI
         S3PQ==
X-Gm-Message-State: ABy/qLYyFC7zbYY3Roh8ilDvmPE/GI4ElT0Qkz0EcIjFLW5ebsiKjkf7
        sT6zD9Y6no6XS9O0QUPqAYxOeFXpfHo=
X-Google-Smtp-Source: APBJJlEpeHadsi/VLTXuFGmF4NjyzX+wDoDGJ/NCrwia1SnCybpmTZuUX57s3FV2Tm2tcdWP2IcChQ==
X-Received: by 2002:a05:6808:23d2:b0:3a0:5a6b:25c with SMTP id bq18-20020a05680823d200b003a05a6b025cmr352810oib.33.1689218902241;
        Wed, 12 Jul 2023 20:28:22 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id b12-20020aca1b0c000000b003a3645e9ebbsm2511684oib.40.2023.07.12.20.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 20:28:21 -0700 (PDT)
Message-ID: <3c917bbd-7d53-23e2-d067-7ce8fce95307@gmail.com>
Date:   Thu, 13 Jul 2023 00:28:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230710074642.683831-1-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230710074642.683831-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/23 04:46, Alice Ryhl wrote:
> Previously, the `ForeignOwnable` trait had a method called `borrow_mut`
> that was intended to provide mutable access to the inner value. However,
> the method accidentally made it possible to change the address of the
> object being modified, which usually isn't what we want. (And when we
> want that, it can be done by calling `from_foreign` and `into_foreign`,
> like how the old `borrow_mut` was implemented.)
> 
> In this patch, we introduce an alternate definition of `borrow_mut` that
> solves the previous problem. Conceptually, given a pointer type `P` that
> implements `ForeignOwnable`, the `borrow_mut` method gives you the same
> kind of access as an `&mut P` would, except that it does not let you
> change the pointer `P` itself.
> 
> This is analogous to how the existing `borrow` method provides the same
> kind of access to the inner value as an `&P`.
> 
> Note that for types like `Arc`, having an `&mut Arc<T>` only gives you
> immutable access to the inner `T`. This is because mutable references
> assume exclusive access, but there might be other handles to the same
> reference counted value, so the access isn't exclusive. The `Arc` type
> implements this by making `borrow_mut` return the same type as `borrow`.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
