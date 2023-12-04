Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441DA8031F1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbjLDL6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjLDL5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:39 -0500
Received: from mail-lj1-x249.google.com (mail-lj1-x249.google.com [IPv6:2a00:1450:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517F1138
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:32 -0800 (PST)
Received: by mail-lj1-x249.google.com with SMTP id 38308e7fff4ca-2c9eca8abe5so17892221fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691050; x=1702295850; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lXjCwFgAar95dunczXLw+bN6GpMHXzLUOtS+2fvPta8=;
        b=ZZ0VutK0nWQx56FSV/HHQTekiRBNmXRkKdjiv66gCEpU36Wk/Qt7RLf6ZPibPdBQOJ
         6UuenaeiUjuo2rtUVVBGYyyIvnTfgmnHITh8AWdqt0QWHB19QLzHJfmjs3LAF+qmWxh4
         Mhp9999bqhGDKjvaMoHts3KJG1RiyjiYsuCNeBlDORwhRHscaOM2zj5RRhlcGKlLRrTG
         1JFZAZOAPDt8Eu0gKTO3UXo++sWGA9kAhXgDPB2bROdAcPxyEtZua2ILyA+vz1JdkMOX
         UyrmU7zQHqRNdcPwDg8pHU1wiiA2yPlLLb3dYLClIpKqql3sExiEOu/WktGKdhuJ92QY
         gYBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691050; x=1702295850;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lXjCwFgAar95dunczXLw+bN6GpMHXzLUOtS+2fvPta8=;
        b=C9wIFXiBU9jaVzptk14OdNc/80XViL4vVcR4Fx8SUlvQFET62+GSzxAXLz/JAQAwYn
         oKqY/k8TZ4F6K/7ischFKBIVGbQ3HM7XErCWQfJtPrbcLsN2Dn7qIrZc3/pgAift2tW6
         3dbpSG1MbUbYiFdlP8XgPLGmS/jhKoyK+qUh5Pm1BJPzOBR1dStLQ9IF11d9EYwuKFOu
         ljz6cdi+E4ag36esisJkDaskzt3/ipsOtk30aVBsSzVIJiCpf+kPZ+fYqQwQ07GUJQty
         0wVSRMdyd5eD8aN2F3gokOwvZGO1+erzvT21nGDb2a/57dP5N9fCSAw+IfGDQpmhnqYT
         sQrw==
X-Gm-Message-State: AOJu0YxJ8Jd7D/YUby2EZtv4061Tmx9eLiXbsleD3OSjR8ZuKGhh7P7A
        xsyNbUtjIpUOGWyoraHS4tuOOfbDfQHiG+c=
X-Google-Smtp-Source: AGHT+IFBRq+hVdhUuIBuuWFInFuOEL6VElls2dwjtqXxjYJlQQ3zB/zbK4GL9BLcS5ZOZfwmnFOIhp+QBhZHz6c=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:2203:b0:2c9:f793:eaf2 with SMTP
 id y3-20020a05651c220300b002c9f793eaf2mr71582ljq.0.1701691049879; Mon, 04 Dec
 2023 03:57:29 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:27 +0000
In-Reply-To: <20231201172212.1813387-24-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-24-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115727.42370-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 23/28] binder: document the final page calculation
From:   Alice Ryhl <aliceryhl@google.com>
To:     cmllamas@google.com
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com
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

> The code to determine the page range for binder_lru_freelist_del() is
> quite obscure. It leverages the buffer_size calculated before doing an
> oversized buffer split. This is used to figure out if the last page is
> being shared with another active buffer. If so, the page gets trimmed
> out of the range as it has been previously removed from the freelist.
> 
> This would be equivalent to getting the start page of the next in-use
> buffer explicitly. However, the code for this is much larger as we can
> see in binder_free_buf_locked() routine. Instead, lets settle on
> documenting the tricky step and using better names for now.
> 
> I believe an ideal solution would be to count the binder_page->users to
> determine when a page should be added or removed from the freelist.
> However, this is a much bigger change than what I'm willing to risk at
> this time.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Yes, this does help somewhat.

However, `curr_last_page` is actually not the last page. It's the last
page plus one, since `binder_lru_freelist_del` is exclusive on this
argument. Maybe rename it to `curr_after_last_page` or something like
that? Or maybe even just `curr_last_page_plus_one`.

Alice
