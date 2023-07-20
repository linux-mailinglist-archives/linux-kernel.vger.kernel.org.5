Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A87B75B02F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjGTNhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGTNhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:37:11 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9300510F5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:36:57 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-94a355c9028so61040066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689860216; x=1690465016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k51stBq+o7kJZEIZv26DdcdZg2cE4vmKfb3tLcw/wzI=;
        b=rUfzV8DPsULpg24zPK4bm/8wgeUZeqKsAQOXtOekbhkM/Avo2hMCPPWKQgMn9f2kn+
         dQvx+NCUmFgXxwX/DcEH9KAd9S1dfhWXGjG70KY6G4FiSvWZyb6JmVyvKtzYBaKRoXS8
         14ta0oKVSj0Kjl/yLorQo13gp+UzBhXZg07sGqTLfqiYUJP6r7XPVVPFQJq2UFkChaXj
         nKuaXFzJiGRfL9ooexMpnU+xLPbZPuz7ZwaVsaJ0leM6H4He9CxHq8oxwviu1Bkzt/mn
         Hz3aEdN5peyRQK4eAY6nE3+BOpgw6YpAtTEMn1q5B30mGkadVhsCIhCN1gG4fmICrNyV
         r+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689860216; x=1690465016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k51stBq+o7kJZEIZv26DdcdZg2cE4vmKfb3tLcw/wzI=;
        b=bAnYyfTItJ8+2caS0RaTQY0tCM+kbjYMhErcky5knZHapL5X+Xo7z3kSdyOVlJfgnZ
         p1f+OcWaGo0QWZzFgvdRbJUAC9PTzo+u9x4M2Q5JUhUlvp/BP2xfQ8RjM9J1Bf/040SF
         NDHT7DtszRA/bJmxU89C+ifgYgYFDNpMImbbdHEbZrXUcIKB+0Y9Dd6Hgj0t90A2DO/7
         2wAY6Ro2deLbJn/VwQgJHb50/vxvaG0uKtVwNepc/ii2ZasrOKyaubn+SlbYFaN6aJz2
         b6yMli2E7t7J3CAZvFucFQOfOZ4YmNO/dM4vnfBGx0pyVBzkZus6Kk84aKNm/a8xGIn8
         KL1Q==
X-Gm-Message-State: ABy/qLa5sbJ6TL/e2emsUbvLyHox/qydFyg0eWAT2nG6faQcLQu07ZIY
        fxg2hL99dp381h5dHnE0V6z5Ya0eFS58Xso=
X-Google-Smtp-Source: APBJJlEIlF83hNdPRGQUAWmVuaBGP0GbMcXQpvAovU38izZLFx8rAM5TcC62AGMMghFYwxeTSynPtWtOY3uZt74=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:5a73:b0:997:e6a3:9168 with SMTP
 id my51-20020a1709065a7300b00997e6a39168mr13287ejc.1.1689860216063; Thu, 20
 Jul 2023 06:36:56 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:36:50 +0000
In-Reply-To: <20230719141918.543938-11-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230719141918.543938-11-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720133650.3546587-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 10/12] rust: init: make `PinInit<T, E>` a supertrait of
 `Init<T, E>`
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
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

Benno Lossin <benno.lossin@proton.me> writes:
> Remove the blanket implementation of `PinInit<T, E> for I where I:
> Init<T, E>`. This blanket implementation prevented custom types that
> implement `PinInit`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
