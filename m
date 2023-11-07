Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5378D7E3653
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjKGIG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKGIG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:06:56 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3F3EA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:06:53 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5b31c5143a0so64349107b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 00:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699344413; x=1699949213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUJsPs5h4dMzP+QB89ARP4Mh+Ywy+SZafpMELyFGsZk=;
        b=sNBLPe/WXi0zlrzu7zXUE26A5SLiDXqs6RiJyJfu0pGApG5cT1EgEQ94F1JbZnN46q
         8GaCpJdXZ4Zt2CYkVEj1tueR2JYV/shHhUyeM45Ezupo+P3sKO39g0ZAierHLXide/95
         bWc86BaEWYTqi7KargSeBX+T30vzGTo+rfwWxhO7j2xMKa88JLoIh2JicRXTTtfCI6F6
         U/pDcgrTkjR5cRnQxFEGOKXdu7xB2yZlJIwFyPc2h8y6kJCJINp8GUC3acDSb3FiJXDD
         UBdjE/Givc0wuZRkwYnI9iQGuqqXUrsxqlhmHH9vYdtGOWEvBCgbDvEkfMU7F4kUst0g
         klxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344413; x=1699949213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUJsPs5h4dMzP+QB89ARP4Mh+Ywy+SZafpMELyFGsZk=;
        b=RFBqySSI+Oz5lqwO+LFKFCOC0fg1MydD3KQ12i8hMH/Dr8XN4J1fSma/FHNVpvmVhZ
         t6xMaqfVV8LkhKzZAfIXBskVW90saO0CeiIcRAwtqVjKsiU+iSWevVv7JWKe9N59E9vW
         2/S4jmzj6ZOFaUuxJo0FciRZwSCHbVyQKa3SC6efQM/Lh/hsIS/Ftl+xWbLOturtDENw
         V3VbnnS210GPRljbw6Kwmks7XpqpJ29vFWB65nldH74KxfUGiv9K3C6Y2B8NSocIRJ+G
         mVDUQOpkYZVid1PdQ8L6a9/9bgnhglqaYqrDbw6rA4O3rrzheas84V/gQac4qdIYosAV
         Dh1A==
X-Gm-Message-State: AOJu0YyvdKs6v1MyIern/zH4dEQQh8xVPUA1co8viXN9snFMQPLgJuUD
        5LxovE+wR157I95cvp7TOxEX8goRNSJ+GIc2b5jMMkPl5DqfaAYO
X-Google-Smtp-Source: AGHT+IE7d3Kze4zoxfGZhZBBF402Jw5zAXD3ojtBzTrxh8AqoiccxgGCOfF7FL603CmDsZuQ4weTyq0dtC0V95L9E/Y=
X-Received: by 2002:a81:6582:0:b0:5a8:960d:e538 with SMTP id
 z124-20020a816582000000b005a8960de538mr13935556ywb.47.1699344413174; Tue, 07
 Nov 2023 00:06:53 -0800 (PST)
MIME-Version: 1.0
References: <20231106-virt-to-pfn-fix-ppc-v1-1-93197a7ccab4@linaro.org> <87ttpyw1ez.fsf@mail.lhotse>
In-Reply-To: <87ttpyw1ez.fsf@mail.lhotse>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Nov 2023 09:06:41 +0100
Message-ID: <CACRpkdbL1mfcAz9sPn89UGSQ6tb=jF6nRYAwp9Qz8zLXLLU_UA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Fix signature of pfn_to_kaddr()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 6:57=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.au=
> wrote:

> I'm struggling to connect the removal of const with those bug reports.
> It looks like all those warnings are about 0xc000000000000000 being
> outside the range of unsigned long when building 32-bit.

Aha right. I wonder what actually causes that.

> Is it the right bug report link?

Yeah I'm just bad at understanding these reports.

> The current signature of:
>
>   static inline const void *pfn_to_kaddr(unsigned long pfn) ...
>
> seems OK to me.

OK then, drop this patch.

Yours,
Linus Walleij
