Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FDE7794DD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235733AbjHKQjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjHKQjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:39:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5562696
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:39:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99cbfee358eso292517566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691771946; x=1692376746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIHlgRVD4zuIsPHrllchsXgEvRrrKBDJPCXSLRIlRrE=;
        b=YX4ynnme2gJnm7Or6lOXhikRCc7foTzX2Sji0dczYuu9sxeQGYGhmRHuKjyDTGsSLt
         rWbQKuEYHKzTMS2ca4xNF6hxD/pol3szIu481brpJzfBGBMqYKuMr9rMtAMsiQL+L0DY
         5VvjO6LA/vKpODzW1WaLj2Dhc4kJ8DlhvupAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691771946; x=1692376746;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZIHlgRVD4zuIsPHrllchsXgEvRrrKBDJPCXSLRIlRrE=;
        b=CKOYYQYN7baEq3g/UXARnXoUeZAF+0mkAYz4NR5+bsit0sG7mDO78UryH1qq4uIXzv
         Mmzx/p3xYMfdccorgQnKRwden8ePUWjGbcmfJQ/XP8a9IJ/oin1y+hDmUJb+SClvYIOb
         Sb9L66VzGrycGCI1uBY6l14NmfJEjXQTijFFcL0VkqSTvTZ5SBtcHHpwplt6NQY2aago
         3OCgkhOiGI0Xw9QDWW/sTY9YwoSO2h4kVLJtuxY4iZl8hM16oYv/fZlNTGCZzDqttG84
         3SZpNSrHnmO0ZfpXnfIAi4oPIPR1vQExlZV31YO37VhzN8J+c1D0MHr0veuXfBjo5SKT
         ZD/A==
X-Gm-Message-State: AOJu0YxRpA0xV16b0J+nlNvNX/dH/7TSHDzNLYQ037DA7jlzf4n2Nn8T
        eYiF7e3euI12X+618mCF39eUaQoVHj4WcBYDklL7ubzP
X-Google-Smtp-Source: AGHT+IHQla/QVNyVIpFiZmaBpub85dAv9oms8PXwg6yYeeTYnzB5vhqmyPpxZ+WtlYuhw0Ni8hG/iA==
X-Received: by 2002:a17:906:10b:b0:96f:1f79:c0a6 with SMTP id 11-20020a170906010b00b0096f1f79c0a6mr1987051eje.70.1691771946215;
        Fri, 11 Aug 2023 09:39:06 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id z8-20020a170906814800b0099d798a6bb5sm1152028ejw.67.2023.08.11.09.39.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 09:39:04 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5236c9ff275so2897249a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:39:04 -0700 (PDT)
X-Received: by 2002:a05:6402:184c:b0:522:ae79:3ee8 with SMTP id
 v12-20020a056402184c00b00522ae793ee8mr2037905edy.5.1691771944135; Fri, 11 Aug
 2023 09:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <3710261.1691764329@warthog.procyon.org.uk>
In-Reply-To: <3710261.1691764329@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Aug 2023 09:38:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
Message-ID: <CAHk-=wi1QZ+zdXkjnEY7u1GsVDaBv8yY+m4-9G3R34ihwg9pmQ@mail.gmail.com>
Subject: Re: [RFC PATCH] iov_iter: Convert iterate*() to inline funcs
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>, jlayton@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Aug 2023 at 07:40, David Howells <dhowells@redhat.com> wrote:
>
> Convert the iov_iter iteration macros to inline functions to make the code
> easier to follow.

I like this generally, the code generation deprovement worries me a
bit, but from a quick look on a test-branch it didn't really look all
that bad (but the changes are too big to usefully show up as asm
diffs)

I do note that maybe you should just also mark
copy_to/from/page_user_iter as being always-inlines. clang actually
seems to do that without prompting, gcc apparently not.

Or at *least* do the memcpy_to/from_iter functions, which are only
wrappers around memcpy and are just completely noise. I'm surprised
gcc didn't already inline that. Strange.

            Linus
