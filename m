Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E508031D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbjLDL5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjLDL5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0141A113
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5d1b2153ba1so57160927b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 03:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701691024; x=1702295824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hKg8TwUcRZZv3FI9ZhMT4QyQodVWo+PJAdidc1wFIkQ=;
        b=1wzzjNA9xAaqrYIFnFRVOSZMMV3WxS9XMKP1eg2rSuJ2WWWE7KU6ZYLQGMh7xLVqvh
         X2hSuYEuRdAR4DxAx8Rk6jqG/K0zTgIJDYj+qR1jmaQRZljMi0+YCVoSvBwkYFC1ANAB
         fOxUBLkhN9j26LeXceRHWrhRcHfNuSiw57FWDvJYmc5MKP07H5bBtnNZT5TXW1chbUD9
         Aj9AlUxjvhKJoT68mYOh30rNQ6zZZ1YnfJ1GR3c06lrR86rVD0P2EQz+NRNh4xOLzji5
         uRv/pTX1GIC68AhKTwRxoTl0iYIDgxqhjn/rkIISp3jcNolE4efF3JLJoZfeCDMSJxw3
         ZDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701691024; x=1702295824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKg8TwUcRZZv3FI9ZhMT4QyQodVWo+PJAdidc1wFIkQ=;
        b=OW/fl3T9rVT5j49Q3E4a4Nv0KgC1u6Nu3a4MBKzOqJdZbStIyjdzmXkocEP/tSh+M6
         Xrec+ph9H5Z0BBE6SK0z1ObkNVbb02khKr49D2aG9RX1WIrn4XCeUdr+Xf4Euo3sgtiB
         k2vetndamEgF80f2qL4zx5+SCUJOv66Hr9/PQ2W3ZsNmrlc2ov4hZMmHhdBXULR8/QrI
         S7TMxem/i5O0hVJocsBbAwpuYgV2Tt26GSwj425AcbEQHjrG5XfnyXk40cLJZw5l76IS
         kzxn8Mmw3EMYY3RbBVUqEjEhXZb2R0sudWxJ01NWWfQ6JNz/wgBsRZePiszL1m1QTBZp
         B6Bg==
X-Gm-Message-State: AOJu0YwCG4LfoeY4sgqECtXGR2y+NeOUaZi5R71uUGhzTGHKknTwICiX
        inDb+OL2qV0Rbzg4v9u4Tmykr8GG8q8phLs=
X-Google-Smtp-Source: AGHT+IG4FS/4InfN2bnvpV9xrnGGP01IegpxuKdyO/4+gfGGu+Zx3KxYpGyy60OX6KM20Aim2MO2bN3yW1Mt86M=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a0d:dfd7:0:b0:5d3:b449:e58e with SMTP id
 i206-20020a0ddfd7000000b005d3b449e58emr344423ywe.6.1701691023858; Mon, 04 Dec
 2023 03:57:03 -0800 (PST)
Date:   Mon,  4 Dec 2023 11:56:59 +0000
In-Reply-To: <20231201172212.1813387-10-cmllamas@google.com>
Mime-Version: 1.0
References: <20231201172212.1813387-10-cmllamas@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204115659.40228-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 09/28] binder: keep vma addresses type as unsigned long
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

> The vma addresses in binder are currently stored as void __user *. This
> requires casting back and forth between the mm/ api which uses unsigned
> long. Since we also do internal arithmetic on these addresses we end up
> having to cast them _again_ to an integer type.
> 
> Lets stop all the unnecessary casting which kills code readability and
> store the virtual addresses as the native unsigned long from mm/. Note
> that this approach is preferred over uintptr_t as Linus explains in [1].
> 
> Opportunistically add a few cosmetic touchups.
> 
> Link: https://lore.kernel.org/all/CAHk-=wj2OHy-5e+srG1fy+ZU00TmZ1NFp6kFLbVLMXHe7A1d-g@mail.gmail.com/ [1]
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

With the discussion in [1] and addition of patch 26, I am happy with this.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

[1]: https://lore.kernel.org/all/ZWmEv6-OBEZ08vy5@google.com/
