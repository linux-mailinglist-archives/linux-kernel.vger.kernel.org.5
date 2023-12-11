Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE580DAA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbjLKTON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKTOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:14:12 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EDFBD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:14:18 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so66814541fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 11:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702322056; x=1702926856; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAfezLtwlsLKsGLxIMeUmD/ncEXFCl8paKQT2/k5F8Y=;
        b=IfvCoTglC021eQ+oYTMUiWABBsiQmXZ91FOBuJFPgKKBjk1cbNAvUA5eIKRueb6j8W
         FCupufQNrWGjYjvzDrrkBzXxi8AY0O9W09MoIpbpTXl3FPfiaGNW3vDs/dd/VDW19uSE
         La03cU2IsqiMOQ/FVjS6slIbpSu8PdKb9Rldo9+Hce9i/GU5GBWWgVrjEPaUOyNem6Bj
         jrhvkZpFK1MxZLyZxZEF5OlqmFKGIaUPtiJ2aCmttBTbL8O15v+lHRex/3L3dMKit+it
         NpIZ+noK0EjM7VVOQLbg/AzxGuXL5xpfm++5MtGyyye+Hd+9BWQR5QVPSzoEKyXwaI8e
         MuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702322056; x=1702926856;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAfezLtwlsLKsGLxIMeUmD/ncEXFCl8paKQT2/k5F8Y=;
        b=Kvli0IA1zrm+QYA8FxDS2puWYydpCWH4jgxMhn3jDE18Ukdps7QIm/8U3tRQCkValr
         RmMjrbe40VqRMvA0YrVtLsgPrV9K7xHyOBjpfF2gz3azP6/G2KoTHWAocDakdVVqjNSc
         MOuGD9Mj/RU1cx/PwZUmDV1LwpNGW1+uIMYbp0GOjaPganc8tnlKTkqNVa8eABDOEVjk
         2s/1IoX4CXhP4ygKBuKle9r4darUtefGBZYxL3rwmsUYkH7fB2LTeEir2tGS0JGNrybC
         D6y85UD8wJbVlgopWftTNrDhYC6f8g3jhi0mYeb8dGRg8GVwVzQLkA5X10P48wzBKdnr
         2E5A==
X-Gm-Message-State: AOJu0YwYvriJjiSR8Ol3RnLy88xxz9fD7fsJR/4eIUi0MdKBYLxPzlyW
        0j59qnGR5uXzed2nqGgLTG1W5JbG2HYpkv2REVPOCsmW/46hOA==
X-Google-Smtp-Source: AGHT+IFoW8tjESXXjZ7fjCCGy/EZqXjqB8xSrlNzNRkX5VWaU/k4a8pAlSSiojBKV4OrQ5zIVyh7to+ESpijo9WFgHg=
X-Received: by 2002:a2e:b5b5:0:b0:2cc:2170:87fa with SMTP id
 f21-20020a2eb5b5000000b002cc217087famr740056ljn.44.1702322056038; Mon, 11 Dec
 2023 11:14:16 -0800 (PST)
MIME-Version: 1.0
References: <CAHP4M8WQdQfjxa-oqGTEF-kfF3j8En6V5fi7gyNbGegwFqfpCQ@mail.gmail.com>
In-Reply-To: <CAHP4M8WQdQfjxa-oqGTEF-kfF3j8En6V5fi7gyNbGegwFqfpCQ@mail.gmail.com>
From:   Ajay Garg <ajaygargnsit@gmail.com>
Date:   Tue, 12 Dec 2023 00:44:03 +0530
Message-ID: <CAHP4M8U8rUaFFRkQ2wYmT3JgKJ+g7h9nKLiqSYNdrBGLF1ckNw@mail.gmail.com>
Subject: Re: Query on a rare simultaneous processing of interrupts from GIC/NVIC
To:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

Have had some discussion at the following link and following comments :
linux kernel - Query on a rare simultaneous processing of interrupts
from GIC/NVIC - Stack Overflow

Really wish to understand if interrupts can in fact be queued at the
software side, if the sequencing mentioned occurs.

On Mon, Dec 11, 2023 at 6:36=E2=80=AFPM Ajay Garg <ajaygargnsit@gmail.com> =
wrote:
>
> Hi everyone.
>
> Let's say the following code is shared by multiple ISRs :
>
>    spin_lock_irqsave
>    <critical section>
>    spin_lock_irqrestore
>
>
>
> Also, following sequencing happens :
>
> *
> Low-priority interrupt comes in, and GIC/NVIC causes it jump to ISR.
>
> *
> Low-priority interrupt starts executing "spin_lock_irqsave".
>
> *
> Before preemption and interrupts could be disabled (by the executing
> low-priority interrupt). high-priority interrupt comes in.
> Since a higher priority interrupt has come in, the GIC/NVIC causes it
> to start executing the "spin_lock_irqsave" statement.
>
> *
> Through the low-priority interrupt executing, "spin_lock_irqsave" has com=
pleted.
> Preemption and interrupts are disabled, and low-priority interrupt
> grabs the spin lock.
>
> *
> High-priority interrupt spins on the spin-lock.
>
>
>
> Is the above sequencing possible?
>
> In other words, although the first interrupt did its best to disable
> all preemption and interrupts before it could enter the critical
> section, yet above sequencing *will* cause the high-priority interrupt
> to spin?
>
>
> Many thanks in advance for your time for help !
>
>
> Thanks and Regards,
> Ajay
