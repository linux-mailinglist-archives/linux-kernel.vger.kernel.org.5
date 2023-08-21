Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4A67827D4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjHULZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHULZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:25:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9A4D8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:25:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58cbf62bae8so46128117b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692617103; x=1693221903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KNwlE0hptEJ+KomxedbhNDZdQW8nX6UaNAvgVOd3YTE=;
        b=DqYbQAqTPQYpujtcLYwSGJB6scOaDUgrpKcB1gNAriudu9qoLwTPXxTSLZ5kmAiqvq
         ZtUugMzKUiimHHWbnvjmP/cP1LtcksHcdFvDPRhov/AeIInzkZlFdTuCpufy9/OmoO09
         jhymM6UxghCuAKYy4j+Dp+DxnZujMVH+ZqhupYyyLuSR0Mi1WDRbwyq80Iq5pBDhUTG8
         i3jB2nDtQpdvsHgBjlyeG5TjE2BBxYrc/O5gFpsNNdYBQ1n7Pi2mSqrxZPrZq4g3ndlu
         /hZi+m+DI5Tf9AlMAkxRg3HvY66XstbLFnnbtBjIw/NwI1hOaUecO4GjNBN1Sahhv4wK
         0n+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692617103; x=1693221903;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KNwlE0hptEJ+KomxedbhNDZdQW8nX6UaNAvgVOd3YTE=;
        b=OfmZpVF7KQca85sVhQb0JqoBoCjYZNK9z43dE7n35q45RJ/IqTuhX3SdxcNG8+vrux
         wDA9+mM5OjpY3BIZBfCUbmhNWs+unoP+0Pn7mrXx6iMJEc/l0pMMPCMl6R4kjXKuLzXT
         5A7oJMT/8ynuGZpH7Z79jKbU00r3hYkMfR1bDhbhKUnnakpoSsa6JZMwdUua+aYDhq8V
         UcV2KT2hYc980NeO1Y4UehdjVC1zX3b5dN1iYfHl6ixOC0JchJkZGvGc6S5p9UUNahp5
         6ve+xuH/uGoIV0IGfl7HDGKPdOG5RWzgg2FuNCk9YgMaK3R5aLEGa1kM+8n5vUwGZ9ar
         8DoA==
X-Gm-Message-State: AOJu0YxOGSpPrUECN+NxcrHCLUt18FL5m458ovVe5e2UfUVQ2bQ9sF4c
        UpGfaYgB7+Ye2O5U6CjtSGtHgS0L2faFCd8=
X-Google-Smtp-Source: AGHT+IEyI+l1AmBVra+jc/USX7OIpJ/VyLZPOuiV4jSok8FXOhINKd/eEKL8WvEoKj4KrH4vZ1m4Y2YlYLCvU+I=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:18c6:b0:c72:2386:7d26 with SMTP
 id ck6-20020a05690218c600b00c7223867d26mr71861ybb.0.1692617102826; Mon, 21
 Aug 2023 04:25:02 -0700 (PDT)
Date:   Mon, 21 Aug 2023 11:24:57 +0000
In-Reply-To: <20230814084602.25699-13-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230814084602.25699-13-benno.lossin@proton.me>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230821112457.1363843-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 12/13] rust: init: add `{pin_}chain` functions to
 `{Pin}Init<T, E>`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        lina@asahilina.net, linux-kernel@vger.kernel.org, nmi@metaspace.dk,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
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

Benno Lossin <benno.lossin@proton.me> writes:
> The `{pin_}chain` functions extend an initializer: it not only
> initializes the value, but also executes a closure taking a reference to
> the initialized value. This allows to do something with a value directly
> after initialization.
> 
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
