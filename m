Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383CD7E537D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjKHKi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjKHKiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:38:25 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41EB1BD4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 02:38:22 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c515541a25so71752561fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 02:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699439901; x=1700044701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nzWn2/btn0V+XmHJfWHIYgyjhRSrjzPvVjzzAso4GDI=;
        b=z2WCiFgHukBzawXx2xUK2NWAyZulLFP4P1j8U8/ZQ57O4subCXdIusdAreeKFsPDGK
         Po5XVZPA2I3+WctZX7Fyq3avwyWg9J1b6n+OZkme+bcy4JWkEVhc+FQrNpv1EPVrtXN9
         YfSIXWbAw9wwPKptkUz/33y/9l8mX7xZypbagG1oDAg+kYLPuZkqxk7CqPc/Cl3pLQR7
         QqQdkzLyFANIi5ofmG4UwUSYHQZpoAXvpX/IVIE59CJ72eOWK1IhQrbk/5xc+vjO+Bab
         F18uQz0V1qSfr1bvrKM8GhxaUoEfdvT//G1lH8gxwBpFwS6tOo1o/qnExfIZklkVKFHz
         dorA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699439901; x=1700044701;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzWn2/btn0V+XmHJfWHIYgyjhRSrjzPvVjzzAso4GDI=;
        b=b9uUdV468ve5Gl+D5ECxUTSLB9XLRadJZnEeeazff3TtlyqlRB2TB/p1Gx0QVBmo/Q
         +lDC5zQcefWF9JFeTlfRhL44wtfcLauTp3CEVU/veI46jp7FsWprQCgEiRorbaVTZmkD
         VDl4SPR/SclPTaCLvQt5vdsH6JuWYSBCO7lLvNmNRtvWQCfd1DsPuIi4EBCVOZLmCO58
         Di0rbWiHeYtB+kuqs10sVydFbIahEex8h9fRDOPixHQGRSVolXIi3k/pDCXN5DtoNUSX
         NNvDSlfh5wXSy7VsMEcbeHtzFQJHBKVmFF+McSwwdrWi1rYWa58VrWOTxc4QRHOr/+XL
         DKZw==
X-Gm-Message-State: AOJu0YyIle4lV4KxB5ZEtcNyWbGvegpjQ1hEcZDgcE5VY2Bd+neYTdvP
        x3oaFye5+W36umrn0FuUAeWH9DsgnBxOD3s=
X-Google-Smtp-Source: AGHT+IFRGK+yoXfemUJ85D+8dYbiPL3DuZ1GLp8NQbNXRZTIl9CINVYMEwP48WSyXF4Kc0W7fg4SkgRxA8XxH2E=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a2e:a4bb:0:b0:2c6:ed6a:7ca6 with SMTP id
 g27-20020a2ea4bb000000b002c6ed6a7ca6mr14971ljm.10.1699439901160; Wed, 08 Nov
 2023 02:38:21 -0800 (PST)
Date:   Wed,  8 Nov 2023 10:38:18 +0000
In-Reply-To: <2023110108-overarch-dumpster-5452@gregkh>
Mime-Version: 1.0
References: <2023110108-overarch-dumpster-5452@gregkh>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231108103818.526526-1-aliceryhl@google.com>
Subject: Re: [PATCH RFC 01/20] rust_binder: define a Rust binder driver
From:   Alice Ryhl <aliceryhl@google.com>
To:     gregkh@linuxfoundation.org
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com,
        aliceryhl@google.com, arve@android.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org,
        cmllamas@google.com, gary@garyguo.net, jeffv@google.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        maco@android.com, mattgilbride@google.com, mmaurer@google.com,
        ojeda@kernel.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tkjos@android.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Wed, Nov 01, 2023 at 06:01:31PM +0000, Alice Ryhl wrote:
>> +config ANDROID_BINDER_IPC_RUST
>> +	bool "Android Binder IPC Driver in Rust"
>> +	depends on MMU && RUST
> 
> Can RUST even build on non-mmu systems?

I don't know, but if it could, then the dependencies of this RFC
probably broke that. I guess this depends on is in the wrong place.

Alice

