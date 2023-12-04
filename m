Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC9A8031F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbjLDL6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbjLDL6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:09 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F219B5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:40 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5d42c43d8daso21824757b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691058; x=1702295858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bL6rQwoq4XSJ/ZUS/WdnMW57ZK8U/D00cS/60vn/vqc=;
        b=ZpY6bdMIejVNahtUtPGJ4K6o0FBbafTvzT8dWYNuXoWiIKpQ0t9oXVVPI5MiNn0cX/
         fZfa8yXR3lI6tYh0SMV9wyZNHRD3REcDZw8iYj0c54kCYmKAe2IebCalYpJp7TJ8hN8E
         iS3Dds0qt2k+BUnVrQWrE27wC6tHWR85vgGFifp7crQYB6PmaxB3nSX5zWgYxrqKrr7G
         3xkzSl2ww1I1P2aurNkLby/VBwessjKF0E5wmlS6KNJv99ldN9Jh2Troof/aW7d1LbMZ
         iG7bIRIvm2kE1z5z5t1qL92q2+zQ2STchqerQJoC1dHesYJsk/XQBT5LNCbPCRTR4I0w
         7/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691058; x=1702295858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bL6rQwoq4XSJ/ZUS/WdnMW57ZK8U/D00cS/60vn/vqc=;
        b=njTJ37NdG4XSktzbtpuZ84fLUJ7DVxOPwtzYM2AbMoRhaL+uXR0a0TYmzHBTlKsocu
         JoTcZfDLM9pBpIwSkNSdj1QUcSDrg6+B8y79HvJMPwBmDlaef+Td6q42wiGznWnsGV/L
         G5SH5v0S8cG12NNbhNW9zHhEXwQxozkWwfZp70CWOjbz4O1RpnMon0cmxRaAPmi0qMO4
         MikvhZu08bGOKae+dOEhIhTlwzHsookCzlmEikFe0TkkL8u9c0WZBAjEb9tHeE4VtHVx
         ZQPW+m1ijgVqcW6AyVVNAyR7wzyeKZZ1gUkLt9gxdyLSfPTicbYVd6AWsxEko+Qf8pFI
         5Ifg==
X-Gm-Message-State: AOJu0YweXUw/GIv7dBuD3ImwWsJZ+2k8fqCmWaO3XA+4UrjibLnKRRkq
        Xcjt/BJ/NXMKaduXK5dZoie1kbB1X/KZWyU=
X-Google-Smtp-Source: AGHT+IGULYEP2S/RraTdKtF+NhmkCJk7YKGJ2f56TPUHlByxNufqOpqYFp2A5Fc/0pngIlMfR5p8TkZM5wEPJ1Q=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:2e02:b0:5d6:f1d2:2e5e with SMTP
 id et2-20020a05690c2e0200b005d6f1d22e5emr191243ywb.0.1701691058471; Mon, 04
 Dec 2023 03:57:38 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:57:34 +0000
In-Reply-To: <20231201172212.1813387-26-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-26-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115735.42976-1-aliceryhl@google.com>
Subject: [PATCH v2 25/28] binder: refactor binder_delete_free_buffer()
From:   Alice Ryhl <aliceryhl@google.com>
To:     cmllamas@google.com
Cc:     arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
        tkjos@android.com, Alice Ryhl <aliceryhl@google.com>
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

> Skip the freelist call immediately as needed, instead of continuing the
> pointless checks. Also, drop the debug logs that we don't really need.
> 
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
