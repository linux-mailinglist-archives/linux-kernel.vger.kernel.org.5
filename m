Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0A7854EE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjHWKKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbjHWIpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:45:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983E32D50
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:41:26 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so83123041fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1692780085; x=1693384885;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ADGGDbtG9VdwETdTI9uegT/TDj/LK9Ermf0BY1pyan4=;
        b=VERXx5a/FY1g4cz7TNxBlxrADguo1odfx5FgYGuY006LuXOwj/qZPXH1nawUFDan2y
         hK9e8O9WyBzghs23+Sef0NmsuolkfM9L2pZXsMWAmJvKqsxx2lG6FKFDLEWj9iv7GDqk
         a0dpWxwl8z0dLaTnZMMo+jpKzpp1dc1++Cj/fPs1Gv62juEgGIW6Nf0ezcydOHNhx0yf
         bPgSRpoXWJMyXGPkYsf351zm1pBzkzFbdPD8gBaluL/fmRI/KQ8PcW2S4Xn7KFCCpuH7
         2/VbVnLoCaT6eZI/AuuMy0FlPcjgnRybOQKDDk7IxWYbzJqtAS9OvhtpmczK14OOpHIg
         3X+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692780085; x=1693384885;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ADGGDbtG9VdwETdTI9uegT/TDj/LK9Ermf0BY1pyan4=;
        b=YF7zanFCsBJXSUDfNnT9jm2WZQTBgsBPH9reBSBCprCoiFUs6dOa5YMblpTfO6OYTu
         7K2d/4hFW8eGiHKaGkLZ3zCpTW8CELVLU/YzNgVPWqlcldi2djd21Rd11iwuLEAO9XAh
         V3cGSfAc0XsJoyvRwgaR13lgVfNp6Gz7uom41nDDV3tkg7EYDOApNIQueUjmCEivrPdN
         zGw/qlyHhhwXxsXdikY5FqiUGtCsPBy2RiCfwG2TMv0OamflLU4xsQZGH1H1f0f845c0
         YWjekhdoE/Mk1qd14iGixlLDxPemPkRNTGaDKp6jxgfOb9N9H0iCsnJ0xVktTyv+mh8t
         kaxA==
X-Gm-Message-State: AOJu0Ywb4ymu0vuln2DX/zy1GEVrG3fibLAzX6OSF8YbNDOmFAauYabr
        5l3xTrKIB7+oCEyXxcXooTCjkw==
X-Google-Smtp-Source: AGHT+IGVBY8vfYuHN9oZfC4KA6gsilfYQ6t93muUcdurvOZg0uLZ9V3ryMaF2bhwTVHGjV80+3pk9Q==
X-Received: by 2002:a2e:95c6:0:b0:2b9:eb0f:c733 with SMTP id y6-20020a2e95c6000000b002b9eb0fc733mr9069250ljh.35.1692780084435;
        Wed, 23 Aug 2023 01:41:24 -0700 (PDT)
Received: from localhost ([165.225.194.205])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003fe1a96845bsm21520804wmh.2.2023.08.23.01.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 01:41:23 -0700 (PDT)
References: <87r0octho8.fsf@metaspace.dk>
 <20230822093148.3478340-1-aliceryhl@google.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        wedsonaf@gmail.com
Subject: Re: [PATCH v1] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Date:   Wed, 23 Aug 2023 10:40:54 +0200
In-reply-to: <20230822093148.3478340-1-aliceryhl@google.com>
Message-ID: <87r0nu40cs.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> Andreas Hindborg <nmi@metaspace.dk> writes:
>>> +    /// Borrows a foreign-owned object mutably.
>>> +    ///
>>> +    /// This method provides a way to access a foreign-owned value fro=
m Rust mutably. It provides
>>> +    /// you with exactly the same abilities as an `&mut Self` when the=
 value is Rust-owned, except
>>> +    /// that this method does not let you swap the foreign-owned objec=
t for another. (That is, it
>>> +    /// does not let you change the address of the void pointer that t=
he foreign code is storing.)
>>=20
>> How about this:
>>=20
>> "For a smart pointer P<T> this method provides mutable access to T if
>> &mut P<T> would allow mutable access to T. Otherwise it provides
>> immutable access to T."
>>=20
>> The point is that the method provides access to the pointee, not the
>> smart pointer itself. In fact it is perfectly fine to do a mem::swawp()
>> for the pointee in the case of Box and depending on interpretation the
>> sentence "does not let you swap the foreign-owned object for another" is
>> confusing.
>
> Yeah, I agree that the phrasing is somewhat confusing.
>
> How about this:
>
> /// This method provides a way to access a foreign-owned value from Rust =
mutably. It provides
> /// you with exactly the same abilities as an `&mut Self` when the value =
is Rust-owned, except
> /// that the address of the object must not be changed.
> ///
> /// Note that for types like [`Arc`], an `&mut Arc<T>` only gives you imm=
utable access to the
> /// inner value, so this method also only provides immutable access in th=
at case.
> ///
> /// In the case of `Box<T>`, this method gives you the ability to modify =
the inner `T`, but it
> /// does not let you change the box itself. That is, you cannot change wh=
ich allocation the box
> /// points at.

Sounds good =F0=9F=91=8D

BR Andreas
