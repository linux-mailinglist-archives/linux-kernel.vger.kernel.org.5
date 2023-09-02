Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F4B790953
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjIBTY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjIBTYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:24:25 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C34CD8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693682662;
        bh=86sudvpMHco+effGBKJgscnwwfjIWUBl6dAqg4Bl9dA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=D6+BsinW7Mv7PnWQk17CSZoioJTKA0fZGf/f8u2p2regygydHIF4Z2/ioZ9hB7MY5
         giMu9X+kE99tW0/QDDG5vrh4vma5ryA1HeExKwltLMu5TemUwg1BrpvbNbkLDBbKhe
         KLaMhFV+/jQQfLaedsVsJQJejoXGRETJ2khSozTdQ1XzUzOa8GeNoAEcmtcmU9lmtO
         TGMWftBukBbmxVtorzFxApV7W4xWL5AQshbvponS112w9/Y9akaKCOUdO4cJCfYBPh
         5YcYx83nq+fhvrjpHm3q+GIPQon4/Ue8Gb4O4aOA6lgiV12FtTQ+AM31su0u1GSyd9
         4KIcPWH3u42Jw==
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by gnuweeb.org (Postfix) with ESMTPSA id 3629324B250
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 02:24:22 +0700 (WIB)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50098cc8967so343940e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 12:24:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YywM3hw3qNhCmvYV6qay79olbjc3q9h243vs5YhSl2YoHvVKqrf
        SGP1vvXyWMh1b/gQB8LY2kNiF1MbnLY+e4c8P/w=
X-Google-Smtp-Source: AGHT+IHGLxfm6XPcDmQLbZqJ1EmLbZC215XY2R75s34lrwNkKkWijQHfScYWAjba1b4tIwFRmj6V0I93kdCVBy033hE=
X-Received: by 2002:ac2:4545:0:b0:4f9:5580:1894 with SMTP id
 j5-20020ac24545000000b004f955801894mr3924797lfm.15.1693682660161; Sat, 02 Sep
 2023 12:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org> <20230902133505.2176434-4-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230902133505.2176434-4-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sun, 3 Sep 2023 02:24:08 +0700
X-Gmail-Original-Message-ID: <CAOG64qMOUxysSuWqadaMxVgZY_o9HtfyVVDHe7mYmatSRErWJA@mail.gmail.com>
Message-ID: <CAOG64qMOUxysSuWqadaMxVgZY_o9HtfyVVDHe7mYmatSRErWJA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/4] tools/nolibc: string: Remove the
 `_nolibc_memcpy_down()` function
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 2, 2023 at 8:35=E2=80=AFPM Ammar Faizi <ammarfaizi2@gnuweeb.org=
> wrote:
> This nolibc internal function is not used. Delete it. It was probably
> supposed to handle memmove(), but today the memmove() has its own
> implementation.
>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>

-- Viro
