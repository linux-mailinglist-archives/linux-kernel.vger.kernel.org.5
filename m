Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDED7687AF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjG3Tuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjG3Tui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:50:38 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A2FE5;
        Sun, 30 Jul 2023 12:50:37 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-3a4875e65a3so2606594b6e.2;
        Sun, 30 Jul 2023 12:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690746637; x=1691351437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qCJ7pSNYfqsNs7KY1Muuh1w5+Pispwv1vOpFTja5zL0=;
        b=Q0IGHbDGkFY3YeOFTDA3cZqvk5wkbbRyaJG5zMnOusSgw7tJcqSUK1dm1mKj62xHaY
         d5bOOUfLh8Yn8rW6C3WZOYKpR42jZyFwBQocgNUjueBnIqV5yfLJZ2OKCNxUXWa4Rcjo
         +B4otyODmgNAODZHmGKQrkWv19eDQyTSqBDgCqZ4CCbo8xEWMpv5niLvsK4t/YrQyqm2
         1FHUYhlcXE7eliQ0ulDaTDorpEoAB6hBxvhWMtT03INAJqPp5H1bAxcxJcZe5oSoD6cn
         KJsIRR9Splvy83StSEBBFR4ASfPzeHCg74O5TNmGU2R9a32YLHaHPi+srKgIY5MoJp7F
         VuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690746637; x=1691351437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qCJ7pSNYfqsNs7KY1Muuh1w5+Pispwv1vOpFTja5zL0=;
        b=gDrcpWjzQ+J438bS/p68zi5DdWyTUCQCnVzTN0chRTJ0lk/qIqHJcM2lLYMcW1Xhs1
         36viXemt9tTgTzPG3j9F3AuFU/2mo4brQSzvf7cSN1/LkEHGa/dkpjWNRs7vBGKtu9qP
         R8UngDGr+uhp0TDC6oAL6VFXJZU8y7fjqKhwyg/RZT/sGOZiWHwH212HwyNdFVbykiMd
         Kf0WqEAgFHJLCwDvAiMb2f3DQm6egFzCPJKzY5DIZOVOr1k+8TT5lBpa6BFbShP2/OvE
         /59lL47Q44NFaCKAJeGD4+fU2GCv8B4o6SscjTdLjHMLyM9S1TC2go1bMmAPtntpqv3r
         ZIVA==
X-Gm-Message-State: ABy/qLYKg4L/fuwQeH4e5uFxMsOTCsg2k4CgQmjbwqL3cVJJtJ7GPTGn
        nooFLxLr2bDDqaXw7aCRJzTn0PV0k7ZXXgN3HWU=
X-Google-Smtp-Source: APBJJlG0xWNr7SrEMc7Tyhix/H/7zR1s4xwyI+OFP7Il6Z6Gzj9sBa9pBs4gVKmd31DA5K+40Lf8mQqjKC7aLeDs9Tc=
X-Received: by 2002:a05:6808:14cb:b0:3a2:572a:eaa6 with SMTP id
 f11-20020a05680814cb00b003a2572aeaa6mr9760362oiw.5.1690746637249; Sun, 30 Jul
 2023 12:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230728180833.18399-1-aboutphysycs@gmail.com>
In-Reply-To: <20230728180833.18399-1-aboutphysycs@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Jul 2023 22:50:01 +0300
Message-ID: <CAHp75VeBm=DpfhXOBmgHM-5Y9DBNqwdGdcWRzMxn6PVrZCKbKw@mail.gmail.com>
Subject: Re: [PATCH] gpio: pmic-eic-sprd: remove unnecessary call to platform_set_drvdata()
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        zhang.lyra@gmail.com, baolin.wang@linux.alibaba.com,
        orsonzhai@gmail.com, andy@kernel.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, Alexandru Ardelean <alex@shruggie.ro>
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

On Fri, Jul 28, 2023 at 9:09=E2=80=AFPM Andrei Coardos <aboutphysycs@gmail.=
com> wrote:
>
> This function call was found to be unnecessary as there is no equivalent
> platform_get_drvdata() call to access the private data of the driver. Als=
o,
> the private data is defined in this driver, so there is no risk of it bei=
ng
> accessed outside of this driver file.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

--=20
With Best Regards,
Andy Shevchenko
