Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB00764371
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 03:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjG0BhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 21:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjG0BhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 21:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4431985;
        Wed, 26 Jul 2023 18:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94B9D61CED;
        Thu, 27 Jul 2023 01:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0632BC433C9;
        Thu, 27 Jul 2023 01:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690421830;
        bh=6yNIA6fRxodJIxC/uYDxu2cXOrAWw00D5WC4Cuw36vc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=olaFGSfyWJq99Uc3i8G4DKYIFMbcrlvQBh17pnMwTHyVFX5G4PsMuMR0On6W4sR9j
         M2fmxLmpu49t3PTGHFi4EK7DkwFQT5NRTviBR8brW69Ho+3OV6QsGU4pRdwfAKGcD2
         09fgeYKfmmz9ZUnUEva+tCn94cpKVj3PKCQ/8gQrRUJ37S8wUJon2utD5ADpTbHrre
         cev4JEmbyVkL/UWls2zrYNzjYsGRbobiIIZ+8pFBTz5lz8bW1Bv6uLXcXWUq+slCX/
         MXYCmFO2Jw7BPGK64L9lrK18mNTCPceIJjM7jI4W0arH7zvhGHl1jdvmH0sS+qhEoj
         HLlm57zZrhAow==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso6059751fa.0;
        Wed, 26 Jul 2023 18:37:09 -0700 (PDT)
X-Gm-Message-State: ABy/qLaPT1oZNuJ7OlUf4x7y/b3aJVkCMBRIgwzYueR2nAJv50oq9gbM
        0ptgSJqGgm/hDHkhKYwC1lsEgFRKDnmof+prOA==
X-Google-Smtp-Source: APBJJlE0p9IKEYW5N3d5gWvprz8S6+lEnY5wi2oLoDmWHOMlDkDblGHGA66Qwzl4JjM33xQoscD4bsUTNJYskx36TPc=
X-Received: by 2002:a2e:8883:0:b0:2b4:65ef:3af5 with SMTP id
 k3-20020a2e8883000000b002b465ef3af5mr556354lji.30.1690421827973; Wed, 26 Jul
 2023 18:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230725083212.0f59e6ac@canb.auug.org.au>
In-Reply-To: <20230725083212.0f59e6ac@canb.auug.org.au>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 26 Jul 2023 19:36:55 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKpDO4gtSBn=P1OdArY_s8Za0z7LTiAF3-=Ri5Bt+UfEQ@mail.gmail.com>
Message-ID: <CAL_JsqKpDO4gtSBn=P1OdArY_s8Za0z7LTiAF3-=Ri5Bt+UfEQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the devicetree tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 4:32=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> In commit
>
>   120e4bb6ca34 ("of: fix htmldocs build warnings")
>
> Fixes tag
>
>   Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node c=
reation functions")
>
> has these problem(s):
>
>   - Target SHA1 does not exist
>
> Maybe you meant
>
> Fixes: d9194e009efe ("of: dynamic: add lifecycle docbook info to node cre=
ation functions")
>
> I assume somthing has been rebased along the way :-(

Probably, but the above commit was committed Feb 20. You first sent a
patch on Mar 22.

> Also, please keep all the commit message tags together at the end of
> the commit message.

Looks like b4 was confused by "Reported by" (space instead of hyphen).

Anyways, both now fixed.

Thanks,
Rob
