Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6711981243A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 02:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442912AbjLNBCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 20:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjLNBCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 20:02:39 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BE7DD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:02:45 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b35d476d61so276471039f.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 17:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702515765; x=1703120565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZ6SgAfQDssvTRivplz0l7pRVMGZobusTs3WBzsEAKc=;
        b=hpHCQeizWB/MvpXmE9WPd+m80FOpR2TZQHIv/8YZ8UPYE1ZPpmZ7AGdOx3fDsipFDO
         HRAJi+wlE5K8jiA54G35URleXoGfNfZ1cYcsGwlHtEOmSt4qF7GlWqbWhcjtFE5xW8UV
         q21u3S+DbU/yoqyq03hb4ycMLkI7QCuwtoIVXng4TPxqsKKAeqPLExUVM6j5szPZ+7W4
         KD9gnyOqY0SxcXJGjepq/DLM0P50nSvutBi656CtCAvYAKTStGTR8RN1uVWaj30c57aa
         e+nQN1I9ZCyABSUoMKIaLMHEe9UuPLqijMWCKpvBhgnQia+hHX5+5wLFoQyHhCEsOTYQ
         Q+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515765; x=1703120565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RZ6SgAfQDssvTRivplz0l7pRVMGZobusTs3WBzsEAKc=;
        b=MtSnjhpV0N6XtdwpmGjq1OkIws8nCUUhrMLO36fQr91FK/ekarAXkOsGIe5foCY0+4
         gCzqhVn5Fvu2AODDR3Szk4frSn/fuaErlHYn2lFrjz9CLvrYxWUaOz6k8r8zQ7K21mCE
         Nnf/tVmMTqqADbAcgbT64U8f3hY6sHA9lzn4qKuKp9sAfu9TkvtqMgxcp9jZ7BQ0jaT3
         2jvVFzO1LGANoug515n+GyW5JYkQ/HZZqgLHXQskJCnTHvoX6nYwvtIJ+FZcDTybi3ev
         xFh7fl4BE+8LD2jlb/yL0vbRAl9Usbi2VPWhSedEGFqLG8ocv2e3F4aXuLptaAbfvElo
         2YEg==
X-Gm-Message-State: AOJu0Yw3tjStPeIybhQHvLHJyeMTifQBUb80g900Qj9n3fneEX3lhuUn
        pUCHjvOELQNo869fjm/vJ/h/q6lqPKPZP8JwwIE=
X-Google-Smtp-Source: AGHT+IHWmoCA4THjQRHrrC/9ogkEBXNXJvVqqrh+4U8P4uFRpSlNkRN7KDO/bEVfLjAPgTG7zwEQ0Yi2ZmcR7fw1AEQ=
X-Received: by 2002:a6b:7302:0:b0:7b3:f062:7267 with SMTP id
 e2-20020a6b7302000000b007b3f0627267mr9926597ioh.21.1702515765286; Wed, 13 Dec
 2023 17:02:45 -0800 (PST)
MIME-Version: 1.0
References: <20231211052850.3513230-1-debug.penguin32@gmail.com>
 <CAKEwX=MzkBt1F2WZaacuCQ+E6eWt1AKvbGZ6JFHy5tkoYigqQg@mail.gmail.com>
 <CALk6Uxog_LLF2dec2J54baMfee8jCOEabjWLG6-L=FEyZ-FFBQ@mail.gmail.com> <CAKEwX=OwFk7aL-PGE4JBR0qy5NzbDbSmPGyu8yd7FK+yU8mRBg@mail.gmail.com>
In-Reply-To: <CAKEwX=OwFk7aL-PGE4JBR0qy5NzbDbSmPGyu8yd7FK+yU8mRBg@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 13 Dec 2023 17:02:34 -0800
Message-ID: <CAKEwX=O2E5LUCMi+x_7Yh=wO+Ot-YNs4j+cxbtTgS_-aU7Kq7g@mail.gmail.com>
Subject: Re: [PATCH] mm/zswap: Improve with alloc_workqueue() call
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     sjenning@redhat.com, akpm@linux-foundation.org,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 4:28=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> concurrency limitation. Also, in practice, the task_struct is
/s/task/work.
I was looking at some articles about tasks recently, so my brain just
auto-completed. I was referring to pool->shrink_work here.
