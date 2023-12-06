Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB15806B56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377406AbjLFKJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377400AbjLFKJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:09:38 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D5711A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 02:09:44 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d988d69812so31049767b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 02:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701857384; x=1702462184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tS826RY7ZDjYnviwooMpFkfbp8DroL9fRrC2LOu0WwM=;
        b=eQwHa7jksW2FpJOS4cIGvGqD0EgtIX+lcOmeGNMiwThv5qcdiC2hZeL67vxSOeRppR
         dEiPYtAsH/xGSKr8vRIMaCnjivd9iQipRZpV+0WoD8WZR4M8ff4FzYn30pxsCv1zzpnU
         5bFT++DaA4vyFPe8oaOTagkD+lJ+CzqkyvmXA49sXfb30FsNn3oeQTvbekVy0n61H4LX
         EES1slZ2iRWcErqVjsA+/2ZX/zK1XTkxZ3gSqJCiIlJov5+Tx+komwZBcpa4kBSehq0t
         wI1+dnYaab5q2BxxJYveBr1G7UjafD79P8D7z96pFAsW82FI2uxgfupgwxsfiQFQ2Wrf
         EDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701857384; x=1702462184;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tS826RY7ZDjYnviwooMpFkfbp8DroL9fRrC2LOu0WwM=;
        b=WKTTeAwqcC7J6om69RA7odR/xLiy0VcsGt/QkUl2XA6aMGuHlKKDDrxpcwY8RuCcjD
         rpKq1WM+KL3oOn/ZZLbInYxktE8l9Yao4k6U+zRcykblE07intSg1u2nLCfT5WGa7Drp
         d4AcJJao0nbpTMzWdPKr/JHSzSXWrAEFK+JWFuWkm5XAlNbovwqCgfqDrPM3M9pZFmaO
         s4JBXq+/LDwjLrGMO+PrtBPpxqaqkVYs876kOsxqM5DujR9SbHeb/MHWWpqhKE1SziSH
         9gL8E2x0w4ql8VqdryHtfZLwN+DPfjbsHzOpFcwfNqZ++CWqquGECt1soyJFxPmvsJhr
         Xcew==
X-Gm-Message-State: AOJu0Yyksh+/WpI20Nz/lzj9Ag5gb/96pUDUL94kx/AeSqvDUv9FqHKU
        NbeWijYsePRvfsNjbnOUIq0o6gX2/mlTLgo=
X-Google-Smtp-Source: AGHT+IE6nRuDm7mZQB5UjZq+4WnprOliIhwizc8itYfynO5njH1gaT9MylgvqpkeyhtOZAhM4YNf4T7tXXFogIg=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a25:da92:0:b0:db4:5d35:c5a3 with SMTP id
 n140-20020a25da92000000b00db45d35c5a3mr5511ybf.0.1701857383678; Wed, 06 Dec
 2023 02:09:43 -0800 (PST)
Date:   Wed, 06 Dec 2023 10:09:22 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFJIcGUC/x3MQQqEMAxA0atI1hOw1SLOVWQW1UTNwnZIpQri3
 S0u3+L/CxKrcIJvdYFyliQxFJhPBdPqw8IoVAy2to2xtUMdMfCBUwyUveLG+xopoe1G3zuaHbU GSvxXnuV8x8Pvvh8hZSn1aAAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=21rZcv3YtKCE0uJ7O4P6S3FytbUTRl1n9exzjPPdf9I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlcEhjUe7fX5Gw8oOXZ98U+843QEknUVKUZf/YR
 aZu80RdGveJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZXBIYwAKCRAEWL7uWMY5
 RjOwD/sF5lbyCmJ2epQ5v56Qy/upnXfcMHux2qz1m0Pv0tyqN1Vpk//NNaM0DqnFvuS1xoK9nJn
 Le88c0QUNCb9Q9SRGNORIKymdHrRpOnqrKOG3ZQr57Fd7+WBXY7QpS2BXTuX6MR6N6sEx9kqzEb
 9X4P+u1Kw6n5yTUOLtCXy3KX9HaE3J0ZXpKBFdUs73cuzRF/y13d0eDghlk4NF8Xr52j9rihEWe
 zsloVKOxqB8kitNrpVkuBIo4N1OmmtN/kds+TVv6ET6buedSKjuXgLK9O3wGBUP7PHMm7ycJbE0
 0SS9nXXeyOTXNcEczJ0r/IlCcNk29wyGnO/ND/TOWej1nPzaECRs+Kto60dsnmVfvhWVqxhkxus
 OLJkfPQ26wNI3jne0NsGZGS0p9cMnx5HITLEp+hib2lkTjhsIC95wHdoK5sj90LvSpS6z24oLfR
 3OlDFX213hXA+iuzTPNRjFphXNI4d0xfAXyFNuUKN4nTTl1TogRhHDqdTq0W9xVOsGqVD8PCYrW
 KTXKrGUa0pCPN9pD+Y/fJh4WcZqX9R8Aipkbv4KLfvI/b+BppK3atCVnoHxMLShXPbKE+q0KV8S
 3oqMmcDD3mpKQEIqNLWZP1/oNYoDzO9SIE/GZbs6LX0xEtj9xwJUPOwhcVpU5yf/QN26jrAprGj SAvX4LGeg/qunYw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231206-rb-new-condvar-methods-v1-0-33a4cab7fdaa@google.com>
Subject: [PATCH 0/2] Additional CondVar methods needed by Rust Binder
From:   Alice Ryhl <aliceryhl@google.com>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains some CondVar methods that Rust Binder needs.

The CondVar type implements a condition variable, and tries to mirror
the API of the CondVar type provided by the Rust standard library [2].
It is implemented using a `wait_queue_head`.

Please see the Rust Binder RFC for usage examples [1].

Users of rust: sync: add `CondVar::notify_sync`:
	[PATCH RFC 04/20] rust_binder: add work lists
	[PATCH RFC 07/20] rust_binder: add epoll support
	[PATCH RFC 08/20] rust_binder: add non-oneway transactions

Users of rust: sync: add `CondVar::wait_timeout`:
	[PATCH RFC 15/20] rust_binder: add process freezing

Link: https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/ [1]
Link: https://doc.rust-lang.org/stable/std/sync/struct.Condvar.html [2]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (2):
      rust: sync: add `CondVar::notify_sync`
      rust: sync: add `CondVar::wait_timeout`

 rust/kernel/sync.rs         |  2 +-
 rust/kernel/sync/condvar.rs | 79 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/lock.rs    |  4 +--
 3 files changed, 82 insertions(+), 3 deletions(-)
---
base-commit: 33cc938e65a98f1d29d0a18403dbbee050dcad9a
change-id: 20231205-rb-new-condvar-methods-27ba95df5d41

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

