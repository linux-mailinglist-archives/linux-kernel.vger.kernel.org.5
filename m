Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202E4771D42
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjHGJjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGJji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:39:38 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1329E10C1;
        Mon,  7 Aug 2023 02:39:38 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-5768a7e3adbso76980467b3.0;
        Mon, 07 Aug 2023 02:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691401177; x=1692005977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KANoAi4KJxWNG4lfh8UFbdoVDzynEqjJ4XX3JtIISDA=;
        b=FStAdle3A+eN6EDU2RoWhI0wC+xZ6DjAHAhBdp6qx+EamI7CD+12o60qRr5NLZfPVN
         g2KnTCcxDgR0SAjJp8/Uzt7YLoGwwIMbwPT9yZ62XdZTR/dppwPjXaRQqFUM7gofjbRJ
         pdJgQJRRc/+7ekahK8FRCaTVqJXwcC+i2HVK3KWiZ9opSZp+A5H7Wf50oZAcDm2Bi+F5
         WvZC4tp+7yJfBVG6spVYy+eV9u0luxvpaXbKPPuoai1aFvCNi+bUq86z1FcZFqvJZAEm
         Hp6ByQcpFTPPFC5r1lilYs3ym/UuyBo/QBtvQmVXPAXSm1niMGzDiBoD6W/6emcXfNs5
         Rn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691401177; x=1692005977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KANoAi4KJxWNG4lfh8UFbdoVDzynEqjJ4XX3JtIISDA=;
        b=YpihfOLx/fWPj3GlONICLSP0BMFvLnQDn9OrBURiFER2Vt1lnzCz+IlPALIl+61KXp
         WJ2w4oihHIoGPrakcxkWSZkvPgiZTmjaHHR8/K7vfQRYBf+NfmKUw1NqUxEl4iYXxYek
         PQp7dAJlsjb3o6B0gjN9EBtipoE73BQf1jnYKT7j9CFXT17ZpsQMMuh5voZKYDbBW8I7
         407vVtDGsOR0wQya/FELYIJJUyu0h62QsEen3byms5F3bAiUrSqm5ZAHbxr3+0cABl32
         WCiW3G/WDrcJ8C17/ARxVv9yHqJaAae56cBYbLmKQp7BwxNN2nulwgy5CejY21bgdOL7
         9fiA==
X-Gm-Message-State: AOJu0YwrE0NCg7dkG0RMHakJqJDdqtdTGR8im0WLbNwiQrWn1W09gwaX
        fE3LK6U//eif1wccTa1Gzkv4oKCxi92tkhVwB2hiezJ2
X-Google-Smtp-Source: AGHT+IE1VZFpJpCa0mdDRCG8L2APBzvJPVO5xHPetYuXQyjt6XOOI3itXxnOADZw2UopJTBtnw92Ooo/pOZToPwLEU0=
X-Received: by 2002:a05:6902:4e6:b0:d48:7988:15e0 with SMTP id
 w6-20020a05690204e600b00d48798815e0mr6296024ybs.6.1691401177260; Mon, 07 Aug
 2023 02:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230807091302.6370fc50@canb.auug.org.au>
In-Reply-To: <20230807091302.6370fc50@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 7 Aug 2023 11:39:26 +0200
Message-ID: <CANiq72nspJn=YGkMH-hC56ynBc+d6mHdUOQtcui6_UntJNAb1Q@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the rust tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Aug 7, 2023 at 1:13=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> The following commit is also in Linus Torvalds' tree as a different commi=
t
> (but the same patch):

Thanks! I should have pushed the reword to `rust-next` too, sorry.

It is gone now.

Cheers,
Miguel
