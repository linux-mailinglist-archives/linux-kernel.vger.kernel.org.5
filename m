Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E84A7BDA2F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 13:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346227AbjJILl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 07:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346203AbjJILl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 07:41:27 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D23899
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 04:41:26 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-65b02e42399so27844746d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696851685; x=1697456485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8Ea6TW7T9MLSMJpTNywUDmHSrDqthlTo8veDLZhSMo=;
        b=4iGheH3YMPxn4SELOp2nQP6Vxcg3Er9m/K7Fz1kHcAYbquERgn2lv4Q/H7Mpz2dF0h
         GkALY8DG4qMav8VZsOZY9vVG3tIvMi+hiF1lgNbKhWixrBy3KdwP+0fJg9RlmKZKWg2x
         SiFN6WWqn4+8TJfIZG2kUDLe9WO6dWsdjHFF9YnTLH+X5DU1q4CUJgV9ACWViubhXLm9
         Z6caJAJuXN3gp9hO2fGo1BaZpVueqtEloRfAdFtCd6jOEigA/3v25dLxLfTpC+NMzpGh
         CAf0chVzJSW7+/hNiP0P0AG3+uT72DrOwfjSx9xj3HDriLv3tOviHwDR1SlpP4J21OpH
         YjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696851685; x=1697456485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8Ea6TW7T9MLSMJpTNywUDmHSrDqthlTo8veDLZhSMo=;
        b=EDIqPH2WFigLNcZsXm5YGh1TOLGl+Ofm/ddTBWrhAkX26lesF/hLzPaKLOWxJt8i1e
         PXG3iF6ZDmTcbEnmhusE5hjbJ8mjnNy453tg5Zq6fPXcQ32Wwg37Ih61gwA9Zgse3eto
         pxZ8IU6bX6FxzTnE4NgliFSywfQZqccNWCTMm7rHn4a4WiSin+87Hah9YIYxupQ3mwZh
         aY4/zxEc94a1gKY0++rA3gwUXH3du9QcvF5hk5/gK+dOG32UpFmrzZ7gJuQqdgR+Ri2D
         A9d1FU79Kz0EuBofKKWrtTWxJvhJW3fuNAs/z2ZNNFH44dJJ24DMGALL9KInvj0Pr6rJ
         kCGg==
X-Gm-Message-State: AOJu0YyGXDgIPwPMv826yj5goIqzzYlChehyu2f8o30/3lIw91Z6c0Cv
        WkAFJerTy/9Jnq8j6WeVx5hvWb5TFyk/NQYsjchiHQ==
X-Google-Smtp-Source: AGHT+IGUdqL8uNX6vXwIwICTF/FsZDJtG9CPVvgCWeEyjaaMwckc79PtrbUFKNuFjQa/eSgSSebjnMQPIE+TbH5Uceo=
X-Received: by 2002:ad4:4d92:0:b0:668:da55:6c17 with SMTP id
 cv18-20020ad44d92000000b00668da556c17mr14592159qvb.49.1696851685150; Mon, 09
 Oct 2023 04:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <c15b94412d146957c8be423c8dc1d3b66f659709.1694625260.git.andreyknvl@google.com>
In-Reply-To: <c15b94412d146957c8be423c8dc1d3b66f659709.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 13:40:45 +0200
Message-ID: <CAG_fn=WLgOq_dAK7pHro0DkyaLY7juCyHhLgKwxbbwUp=qgOKw@mail.gmail.com>
Subject: Re: [PATCH v2 15/19] lib/stackdepot: add refcount for records
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 7:17=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Add a reference counter for how many times a stack records has been added
> to stack depot.
>
> Add a new STACK_DEPOT_FLAG_GET flag to stack_depot_save_flags that
> instructs the stack depot to increment the refcount.
>
> Do not yet decrement the refcount; this is implemented in one of the
> following patches.
>
> Do not yet enable any users to use the flag to avoid overflowing the
> refcount.
>
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
