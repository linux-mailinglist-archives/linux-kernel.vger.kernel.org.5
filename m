Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B7E7AC5E2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 01:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjIWXcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 19:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIWXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 19:32:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8006C127
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 16:31:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c93638322so1008687266b.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 16:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695511915; x=1696116715; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3pq9qN8wtms8FZT//oeRwGp6nwsrTlkKVlOUsyFBqdg=;
        b=h5IBemmfMl9CNy+pM2LpiIdrl17TH8lwbLo57IBUTjS92uJdnZo0qXrXeTJvx8+RuD
         ZhK9omjKHQrHObFVqRcIbLpmPI+YhpDHcItgDkbT7N12YrSAE9seJwONlBQ4si2glDPb
         iJnYheV8k1vEgWR2KddFo7Ele4eBB838W2vFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695511915; x=1696116715;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pq9qN8wtms8FZT//oeRwGp6nwsrTlkKVlOUsyFBqdg=;
        b=JDvcdQ6yO3pAwWfV8O6zZ3xTKRrMfD3kBLl0IOEnsIF2VH/AgZ0sHde9Dpzbz3x0IQ
         /QFbP8sWB7NfibGXROqn1O88vPcgLfeIDAdhQbPthq8dU84QUWa10IwoRasHJWgj94Qk
         FEeISAsNyJV55U0XYmZz01SZz02rfh0Tcjbrl3IIy2LREaW/pBOlUuH0Atv33YuYN0v/
         mz9J9ThtotaFoMgAsmnKxketWJlzWBBxvjrmmpUMe2wtXX8dFUwSY2v3CNffHKQP47QC
         QxUkalODt8jZypGfOz46HAxL7ADKC9z+Hw5LyEhGq6N1koPJfjWm0ZDjI5xZJg0nwML+
         972A==
X-Gm-Message-State: AOJu0Yww+L4in2wXLGAyKZRietkaOx1wKTHhnsO6duQKaO7UvXhrGDoz
        UiOduSTNoduTz6MbDRTzc2mW5uuj9BnvMkr9KMPP1Oo3
X-Google-Smtp-Source: AGHT+IH2g7raAZxR+ShfaGc4iCC1+BpIrbbJZQx1c30PZNI3YbL2VpYKtfdyNU+Gx2j6DlFuFjN3eQ==
X-Received: by 2002:a17:906:c143:b0:9a5:794f:f3c5 with SMTP id dp3-20020a170906c14300b009a5794ff3c5mr8389434ejc.6.1695511914704;
        Sat, 23 Sep 2023 16:31:54 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7dbca000000b005330b2d1904sm3744513edt.71.2023.09.23.16.31.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 16:31:53 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so12531645a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 16:31:53 -0700 (PDT)
X-Received: by 2002:a05:6402:2803:b0:533:4a89:5b2e with SMTP id
 h3-20020a056402280300b005334a895b2emr9576725ede.1.1695511912931; Sat, 23 Sep
 2023 16:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-umgekehrt-buden-a8718451ef7c@brauner>
 <CAHk-=wgoNW9QmEzhJR7C1_vKWKr=8JoD4b7idQDNHOa10P_i4g@mail.gmail.com>
 <0d006954b698cb1cea3a93c1662b5913a0ded3b1.camel@kernel.org>
 <CAHk-=whAwTJduUZTrsLFnj1creZMfO7eCNERHXZQmzX+qLqZMA@mail.gmail.com>
 <CAOQ4uxjcyfhfRhgR97wqsJHwzyOYqOYaaZWMWWCGXu5MWtKXfQ@mail.gmail.com>
 <CAHk-=wjGJEgizkXwSWVCnsGnciCKHHsWg+dkw2XAhM+0Tnd0Jw@mail.gmail.com>
 <ZQ884uCkKGu6xsDi@mit.edu> <CAHk-=wg8zxC9h5a0qimfGJVvkN0H5fNgg03+TNn9GE=g_G30vw@mail.gmail.com>
 <ZQ9hvS4m775EosEm@mit.edu>
In-Reply-To: <ZQ9hvS4m775EosEm@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Sep 2023 16:31:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQLoKLw+MLRpRE6nW9KH48CdV=oR+uYENfEoeSf21XRQ@mail.gmail.com>
Message-ID: <CAHk-=whQLoKLw+MLRpRE6nW9KH48CdV=oR+uYENfEoeSf21XRQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] timestamp fixes
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>
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

On Sat, 23 Sept 2023 at 15:08, Theodore Ts'o <tytso@mit.edu> wrote:
>
> I might be screweing my math, but I believe 24 bits should be enough
> to code 10,000,000 units of 100ns (it's enough for 16,777,216), which
> should be sufficient.  What am I missing?

You're missing me just being stupid, having a brain-fart, and doing
the math for 10ns despite telling everybody that 100ns should be the
reasonable thing.

Duh.

             Linus
