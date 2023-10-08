Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA27BD018
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 22:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbjJHUbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 16:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjJHUbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 16:31:51 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5BCB3;
        Sun,  8 Oct 2023 13:31:50 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-57de9237410so2129530eaf.0;
        Sun, 08 Oct 2023 13:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696797109; x=1697401909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eO0wrsZ4W7mLGWyOWo1L1ds455g3zsEhPxWE1R/flK0=;
        b=AAuRsMn8EiQs6CHP5jBPxhpUEyyoZAZ8E4lHow1UREInxUA6Wboc9bh4W39FQGkRly
         qEQyrFQvhWqSkCXGXktpopR3rA6g6MScjmiPsSvCEFHsf3+GnLiErJsfJjdTrDODNxA8
         n9EtmR7Wnby7ABTJEooQ+aAl8z5eJ80i3K+AzejkLpm9Vc91Vk2noQVma0xWOmpkIYb7
         oVnGbJiiswGK/n5QA5wifKBO9nBsvkQEQXiNKQy30N7ZtI4NcivHAhVc77mvrMHdtovQ
         5vao/zewO3tyaEhJgqJ5ynMI6n4eZBdqumy+xR9HeEyvf+HJnjMrLKQd+G4WpRvP5/k8
         c1gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696797109; x=1697401909;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eO0wrsZ4W7mLGWyOWo1L1ds455g3zsEhPxWE1R/flK0=;
        b=M2Lwob6KhYjTYhEONYlah7zd4ap9t5umPg7hsNVT7xPxWmi41zrIzH9edUqz29aJPc
         LqbQSGifL9Q+HfdSu7VWFimi1HHq6nX7H0dZrMy9B9egY+hJ4CBNd5CYb86LnaET4oju
         tyNAPYvkYWjof0sXlvqIGFSXi1CnRgpJ9PeQ0pTBi+cfsZbuibPmhxXjMs6nfs/M1H3Y
         t8NiCQw6p1u6rfHYXNB9ngcHVXOAtV7tDJ3wWiRltFvwfSvpzvshqc4DQUvvKjkk2rpI
         pvxcBMxv8OUFofGyWbKF5VdUt1rBDi/fHGjEJULxHh8l918k/liPnQui0cDb7DugujAJ
         KOHA==
X-Gm-Message-State: AOJu0YyhrE+wKtwq/XZISeR/dUvEbtanqNNZeAoh+ODyWAMRBSdalSQg
        n0Xv9Bl12ciDwYlIHVLF+Ou7aEVJ4QBkmx1uPPg=
X-Google-Smtp-Source: AGHT+IHMTXJfWvMuR6oznb5qGqDLVX/IA7uJCid1OAV7BHG9/LxbKCHJUdFrpndXzyGXCLxjzqUe8AgJi/bxF+VkDPs=
X-Received: by 2002:a4a:9b0b:0:b0:57e:cc93:892d with SMTP id
 a11-20020a4a9b0b000000b0057ecc93892dmr12747411ook.3.1696797109302; Sun, 08
 Oct 2023 13:31:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5786:0:b0:4f0:1250:dd51 with HTTP; Sun, 8 Oct 2023
 13:31:48 -0700 (PDT)
In-Reply-To: <20231007203543.1377452-1-willy@infradead.org>
References: <20231007203543.1377452-1-willy@infradead.org>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Sun, 8 Oct 2023 22:31:48 +0200
Message-ID: <CAGudoHEOTXu_53Cj+6XrS6x=8ouOiiC8bRnerYg39ZjWEoGvNg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Remove the XFS mrlock
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/23, Matthew Wilcox (Oracle) <willy@infradead.org> wrote:
> I'm sympathetic to "this will warn twice and dump much the same
> information if you have lockdep enabled".  Perhaps somebody has a
> suggestion for not doing that?
>

Well the obvious idea is that lockdep could provide a macro indicating
what's up.

Then you would:
static inline void rwsem_assert_held(const struct rw_semaphore *sem)
{
        if (lockdep_works)
               lockdep_assert_held(sem);
        else
               __rwsem_assert_held(sem);
}

Am I missing something? If this is not feasible to achieve, then the
proposed routines need a comment justifying the state.

-- 
Mateusz Guzik <mjguzik gmail.com>
