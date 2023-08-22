Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3F2E783FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbjHVLsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235312AbjHVLsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:48:31 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4A010C7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:48:07 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe8c16c1b4so6666028e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 04:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1692704849; x=1693309649;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=uhIrFon087E3iYfZNnOqwEsuA1QGwXh+7swXilo4wNE=;
        b=MYo+yKWLa81z+XWwwjzVYCoI07QUk84F37CFOstTIT0Olw3mmnSPMI2BwhGVAuQeib
         IqXlcYHpUDLDUko026HKd4AcSIeqtPooSaGhK2A88c0S2uw3UTdvlTIB+kO13CRZtB5P
         Mt1g72j1MQ5ircxEomxpjmSKXlbFRrvKTnEipwqfc4LN+oCJNQqGD0Dp6COdIJYhWna8
         xMHA7oSXMJco9TrwMuOlyqiAN76cwHuRfol0uGnMVUI5OhpaWc6H901blMfKJtbMMK76
         8uCmpeBYJBZdWhDEFgtuYEyG7LaGxEVK1rLNh6lduuwPisotDTc8aga/MzfxGGG3EWO2
         uzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692704849; x=1693309649;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uhIrFon087E3iYfZNnOqwEsuA1QGwXh+7swXilo4wNE=;
        b=CCs4dl+VZijXNjjwbDds9VeP4njtCxTO6T1HUemjzhlB0d/B8gWHdrxHZQ8LLwFyJ4
         FUHL+e2cQHUDU3mwxzPGZI6K1a6Ivp1z6qhMEoCMlJbCA5ZIasjTR0VOfS62a8eMDtR+
         a+dRSYzQL9Vr/8X9Vp+GFXSRNG3qH8+zViaMbbbZgvga2dp0ydfqvDidcB1mBu9r0+k1
         jkMZRYyhQz6g8Vw2+/uHsq7yg7EwS2HJ0AQM6ncYCXMqUvD6LuBXS5jf+i1DsEbEryMK
         xHN9lzLmGpEhg3UHLr4DyrWXB2xHok3ACr3eUvmC+ojUMyUodx9VRNZW2jsKE6re7xmK
         puKw==
X-Gm-Message-State: AOJu0YzKf9iWaT51VLBDkr+GoZLz5EWgdEnoQPHlMMvxM1vP3MuIQm/S
        mV5jXpOgY2w6U7TGWvnyny4ejw==
X-Google-Smtp-Source: AGHT+IHuAzW/pPPxCGL04jOEgbZm7KqKnU9xn7BXSLzQzVo0ZR2moNYaGphImjz9x3L1vE52LMDqRw==
X-Received: by 2002:a05:6512:3b2b:b0:4fe:1bca:d921 with SMTP id f43-20020a0565123b2b00b004fe1bcad921mr8573241lfv.21.1692704848653;
        Tue, 22 Aug 2023 04:47:28 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id o4-20020aa7d3c4000000b005255991c576sm7424753edr.66.2023.08.22.04.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 04:47:28 -0700 (PDT)
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-3-aliceryhl@google.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj?= =?utf-8?Q?=C3=B6rn?= Roy Baron 
        <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 2/9] rust: sync: add `Arc::{from_raw, into_raw}`
Date:   Tue, 22 Aug 2023 13:46:56 +0200
In-reply-to: <20230711093303.1433770-3-aliceryhl@google.com>
Message-ID: <87r0nvs3hu.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> These methods can be used to turn an `Arc` into a raw pointer and back,
> in a way that preserves the metadata for fat pointers.
>
> This is done using the unstable ptr_metadata feature [1]. However, it
> could also be done using the unstable pointer_byte_offsets feature [2],
> which is likely to have a shorter path to stabilization than
> ptr_metadata.
>
> Link: https://github.com/rust-lang/rust/issues/81513 [1]
> Link: https://github.com/rust-lang/rust/issues/96283 [2]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

