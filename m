Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21FD475EE54
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbjGXIuq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Jul 2023 04:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjGXIun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:50:43 -0400
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6099DAF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:50:41 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-cea0021d1f3so7621316276.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690188640; x=1690793440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eru5igGG5ZNMFyi9+7h599RckQE/U9fJOptjtiH/IWA=;
        b=EkCXiHqj4/VKRKeeEjEgSdMD7crdlGXhlb/YwHHz3kh3FveUMOPJLtE7ARMKjdfv3O
         GM7kkQxe+cP8i1jcQc2CB2kWEFM77tJKxFWFC4YJ7AQKywUyAGI+m1ARMYxYnthA1Uku
         Wm7vWtdcMgUJbURRTCmkQXGP40iHVK13PziRKh25oGpSNY+vzhf1PYh41uJ7WbWXKMRp
         8Ij3+64D1FbIw9OAmPna/sUU6Hri0QaPMYa72Uz4sWTK357Bsyd9eWyeiy+nyy1q5Z+U
         rcoSS1oYng7zrar0w5EKnIFuW+WEvlRodSyiatOv2E+1qo/8VM6zkgmINaXsTlIMMtMN
         2E1A==
X-Gm-Message-State: ABy/qLZFin7kl0JEw6hcGilHSMznASVZ6Niq3sXCETxN/2Ci/DrrEXrC
        VikmMaQkviQIAaergmUTPIDy6msL3UgI7Q==
X-Google-Smtp-Source: APBJJlEREVRu4bG1oZY61fBWxCKpEbkRgO99aB8zn2iuIYvOQCKf4XHqM+w6X+4hBmMGlJwsRd45ZQ==
X-Received: by 2002:a0d:d6c2:0:b0:577:2aa4:70aa with SMTP id y185-20020a0dd6c2000000b005772aa470aamr4893389ywd.21.1690188640269;
        Mon, 24 Jul 2023 01:50:40 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id z4-20020a81c204000000b005772fc5912dsm2647506ywc.91.2023.07.24.01.50.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 01:50:39 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-d13e0bfbbcfso330284276.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:50:39 -0700 (PDT)
X-Received: by 2002:a25:f54:0:b0:cef:9a1b:8380 with SMTP id
 81-20020a250f54000000b00cef9a1b8380mr6389620ybp.24.1690188639473; Mon, 24 Jul
 2023 01:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230721075949.5632-1-xujianghui@cdjrlc.com> <fcc5460f8a84680d6e7379d320ad0575@208suo.com>
In-Reply-To: <fcc5460f8a84680d6e7379d320ad0575@208suo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Jul 2023 10:50:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX-wns-BuCGSvC+fLS_RogY=uo2Md_7cnxyHtd-+sHoww@mail.gmail.com>
Message-ID: <CAMuHMdX-wns-BuCGSvC+fLS_RogY=uo2Md_7cnxyHtd-+sHoww@mail.gmail.com>
Subject: Re: [PATCH] m68k: Fix two occurrences of the checkpatch.pl error:
To:     sunran001@208suo.com
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ran,

On Fri, Jul 21, 2023 at 10:04 AM <sunran001@208suo.com> wrote:
> ERROR: that open brace { should be on the previous line
> ERROR: space required after that ',' (ctx:VxV)
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>

Thanks for your patch!

But obviously you forgot to run scripts/checkpatch.pl on your own patch:

    WARNING: A patch subject line should describe the change not the
tool that found it
    #2:
    Subject: [PATCH] m68k: Fix two occurrences of the checkpatch.pl error:

    WARNING: From:/Signed-off-by: email name mismatch: 'From:
sunran001@208suo.com' != 'Signed-off-by: Ran Sun
<sunran001@208suo.com>'

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
