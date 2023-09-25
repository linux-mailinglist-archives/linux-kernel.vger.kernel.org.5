Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD707ADFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232165AbjIYTth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjIYTtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:49:35 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B367109;
        Mon, 25 Sep 2023 12:49:29 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdf4752c3cso49131875ad.2;
        Mon, 25 Sep 2023 12:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695671369; x=1696276169; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x9jR0bp9vcQzOLj43wS440EgIxc19Wrw9EkXUEXKDdI=;
        b=SXiVLe5l9yyuB0kjgeGJpedkOkfsbyQ5m9cSqwzL2BanCbLbNL3FqVC/0O4QFTF+m6
         XRxLMaWOCD1g68OCUrw8jmITr9HnA6kEkxKqorYtWBSRr4fHy8i6WhXlpKAtQ6f64zDQ
         8q5q6+k7LAs1toHyfUQuvW64Kixmmqi1B7IWNmVtXBix4csjO1CCz2oKR/390hXW/Tox
         DdosY6wRu6AWmYQTUgi70RocejtJstv7HJPEpHVm8hvXJAnuw7v9Zo7IUu1xfCbgWZdw
         Cn7wdpAunL+IU6b8JtlxUs4dtPbJWVBnqJt+98ll7PDGuruFYfWrdLvof2GzNCtA0CmD
         GIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695671369; x=1696276169;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9jR0bp9vcQzOLj43wS440EgIxc19Wrw9EkXUEXKDdI=;
        b=d8+ahb0HO8lvloshALnmj2Vbacsvpw9LYIUjRin6dmnh43vlapRJPvtpQj0vQOBuSE
         W9BdoQJZxr0sA3JY3/MdCt/TNPy+sgCRmtXb4p6NKJ1bTBl91U72ZpUOfKyugLSccs5x
         VftYhntmt1MtVaN9nZWwKXJDnFf0736AeSjF4mxpdJ/TyC74/hhs/wlZ5xfdrI/tnqCm
         ttvaWlh0ZfAyBkybtfv55HNSDLKj8UPa7L/TA/OXzdMAuZ14DgDqNDL6aDSZ1UO8khF7
         fZaRr/3YCQ86viDRQzDq5MKVtt+vXq9CcJz+GpzHbap+yFb/RxHpEUIS1M2ATb+qY/0B
         I5Mw==
X-Gm-Message-State: AOJu0YwiVcYszKT9QPNp04RdX2XxqxK8g3zo+eVfvKPyzLWacXLot8Gj
        tsJ7sMJrxjCe8ymg8jadsS4=
X-Google-Smtp-Source: AGHT+IEP3hHqgdcijF5/i7dWkK16W0tXHGtF0wS9J7MqWj4+boWTkXWnA5AiJ8GRiQB/Fud6wGq6BQ==
X-Received: by 2002:a17:902:f549:b0:1c5:ba50:2b14 with SMTP id h9-20020a170902f54900b001c5ba502b14mr6078472plf.12.1695671368887;
        Mon, 25 Sep 2023 12:49:28 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:dfcd])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b891259eddsm9250970plg.197.2023.09.25.12.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 12:49:28 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 25 Sep 2023 09:49:26 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v4 0/7] rust: workqueue: add bindings for the workqueue
Message-ID: <ZRHkRpZJemtn67rf@slm.duckdns.org>
References: <20230828104807.1581592-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828104807.1581592-1-aliceryhl@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 10:48:00AM +0000, Alice Ryhl wrote:
> This patchset contains bindings for the kernel workqueue.
> 
> One of the primary goals behind the design used in this patch is that we
> must support embedding the `work_struct` as a field in user-provided
> types, because this allows you to submit things to the workqueue without
> having to allocate, making the submission infallible. If we didn't have
> to support this, then the patch would be much simpler. One of the main
> things that make it complicated is that we must ensure that the function
> pointer in the `work_struct` is compatible with the struct it is
> contained within.
> 
> The original version of the workqueue bindings was written by Wedson,
> but I have rewritten much of it so that it uses the pin-init
> infrastructure and can be used with containers other than `Arc`.
> 
> This patchset depends on the patch [1] that changes `Opaque` to be
> `!Unpin` for correctness. The patchset is based on the rust-6.6 tag,
> since that tag includes that patch.

Applied to wq/for-6.7-rust-bindings with Boqun's reviewed-by's added.

Thanks.

-- 
tejun
