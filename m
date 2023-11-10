Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88DB7E7FDF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjKJSAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235332AbjKJR7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E67ABD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:42:51 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-407da05f05aso11580735e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699598569; x=1700203369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6sAETdwuHDStPNydylggHJXqBMcNQvpufLInsKoFd0=;
        b=LFG13Qvh4C5WW4CBQo4D75kx911DJGmK6FkC37kGv9jb/2QAO4XJLiBciNE/De3IVd
         5BGQP2GzOCdULhLQvKw0rbZNLhSzPLvaAG53+xUqTRz+xPfkw6FZEVrX/7m1svpwvuD+
         haTA8cIa+pXVKFH8BtWi86oZjx6WQl7LOAZBVp5830/oSAzi9EAjJ1yq3Ck+e4Vo+fdX
         a66OiYkTi9ajVllAYfAyhSo9pZ5ly10it5L8q7muhzdtChCqJ2nugNIbRl23W1Ol83Em
         s/vMRvgrYQvc0T46DDHcKiPyX/rHkS72mtAJGupeUG2eA/hQD9s6G4nmo7KKU7cpJi8n
         xztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598569; x=1700203369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6sAETdwuHDStPNydylggHJXqBMcNQvpufLInsKoFd0=;
        b=bMD374ZFOU1hQg75+8RDU/6HWcwenSk7yEjgsRFT7tmvsKKepLF67kGjo6oyNfNMWF
         7GtpKw+0MA7AVkgoK+vyII+BOWqAAHsVqWU7y6KLo0HG04DvB+mQgEuzJO46r+3EGvCl
         oRyH/HPv0G+maLf26cp2+R2Qto3EfLBnf7haVuH84XQ4Gy1XoZBFB0awjkuNnDgiHHHd
         pB3/jVcWOYpOP/v0xcgRERBluTSAp79Eu36z95Psl99qdrCKkRPTxoqe9pr+DfOh7s+H
         fYjVHhUwEhqlxwcq19U7Ay66dglN+8UHhgmkGHgdusScQZe718+OxhAL7TSvKitnDRWx
         3WYQ==
X-Gm-Message-State: AOJu0YzAnn7+E26hn3t7Qahx3U5zGJI7KLeSMOASbZzyTkMdyk8AMYVh
        H0ayj6CRJNZphcI4tyXpjzQpKS5SuPILVZzVTTjX7exMlEz7IWMYukc=
X-Google-Smtp-Source: AGHT+IFiskVXU4f6KHS4fu76MT4C8NU0DvvVemixeUs0gO7+UD6OZvL9Om2hT/7BdlRp17/BfrmrUlL9CXx9Ip2tQFo=
X-Received: by 2002:a2e:98c7:0:b0:2c6:f3fd:7f0 with SMTP id
 s7-20020a2e98c7000000b002c6f3fd07f0mr5711888ljj.19.1699592304043; Thu, 09 Nov
 2023 20:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20231025183644.8735-1-jerry.shih@sifive.com> <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231102051639.GF1498@sol.localdomain> <39126F19-8FEB-4E18-B61D-4494B59C43A1@sifive.com>
 <20231109071623.GB1245@sol.localdomain>
In-Reply-To: <20231109071623.GB1245@sol.localdomain>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Fri, 10 Nov 2023 12:58:12 +0800
Message-ID: <CABgGipXnGVB770ZA=60rD-6Hi5Fv_wh3tST+G+VFbTmMYzz0Mw@mail.gmail.com>
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS implementations
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jerry Shih <jerry.shih@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>, palmer@dabbelt.com,
        Albert Ou <aou@eecs.berkeley.edu>, herbert@gondor.apana.org.au,
        davem@davemloft.net, greentime.hu@sifive.com,
        conor.dooley@microchip.com, guoren@kernel.org, bjorn@rivosinc.com,
        heiko@sntech.de, ardb@kernel.org, phoebe.chen@sifive.com,
        hongrong.hsu@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
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

Hi Eric,

On Thu, Nov 9, 2023 at 3:16=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> On Tue, Nov 07, 2023 at 04:53:13PM +0800, Jerry Shih wrote:
> > On Nov 2, 2023, at 13:16, Eric Biggers <ebiggers@kernel.org> wrote:
> > > On Thu, Oct 26, 2023 at 02:36:38AM +0800, Jerry Shih wrote:
> > >> +static int ecb_encrypt(struct skcipher_request *req)
> > >> +{
> > >> +  struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
> > >> +  const struct riscv64_aes_ctx *ctx =3D crypto_skcipher_ctx(tfm);
> > >> +  struct skcipher_walk walk;
> > >> +  unsigned int nbytes;
> > >> +  int err;
> > >> +
> > >> +  /* If we have error here, the `nbytes` will be zero. */
> > >> +  err =3D skcipher_walk_virt(&walk, req, false);
> > >> +  while ((nbytes =3D walk.nbytes)) {
> > >> +          kernel_vector_begin();
> > >> +          rv64i_zvkned_ecb_encrypt(walk.src.virt.addr, walk.dst.vir=
t.addr,
> > >> +                                   nbytes & AES_BLOCK_VALID_SIZE_MA=
SK,
> > >> +                                   &ctx->key);
> > >> +          kernel_vector_end();
> > >> +          err =3D skcipher_walk_done(
> > >> +                  &walk, nbytes & AES_BLOCK_REMAINING_SIZE_MASK);
> > >> +  }
> > >> +
> > >> +  return err;
> > >> +}
> > >
> > > There's no fallback for !crypto_simd_usable() here.  I really like it=
 this way.
> > > However, for it to work (for skciphers and aeads), RISC-V needs to al=
low the
> > > vector registers to be used in softirq context.  Is that already the =
case?
> >
> > The kernel-mode-vector could be enabled in softirq, but we don't have n=
esting
> > vector contexts. Will we have the case that kernel needs to jump to sof=
tirq for
> > encryptions during the regular crypto function? If yes, we need to have=
 fallbacks
> > for all algorithms.
>
> Are you asking what happens if a softirq is taken while the CPU is betwee=
n
> kernel_vector_begin() and kernel_vector_end()?  I think that needs to be
> prevented by making kernel_vector_begin() and kernel_vector_end() disable=
 and
> re-enable softirqs, like what kernel_neon_begin() and kernel_neon_end() d=
o on
> arm64.  Refer to commit 13150149aa6ded which implemented that behavior on=
 arm64.

Yes, if making Vector available to softirq context is a must, then it
is reasonable to call local_bh_disable() in kernel_vector_begin().
However, softirq would not be the only user for Vector and disabling
it may cause extra latencies. Meanwhile, simply disabling bh in
kernel_vector_begin() will conflict with the patch[1] that takes an
approach to run Preemptible Vector. Though it is not clear yet on
whether we should run Vector without turning off preemption, I have
tested running preemptible Vector and observed some latency
improvements without sacrificing throughput. We will have a discussion
on LPC2023[2] and it'd be great if you could join or continue to
discuss it here.

Approaches can be done such as nesting, if running Vector in softirq
is required. Since it requires extra save/restore on nesting, I think
we should run some tests to get more performance (latency/throughput)
figure let the result decide the final direction. For example, we
could run Vector in either nesting with preempt-V and  non-nesting
without preempt-V and compare the following performance catachristics:
 - System-wide latency impact
 - Latency and throughput of softirq-Vector itself

>
> - Eric

 - [1] https://lore.kernel.org/all/20231019154552.23351-6-andy.chiu@sifive.=
com/
 - [2] https://lpc.events/event/17/contributions/1474/

Regard,
Andy
