Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2557777C206
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbjHNVCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232879AbjHNVBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:01:40 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BCE199F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:01:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-26b4cf4f7b9so1019381a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1692046873; x=1692651673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnOqfXebl5dRNUljflWYEjtYdatKhTnC4hi2EDyy3rE=;
        b=f+mEmzgNuQSxLlf1UxAtmo6Xr2Chh74/KT2SGtB4Uyic5HM7yZZU1RBC10Kl8xqQ/W
         02J31pTYLLLGXokaE7rm/p7zFgPiBbeXCfyrNz8Jna9t2q9JeLKRFoK53nF241hyOkoo
         0ckUDmz5DEwchQ+H5W4az68Ntwo/6ZvAPVhTPHVedPrVYIF6g5ZykgeS8IsgvPInsL6N
         Yfte/JwM7v0eODQ/sucspVhNQbDL/F6r/HywLGUEiKXCOdOAvCfmEkAs+ptoQUSCoDoP
         U2/B0a/Kq+5r/Yom0IqKkkVvB8pdgl6JMsV/fExMwTYhdsGmQs1ahycGJl2W/EX0C7Ue
         z6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692046873; x=1692651673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnOqfXebl5dRNUljflWYEjtYdatKhTnC4hi2EDyy3rE=;
        b=Bn/C2MJss+FbqQqXpDLlyZEF96J5676xrpWCRQOD8r8pk5e87fVFzCEr+gWdGNJ18Q
         yHHzAOFg94nLRisdLXV9f8voATEIL/SYeCj7ViNG164giP1g7nifLv7ZEfFaXIvpwy2y
         wnXc+In8mXU5epBMgzUv4av8aiyG7CRdBI6ev1dfDR0tYNEUksyOzA8/E/tLC4Qnc/+w
         cTczHQq6h4UcU7Q5VpRweYI4LXSYWgBRS9rPbuQQASa45EralULlO/I5RXI9THSyJZix
         2I9LhHbQxJ+Qd/Yoq/6Lw87MVB1irWRCcWL7rWAanAVQtihg2wb+ufTYgPaR4iFzmBkA
         BkCw==
X-Gm-Message-State: AOJu0Ywdw86eXJsvva+Ec6a5nFzDGt55EHoJd1yhzAR+Z/jdpscIf1D+
        RWFiF/S1jWcZz3P01eAXYkhP7g==
X-Google-Smtp-Source: AGHT+IHKNceQUmeAFhyH23LTGWMQK0GUOJmI4GMnK7wvaQ5bf2A5drLHyKcLWNJ7Ia+S/WbNSTQ+Yw==
X-Received: by 2002:a17:90a:e584:b0:267:f758:15d4 with SMTP id g4-20020a17090ae58400b00267f75815d4mr6835511pjz.48.1692046872860;
        Mon, 14 Aug 2023 14:01:12 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id gk18-20020a17090b119200b00263ba6a248bsm10469478pjb.1.2023.08.14.14.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:01:12 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:01:10 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     =?UTF-8?B?RnJhbsOnb2lz?= Michel <francois.michel@uclouvain.be>
Cc:     Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] [PATCH 2/3] netem: allow using a seeded
 PRNG for generating random losses
Message-ID: <20230814140110.0b35eb8b@hermes.local>
In-Reply-To: <dffa41e5-cde3-5b88-9539-9c03d9e10807@uclouvain.be>
References: <20230814023147.1389074-1-francois.michel@uclouvain.be>
        <20230814023147.1389074-3-francois.michel@uclouvain.be>
        <20230814084907.18c339c2@hermes.local>
        <dffa41e5-cde3-5b88-9539-9c03d9e10807@uclouvain.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2023 22:14:53 +0200
Fran=C3=A7ois Michel <francois.michel@uclouvain.be> wrote:

> Thank you very much for your comment.
>=20
> I do not use prandom_u32_state() directly in order to ensure
> that the original netem behaviour is preserved when no seed is specified.
>=20
> But I agree that it would be cleaner to directly use prandom_u32_state()=
=20
> instead of get_random_u32(), if we are sure that we won't have problems=20
> (e.g. short prng cycles) with the randomly generated seeds when no seed=20
> is explicitly provided. If it is okay, then
> I don't see a reason to not use prandom_u32_state() directly.
>=20
> I'll make an update of the patch taking these comments into account and=20
> simplifying the patch.
>=20
> Thank you !
>=20
> Fran=C3=A7ois

Older versions of netem had prandom_u32_state() equivalent built inside.
The code was split out later to be usable in other places.
Over time, get_random_u32() was added because it was more random and
there were calls to unify random number usage.

The prandom was based on Tausworthe to have good long simulation cycles
and reasonable performance.

Going back to prandom always is good idea, since get_random_u32()
has addition locking and batched entropy which netem really doesn't need/wa=
nt.



