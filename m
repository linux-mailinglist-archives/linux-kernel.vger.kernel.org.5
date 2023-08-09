Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29F4774FBC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 02:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjHIAPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 20:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHIAPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 20:15:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C81996;
        Tue,  8 Aug 2023 17:15:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF15D62E5B;
        Wed,  9 Aug 2023 00:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EEB9C433C7;
        Wed,  9 Aug 2023 00:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691540142;
        bh=Z/PzABt4yt6pB7W6zcNJyZg9QLMe8RQXoLL9jioMaLo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JgAwzxI3HMQmgfnxNA6oQck5CYyBENOfzYqBCGCzf80RKP8dYRnV2Rnq5twL6cWoW
         Oqg87XbROkHnYNTE02odPJKBjYYym1CwcOlMg+xOIInOfACVjLMGmAiLt4Fm8KUGqc
         31p530ZuBdh2ZbHBRsyo4AItz3TklpspwKSzppaJQbYrUyhuzbo7g18CpzBNg08fVu
         Iexigjzin9wr4LM0P9jSIAZsJJM/GzXU3VmnS0n3ATXQdGSiy+R7pPSHj+e9CRctoJ
         /BFZIFLz/ioMlNWucqXxvF5OT3TkE1PJtsxLiN0/90P6EBQyrTVv9ck/9d6h8FDUnR
         PtIsUIDyrUX+w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2b9a2033978so96690781fa.0;
        Tue, 08 Aug 2023 17:15:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YxHhEofRqw7Rub+wocMRusWHV15YlhfMpYrlRYvGCxSgTTCVfMP
        HPHrh7cbgaJkXydAnp2NRQWtbwrnuJQg8wmlqw0=
X-Google-Smtp-Source: AGHT+IFRENO8L5910xSKB4YBZKHrFeiO4P731S9dDkQX5Tj3Roeili0J2IZROdoUlzfJiaySP9X2B+lj60fK00xb0Nk=
X-Received: by 2002:a05:651c:214:b0:2b6:de52:34f with SMTP id
 y20-20020a05651c021400b002b6de52034fmr728417ljn.24.1691540140217; Tue, 08 Aug
 2023 17:15:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
In-Reply-To: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 9 Aug 2023 08:15:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS3xmn7YFzBLfOEJ-WX5FRth=_Q5YDwzXrK0dJBOECBvw@mail.gmail.com>
Message-ID: <CAJF2gTS3xmn7YFzBLfOEJ-WX5FRth=_Q5YDwzXrK0dJBOECBvw@mail.gmail.com>
Subject: Re: [PATCH 0/2] csky: Convert memory accessors to static inlines
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 8, 2023 at 4:26=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> This converts the virt_to_pfn and pfn_to_virt macros
> into static inlines so we get proper type checking on
> the pointers passed in.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Linus Walleij (2):
>       csky: Cast argument to virt_to_pfn() to (void *)
>       csky: Make pfn accessors static inlines
>
>  arch/arc/include/asm/page.h  |  2 +-
>  arch/csky/include/asm/page.h | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
> ---
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> change-id: 20230808-csky-virt-to-phys-3d80c17211f9
>
> Best regards,
> --
> Linus Walleij <linus.walleij@linaro.org>
>
Thx, Approved.


--=20
Best Regards
 Guo Ren
