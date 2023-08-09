Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7262A7765AE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjHIQzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbjHIQzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:55:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8CE2100
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 09:55:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98377c5d53eso12654566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 09:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1691600113; x=1692204913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sEEzkpRk4R5ngJk0sdsY4jksrqnBMmsAjfH4cPZ0Ceo=;
        b=LXifjXMjDkY+9vzyXyHF446KTFEVUBCGm6SxFbnjl7ZrDNlY8xnmabEJVxUW+ush49
         KKTZgh4/nppv9HRYHadUjsFyw9RkxQOq/WYrOfj40CU1EJmV4qLnVT7Fpbp1G3xyg2fg
         zVqg5l9IodUOMREAVjo0vXijlwzjHBQA0wc0IWOklIJ8xy95jxtpJkoZvFOJB1AhDlEE
         8yQb/0zN3SLbB54vF7iBeSO7+HaQszGc6LK35twMKAIV0gwa+L4NPOQr+nfUGIkvZbpE
         lTIBmsDwhaoOWEVeDVVn9FsSV6LTT5lELwKU13KV5VSCwyHi9BXIY5r0CWNQscVo3R7D
         VHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691600113; x=1692204913;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEEzkpRk4R5ngJk0sdsY4jksrqnBMmsAjfH4cPZ0Ceo=;
        b=DOYF+vB+BudpgHMTO3i3mlhIbvBXIgdkOfk/8QPNLpTXb8MgMbadE8S7Tt4CcF0HA6
         c+8Eln0q4JiU1lU3pR0M9bPTzyEjewnmNGupPQT+p+gQuqwPkd5QzXG+CYaLmLLSMyxL
         EPxLnnrq1+G5BVlfkpuAX7NTBEojUbEYpD+AkV+gQCiOIabxQcGwo+nnE5VjvSGCODuo
         AssfJk3ccnWjHRj+B5/KX+AecgZbhszC5Ch84U1HOq2fJRJ1f8V0CCr2XyiKzpOIAb/j
         4LMZU1A6Ric7kmFoaW6JucMdt9Yltu89KEdTpT5wQJjsAYw8TFej4z5cqs82IkDJBJ6h
         tCOQ==
X-Gm-Message-State: AOJu0Yz10+PbEd/n4A0cNqT2g6yfyJWw5X2nlEEtkSPDz5EMzV9vwxov
        VliMpJ8kpGpFxWMhH8XTntDMR93qBRzWixz1QJOvPw==
X-Google-Smtp-Source: AGHT+IF7dM2eXGn6dRXYNXBc36kPTeydH1cLQHZ69WdeM57HrUxewNW65BPbYowzY8vRF7JfnkGpiq0tLQV/ExDslXY=
X-Received: by 2002:a17:907:78d9:b0:974:183a:54b6 with SMTP id
 kv25-20020a17090778d900b00974183a54b6mr2328010ejc.33.1691600113512; Wed, 09
 Aug 2023 09:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+4W8hMpL3+vNOrBBRw01tD6OxQ-Yy8OWpq9nRtiyjm0GgE4g@mail.gmail.com>
 <20230809155538.67000-1-kuniyu@amazon.com>
In-Reply-To: <20230809155538.67000-1-kuniyu@amazon.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 9 Aug 2023 17:55:02 +0100
Message-ID: <CAN+4W8h44UdLRT+QLdh2rNeiKg0AkPAuGtYuXOgtFzvT2kHsWg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] net: Fix slab-out-of-bounds in inet[6]_steal_sock
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, martin.lau@linux.dev, memxor@gmail.com,
        netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 9, 2023 at 4:56=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.com=
> wrote:
>
> > Things we could do if necessary:
> > 1. Reset the flag in inet_csk_clone_lock like we do for SOCK_RCU_FREE
>
> I think we can't do this as sk_reuseport is inherited to twsk and used
> in inet_bind_conflict().

Ok, so what kind of state does reuseport carry in the various states then?

TCP_LISTEN: sk_reuseport && sk_reuseport_cb
TCP_ESTABLISHED: sk_reuseport && !sk_reuseport_cb
TCP_TIME_WAIT: sk_reuseport && !sk_reuseport_cb

Where is sk_reuseport_cb cleared? On clone? Or not at all?

> > 2. Duplicate the cb check into inet[6]_steal_sock
>
> or 3. Add sk_fullsock() test ?

I guess this would be in addition to the convoluted series of checks
I've removed in this patch?
