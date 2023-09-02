Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BA5790956
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 21:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjIBT0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbjIBT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 15:26:32 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E6DCDD
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 12:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693682789;
        bh=5eUYQuK/rN8c/DnC59ghgvHW+BU6SZmTobUAWpZkBxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=a0oINicXLVzq4puA0zdr4P2+wbzE2KwIJYg75uqZA/y0psmYQBOK+mTOTT4ChBD8u
         yHOiLdh25b3zAEnpFDlmU2e/X+oZ15dA5XbxVmINNpfzj+r4jKTSAEJdE2DzMEtpam
         ukuf6UvQuxiUKwhT/82EQs8r3QTQwJ1mXtJ6alECeMFGy1okirtjtO2mwWJj1AMZD3
         iQeDHV751sql9axJIuiRFcVwIZJH1mnbaT0aYwQuvnj66kEpkn1UVT3GtUN2oM1Zxq
         ciIez+3wheVZFv+jjIGwMgNCYl9beE+LDuYG9HPBj/P9nXhs61aKA3QzSfZNTdkvCx
         q7l3B7cXa3gdg==
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by gnuweeb.org (Postfix) with ESMTPSA id 0866324B3ED
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 02:26:29 +0700 (WIB)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-500760b296aso207277e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Sep 2023 12:26:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YyTQahE9LJ3sdITxvBWDT+kSH0WNLfJBWFgao2YWlaibVp3zALN
        F2dCGfcU6NnwfmPa8xUCsGzTh4iCPRSkOUtb1ww=
X-Google-Smtp-Source: AGHT+IFHdZSN/4S8SEJPxAzs5eawMu0mGx8qPU6M2A/mnlB4jaLiCFZsthXigQxc5UTr3NgP+xO2CI2yL4igx+MHTSI=
X-Received: by 2002:a05:6512:118e:b0:500:a6c1:d8e0 with SMTP id
 g14-20020a056512118e00b00500a6c1d8e0mr2721445lfr.22.1693682786640; Sat, 02
 Sep 2023 12:26:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org> <20230902133505.2176434-5-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230902133505.2176434-5-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Sun, 3 Sep 2023 02:26:15 +0700
X-Gmail-Original-Message-ID: <CAOG64qNjY=w71UPoNf2KBWG1WiYLDDE=K0V0Fp2z2RLbw7n=0g@mail.gmail.com>
Message-ID: <CAOG64qNjY=w71UPoNf2KBWG1WiYLDDE=K0V0Fp2z2RLbw7n=0g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/4] tools/nolibc: string: Remove the
 `_nolibc_memcpy_up()` function
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

On Sat, Sep 2, 2023 at 8:35=E2=80=AFPM Ammar Faizi wrote:
> This function is only called by memcpy(), there is no real reason to
> have this wrapper. Delete this function and move the code to memcpy()
> directly.
>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Reviewed-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>

-- Viro
