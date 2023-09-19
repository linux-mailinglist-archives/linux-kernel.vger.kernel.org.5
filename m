Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319AA7A65CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbjISNz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjISNzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:55:54 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DBBF2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:48 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c022ce8114so16632691fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695131747; x=1695736547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=96EO/+9CqEhXOh6rRl0yM32sXXQtCjQMIYuhs9+Nd8Q=;
        b=UjVIDFEpvYguUcTFSzy/FfYsyUFmTxKzirWmYCjtr2ORHOwECUKDjIbEIoMvKJk7bA
         Pe8rId8FuWiVV0IHXm2aJ4itfMTVw1eQXIklrj9ZqeoKIzweiUVKj+ZcTOBJdglalDXm
         AhEkdGTQodkK0hK8ApUxvGP2xfPWnTOWr7KdUvlDAC4sgxDc/HTQj2SRRh5vCdKAs+Q6
         fH4R2H8xaONLb2jclS0dmLxu/2kn2uweTydgXkCg/LOAumCTu1GEbNF2GRsOAYxigCZ+
         9kKcrCxj8CWuC9Xu14Rnwy4DbIL5X4StqEkoI8jUxqd3+OvWupiHZgAw/2ND1J66pZyx
         dQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695131747; x=1695736547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96EO/+9CqEhXOh6rRl0yM32sXXQtCjQMIYuhs9+Nd8Q=;
        b=gtAqccFi7wZY5PQGBRMzlPwz2yG+k3bAoxg4liSz2xIektjMEUBtxxJShW2epf2hej
         n5fwvUQs2BBkDl1BzhJC56XqgdxnZC3idbvgDWEdzT2n6dxCojkbFdIHp6CuFf/xzZXd
         YdF8iEqTJ9wAFafaZPWLdfkK3KW42sLeI7VmjTygVIxn0l152jFN6ww9KvcVGN6euZPo
         6gjUYiQE2mv76HgULwqIfM29UpdJgO5v8pbKQCseCymrl6vMKYWMALPTAn7gPU2+xFu4
         vGotAJGSgtSGk8xBPnIgaIUWuxr9vNornygP9Amab4sC+mUcecPWFKMzSquadxMoYgFf
         3zsw==
X-Gm-Message-State: AOJu0YzfwJWnJMvJXUT4Eu/D8aZyKB0VxqjiAMgOfT2stQq5N+qGFWTM
        RjA1E/Rq4OkoyLYrErKuVKgNG9H6J8aOruv62Ez4MSmjYducFxHcU7Q2lQ==
X-Google-Smtp-Source: AGHT+IFJLGIStxQCWUOJLYMZUOemt7jA3aEfUgu0fd215r4qtFH61Zn2P/e/F2s2u1K56/GyViIETxwH7rCtt24sTLQ=
X-Received: by 2002:a2e:5019:0:b0:2c0:21b6:e82e with SMTP id
 e25-20020a2e5019000000b002c021b6e82emr2134019ljb.4.1695131747045; Tue, 19 Sep
 2023 06:55:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230919080707.1077426-1-max.kellermann@ionos.com> <20230919-fachkenntnis-seenotrettung-3f873c1ec8da@brauner>
In-Reply-To: <20230919-fachkenntnis-seenotrettung-3f873c1ec8da@brauner>
From:   Max Kellermann <max.kellermann@ionos.com>
Date:   Tue, 19 Sep 2023 15:55:36 +0200
Message-ID: <CAKPOu+_ehctokCKHFZgqs2NksE=Kva80Y5xjA705dNCbtcDxgA@mail.gmail.com>
Subject: Re: [PATCH] pipe_fs_i.h: add pipe_buf_init()
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19, 2023 at 3:45=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> So pipe_buf->private may now contain garbage.

NULL is just as garbage as the other 2^64-1 possible pointer values.
NULL isn't special here, nobody checks the field for NULL. This field
is specially crafted for exactly one user, and initializing it with
NULL for all others will at best only add unnecessary overhead, and at
worst will hide initialization bugs from sanitiziers who now think
it's indeed properly initialized.

> Does the helper buy us that much overall?

This is about introducing a safer coding style. The lack of a central
initializer function is what caused CVE-2022-0847, which was the worst
security vulnerability in a decade or two.
