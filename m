Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA59810E01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbjLMKJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbjLMKJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:09:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933A2DC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:09:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-db4004a8aa9so7055896276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702462162; x=1703066962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LMjiZ1Mla0TJIvfZN07yuuMqisYwNLMlxhRR40WgnKE=;
        b=rUEdBuJWwCar4cLrt6t73JyuSbctkJAChccfZ4x8p8fIffEyv+tcx1ffnERubMQCAL
         w01J4bT8p7cldJfJH2WUF5CvL7O3AW7TZ1kVZqGuUf0aMzytoLgawo2IVWb6wPY/2fam
         Ae0m0vM7tEVKSvU28bh1OKe5KIrVNXCitCJQKvseQAI00MuqWPEhgRC26sL+kBTxMO7o
         V/PxVIxFiqWyFtLHdZP0Qjanl6e/rFuwsQTBoYpNHzCG2+Ne/6DAK+GpW9BQELv+5lND
         1wjRKQ91IPdY++DDTXiocHiKDyKs7LXTtJv65EgzmDuGt4LUNEl7n9FEma7HJVJJ55Zy
         uDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462162; x=1703066962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMjiZ1Mla0TJIvfZN07yuuMqisYwNLMlxhRR40WgnKE=;
        b=Eli4bTlMXsT3I9bsj5wMFDRkz20bGyX6gxQON/kQRreb0o8cOcVnZX8Vvneuc5HuME
         HJNbFrz0CwjLxj5+3rME4M9+I3fBAEsG086MTr8Fn6uPp+AYa2STtUPGXI0krKA51AoC
         u1ALnxx4ElZtw1yuvrVQNwGwayUol3k+eKjeUjvDR50vkYZI5xPQEl37Yx57oD99hw2E
         BLm3Q2mF2Rj/09eiELwQuk52rEA1xOgb2e6T1k6Hg++gGwN1JwBmxOhP4k85RsI0zQ4y
         SmEI+WyKxCoCBibSMO/1Nbpf38++f3CX5Lj3lbuPc/hLCt1GFSt42c7Fnd9mNYFXqvMR
         Zn3A==
X-Gm-Message-State: AOJu0Yw/JMh8mtk+HTxWZpvSqAEdF4ucfR/EcVDpcE6bOZGJxSC0jISZ
        DWmR8s/1zzGsELKx1/ehAncnxhwUnMtei78=
X-Google-Smtp-Source: AGHT+IH1VF9gQH/zvDo8sZsOOMLcD8dWkfvwJA1iOSJh8Gow9jwJUdpnt5y5GZa/kNlrATJlzEmAqJR3Np4SOuA=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:c78d:0:b0:dbc:c98f:8075 with SMTP id
 w135-20020a25c78d000000b00dbcc98f8075mr10120ybe.12.1702462161656; Wed, 13 Dec
 2023 02:09:21 -0800 (PST)
Date:   Wed, 13 Dec 2023 10:09:18 +0000
In-Reply-To: <pxtBsqlawLf52Escu7kGkCv1iEorWkE4-g8Ke_IshhejEYz5zZGGX5q98hYtU_YGubwk770ufUezNXFB_GJFMnZno5G7OGuF2oPAOoVAGgc=@proton.me>
Mime-Version: 1.0
References: <pxtBsqlawLf52Escu7kGkCv1iEorWkE4-g8Ke_IshhejEYz5zZGGX5q98hYtU_YGubwk770ufUezNXFB_GJFMnZno5G7OGuF2oPAOoVAGgc=@proton.me>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231213100918.435104-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 7/7] rust: file: add abstraction for `poll_table`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brauner@kernel.org, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benno Lossin <benno.lossin@proton.me> writes:
>> and here we can said,
>> 
>> "per type invariant, `qproc` cannot publish `cv.wait_list` without
>> proper RCU protection, so it's safe to use `cv.wait_list` here, and with
>> the synchronize_rcu() in PollCondVar::drop(), free of the wait_list will
>> be delayed until all usages are done."
> 
> I think I am missing how the call to `__wake_up_pollfree` ensures that
> nobody uses the `PollCondVar` any longer. How is it removed from the
> table?

The __wake_up_pollfree function clears the queue. Here is its
documentation:

/**
 * wake_up_pollfree - signal that a polled waitqueue is going away
 * @wq_head: the wait queue head
 *
 * In the very rare cases where a ->poll() implementation uses a waitqueue whose
 * lifetime is tied to a task rather than to the 'struct file' being polled,
 * this function must be called before the waitqueue is freed so that
 * non-blocking polls (e.g. epoll) are notified that the queue is going away.
 *
 * The caller must also RCU-delay the freeing of the wait_queue_head, e.g. via
 * an explicit synchronize_rcu() or call_rcu(), or via SLAB_TYPESAFE_BY_RCU.
 */

The only way for another thread to touch the queue after it has been
cleared is if they are concurrently removing themselves from the queue
under RCU. Because of that, we have to wait for an RCU grace period
after the call to __wake_up_pollfree to ensure that any such concurrent
users have gone away.

Alice
