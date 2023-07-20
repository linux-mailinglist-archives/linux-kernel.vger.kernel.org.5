Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9429775AF81
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 15:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjGTNSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 09:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjGTNSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 09:18:00 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8789D135
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:17:59 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-997d144f31dso63972166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689859078; x=1690463878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqC/0JpDhyXercql+gb+A9vFQQTl07+8TE4AdNDBMOY=;
        b=Ae7PRYJlYnD1+4pmKb+x5JftBt4GemKLNPzxWPe/uMdE5jNm0J4SP1TiGIljtQl+Gv
         5qKA5HG9kJjVVKDx2SSnjz8mxwZw93jyQaXf3PpG0KiY6vNKbUs3PTlhW8nFrFzf6Vfo
         iUDh5FTFv/ADr3M2PYhuTCcL3Em55rqDV1UFAcgh5mKeCTtQgwfVR6rjxIDIUjocR5cT
         Pzkcc7SsPPIdCNHkR3WDOZ4aH4BNug7YXnvz6kjJYsOv3/p8sznAWrM+mN85FxLUg3gu
         OiGnY0LNKVIlvUTz1iecN1s/hoGLmqWm1qzSjICL8JSBMiJBwVRRZLLPdNIh6Z1RIJFn
         eZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689859078; x=1690463878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqC/0JpDhyXercql+gb+A9vFQQTl07+8TE4AdNDBMOY=;
        b=YSu4RhvQ5/q4vNxboxhNdc6qbCUuSv7AoA8oxQS/meTaY9iH/z4qczspw2W0teS8Rs
         T0s2CelvgEmy02Npmi1/S3lzaZxLcZrpr9NNRD5CVaVFoUxEEYh8WwA0pvVsTsDnAx/x
         UGaWJFKhzMse68MRBHEiwBZF1Hb5TznqfiOqzlWV8DL/3rIA/0nLkGVNvanwOaYT+A/p
         XGpPnCVlNPOphOvCovLcB/DFvrfAe3E3/EgAOkZV7nwFxXqsb4iq1WRqAG9UsuwuAX9O
         iPl24ab2PPtj2BaLxYJmD96GMEFZT0qivfxa2UexmwEWvq+UPXMUfiWuXFkUP/binS+h
         PHxw==
X-Gm-Message-State: ABy/qLYDdaRDLtYPU8yHIG3BB0JNxLf7+t75nR0Kgjx3CTVE6SUCQJ7T
        o4jboW4j4ysCRemoOlLnZfvbGxxm/Eream0=
X-Google-Smtp-Source: APBJJlHeJaf7B0zoQ7KZXQTNw/JnIXKLzxfjIc+cswd1g/hDjonIcYSCpq6kHkA17ALUgwWYE5Ro3oLOzyFslaQ=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:5a71:b0:997:e8c9:6f61 with SMTP
 id my49-20020a1709065a7100b00997e8c96f61mr15503ejc.2.1689859078009; Thu, 20
 Jul 2023 06:17:58 -0700 (PDT)
Date:   Thu, 20 Jul 2023 13:17:51 +0000
In-Reply-To: <20230719141918.543938-5-benno.lossin@proton.me>
Mime-Version: 1.0
References: <20230719141918.543938-5-benno.lossin@proton.me>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230720131751.3542420-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 04/12] rust: init: wrap type checking struct
 initializers in a closure
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
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

> In the implementation of the init macros there is a `if false` statement
> that type checks the initializer to ensure every field is initialized.
> Since the next patch has a stack variable to store the struct, the
> function might allocate too much memory on debug builds. Putting the
> struct into a closure that is never executed ensures that even in debug
> builds no stack overflow error is caused. In release builds this was not
> a problem since the code was optimized away due to the `if false`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
 
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
