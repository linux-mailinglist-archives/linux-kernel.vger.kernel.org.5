Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F576D829
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjHBTu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjHBTu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:50:28 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125ED19B9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:50:25 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-993831c639aso10052666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691005823; x=1691610623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czEhvzC3+/GfMMXhkZoSsfuqncVAQxP622lGKX8QTK4=;
        b=In6KwkBUlF4ul/pW+99vbfUH4W72hSlc4rAx6HaoVdGCJU1GaE2X9lj4Pjj+6RWk+C
         9fxAb/3JV7cTIm1+qsm9wnfAlfshOLxTb6W+jC9jnJZ28ovJuiTbixxHyKj2xFNBZPBh
         Id4NGtDNbuYYC82m9B8xJOue2mi9GrhqrDlOQeRSwv5RQbENmPAu3R6bpnqAELTz4gzL
         yA9P6h8YVLx+V6V8ZlHS+j3dd+5UUJlmHDPU4GOOjM37Vr7dboYs1nennur0xoRXhQjU
         59biGR1KC5CUyGgJj9kngpB1u+CaUP7Rgykicm/tWysuodlGOwazma9rwFSMYS2H0/to
         4AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691005823; x=1691610623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czEhvzC3+/GfMMXhkZoSsfuqncVAQxP622lGKX8QTK4=;
        b=bmfuMptd262a7IqlMgmNrjBzXLhVTtBdcHswdg48bsl07W27UyePONTIOQYxwIP/Em
         EPd09c/ZijSPccI1cnBDF8dhGKVUD8HwCk188wMekCn/ewVHPlHsC0qH39eUF9INytwo
         zN/eIr18TBwHYVZvWy8FyV+/UvIB/dKUBkmxKa/0Gf4yUn8Tj3p76Cl8Ls0vVyEinYrk
         WKdecpySrKHxZ/PcO6QLC/q2JD2tIhDs1XCMUx7uRh+eVqMlGDdG0GUXXxmmY87c6xc4
         /HmSVXlV4DkaL7onrC6EsBRf0+vnlNnAIix9/3i5enqraM5khPC4yxm4jL1JhuSEYPff
         XeJw==
X-Gm-Message-State: ABy/qLYRKFjLlLLGRrX6ec6kUeVp1/OdxJXJ4ZIOl7MzwkjYom794E0F
        TdvPZ518NpoMXd1cpwRAUlTxhMGLMshqu4E=
X-Google-Smtp-Source: APBJJlHGv0gfg0TtRWInLVBUJvv637TnAGMVZ+kfDPzYop8KgrbyNX9CGg6I4WdD4CsMqprTNLhpLKzLbeizEBc=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:1593:b0:994:4e82:376f with SMTP
 id cf19-20020a170907159300b009944e82376fmr22455ejc.12.1691005823293; Wed, 02
 Aug 2023 12:50:23 -0700 (PDT)
Date:   Wed,  2 Aug 2023 19:50:20 +0000
In-Reply-To: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
Mime-Version: 1.0
References: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802195020.3062950-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
From:   Alice Ryhl <aliceryhl@google.com>
To:     changxian.cqs@antgroup.com
Cc:     alex.gaynor@gmail.com, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, sergio.collado@gmail.com,
        tate.thl@antgroup.com, wedsonaf@gmail.com
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

Qingsong Chen <changxian.cqs@antgroup.com> writes:
>      let mut body_it = body.stream().into_iter();
> -    let mut functions = Vec::new();
> +    let mut functions = HashSet::new();

Please use a `BTreeSet` instead of a `HashSet`. A `HashSet` has
non-deterministic iteration order, so this will make the macro output
different things each time you run it.

Alice

