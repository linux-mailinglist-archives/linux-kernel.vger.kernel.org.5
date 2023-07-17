Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17549756568
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjGQNsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjGQNru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:47:50 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6441720
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:47:43 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-573cacf4804so40124927b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689601663; x=1690206463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3SxyETf8ddszKx/ZhEs13N7fJ1p21U4RjlqamH3wRM=;
        b=Ps+rAGyMV9qWxjfyp3bnC4WvVcq8X5T25dqQ025faVPUbZWlN2fAoDNDfXAcv0qXQO
         2rVh/F+CEbd9tCHAujfRsQGuKMmSyiBZjs2eOW67e3+9f8kDZtdM0UP/nRbGDOfC8bXs
         17XAdkMOpYNQtBfbzsnCgX9mGrtMoO6Ou2sMGzQtb3EsgH06Xpaq6QVx4+eIMb+N/843
         gPnkEHOnUVw6yoiaH8h0F3c8OwlT5WkmTQDkb9f7s3mPN7IWIFg75VFKueOM6dFG5j+J
         gv/odE6hDve5rsonG898yH44kzvxYYypt00MA0hqgIFkexFHlypO+5r2oufxg9SMk6+U
         ydMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689601663; x=1690206463;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j3SxyETf8ddszKx/ZhEs13N7fJ1p21U4RjlqamH3wRM=;
        b=MfgJpvqHCHbPcjfHTqhDqVTEbGEDOOIFyugG2FCMN472bQUm3MCxTtc5EZ0rX1njVw
         OoxnB56kmORSUGXE/Jk9wpg+CGh5ReruXUbykKt3+t95MUA+YtfHjNd/nKisNhozvKWn
         9fMCdHGkBBlVfmyijiA0mx8YMatRTP/rHSCrxwc6VmfKxbFCHVW24bDl4vW9pQJa+KrB
         YFGLTJPWhNKtPdFqAbofjH72UlwaFjBw0AXyIj8+ENxmQ/AUzweEdCeM4kpzi3mRW4fZ
         40A5nrlB0diTqlhWtdcUBOsUTbrAMi8xIL74Gpc187I4W207yP5ayLuqMt9LfVYKRkol
         ZXug==
X-Gm-Message-State: ABy/qLZCsSDal69p5p/y3Da7AwnqOfSvHmp62W82ZNH5/oDG0hRtBj27
        dRTsBajr7Mz+8ZWFpOmiecad0kMcBTJQn60=
X-Google-Smtp-Source: APBJJlEwhdE5N/SzORH8cVNDBC2/w2CMWD9t0WmrCmMaq52fjxnqtqHEqHMehOn8c5v5sI2WIAd0lhlO7YkmMnA=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:bc14:0:b0:565:9e73:f937 with SMTP id
 a20-20020a81bc14000000b005659e73f937mr153880ywi.4.1689601662979; Mon, 17 Jul
 2023 06:47:42 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:47:40 +0000
In-Reply-To: <CUqkSCKfZbSOwonbc1HECGB3ah_8k404uGJFaebLi2oD8GScDzqRxZ350YdmljslxqUC4mqdvqpbBhD1wFSmCvpA4MhklUGnN6RB0Y8YlFo=@proton.me>
Mime-Version: 1.0
References: <CUqkSCKfZbSOwonbc1HECGB3ah_8k404uGJFaebLi2oD8GScDzqRxZ350YdmljslxqUC4mqdvqpbBhD1wFSmCvpA4MhklUGnN6RB0Y8YlFo=@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717134740.1840206-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 2/9] rust: sync: add `Arc::{from_raw, into_raw}`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org,
        walmeida@microsoft.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
>> +    /// This code relies on the `repr(C)` layout of structs as described in
>> +    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-structs>.
> 
> Why is this in the documentation? I feel like it should be a normal code
> comment at the very start of the function.

In fact, I think we can drop this comment entirely. The motivation
behind using `Layout::extend` for computing `val_offset` is that its
correctness does not rely on how the repr(C) layout algorithm works.

(As opposed to how the previous implementation's correctness *does*
depend on knowing the repr(C) layout algorithm:
    Layout::new::<ArcInner<()>>().align_to(align).unwrap().pad_to_align().size()
)

>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
>> +    /// can only be called once for each previous call to [`Arc::into_raw`].
> 
> "it can only" -> "it must only"

Sounds good. I'll change it to use "must" in the next version.

Alice

