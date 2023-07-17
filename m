Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8843E756580
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjGQNxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjGQNxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:53:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AF5CC
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:53:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-cac213f9264so4510427276.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 06:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689601994; x=1690206794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7a5j4gvhnG5mrdZ/F4z3dJKPADNbpn8JJt+6WIEe8sU=;
        b=lK2MzwZAd8EF2hJ82Wrids5Yon9GdRQhhNLfZ2ksqHpFJYE6J0xTMaiMwll8uAghz1
         Q62+KB6AQNgPBSOKx8vtCAfk+h9fYbT/aJZn/4nhnPfduu7vlXDMKEg4WyZZ2FFixDoq
         oDgqbcwo0gIXZODKkk4NXKi3u+mZG5rGW28+W2IGOYejqkl9UHoT9i6jCSgrXCkd4SPQ
         i6d91L8Htl5aAkcJmprFUFouxpSIdoRyLSnLuX0qBZr0vhnT4QEuUyzkpgeOOV2dHqBb
         5gTDJFFnbQho1EeFjkMi82uQfx7G3caOKn/DQAw/gzC/yuy69GoBodepUdF460PeP/1Z
         CrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689601994; x=1690206794;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7a5j4gvhnG5mrdZ/F4z3dJKPADNbpn8JJt+6WIEe8sU=;
        b=CuO6M+bXaCH4bAtbGTuHBXEe8O7nxyzuoErnKSyAZizQJ2OXIw+u7GcyPPJk9K3Oij
         PdiKIyPuvpJc82ikOC4H3Fm0KORuXxu9LEaKv8rKi0VazVps5LmhGOaunNLMMEKnBZPx
         1+3q14iBrcIsntG8Kpva8FgnAARw6hGiJysXl7bADZi8KzDOGfeGgvQdEC0DiJ+oIqhL
         VVfd1gE5sZqlEBlIntEwJGKpp5aqATd0YtP97gekVaMubpW/K+ThP/lWhgQpraJ5hDxX
         Q4Y7ll8CCbDU+1UKlS0T72cOOLTyDBJvimRCE/2lkTIo2BZkUCEvL8vBwqzFR+Cg/yUb
         9OPg==
X-Gm-Message-State: ABy/qLbzs8cHVBD5jz3qBzx7uDjyVUr31R+QDkMveSTGcwFzx5zlrBLm
        FSAugjiHgpXoYkZWhdlgeG6/zvEbReAMkmE=
X-Google-Smtp-Source: APBJJlFqfJxS9tr9kwuqTLxh56qQM4RllSCU5YzQj4nW0duV/3DgusRHSW5nZK7P7bx+oV8x7DiAddAcyBASxqQ=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:2556:0:b0:c22:38c2:43de with SMTP id
 l83-20020a252556000000b00c2238c243demr96482ybl.11.1689601993768; Mon, 17 Jul
 2023 06:53:13 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:53:11 +0000
In-Reply-To: <ZK3WUBTb1dHfjnh8@boqun-archlinux>
Mime-Version: 1.0
References: <ZK3WUBTb1dHfjnh8@boqun-archlinux>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717135311.1841165-1-aliceryhl@google.com>
Subject: Re: [PATCH v3 4/9] rust: workqueue: add low-level workqueue bindings
From:   Alice Ryhl <aliceryhl@google.com>
To:     boqun.feng@gmail.com
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        nmi@metaspace.dk, ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com,
        yakoyoku@gmail.com
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

Boqun Feng <boqun.feng@gmail.com> writes:
>> +// SAFETY: Kernel workqueues are usable from any thread.
>> +unsafe impl Send for Queue {}
>> +unsafe impl Sync for Queue {}
> 
> I don't think "usable from any thread" is the accurate wording here, it
> sounds to me that there are types that cannot be used for a particular
> type of threads ;-)
> 
> Maybe
> 
> 	// SAFETY: Accesses to workqueues used by [`Queue`] are
> 	// thread-safe.
> 
> ?

Sure, I'll make that change in the next version.

Alice

