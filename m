Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA6A7C42DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbjJJVno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjJJVnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:43:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAFA1708
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:43:34 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5347e657a11so10222944a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696974213; x=1697579013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQ7LV7udIaMiewA1z3bMb8JW/Ylqm8aFLUitdTKsmZQ=;
        b=FugoGolm6sINpjYesZjoWjeqKmfQAS0Rzqheest2c4TVEGCqciY7JPfDuI2gB/sfc9
         PuRjQeQcfmZL0foM2wQmRIb74NkSkuOiFM6Hi6rffsD343tceNh12RcfpAMyxsYEfkLj
         sr2xCwMAcKa+DeBGr5nviLjA7lcGYY+tQPRY0JalMCFb2CCl+G9EU4At6rr99Si020UR
         Pt13sQE3Uv3Z6S11iXqTtX2UGqtG5rZYhrboTksMxiYunIsLH04nb+47x3fMzVsMD6yY
         u2AJLQ7GLlLViN3FswdwwBVfjlzFF16/2ajGAGR3gtbe0yHH0mb5hlJR38osWebRW1UL
         QspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696974213; x=1697579013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQ7LV7udIaMiewA1z3bMb8JW/Ylqm8aFLUitdTKsmZQ=;
        b=BrXZOVVLvKKAjDzvXnlgZnBL/CCDGA0neOrc6aIZyqbJau76CR322MGiNrqFgVmaDG
         LMJB5AzQ2tA5hTOyXvbEPfOQlmkelWP216bJSwd9tU32Wc5vElKOPeaiLBLnfxIsZp4H
         XqgqSRqojsxQnJvWIGQl/xc2PTQ0LF60e2WOJUFpL1alJ8mdW6cPn9G0WM7Jlee01MHj
         LUvBEOSI8O356tshmY91JmwBEC1qgPk0eEuobDz9ZkrysOcXA9GdM3b19+yFnb8cYYPd
         C1pKUt0VJaHUJgn0Xajt7l6MaO8BZfnLTuG06SDYQqmpNGJCCH77HPv5fm6QpT3ZSRak
         GwwA==
X-Gm-Message-State: AOJu0Yw6dW/qniJ1r/WYX5D8h6u6ZdUn2cXmM7Vxy4InSjDDyPrhfTsr
        e0HA8VPgDfhcMQeJ+OoxpjGZVOyZv0TGv3dx4OwGzw==
X-Google-Smtp-Source: AGHT+IGOMNalWZyIJ6/M6e+qgCiNES2RiFczmxRyJOq7r5gdxadkHffHljA9WN4NZG0I3/lPm+rA1OuyNOLC/zBZBaM=
X-Received: by 2002:aa7:c30b:0:b0:530:b75d:7a83 with SMTP id
 l11-20020aa7c30b000000b00530b75d7a83mr16902772edq.21.1696974213069; Tue, 10
 Oct 2023 14:43:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231010-strncpy-drivers-net-ethernet-intel-igc-igc_main-c-v1-1-f1f507ecc476@google.com>
 <128f5692-982a-7bba-d9b3-174881cba49e@intel.com>
In-Reply-To: <128f5692-982a-7bba-d9b3-174881cba49e@intel.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Tue, 10 Oct 2023 14:43:21 -0700
Message-ID: <CAFhGd8qE1oO0q91Y7sEq342qH1ty+KSMGUkczaQAJgghPBBX0w@mail.gmail.com>
Subject: Re: [PATCH] igc: replace deprecated strncpy with strscpy
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 2:22=E2=80=AFPM Jesse Brandeburg
<jesse.brandeburg@intel.com> wrote:
>
> On 10/10/2023 2:15 PM, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > We expect netdev->name to be NUL-terminated based on its use with forma=
t
> > strings:
> > |       if (q_vector->rx.ring && q_vector->tx.ring)
> > |               sprintf(q_vector->name, "%s-TxRx-%u", netdev->name,
> >
> > Furthermore, we do not need NUL-padding as netdev is already
> > zero-allocated:
> > |       netdev =3D alloc_etherdev_mq(sizeof(struct igc_adapter),
> > |                                  IGC_MAX_TX_QUEUES);
> > ...
> > alloc_etherdev() -> alloc_etherdev_mq() -> alloc_etherdev_mqs() ->
> > alloc_netdev_mqs() ...
> > |       p =3D kvzalloc(alloc_size, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAY=
FAIL);
> >
> > Considering the above, a suitable replacement is `strscpy` [2] due to
> > the fact that it guarantees NUL-termination on the destination buffer
> > without unnecessarily NUL-padding.
> >
> > Let's also opt for the more idiomatic strscpy usage of (dest, src,
> > sizeof(dest)) instead of (dest, src, SOME_LEN).
> >
>
>
> Please see my comments on the igbvf patch.

Ah, I sent too many before checking back in. I see
your comments now. Responded over there!

>
>
Thanks
Justin
