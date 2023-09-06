Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD415793924
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238095AbjIFJ5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbjIFJ5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:57:39 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE4E1734
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 02:57:04 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59504967e00so36929257b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693994221; x=1694599021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S6U/bZx3CCZkDt+9hB5fA1eaCfzNi7bkJC7f529EWkw=;
        b=4Lwoon3q1cTNc6SsgNfllwEhT9sYQRs4hl9b+sHJT/rf2epZ6dLPV/1SYI1nLWVoN0
         cy48v5+GpCTBUaMJnmNqjschfyYvA5nw+lTCUD+Cy5kej5eEPEIT+jgn+5NmCX3D/EyB
         B6URpCXw2wSUYtASp81rIBFc/2EAm6cvMw5vTjaZwA4oqQopaRZ11QoKQNc69sSVtkhd
         aqQf9EX34LH3trob1Qh06cM1dorCkQVcK/ZWy6DNHrOci3WuQoIuAFoUJBtTTgnhHt4M
         G5i7sDCdSPKnorjh+vSDsR3LpWFDOGhUvjS+LnQNXUjw19vyiPIVgYvsvX01C50Y2MSP
         pmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693994221; x=1694599021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S6U/bZx3CCZkDt+9hB5fA1eaCfzNi7bkJC7f529EWkw=;
        b=LK2TdimnmHj39vbveEyBMu3U8t6v7DDLvS1o010Y/A9xwh8JIEMGLjQLrUtEEowsfd
         0WnyeyQr3vNDcwAmwIWA6w8OZ3oggRx4IrXHWsxnCE/AGat+OPRD7cHqK61H91jIojkB
         8iXm5aKBtBs+u8GPHYRYcEcRsu9nWP8ySM1LKBK6LfWRQQLTQQRNabgp0+X0NeKsk8fq
         1cXKE99oJZUBHT226E4uNRdf1SJuU1KelYWxOnMRJMyWr9U4qPkiF8uuM1PjP65CdA2U
         JDKKSOigCsJrU4OxEGKRYsChv4TS3BNmFpw+rRvjbg/Rtll3/j6wnIW4C2fffuunBJle
         HnPw==
X-Gm-Message-State: AOJu0YzJNyyy9AAHiY0uzO9xbnmgMppbijRWA2QdWfqLg19yUehBpjHZ
        li/8Q/MOUDFv0jWQJmsucVVxkp2FXEZHa7s=
X-Google-Smtp-Source: AGHT+IGtrKPNRYI3AhoixLmlwImfM2X/hdnQadWPxqOqcdFIZ2UCfmxKsJFXaNdIbjrF+J7e1IOSJ4uKQ9IdQe4=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:ca51:0:b0:58c:b5a4:8e1f with SMTP id
 y17-20020a81ca51000000b0058cb5a48e1fmr421736ywk.3.1693994221613; Wed, 06 Sep
 2023 02:57:01 -0700 (PDT)
Date:   Wed,  6 Sep 2023 09:56:59 +0000
In-Reply-To: <ESFnxZLcZD-JbNp5PHtrjAdophrPm9gOJR1C5kwsvw6errySiqsG7zbs-0bKWKGrq3Phz7-of0M1znwoTNYAZATTHBhUaFehe5bHP1YksCw=@proton.me>
Mime-Version: 1.0
References: <ESFnxZLcZD-JbNp5PHtrjAdophrPm9gOJR1C5kwsvw6errySiqsG7zbs-0bKWKGrq3Phz7-of0M1znwoTNYAZATTHBhUaFehe5bHP1YksCw=@proton.me>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906095659.906257-1-aliceryhl@google.com>
Subject: Re: [PATCH v4 4/7] rust: workqueue: add helper for defining
 work_struct fields
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
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
>> +impl<T: ?Sized, const ID: u64> Work<T, ID> {
>> +    /// Creates a new instance of [`Work`].
>> +    #[inline]
>> +    #[allow(clippy::new_ret_no_self)]
>> +    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
>> +    where
>> +        T: WorkItem<ID>,
>> +    {
>> +        // SAFETY: The `WorkItemPointer` implementation promises that `run` can be used as the work
>> +        // item function.
>> +        unsafe {
>> +            kernel::init::pin_init_from_closure(move |slot| {
>> +                let slot = Self::raw_get(slot);
>> +                bindings::init_work_with_key(
>> +                    slot,
>> +                    Some(T::Pointer::run),
>> +                    false,
>> +                    name.as_char_ptr(),
>> +                    key.as_ptr(),
>> +                );
>> +                Ok(())
>> +            })
>> +        }
> 
> I would suggest this instead:
> ```
>         pin_init!(Self {
>             // SAFETY: The `WorkItemPointer` implementation promises that `run` can be used as the
>             // work item function.
>             work <- Opaque::ffi_init(|slot| unsafe {
>                 bindings::init_work_with_key(
>                     slot,
>                     Some(T::Pointer::run),
>                     false,
>                     name.as_char_ptr(),
>                     key.as_ptr(),
>                 )
>             }),
>             _inner: PhantomData,
>         })
> ```

I thought that I changed this in this patchset ...

Anyway, I don't think it's a big deal. If I need to send a v5 for some
other reason, then I will fix this there. Otherwise, I don't think it's
necessary to send a v5 just for this.

Alice
