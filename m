Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FBA7697C1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjGaNgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjGaNgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:36:01 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A0B1708;
        Mon, 31 Jul 2023 06:35:56 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d09ba80fbcaso4675013276.2;
        Mon, 31 Jul 2023 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690810555; x=1691415355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAyXH6ekoTa05SAgzmQb3wllKwSfvfzCrLBBn4jkkW4=;
        b=gLyC++uMA73NEwRZEkud6ZUJY1Dsimw7XhAv41TwiKC98Ik61qftRevUzwfUiCxVuh
         3uiAbaiSuFE3ZrDVAso6i83lCKnNJ+FPzNkyVtSgjHfQuoGXYydiYmckIJwB5OfK2reR
         Pb/ym26WIkf73+Jgbx8ZvnV6cQU6id7zSxbjIZ9J584vqeqvMDGbk7CdMrtKp2LdVAx+
         /1Ey3DbxGLl4U2VVP0YYA9XL79GU50m5t/jyuaca5rfNmOP1DYjW5RCNVUo4QUPNoi4p
         DY6ghdxqzyynDLBHa49ou/WG4Q/DI01xGlCKNv3htUCiMk0QXakVvdWP6f5gVqx6O9Gq
         x7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690810555; x=1691415355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAyXH6ekoTa05SAgzmQb3wllKwSfvfzCrLBBn4jkkW4=;
        b=kjmaaDsSoJS6xiBmRZMIpu53NaUsr+kbubPhYDT9JVt3aNc7xsNHVdW51XwGP4msfp
         AbO+QHNLIA3p83MjYHQLNx5ipnhepZHQs1jDdogdf4kLaAoZ5weCzJ4PJd2WbvLBoyuQ
         PD/ze1ywR3Z8XMftJj/Jt7860Zw9YHu53xLe+G0VF2A3z+WutpffY+8c9uvg7Upspp8v
         p+Zd9fYJLKNvgYAtjWnn3f7TRFBFHZEeuce752LvshQVEmhEa7JHPfoyW+4lsb5JrEBR
         JVLfQ/m3Mp+YNxtuYu2A+NJykkDivwVDA7GV8HKc0zHwR1cHFxLbSlqZGZk6V4Ep0HMr
         XANg==
X-Gm-Message-State: ABy/qLYxp1SPB37NA2iCO99Cfk4oHZcpJawpbHpRnSIMrp5Mxsal8S3X
        D4t/o1xgirPX7UeyaNwkIG95ytV3JtYl2lYXrqo=
X-Google-Smtp-Source: APBJJlHlKQxquau9vHbub3enl9P4TMStwyjPMWusF11iwrzgObp/yDS37tRQeizN7EUqGRl1cyuLrJAbgaz0DyI7iTQ=
X-Received: by 2002:a25:ce04:0:b0:d0c:9ab2:72d3 with SMTP id
 x4-20020a25ce04000000b00d0c9ab272d3mr9716417ybe.14.1690810555377; Mon, 31 Jul
 2023 06:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmStPqBhubxyk_A@mail.gmail.com>
 <97730.1690408399@warthog.procyon.org.uk> <yt9dbkfxsxtl.fsf@linux.ibm.com>
In-Reply-To: <yt9dbkfxsxtl.fsf@linux.ibm.com>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Mon, 31 Jul 2023 15:35:44 +0200
Message-ID: <CAAUqJDvk0y4x=fzfe8GX_t7Qj4WcRBfTOK2Za718wki9h-XkjA@mail.gmail.com>
Subject: Re: [PATCH] crypto: Fix missing initialisation affecting gcm-aes-s390
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paolo Abeni <pabeni@redhat.com>,
        Harald Freudenberger <freude@linux.vnet.ibm.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev,
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

On Thu, Jul 27, 2023 at 7:55=E2=80=AFAM Sven Schnelle <svens@linux.ibm.com>=
 wrote:
>
> David Howells <dhowells@redhat.com> writes:
>
> >
> > Fix af_alg_alloc_areq() to initialise areq->first_rsgl.sgl.sgt.sgl to p=
oint
> > to the scatterlist array in areq->first_rsgl.sgl.sgl.
> >
> > Without this, the gcm-aes-s390 driver will oops when it tries to do
> > gcm_walk_start() on req->dst because req->dst is set to the value of
> > areq->first_rsgl.sgl.sgl by _aead_recvmsg() calling
> > aead_request_set_crypt().
> >
> > The problem comes if an empty ciphertext is passed: the loop in
> > af_alg_get_rsgl() just passes straight out and doesn't set areq->first_=
rsgl
> > up.
> >
> > This isn't a problem on x86_64 using gcmaes_crypt_by_sg() because, as f=
ar
> > as I can tell, that ignores req->dst and only uses req->src[*].
> >
> > [*] Is this a bug in aesni-intel_glue.c?
> >
> > The s390x oops looks something like:
> >
> >  Unable to handle kernel pointer dereference in virtual kernel address =
space
> >  Failing address: 0000000a00000000 TEID: 0000000a00000803
> >  Fault in home space mode while using kernel ASCE.
> >  AS:00000000a43a0007 R3:0000000000000024
> >  Oops: 003b ilc:2 [#1] SMP
> >  ...
> >  Call Trace:
> >   [<000003ff7fc3d47e>] gcm_walk_start+0x16/0x28 [aes_s390]
> >   [<00000000a2a342f2>] crypto_aead_decrypt+0x9a/0xb8
> >   [<00000000a2a60888>] aead_recvmsg+0x478/0x698
> >   [<00000000a2e519a0>] sock_recvmsg+0x70/0xb0
> >   [<00000000a2e51a56>] sock_read_iter+0x76/0xa0
> >   [<00000000a273e066>] vfs_read+0x26e/0x2a8
> >   [<00000000a273e8c4>] ksys_read+0xbc/0x100
> >   [<00000000a311d808>] __do_syscall+0x1d0/0x1f8
> >   [<00000000a312ff30>] system_call+0x70/0x98
> >  Last Breaking-Event-Address:
> >   [<000003ff7fc3e6b4>] gcm_aes_crypt+0x104/0xa68 [aes_s390]
> >
> > Fixes: c1abe6f570af ("crypto: af_alg: Use extract_iter_to_sg() to creat=
e scatterlists")
> > Reported-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
> > Link: https://lore.kernel.org/r/CAAUqJDuRkHE8fPgZJGaKjUjd3QfGwzfumuJBmS=
tPqBhubxyk_A@mail.gmail.com/
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: Herbert Xu <herbert@gondor.apana.org.au>
> > cc: Sven Schnelle <svens@linux.ibm.com>
> > cc: Harald Freudenberger <freude@linux.vnet.ibm.com>
> > cc: "David S. Miller" <davem@davemloft.net>
> > cc: Paolo Abeni <pabeni@redhat.com>
> > cc: linux-crypto@vger.kernel.org
> > cc: linux-s390@vger.kernel.org
> > cc: regressions@lists.linux.dev
> > ---
> >  crypto/af_alg.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/crypto/af_alg.c b/crypto/af_alg.c
> > index 06b15b9f661c..9ee8575d3b1a 100644
> > --- a/crypto/af_alg.c
> > +++ b/crypto/af_alg.c
> > @@ -1192,6 +1192,7 @@ struct af_alg_async_req *af_alg_alloc_areq(struct=
 sock *sk,
> >
> >       areq->areqlen =3D areqlen;
> >       areq->sk =3D sk;
> > +     areq->first_rsgl.sgl.sgt.sgl =3D areq->first_rsgl.sgl.sgl;
> >       areq->last_rsgl =3D NULL;
> >       INIT_LIST_HEAD(&areq->rsgl_list);
> >       areq->tsgl =3D NULL;
>
> Just tested, with this fix the kernel no longer crashes. Thanks!
>
> Tested-by: Sven Schnelle <svens@linux.ibm.com>

Same here. Thanks for the fix!

Tested-by: Ondrej Mosn=C3=A1=C4=8Dek <omosnacek@gmail.com>
