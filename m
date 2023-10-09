Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1B7BD3C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjJIGt1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 02:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234248AbjJIGt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:49:26 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA1AAB;
        Sun,  8 Oct 2023 23:49:22 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f7f2b1036so50636227b3.3;
        Sun, 08 Oct 2023 23:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696834161; x=1697438961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GRUDqy2ec1uOO+SkamWEjCsINPtEX2s7XRvtWem4WwU=;
        b=oHnEfRr34G7Bl2kQKfa0CKutvpY3C+S4r6DDk7KWrPDePhmzml8rXoDFAspdE5ie/h
         wgFwn91053r7mTpauTfXb+8SHBgJ4531YvR8q4jKLsqqzNOsklrZRkB8XCitnSzu/H3k
         vpKCdKeiSBvDjMiq356ArxF3yeg0g2Y52jPwNCHeBfHhAQdzGSM7x3HUd1ANAgTWrKAX
         0MxmvFY5PApgVCwgIqb3FpbUYpLrdJS7ByYPqZGWOEB3tUM6VoFCe+zLIpI4Czm+0g+c
         ZC6qEJbdXTdKmQV7BK3MEyxILuRpZ3fcrhXr5j1zglkzEFfyl/XaUPCqBvex5vlMfdNE
         iRXA==
X-Gm-Message-State: AOJu0Yzjki2lBO6f3GOLbdjIrUVncXZGgpwqWkzALsSAH2SOlfrNCq+r
        fbTEMzqQ2fjsu4rvlw8pdNvi1BfiVMEezA==
X-Google-Smtp-Source: AGHT+IHueosdP3+utWq4nycDQ96AORUMippNKzYPOUHS73NO93DjseBReGn7TIb96aru23WgOnIbnw==
X-Received: by 2002:a0d:d782:0:b0:59f:4e6d:b56b with SMTP id z124-20020a0dd782000000b0059f4e6db56bmr15667728ywd.5.1696834161248;
        Sun, 08 Oct 2023 23:49:21 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id z16-20020a81a250000000b0059b24bd4f2asm3449977ywg.57.2023.10.08.23.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 23:49:21 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59f7f2b1036so50636117b3.3;
        Sun, 08 Oct 2023 23:49:20 -0700 (PDT)
X-Received: by 2002:a81:4917:0:b0:5a1:d11e:b754 with SMTP id
 w23-20020a814917000000b005a1d11eb754mr15294921ywa.26.1696834160791; Sun, 08
 Oct 2023 23:49:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231009111609.13ac1edb@canb.auug.org.au> <f0d0e8ad-8391-44f3-90e0-d2325daebb64@linux-m68k.org>
In-Reply-To: <f0d0e8ad-8391-44f3-90e0-d2325daebb64@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Oct 2023 08:49:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVo-H+q+X8XCZrVVG3W05B53=ttQ3LUcqbJkCV0-zWTaA@mail.gmail.com>
Message-ID: <CAMuHMdVo-H+q+X8XCZrVVG3W05B53=ttQ3LUcqbJkCV0-zWTaA@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the m68knommu tree
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Oct 9, 2023 at 4:00 AM Greg Ungerer <gerg@linux-m68k.org> wrote:
> On 9/10/23 10:16, Stephen Rothwell wrote:
> > The following commit is also in the m68k tree as a different commit
> > (but the same patch):
> >
> >    af580d01acc3 ("m68k: use kernel's generic libgcc functions")
> >
> > The is commit
> >
> >    a0938a8e2fb3 ("m68k: Use kernel's generic libgcc functions")
> >
> > in the m68k tree.
>
> Sorry, yes, fixed now. I removed it from the m68kmnommu git tree.

Thanks, I wasn't aware you had planned to queue it in the m68knommu
tree.  Sorry for not checking linux-next before.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
