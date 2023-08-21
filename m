Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE62783097
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHUSzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHUSzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 14:55:15 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C331A9EFE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:54:09 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-977e0fbd742so465242866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1692644046; x=1693248846;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=J1bPOG4b+YloUifqT7Rk+dQEUBL9OO+h1q+JajXVUOs=;
        b=zM0Zvm9QVHKO8iQyGlkowGK5ww+I2o69vV6IlExZpbMO5f+Q/Vtv3zjw0mMRTGOJeQ
         wvClPyM5tWhdrPfUTqHOpNd64mb0iPTP6Smm3VgnRAI1nDqQCueaAH6S1A8FopD1ZkrT
         3IZ1t3VJgjbyGFQPMvwvLcyIe6YjGS4+gyZ/KihY1LP1Rq0+1NeVC3zNv2rHwn7S9Jun
         yMKHKnN9FB6ZaUp1aK3O8okj+EWu3fEls1CR1AzznaOBBZcqrN19wkNAzUjci85zdWI5
         bnc8k3sdYTai4WDlYsISndAiCuPa506HXq83/rxWXsSRjwG9EllSilmeE+dS+aMvKAvW
         SE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692644046; x=1693248846;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1bPOG4b+YloUifqT7Rk+dQEUBL9OO+h1q+JajXVUOs=;
        b=bZPQL7thYy3Qx5HbW+WZBQP1k/gFT4ygG/GMPe7rnjTLaGAyix/vALrRRTcWILZwd2
         qCEj3UZHxfyVlbTFlxfG+qMpfERsI2WvN1NBT1thOuZY7/93TnYcdAys3OY6Gk2hVa0k
         pZze33VWAzjxvULy22oFWdWA9MFMSqymSd2wd1XNENw4FZS/jVkmq1j/JLHDQqrBXLpO
         LLvKuxn61uYNp+EoD5a4zvVvJcupU1Y+SVc4JsXks6VCij3VBqb4l91nTSxDzRNvv/HX
         5VyOYxdRxqXDOua+IJA52G8BKP5ShVteNePUw1G2zNQhEHieqPILQ1SqyESFl81CpNGV
         hOWg==
X-Gm-Message-State: AOJu0Ywe23NDo4J9px8Lo0C00Sf8GW+HIWvFoX4n/t6ROVamQPxRZzxi
        1DHYAwbDojF94s91i657/Wz6o7Lpl9bUSw12W7U=
X-Google-Smtp-Source: AGHT+IEthwuxN1Toa5Mr0lSr2fZ63x5sTSrzhhPevyvctTWOgtn884Tztzzip0ASVSL9Vn9A2tb2hg==
X-Received: by 2002:a05:6402:2025:b0:521:ae63:ee63 with SMTP id ay5-20020a056402202500b00521ae63ee63mr5925942edb.16.1692643611060;
        Mon, 21 Aug 2023 11:46:51 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id ca3-20020aa7cd63000000b00529fa63ef6fsm4815116edb.57.2023.08.21.11.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 11:46:50 -0700 (PDT)
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-2-aliceryhl@google.com>
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
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 1/9] rust: add offset_of! macro
Date:   Mon, 21 Aug 2023 20:43:08 +0200
In-reply-to: <20230711093303.1433770-2-aliceryhl@google.com>
Message-ID: <874jksp71i.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alice,

Alice Ryhl <aliceryhl@google.com> writes:

> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This macro is used to compute the offset of a field in a struct.
>
> This commit enables an unstable feature that is necessary for using
> the macro in a constant. However, this is not a problem as the macro
> will become available from the Rust standard library soon [1]. The
> unstable feature can be disabled again once that happens.
>
> The macro in this patch does not support sub-fields. That is, you cannot
> write `offset_of!(MyStruct, field.sub_field)` to get the offset of
> `sub_field` with `field`'s type being a struct with a field called
> `sub_field`. This is because `field` might be a `Box<SubStruct>`, which
> means that you would be trying to compute the offset to something in an
> entirely different allocation. There's no easy way to fix the current
> macro to support subfields, but the version being added to the standard
> library should support it, so the limitation is temporary and not a big
> deal.

I think `#![feature(offset_of)]` is available in 1.71.0, can we use that directly?

BR Andreas
