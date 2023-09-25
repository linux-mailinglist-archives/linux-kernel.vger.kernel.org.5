Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A197ADAD2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjIYPBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjIYPA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:00:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A730C103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:00:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdae1ef38so199152507b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695654051; x=1696258851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TtKOMgyIwOtWr+3ya9qqTPlv0NwOjHuIvkjyb/DX+BE=;
        b=3BKev9YVvnPzsfrAugS3qRJHaxjmFwEMekowJymJNS8gawsESmtKsJN2kFkpCXwMXZ
         jrggdFI0wUbCk7G0+nOxNdcydxktW/EtKmZR2BTh7TGYCzTpHeHdvHy6VttykOp8ZBOs
         9CFyGUOny6BnAVC4yPQBUKgc/MJ7TTmxe528GnE0MJiohl8foN75iCoxr0i+njtQZFw+
         VfHi2wKCc9JmhjehqYmnBWTUbWLO4pApFqxxNBDgqEyvgx8JxusNwL8qsXpgj4lA3nzl
         o5raaRWbYquHgMB/MBfjZ+TqOY1IEjB4XuI89lKWuxk0aZqq57JeyBDLcCdNIXepmGtG
         b4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654051; x=1696258851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TtKOMgyIwOtWr+3ya9qqTPlv0NwOjHuIvkjyb/DX+BE=;
        b=HnKZxcXAG/k1FLvcBZCZlb6dsyBlAyUJ9ZQwjT3VjZMaySeAJl0aF9eeF+lQs3BnuU
         qRbTjC4M2Q466GUYNa9kqDYXBrU8XyrKg3wNSxzblHjg5WLl9t0tB4cjqfwPZB7ptjVh
         4coCy95afFfj1S7Lcey1Y6/tckpXO0JlcYANIoYCJPIEVgp5mLiQuALR2uknupAQyT2W
         eY/Wt08QBmxdVnHmlIPLDMD8gD/mLbqFAZgQBhkos4rsqwDSe6TdP1prtb4X7+Mzr4dr
         49viFaHpUSZfRDzDMaNxsy6V20346Q4I9/QNjgK7KN92YCZ8HV9GTwauNzovXfe1MZz4
         KefQ==
X-Gm-Message-State: AOJu0YxiszMEUK1GOLZA1MGg51vrHghA9WBd+xA4Wqps6QNDYKCIE9Ef
        4Gpa9V/GVaEg0rC/7XpJZSj+kV2PV7L1IKk=
X-Google-Smtp-Source: AGHT+IFwQVMuwmH5yhXVSkx3BMOINalxrfSul/+4LRz1fJCra4cA/e2tR6cK5GnZtIBLaO635mvVxcuNt6jqq20=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:b249:0:b0:56c:e9fe:3cb4 with SMTP id
 q70-20020a81b249000000b0056ce9fe3cb4mr144361ywh.1.1695654050860; Mon, 25 Sep
 2023 08:00:50 -0700 (PDT)
Date:   Mon, 25 Sep 2023 15:00:47 +0000
In-Reply-To: <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
Mime-Version: 1.0
References: <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925150047.1961646-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
From:   Alice Ryhl <aliceryhl@google.com>
To:     boqun.feng@gmail.com
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, walmeida@microsoft.com,
        wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> I'm concerned about this change, because an `&WithRef<T>` only has
>>> immutable permissions for the allocation. No pointer derived from it
>>> may be used to modify the value in the Arc, however, the drop
>>> implementation of Arc will do exactly that. 
>> 
>> That is indeed a problem. We could put the value in an `UnsafeCell`, but
>> that would lose us niche optimizations and probably also other optimizations.
>> 
> 
> Not sure I understand the problem here, why do we allow modifying the
> value in the Arc if you only have a shared ownership?

Well, usually it's when you have exclusive access even though the value
is in an `Arc`.

The main example of this is the destructor of the `Arc`. When the last
refcount drops to zero, this gives you exclusive access. This lets you
run the destructor. The destructor requires mutable access.

Another example would be converting the `Arc` back into an `UniqueArc`
by checking that the refcount is 1. Once you have a `UniqueArc`, you can
use it to mutate the inner value.

Finally, there are methods like `Arc::get_mut_unchecked`, where you
unsafely assert that nobody else is using the value while you are
modifying it. We don't have that in our version of `Arc` right now, but
we might want to add it later.

> Also I fail to see why `ArcBorrow` doesn't have the problem. Maybe I'm
> missing something subtle here? Could you provide an example?

It's because `ArcBorrow` just has a raw pointer inside it. Immutable
references give up write permissions, but raw pointers don't even if
they are `*const T`.

Alice
