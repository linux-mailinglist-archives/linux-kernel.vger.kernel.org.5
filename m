Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DC47FD23B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 10:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbjK2JSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 04:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjK2JSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 04:18:20 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3893F4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:18:26 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-462e19c29baso1364236137.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 01:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701249506; x=1701854306; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WeJ42zpUkCAS/wq8C44kuCI99EZYBs3yKxjKx1eJvgQ=;
        b=QC8tYeFuMjn4PZslml4SjC/iUUrkk+gjgItJzXPIgyVUUGmypsIgWd37lUamsuKbVw
         yG2YPOACEjcJBLbmWmlD8eJbFfivITf7AoM6JFlTN1s+dRqVtCPjPy3OlOUVnN0E592z
         PifKfZJ0OsVNFIiItbyHQialLj33A2OJZC3Pt0yirbYw7VWkfE6qz6uS1qsH0O3P6O9C
         0mDRBMD6FiQz2AF6FXTEOJMc2bBTueYe4+AeNSnF7nwN8ZMb5TUrXs5k3amBWwQyLprf
         n688jDDOHCEqbC1NdYiyCHRqRUZQlYqrn1L+2f/5LMVeMtQ9ZYRdad0kvKIt2WQCgpk+
         nNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249506; x=1701854306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WeJ42zpUkCAS/wq8C44kuCI99EZYBs3yKxjKx1eJvgQ=;
        b=gsS4fj+tsvHmDrnVDCusvvldKEpt5riX5w5k9m+Q+6N4i0imVI0JrOlegDinR/pneK
         KI9Dp4u/vaMBk9CvXinW1B/J4UQCa2MaiyEEK+pUhF0O24KEz+P515ePNZLkLnW4GaQ2
         U7PSW5S4UUBX5QFzbHy1xluP25ylHi1/ywsLuyJZT5WGMQ+vREmA+cjqpncI8oqODujh
         sF+J+8swmvemgd5bNf4t3aFYfdKk6aQCBym/xP5i2LGYTG8Iq65vbOdjpZIsghRHf9op
         Q8o+0U0Bsx9NHXw1KA1U0JOGH/EdWmtG3nP+oIO6tdqGFpedQJLaCdYSDqbBRm1P9NW2
         hOng==
X-Gm-Message-State: AOJu0YzfauSQ92ok4HlegAtFQIXyGPnxBC1L5fgnmeIonhqep4dztxWu
        zyAxwA4j2bx6YNPDMHnXq3+GTUlbuf/n/RZn2YaJuBsSIHMiBYr0
X-Google-Smtp-Source: AGHT+IFWlNgQeGGu3m4Is0nwKF6Q7LXIOIKl+fkkEn6Jdj12Z77uLbz4M8dd5NarAiwbDpgOdq8RD41hRwOU7Jz4TMc=
X-Received: by 2002:a05:6102:3a08:b0:462:9eb3:9bdd with SMTP id
 b8-20020a0561023a0800b004629eb39bddmr17468962vsu.28.1701249505974; Wed, 29
 Nov 2023 01:18:25 -0800 (PST)
MIME-Version: 1.0
References: <20231115165915.2936349-1-brgl@bgdev.pl>
In-Reply-To: <20231115165915.2936349-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Nov 2023 10:18:15 +0100
Message-ID: <CAMRc=MfoE93Aum4s-pweeb_idqYgUG-DBpXnhT5UW_WhVkLwHw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 0/4] genirq/irq_sim: misc updates
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 5:59=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Here are a couple of updates to the interrupt simulator. Two are minor:
> remove an unused field and reorder includes for readability. The third
> one simplifies the error paths by using new cleanup macros. To that end
> we also add a cleanup definition for dynamic bitmaps.
>
> Resending rebased on top of v6.7-rc1 and with tags collected.
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
> 2.40.1
>

It's been two weeks since this submission and ~2.5 months since the
first one so I guess, a gentle ping is in order. This is not a very
controversial series - can this be applied?

Bart
