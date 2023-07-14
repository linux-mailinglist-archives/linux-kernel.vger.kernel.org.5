Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903D8753E50
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbjGNPC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbjGNPC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:02:26 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E80F3AB1;
        Fri, 14 Jul 2023 08:02:06 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-c7a5600d04dso1932730276.3;
        Fri, 14 Jul 2023 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689346925; x=1691938925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZZ9EOh8YDl35VB0YBYDo9hjgSAIvlerdtM+lWHSm5g=;
        b=JTzzYDbIAeBHNT3Mk2cmNycCC3b97HGw6Wa6P0kp0mxr2C0KJFDPLSxJq8Pd6EzUUh
         bIjQvzVXcsD1bkZFQ3umgFq9TqY3tY8Vprh3ciL/qkwidOnt0es1ZnABBhViELmcW8yE
         7hdoifxju13ojhAoxCW+wwfWHB4F/2wrVUxW2PJQxG+IMSqKaI+ydKOWklkKQA4Wto5C
         rogJtvx1NQYCG44jC1GrVj0i//rc8q1aYevxx9mKh/QMzrQE31PClFfhAFpn5qJoA6/B
         PFHvMyG72+PLz7aLqg3R3/vCyN/mdmHx0ftxLv9lQP4Bawm7+5d8f4tAFt0fKL0pnrXL
         xAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689346925; x=1691938925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZZ9EOh8YDl35VB0YBYDo9hjgSAIvlerdtM+lWHSm5g=;
        b=PxMj2tMt/UKeITmp5r8EnLseSb+7IYXMhiRmeRfDW0actOv8WF30os3MmwCSyZeIv3
         fFQyetMZ+tNYWD+v/AGnq0CEgBpQ7cRGMFhuLOt126IOhX9TP1rN/sH4eD07W5IoGR9y
         e1MVGd44f70IgqQsXRXniyjnpuZ3XFKMRxGvnl0S1z4LDRsDgeVqjTeabfvmkemN/jel
         3bJ4UAoSZRzH3nvPtAKxxZ6CrZZDouyKGB6if/4Rx/qOzqoBCSYGsTyFJxdQIjxns6a+
         1npIPfO0oj8LjfXzrW3N+CNIXsgtdaMs3qFiHF9J6jQPPUy/Nsvm4LBA4ndpSr0i6+Ya
         FCQw==
X-Gm-Message-State: ABy/qLa08wVdTttKyRLBSHOVuVcX+KRANvU2t/o/OWEcCLK6SbHV6NV2
        diMDIzhiYzDp/Lv8ZKgRewN+7/kXZft643SQfLE=
X-Google-Smtp-Source: APBJJlERpcU28hgT0T3bIglk0iGT0bmn1uOnaSOpkfR/IyTnKpYwVO97D+A/LlLF6zHeeOjIm0fNWn+04UB37NV0GbY=
X-Received: by 2002:a25:c0c8:0:b0:c4f:43d7:7daf with SMTP id
 c191-20020a25c0c8000000b00c4f43d77dafmr4055869ybf.1.1689346925288; Fri, 14
 Jul 2023 08:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDJoNv1HW-5uCj21PX3t23rJ+sbTL4Gm5pDis8HGJ-VTr4dug@mail.gmail.com>
 <20230714140201.383439-1-aliceryhl@google.com>
In-Reply-To: <20230714140201.383439-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Jul 2023 17:01:53 +0200
Message-ID: <CANiq72n8-b992D4RbwUtuEUxXfJYQLNwfibgWSyspx-HYJ8+8A@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: str: Implement Debug for CString
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     ariel.miculas@gmail.com, alex.gaynor@gmail.com,
        asahi@lists.linux.dev, benno.lossin@proton.me,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        lina@asahilina.net, linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 4:02=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Adding some sort of motivation usually works quite well, e.g.:
>
> Make it possible to use a CString with the `pr_*` macros directly, that
> is, instead of
>
>         pr_debug!("trying to open {:?}\n", &*filename);
>
> we can now write
>
>         pr_debug!("trying to open {:?}\n", filename);

Indeed, this would be the most important bit, i.e. answering the "why?".

The "what?" and the "how?" are pretty much explained by the title, but
it is also fine giving more details (but if the implementation
requires an explanation, then it is usually best to write an actual
source code comment instead).

Cheers,
Miguel
