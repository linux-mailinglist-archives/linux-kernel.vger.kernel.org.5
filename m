Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C7783CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbjHVJb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjHVJbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:31:55 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8C2CC8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:31:53 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-99c0bd2ca23so293976966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 02:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692696712; x=1693301512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vf+urCuo+i/PGdGVpq57Y5tRY0x9kDJ3rrqszJUUwro=;
        b=NX33VQFT1swrupwKm7gCk0QP/aKbrrRVR6vV8NelDdC7bkFRVvmsbaL75lSpQ+ba0S
         BBvoYWXA4c6DekkcFQQvwpGKHtR37hVcpPF859hxDRelIRj9gn68mg9NnOWM3+Ofui/u
         hcmhLCUbbHEYY9vsy/S0nDfrnleUNd0Y6YDW88cQcKX2r7puHl/DLbIJcJq5liPMArQx
         B9UXZVbrtTKJ+Elvp8lRhIa3fKWhySQxI8d0mhcL5A88vw54lnskKLBQWgnqj4B/S4GX
         aDUQ1KiLsthK7YA5BIxjvpEVVpQC4uy1ZgFpgOnpnh/nvkRzq8FPxhwpNqDy/BdpZzZP
         LEOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692696712; x=1693301512;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vf+urCuo+i/PGdGVpq57Y5tRY0x9kDJ3rrqszJUUwro=;
        b=QIyxpinA9Xq9HjXkueXRd2+ySZp5HKOIJMwJECWgQsrMIOhz8ML1AVpYjWZF9Frbtw
         MuhHO4GMxfAtICPCukvir1J8SqQx5CPdFiVkZ4mRNzFJ6UPP0GXrISrKTPKVHjDE+y3B
         xqFcXqSREQs8rQjlc1YzLiSgwRShoSDJ0anM0c7FyOJiA9pu2/M9tqA0ADs+vdGtww35
         QI7uYOEM6e1GAe9Sya9qbfuZhOfps7CusFkbUwyUlJAjEhLFpbPGEQFZ+8cmmdFC8/Cp
         KvKa5BClYeOJL8Wd1GhBa2LRQBu6/KsaIDB7CnBEoI9J63sAJ+3TzPh+reO4xj3MacaO
         JNUA==
X-Gm-Message-State: AOJu0YxS5ag6SskZCVq51chQTLJWDcuZW3Y3zsaANkbQb86hNgEILX8t
        vDby8bc3XfM3hwQfgWNYwIzQYhX64Fe+pSs=
X-Google-Smtp-Source: AGHT+IH7jfczo1ag7cPwrHC5eR3B4Cg6Z+4gTxcX+oGFl3qww4kgIT0tUDCiQT3rTAsmf3QNu+i9aP8coHB96vA=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:a1a3:b0:9a1:bce1:e8f7 with SMTP
 id om35-20020a170907a1a300b009a1bce1e8f7mr3999ejc.5.1692696711766; Tue, 22
 Aug 2023 02:31:51 -0700 (PDT)
Date:   Tue, 22 Aug 2023 09:31:48 +0000
In-Reply-To: <87r0octho8.fsf@metaspace.dk>
Mime-Version: 1.0
References: <87r0octho8.fsf@metaspace.dk>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822093148.3478340-1-aliceryhl@google.com>
Subject: Re: [PATCH v1] rust: add improved version of `ForeignOwnable::borrow_mut`
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Hindborg <nmi@metaspace.dk> writes:
>> +    /// Borrows a foreign-owned object mutably.
>> +    ///
>> +    /// This method provides a way to access a foreign-owned value from Rust mutably. It provides
>> +    /// you with exactly the same abilities as an `&mut Self` when the value is Rust-owned, except
>> +    /// that this method does not let you swap the foreign-owned object for another. (That is, it
>> +    /// does not let you change the address of the void pointer that the foreign code is storing.)
> 
> How about this:
> 
> "For a smart pointer P<T> this method provides mutable access to T if
> &mut P<T> would allow mutable access to T. Otherwise it provides
> immutable access to T."
> 
> The point is that the method provides access to the pointee, not the
> smart pointer itself. In fact it is perfectly fine to do a mem::swawp()
> for the pointee in the case of Box and depending on interpretation the
> sentence "does not let you swap the foreign-owned object for another" is
> confusing.

Yeah, I agree that the phrasing is somewhat confusing.

How about this:

/// This method provides a way to access a foreign-owned value from Rust mutably. It provides
/// you with exactly the same abilities as an `&mut Self` when the value is Rust-owned, except
/// that the address of the object must not be changed.
///
/// Note that for types like [`Arc`], an `&mut Arc<T>` only gives you immutable access to the
/// inner value, so this method also only provides immutable access in that case.
///
/// In the case of `Box<T>`, this method gives you the ability to modify the inner `T`, but it
/// does not let you change the box itself. That is, you cannot change which allocation the box
/// points at.

Alice
