Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BA765C36
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjG0TkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjG0TkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:40:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EBD02D7B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:40:04 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fb7589b187so2337491e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1690486803; x=1691091603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FzSAIK3tVtAi1R9Ls9FEA3i4ka3tmGQ08Pkh0uzBwqY=;
        b=amCv8HB9nO/A6XSD3imimmhUA90rRZgOzjEcbAbZKqlJhfqARuqU3fOOo2x/pr9OEZ
         iWwWDo4L0kFpKmWdpaYKx06nuWf/7c34HWGjlvI1PzjU1p+JA6yG2Xy6r6AbCBt/bAG3
         CY1O6WFqjLYDV3P/ENzHKBKbIumoxmNkaMah0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690486803; x=1691091603;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzSAIK3tVtAi1R9Ls9FEA3i4ka3tmGQ08Pkh0uzBwqY=;
        b=LraB8HpYSK5ctRYpn89upjnc/0IXhkBuC2xENLSnHasP3x51SwZB6JG40GlMxZ/mwQ
         n/LD4ckgfsewrcSbnGhIsV2Wnxh/9k5ZLpamBCVHn6kECoL7pPSa8B8QfMzzq4RL7TAs
         69+OWCe7wzN3UWPZZII6qHr+2Js3kojuWllJ61Jwv3f0X1/gd+Qqfp/ZWsnMD/Epy/LU
         aE2D4JSMS+PnARMjlPRPvua1IDPSveNU+7qtizMp+B/a00IhGBDB1EQCx//HdDU1JRSy
         otGdjJB+fy8qTg7A1n3/g3UJuIQ2cJ7AICokh52PRVf9eQ41ObgA8LxntKAoYNzPrb//
         VUUg==
X-Gm-Message-State: ABy/qLbGZGQnq+8kRxK3AnYn1T+aj8hxuhuHjel9JFTDVOHPWDaifx2U
        mzDxfrgdArO/WLDFRlmU0L1KO1oE5TNm5E3VQxt695Nx
X-Google-Smtp-Source: APBJJlHzBf5a+1w5hBpF+lKX2D6sDfIy9JzjBgx5fTDXMMWy8SjnZyv7Mfb+w7xu8Qixbh7MVpvIFQ==
X-Received: by 2002:a05:6512:530:b0:4fd:f85d:f67a with SMTP id o16-20020a056512053000b004fdf85df67amr99831lfc.61.1690486802776;
        Thu, 27 Jul 2023 12:40:02 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id w5-20020a19c505000000b004faa82946d8sm452238lfe.178.2023.07.27.12.40.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 12:40:02 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fba86f069bso2319695e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:40:02 -0700 (PDT)
X-Received: by 2002:a05:6512:1591:b0:4fe:8c4:44f4 with SMTP id
 bp17-20020a056512159100b004fe08c444f4mr115829lfb.62.1690486802107; Thu, 27
 Jul 2023 12:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230726214103.3261108-1-jannh@google.com> <31df93bd-4862-432c-8135-5595ffd2bd43@paulmck-laptop>
 <CAG48ez1fDzHzdD8YHEK-9D=7YcsR7Bp-FHCr25x13aqXpz7UnQ@mail.gmail.com>
 <20230727145747.GB19940@willie-the-truck> <8EA729DD-F1CE-4C6F-A074-147A6A1BBCE0@gmail.com>
In-Reply-To: <8EA729DD-F1CE-4C6F-A074-147A6A1BBCE0@gmail.com>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Thu, 27 Jul 2023 12:39:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgeMOvL=ko_eruf5St7h0e9dVn4+GMKjcdshTJoxyD8tw@mail.gmail.com>
Message-ID: <CAHk-=wgeMOvL=ko_eruf5St7h0e9dVn4+GMKjcdshTJoxyD8tw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fix vma->anon_vma check for per-VMA locking; fix
 anon_vma memory ordering
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 12:10, Nadav Amit <nadav.amit@gmail.com> wrote:
>
> Interesting. I wonder if you considered adding to READ_ONCE() something
> like:
>
>         asm volatile("" : "+g" (x) );
>
> So later loads (such as baz = *ptr) would reload the updated value.

Not necessarily a bad idea.  Although I suspect you'd want to add
*two* of them - on either side - to make sure any previous loads
wouldn't be moved around it either.

                 Linus
