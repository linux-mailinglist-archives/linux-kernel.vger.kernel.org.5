Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247227E9590
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjKMDgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKMDgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:36:40 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C94FC2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:36:36 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d9a58f5f33dso3898400276.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1699846595; x=1700451395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GJmOyC7dj1ImgyOrqYv2p5YXSbSzd12oTHJ212zpro=;
        b=fkCBvdwpCUxKRum/myqn9PoWW3gHgAF07k/Z5s+14Eo32OZbBxHW/CwHaHED/5sbMw
         u1sJUAP/4+w9jtaYLixyXwdNMymejr5BgzGKGCM8k/e15V6h0MSXEInFruAGpLQeJl5u
         A1NlRuFd4MMcufwUiEoYLP6XH5QRPNu51LkR3d/DQZTqOzStFqsaeB5vJfLODESTOOM2
         uOgAlY+oNvQuXSt0MjwH4rLmeQGhYWU/m6ASpyUAgvcZX9OhxY6l8zHClCriQ9pIH1DS
         nsk5HYrfFyqEdLLG4TwAYKS/VlzPF11wfzZGmWYBEVOVWvnv52PobHIgns6coOHlyX6D
         fg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699846595; x=1700451395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GJmOyC7dj1ImgyOrqYv2p5YXSbSzd12oTHJ212zpro=;
        b=sku5HelP/CwYIiYsVOrmqCdw0ATu7sqEZ9SmOxUiZmeESrDwFQZBqQYzNBcuysyOr+
         1zawZ5rpDHxD+3frQivJIk7bqd8L4CtJCfEujovL8tBMwBX3Sr4ntO2oi8TUigALfnLf
         1Z6nHBwgv2fw2/2a+rKDGSrTEpjCI6y/GxzlTxorMMcO2RFmerzbGc/hGy/rW+/ty+/s
         3IA1LWn14u98wEkhMaKDtn5zv6dpZuZA62Y62UdKBi+uFM7ndLmkFVv5TTw4B+8NsSqv
         dRESdelSHqcrj9bKRsMYuu0eqXlzZbgdipf+EUJ6HhUI0gn0rAGhXAq5JbQ3a0aw/mxe
         4qMQ==
X-Gm-Message-State: AOJu0YzHmRXCUemBwkTpnqSYnnQYCw2Wj8C89kLtNN36mubv0DJg47ih
        Hiu3zxAeCIJFVCQRARXMJi+d2zn2GXKZNJFKzyUm
X-Google-Smtp-Source: AGHT+IHHTmKxnEkC0RC2JDbWYjvkSSGIvuWoFDdAwa+RNPCR7iXTCqXKnmOhpLla/t8T9O2ppI2jdTf+GCVFtddvLQw=
X-Received: by 2002:a25:3489:0:b0:da1:2a2b:4c5b with SMTP id
 b131-20020a253489000000b00da12a2b4c5bmr4277026yba.41.1699846595296; Sun, 12
 Nov 2023 19:36:35 -0800 (PST)
MIME-Version: 1.0
References: <20231018092351.195715-1-chris.riches@nutanix.com> <c5f6bd1dee4ad9b43fc8c9dc1c7645b3.paul@paul-moore.com>
In-Reply-To: <c5f6bd1dee4ad9b43fc8c9dc1c7645b3.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 12 Nov 2023 22:36:24 -0500
Message-ID: <CAHC9VhQryMhepfZwoVmb6Svs7uq9vJ-oa0S7Lc6v7jyhiGvm_g@mail.gmail.com>
Subject: Re: [PATCH v2] audit: Send netlink ACK before setting connection in auditd_set
To:     Chris Riches <chris.riches@nutanix.com>
Cc:     audit@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 6:31=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Oct 18, 2023 Paul Moore <paul@paul-moore.com> wrote:
> >
> > When auditd_set sets the auditd_conn pointer, audit messages can
> > immediately be put on the socket by other kernel threads. If the backlo=
g
> > is large or the rate is high, this can immediately fill the socket
> > buffer. If the audit daemon requested an ACK for this operation, a full
> > socket buffer causes the ACK to get dropped, also setting ENOBUFS on th=
e
> > socket.
> >
> > To avoid this race and ensure ACKs get through, fast-track the ACK in
> > this specific case to ensure it is sent before auditd_conn is set.
> >
> > Signed-off-by: Chris Riches <chris.riches@nutanix.com>
> > ---
> >
> > > I'm happier with the bool over the integer type for the @ack variable=
.
> > > I'd suggest updating the patch and posting it again so we can review
> > > it in full, but we weren't very far off last time so I think it shoul=
d
> > > be close, if not acceptable on the next revision.
> >
> > Here's the latest iteration of the suggested patch. I've done it via gi=
t
> > send-email so it should apply cleanly.
> >
> >  kernel/audit.c | 31 ++++++++++++++++++++++++-------
> >  1 file changed, 24 insertions(+), 7 deletions(-)
>
> This looks good to me, thanks for your patience and persistence Chris.
>
> I'm going to merge this into audit/dev-staging now and it will move to
> audit/dev once v6.7-rc1 is released and the merge window closes.

I've now merged this into lsm/dev, thanks again Chris.

--=20
paul-moore.com
