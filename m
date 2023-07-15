Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B3D754767
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 09:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjGOH5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 03:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjGOH5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 03:57:39 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190473593;
        Sat, 15 Jul 2023 00:57:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-991fe70f21bso367630966b.3;
        Sat, 15 Jul 2023 00:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689407856; x=1691999856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1n7E0eBFrZXOyOxg2KTx80+Vuh2zZMToGT9fecLUZls=;
        b=UzSxv0Gj3nPmFxJzUfAMXFAYdoY+QBzH2c6TS3EAOlMAjQe7zJKQX7NOeWCCzdtUG8
         e41KjvlUuMGLSicG4a+xRGTnzNbVETJTkAlbfQRTEGpCpQ3a6ffYNk8A7qdzMAMsnlbk
         MF0y+UIXYovVpnNDAvugzOntaMmlGlBG4ytTOUo1Vnqe2w53wB1UINvupsm2bxKULsGj
         bSKiW1xe8tZGkeGQcmDcEIsoZ+fZFjFyRhPyKYpp291gCyIfn757xSTRp/XhfbIjgcFC
         /jVUTs+Col+uUzD8RyvxcTl8wHlShD2MihGIpPwGFSCYnvpZKHwg/ClGMEWmf7uWaOdJ
         pqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689407856; x=1691999856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1n7E0eBFrZXOyOxg2KTx80+Vuh2zZMToGT9fecLUZls=;
        b=anT8huo0YdcC8gYsOv/q5MCoEWqj8UH4P+4SsxrYgfh6mKmXAULcR1c/jivRELosfs
         eE/eUeGIt0Sz9NZIPH7JH6MxhwuQz148Q2FrW3CSuHwhhxlWZAcKFdsdVcZJzjCyh/mn
         PYhX6RWShnt1HBIfdIQBBiv4AYCEX5oZRS2bYUUmiPEmork4HEuSijVaz0U6EqON3xdP
         qQKAw+jVum/8mnr7i5TVQ9i7YePlJ1RhsY4CECVIpIh8MISKXrX+ggw9q/Ru1tc1Hf6C
         BdWBqlCMe4x8+uJ5SSYmz57vzQwUlwvB+GVk8sxOjGITHBru91A5/4kwfUTDJZDVE06J
         8fRg==
X-Gm-Message-State: ABy/qLZBDqF7fjIOuaV/BDIMTUy0WMfs+4fqyv7gT0QVVukQhldfrcPf
        7Sg3+nKogyqCROLdWYJvjCkgW1JhPjcg8K6qFvs=
X-Google-Smtp-Source: APBJJlF+bq9EMD3kISbfhZApaeacBx43bZSftShN+8aU/Hj1mYhuTatXvgzQFPg7cp4sGZUBefWwE43f+lTDLDdwmpM=
X-Received: by 2002:a17:907:2ceb:b0:982:45ca:ac06 with SMTP id
 hz11-20020a1709072ceb00b0098245caac06mr6407189ejc.60.1689407856374; Sat, 15
 Jul 2023 00:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230715010407.1751715-1-fabrizio.castro.jz@renesas.com> <20230715010407.1751715-10-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230715010407.1751715-10-fabrizio.castro.jz@renesas.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 15 Jul 2023 10:57:00 +0300
Message-ID: <CAHp75VdEyYM4LgH2WpwoUteBogDKguSyT8E=e4P21sTr0tRoJQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] spi: rzv2m-csi: Get rid of the x_trg{_words} tables
To:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
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

On Sat, Jul 15, 2023 at 4:04=E2=80=AFAM Fabrizio Castro
<fabrizio.castro.jz@renesas.com> wrote:
>
> Table x_trg can be replaced with ilog2(), and table x_trg_words
> can be replaced with rounddown_pow_of_two().
> Replace the tables usage with the corresponding macros.
> While at it, remove a couple of unnecessary empty lines.

Suggested-by: ?

--=20
With Best Regards,
Andy Shevchenko
