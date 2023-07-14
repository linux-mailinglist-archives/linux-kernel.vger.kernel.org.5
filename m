Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA7775370B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjGNJt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbjGNJtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:49:05 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93D73AB1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:48:54 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-51d981149b5so1041114a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689328133; x=1691920133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LgB9Mhn/4by5bCjJpUEX/UcsNdb0bdjrrqXERtCyeLI=;
        b=C3GVqpZj6i0V8gkeGoO6N72GIt8HeLW1V5EMHZbZAE7/3bqd+2NE3EZ8b624qO0BD3
         jTO0ejZIZ84R7+1oKeHt05CyuT8Yx571+hljrlG5bjx1A1tD1ebv55QLpfBRWvTwo4AF
         GzCHxriMdWWJVLRQKR+UjdxcFE3HjYbbFlnfTPROo/NYJ+hrJAVz/+FBBQYzZd4j2l7+
         NJDISCiRb0ci+5wZj6nIp6DrgMm7Wj6aX5gOS4SEwwMGtbmLUrQbwlhBZT/VSrNLaG1X
         qJ5wEbRmzJVJbeja9uKq4s2N1dI/cKc9HshqAOGM81iO2tuSTFwCkfsqx/D/Rb7xc8X2
         Bqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689328133; x=1691920133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LgB9Mhn/4by5bCjJpUEX/UcsNdb0bdjrrqXERtCyeLI=;
        b=fpRfNSj2JKEOfc0NnesP5RC98+P4EFnM8Uysw01gMjpEDlXNi3RvJzd/OygN97T2AE
         S1Swx7KEXFXdjlmzIUUwDAvtzqDMjRVV9dYU4pP1sl+h4c1q/dgEIWNQY3BsWY4YJTap
         KGD5MthjwbOEXqr4M/DpsryUga2HobdHHWn7SdWjS77bs176x5knd+w3EF2rnijHZ963
         Xu3xHGXQBvNzDxS5guGQAkczqwoGZ/UorsQAd00faTDe4HsegwVFTH9IkdmB3XX0o1Xx
         GCv51AgAqkB0cDBU9akfufvZHbcROl1vHTLejO+TXi6uivTbIxc0HHj2JTd0unAyZVVe
         Qzwg==
X-Gm-Message-State: ABy/qLaqhV5HrutcKoQandQFHJIstIVdDXK+yZtCItLpAuptRXs/FoJQ
        /FZWAcMYA+4MGmotXLcxPncoM/jmkxLj3GE=
X-Google-Smtp-Source: APBJJlFX3YPOyr7+HJnYzpBJU6w92y6qG7Iwif9vTDearcfvz9cn3ZRfZBU1/7bS7OzWLsIsm/mXxa4S1pwPyb0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:2c78:b0:98e:10f5:db52 with SMTP
 id ib24-20020a1709072c7800b0098e10f5db52mr9590ejc.7.1689328133162; Fri, 14
 Jul 2023 02:48:53 -0700 (PDT)
Date:   Fri, 14 Jul 2023 09:48:44 +0000
In-Reply-To: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
Mime-Version: 1.0
References: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230714094844.2189906-1-aliceryhl@google.com>
Subject: Re: [PATCH] rust: kernel: str: Implement Debug for CString
From:   Alice Ryhl <aliceryhl@google.com>
To:     lina@asahilina.net
Cc:     alex.gaynor@gmail.com, asahi@lists.linux.dev,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Asahi Lina <lina@asahilina.net> writes:
> Trivial implementation.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>

The commit message is a bit short, but the change itself looks fine.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

