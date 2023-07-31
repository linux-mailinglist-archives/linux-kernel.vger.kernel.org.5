Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D8376A153
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjGaTd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjGaTdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:33:23 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84355171B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:33:22 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9e6cc93c6so23667381fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690832001; x=1691436801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yXLFlpjaOoFRKiNfZATjG2CogmUERUAniLQFoDaW35U=;
        b=DmEFT6jHO9aU0Q7mmz7r/3blosp5zNuGMXAmEo5De2MDIjQKJZZBHYk/ElQiLMJeg0
         QxQml6A/B37Up+BHTkZgXTfbuW4Inuyyvw66qiXZBSPYiVtmmmJCuX1VbOBpKw+XJtXr
         nRWRkTI1yyC577PjDeimQqdrdqEu8m7qM+jQA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690832001; x=1691436801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yXLFlpjaOoFRKiNfZATjG2CogmUERUAniLQFoDaW35U=;
        b=GM+M3fJjjkBGftzWcIS5SJ0/f5J4L5ZWlN4WCHB2h7oO1IJt8f2yoSH5TXpkie5KG3
         vkViWcOvHXc+/4DOlF8NfHbWQUJbU9RYapGFyu3Fp+V9mVuJfykAPoNwfKCxkqUuoREf
         mMa0QhiJ3F2kPC6nk9gpSth4cyPf6bgTLPoQLxMJuBpwgQ8JVDBQf4CS+t54ICNio4Ka
         V6FajOj2gL7Kh5Su8C7ojgrR+dIkfWeAy+xj5kCdk6ybxDC9fl496r+QgJSaibeMwp8l
         LOFRATO02XWH4ZvdJnfqIDu5ioU76wfdfNidkerMvccjabHU27u6LcH4cfl8zj5L2NaF
         y8FA==
X-Gm-Message-State: ABy/qLaiozQtFFCmO4o6npzcPCcFHJgizr3ksGUzKa/rWVVXKsGB0e/s
        nMifFAwOpeOqGiNp5LoNjp4yeO9UaOd06guv8v9/ASWk
X-Google-Smtp-Source: APBJJlFX+/RIvfTg1wF+tw3V6KBWoubVByrnB5J1aGQ2uX2gmyXpAeBGfqK9iHNXbxCvGgsDdaY/Ng==
X-Received: by 2002:a2e:86c8:0:b0:2b9:c676:434a with SMTP id n8-20020a2e86c8000000b002b9c676434amr665444ljj.15.1690832000765;
        Mon, 31 Jul 2023 12:33:20 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k14-20020a2e92ce000000b002b6c61bac2esm2699566ljh.92.2023.07.31.12.33.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:33:20 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so7605558e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:33:20 -0700 (PDT)
X-Received: by 2002:a19:2d4b:0:b0:4fb:89e3:5ac6 with SMTP id
 t11-20020a192d4b000000b004fb89e35ac6mr527434lft.62.1690832000024; Mon, 31 Jul
 2023 12:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com> <20230731171233.1098105-2-surenb@google.com>
 <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com> <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com>
In-Reply-To: <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:33:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com>
Message-ID: <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: enable page walking API to lock vmas during the walk
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 12:31, Suren Baghdasaryan <surenb@google.com> wrote:
>
> I got the idea but a couple of modifications, if I may.

Ack, sounds sane to me.

             Linus
