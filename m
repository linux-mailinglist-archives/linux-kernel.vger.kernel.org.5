Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506AE77F9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352530AbjHQO5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352498AbjHQO4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:56:48 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3470A30E5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:56:34 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99df11828c6so218175566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692284192; x=1692888992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vz8AzeclrbAtQHTVxmwRIMfUys2iPiXzHBgxBLhu+CI=;
        b=dwziQM2+Yt9ERHVwknRtALisO2aqZA7rC/jWFI8wN3p6hwllcInP7Uz8/Y4CAIoB0B
         iEl+47doPnCTVeFhdMs0Di2PU3ybn6pJEwpHOt5DggUbdtZQDnuoNEXl6xl07ez36e8l
         0qopaeU9Q9lsfOy/xYc337FEEau0Cd2VbclQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692284192; x=1692888992;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vz8AzeclrbAtQHTVxmwRIMfUys2iPiXzHBgxBLhu+CI=;
        b=KwCkQV2ki8vUjIzavjRvv++hE3E+TwmGtxxwgY+Dnxs6Xu+sRjVUegK/+IGZNITqg+
         EZYOicN0m8Y48QF2E5JtFLLcoXq2vfGR3d5VOoFt87bLk8a9jdWPNdh3/4rK9dWW2aeu
         0DX4ZAW4twYIIHwRwZ+HUPgmJjYx8iqO73DBoHtXmIJQRKfh0TbmPNLyyam3z9k8pbc3
         nzCglli7bU+NrGdQdvq0yZBW+lcPVwLOqgqargTT5efZfXnpd51Lz0PjmqqcdfxzlcjQ
         ZstjRQ+2NWjWYxQZwPJOTE6xb5qJfkgZjxsknYPS9RAhOwUB/8UJaArpWZUZzRj8RKGt
         zQ0g==
X-Gm-Message-State: AOJu0YwFr0b8AROaVn6ECriEmWUspoVHW6mWdyBT96d9ufMevBlBpXyR
        eYghkdc6GfLXwGH6HU87ifArb9VesfxVUz8/nzRhKNLP
X-Google-Smtp-Source: AGHT+IEFh4/slAqyoesFcf/XeRscuAbX5JRypbEfHiAk7wU7/D0oqXfLkM8NbastLCNwZ/CXW2Ye8g==
X-Received: by 2002:a17:907:2d23:b0:966:1bf2:2af5 with SMTP id gs35-20020a1709072d2300b009661bf22af5mr3586854ejc.22.1692284192421;
        Thu, 17 Aug 2023 07:56:32 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id jt22-20020a170906dfd600b00997e52cb30bsm10192575ejc.121.2023.08.17.07.56.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 07:56:31 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99d90ffed68so222397866b.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:56:31 -0700 (PDT)
X-Received: by 2002:a17:907:3f8f:b0:99c:572:c0e4 with SMTP id
 hr15-20020a1709073f8f00b0099c0572c0e4mr3620309ejc.7.1692284191332; Thu, 17
 Aug 2023 07:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <d5e1ee76-75b3-26cb-23ae-cf6ab40597b7@xs4all.nl>
In-Reply-To: <d5e1ee76-75b3-26cb-23ae-cf6ab40597b7@xs4all.nl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Aug 2023 16:56:14 +0200
X-Gmail-Original-Message-ID: <CAHk-=wgR3JSopXha1pJh4dRDH-U+jHgqp1zy1nR8OovUQTJgWw@mail.gmail.com>
Message-ID: <CAHk-=wgR3JSopXha1pJh4dRDH-U+jHgqp1zy1nR8OovUQTJgWw@mail.gmail.com>
Subject: Re: [PATCH] media: vb2: frame_vector.c: replace WARN_ONCE with a comment
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2023 at 12:41, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:
>
> There are no reports of WARN_ONCE being issued for actual VM_IO cases, so
> just drop it and instead add a note to the comment before the function.

Ack. That was meant to catch any (unlikely) strange users, but yeah,
it can obviously be triggered by "intentional" strange users, ie
syzbot and friends, so since there seems to be no sign of actual
real-world use, just removing the WARN_ONCE() is the right thing to
do.

I'm assuming I'll get this eventually through the regular media pulls?

                Linus
