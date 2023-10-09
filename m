Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E13F7BDCD5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376577AbjJIMvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346562AbjJIMvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:51:51 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB0B8F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:51:50 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id 71dfb90a1353d-49dc95be8c3so1420351e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1696855909; x=1697460709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=44AhXoT4Z1Vbq/hvZ2n7ymqD0GYzk4VzWb6rLbi44DU=;
        b=PYJzrWX9utYaA4QfjzKhhE2rTEZkgRuguqCMtX26XqsFEXFJKgjp7RuLuMOKP54x1B
         A4SnwpgfrPYPyhqbULZ4v2ImpTLF/zPmXXwd+kvq820oaS1ykg/1B0ySJQZQFk/82n70
         /fcnMVclTfWdzlsQdneVt7w2+QftK4nnUGQG+QiHJZt0Wl5RG43nnMdsx0gL5O5g42sF
         YpMXdywDJiCQHw/vBBvs8g2/KGYybFBUkNuD+LG4WxyrHvBEVIxLs08yXIhHdSUH7nYy
         tc6OrbHBEbcvnxOx+dS3n89ZmM8xIR0eN2rQ7CyuQvyUQ8IZP2ntNIRoLHGJtbDCqs0Q
         RUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855909; x=1697460709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44AhXoT4Z1Vbq/hvZ2n7ymqD0GYzk4VzWb6rLbi44DU=;
        b=QkqOaV5yYyRpfCEG5K8+Tu3N8UA9Q2bLEx7XFH9Ilv4zC3Sll9Oo0Ogx8dQZZl9Lgc
         JWIuvVNEO5SWNynu7BaKJ5T1ejJAEt/GFc2tM2P3KTpJgic6teKGmk18uf7Kf//9kIk3
         YW+9vzk8zoSubHAuCGR9//uApF1pL5YRlIbq3CzGBYfYfQn0uMsDcULJQOlDnTOYo+dg
         NwNip9Eqp5IIMc9bJ3E2Ct2d/taJAOh1FuA7x3SlKsYKNKP6UNJAG+HP/v7FqFblY9Cd
         gRXyUGpXiU1Ekes/57wqZ31o7xvRq4OzAAvDRZjkFQIO0Eaj5eLmmj2Kk6z07Nzrr1Is
         XJcg==
X-Gm-Message-State: AOJu0YzWulkb9388O1JSAVTdVk11zDVc0cQWbaMpVSiQ+5rsCDcsQfID
        Dbfuer74aUDbBTzZrVoVFUCZRz1nezWJ6DA+29PYHA==
X-Google-Smtp-Source: AGHT+IF8LTFz2coNqxy5ZU+3pMsnn72accLWIc/3GC/vPCtjUhTxhK2Lvq326NjzFIx4R8++vQGfi/4IzlNNVEHCwZY=
X-Received: by 2002:a1f:ca83:0:b0:495:bd61:a184 with SMTP id
 a125-20020a1fca83000000b00495bd61a184mr9190355vkg.2.1696855909499; Mon, 09
 Oct 2023 05:51:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230920075500.96260-1-brgl@bgdev.pl>
In-Reply-To: <20230920075500.96260-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 9 Oct 2023 14:51:38 +0200
Message-ID: <CAMRc=Me8dpwygBo7ZFbj1sz_==R=KfiW=L=r4Rxmhg2K=L8CUQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] genirq/irq_sim: misc updates
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 9:55=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> Here are a couple of updates to the interrupt simulator. Two are minor:
> remove an unused field and reorder includes for readability. The third
> one simplifies the error paths by using new cleanup macros. To that end
> we also add a cleanup definition for dynamic bitmaps.
>
> v1 -> v2:
> - add a NULL-pointer check to the bitmap cleanup macro as advised by
>   Peter Zijlstra
> - initialize managed pointers when declaring them to create a clear pairi=
ng
>   between the type and the cleanup action
>
> Bartosz Golaszewski (4):
>   bitmap: define a cleanup function for bitmaps
>   genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
>   genirq/irq_sim: order headers alphabetically
>   genirq/irq_sim: shrink code by using cleanup helpers
>
>  include/linux/bitmap.h |  3 +++
>  kernel/irq/irq_sim.c   | 30 ++++++++++++------------------
>  2 files changed, 15 insertions(+), 18 deletions(-)
>
> --
> 2.39.2
>

Hi!

Gentle ping for any comments on this series.

Bart
