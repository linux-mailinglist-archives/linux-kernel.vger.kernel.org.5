Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D1576B19C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjHAKT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 06:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbjHAKSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 06:18:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438832D76
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 03:16:43 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40c72caec5cso260551cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 03:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690884994; x=1691489794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZN9Ev39oJk78sdD2xFuDOdMnPsbmSFEY0jGkX/TZfs=;
        b=73nIOlxPptDV21sESWCVMAR6SLbm5k0LKaJiE3ztg54DmwekJLjblbGBqzm3h09QHu
         AcWJk4qzGieKWCBWLUremGY0iLXzASSMapZ+ZaDzkS1QkzfpTFlRVJR7dwDBrxR3ZFvJ
         Ayq7XHl9VVuT1b1B0GCU7vv6BOqPiXRFbnpvUC37LxYz2afVSi4xkasF8rxGFDVJfHpK
         XU09LcibSGYjS+FHcB6FeQKd+mqS/i29Kud5Dt8MaQX6gYpJk16rSOjk7CpNo40Mv8Wy
         oet01eHTcf7iSo8CQF7LMVoKKHW3uRnbv5YnCdi5znln1GS2hMvU8q0ZlF1T7rDMEIZl
         kb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690884994; x=1691489794;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZN9Ev39oJk78sdD2xFuDOdMnPsbmSFEY0jGkX/TZfs=;
        b=LG+EKJNXzzFss9UDR7D0BMkK87qkjyF8l1wSHPIEMVvEnpm3lygLc+d6vDduWnEAdU
         4+h6grfvb3qeNkAnmEGu2KL61uNSw4AZGwjC6SMxJdMQsmuwlMX7c+75QJgLVBs4PGwf
         UnQG/waGZsI0b1Ewo2Ph4w85YHFn1ua63Ycr7f6qJYbiFjHP7pImj5GSNB7x5/ThxThf
         RwV04VigoBgX5DsvN9YTSYlj6Pez0mYIzkFtv7YmuZSwC5P73Gp1bJWCcwY/KHdETKLR
         IotwqdcywkVeUFuy9d0IFODYuGCMI5d1iP/AxOOiQgpcDGX1oq4nCgXJCRa4q3cIAk11
         exVw==
X-Gm-Message-State: ABy/qLbn6VbTQUyTDNQNsRycz8hlnUBjZZQCgIwfek8KjnQxXBYrEq8r
        T+/kLjgKZCM9WoA31NX36UDGdP3eNg5mNigFsKjfiQ==
X-Google-Smtp-Source: APBJJlHkfcuesWAMGBbcUdF5JPr/MxcZAjwXVj1t5i3BfLfeO0MddaAxywCAexaR5x9uibEQV/Y/qpX2KAXoZIKo3vI=
X-Received: by 2002:a05:622a:1493:b0:404:8218:83da with SMTP id
 t19-20020a05622a149300b00404821883damr731987qtx.1.1690884994354; Tue, 01 Aug
 2023 03:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230731230736.109216-1-trdgn@amazon.com> <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
In-Reply-To: <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 1 Aug 2023 12:16:23 +0200
Message-ID: <CANn89iLghUDUSbNv-QOgyJ4dv5DhXGL60caeuVMnHW4HZQVJmg@mail.gmail.com>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet header
To:     Tahsin Erdogan <trdgn@amazon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 11:37=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Tue, Aug 1, 2023 at 1:07=E2=80=AFAM Tahsin Erdogan <trdgn@amazon.com> =
wrote:
> >
> > When GSO is not enabled and a packet is transmitted via writev(), all
> > payload is treated as header which requires a contiguous memory allocat=
ion.
> > This allocation request is harder to satisfy, and may even fail if ther=
e is
> > enough fragmentation.
> >
> > Note that sendmsg() code path limits the linear copy length, so this ch=
ange
> > makes writev() and sendmsg() more consistent.
> >
> > Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
> > ---
>
> I will have to tweak one existing packetdrill test, nothing major.
>
> Tested-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

I have to take this back, sorry.

We need to change alloc_skb_with_frags() and tun.c to attempt
high-order allocations,
otherwise tun users sending very large buffers will regress.
(Even if this _could_ fail as you pointed out if memory is tight/fragmented=
)

I am working to make the change in alloc_skb_with_frags() and in tun,
we can apply your patch after this prereq.
