Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE0FC7ADAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjIYPEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIYPEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:04:36 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ED2103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:04:29 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9a681c3470fso520551966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695654268; x=1696259068; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=STVyCq0Z9CufVRuINVHUuC/ypT8+q7NNtSadYInOtW4=;
        b=ctpBL/1MdXZGWRF2Kk2lWUh5PkmjgwLrz6aoBCJo/aQtWjR3+5nHZmhLZnh/bppn/w
         W3TXczLgW1ZUXih+uN+0DsMjmYMKNg0TkU1hgmEzlFepKoixlVo37tDcsb4B0aJqcO6V
         bZVJLkIEbbvfCk4tnx75ycaa8pyYtFcwRc0N0wPkUgA5Qa8Oj1QH8Fzd/AgwfU/I2alD
         lqAPQlkISJzKqeJ5iZUsEw+Yf7D+pAt2VQT4b4Y+mINZgTZuOHMLqcUn4wcMxfySawBN
         ijD2de6eU4LWTJNjrRA7VaKM75JW15aayjSzRREUxEpi/rCU4Mdz8PXAXiGrEwMH/L/5
         ts8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695654268; x=1696259068;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=STVyCq0Z9CufVRuINVHUuC/ypT8+q7NNtSadYInOtW4=;
        b=vM9ac1DQbULkI2svPqTsQGQntyCwtzG253YPUpFaolC/1BjHuXDzsD7IKTwnBIXLVB
         nngUPEbFpoPwe8MthTThUox+XnXmfN+6NwtayO6EwZl0ezsfqW170xa/+2H1KeukoHLG
         56SAKC6l229zRf8kxwVxFsJjZjr6f+Z/XADWfcGs3Pf4suDyuqMjr49Xx/1WUZbNrE/R
         dog3nOERgPnlf22+gUL8XG+jHo/14RV/1xCS8sD87aKQjjj8/6YjeBLjprs8sT54Jjtk
         2zBUBES8B7QPL6PxOtIkPEPFz6EIPS45qBRphTAlBhkXpPl9hQIIoaaWgfNCSj3he/80
         +BzA==
X-Gm-Message-State: AOJu0Yw9dY2iDkt8jQiKv0wr4zpoPTSWl4iqvyyDF2tq9aAJL0SEHdmG
        OPS03lr8+R17IG9kYTZdF9Bid4D+RwshQQc=
X-Google-Smtp-Source: AGHT+IH7Na/bTQRJPh5OVjpPoU8+J4wtAuLH0qHTCMReqZ7k5fdQVXk3PGAPOoKxQk4F2zSDDAx/nTy11Ol/0YM=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:3447:b0:9a9:dffb:4c6 with SMTP
 id ac7-20020a170907344700b009a9dffb04c6mr25326ejc.10.1695654268118; Mon, 25
 Sep 2023 08:04:28 -0700 (PDT)
Date:   Mon, 25 Sep 2023 15:04:25 +0000
In-Reply-To: <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
Mime-Version: 1.0
References: <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230925150425.1963183-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
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

>> I'm concerned about this change, because an `&WithRef<T>` only has
>> immutable permissions for the allocation. No pointer derived from it
>> may be used to modify the value in the Arc, however, the drop
>> implementation of Arc will do exactly that. 
> 
> That is indeed a problem. We could put the value in an `UnsafeCell`, but
> that would lose us niche optimizations and probably also other optimizations.

This is an option. Niche optimizations don't matter for `WithRef` since
it's never directly wrapped with `Option`.

> > It also means that we
> > can't convert an Arc with refcount 1 into a UniqueArc.
> 
> I think you still can, since to do that you would consume the `Arc<T>` by
> value, thus guaranteeing that no references (and thus no `&WithRef<T>`) exist.
> So I think this would still be fine.

The problem is that if you have an `&WithRef<T>` and use that to create
an `Arc<T>`, then the raw pointer in the `Arc<T>` was created from an
immutable reference, so the same restrictions apply to that `Arc<T>`.
And if you convert it into an `UniqueArc<T>`, then the same restrictions
also apply to the `UniqueArc<T>` because it's raw pointer was derived
from the immutable reference.

Alice

