Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C06F7EAB17
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjKNHuN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 02:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:50:12 -0500
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C8CC;
        Mon, 13 Nov 2023 23:50:08 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-daf2eda7efaso3815851276.0;
        Mon, 13 Nov 2023 23:50:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699948208; x=1700553008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZNKgiMastFHu6zZA090ti6BtPSEMiA1kjXskvmbMMYo=;
        b=q2tqCE6C1Ts03wECqY2AhXgR4YVIFRHBJ81waT+rcW92nSdemaj3dC3O1Svwxczi5G
         v+xoCw50tiNs5L/ZutOB3KWlBhwXgl4E4el63YO/gGVRBwv1Rmz6i25UevHazjn3b3p7
         8R4k9ZNo3/4IyYJWqo2nXe/JKELHTIy105G45dgZuiJOrjIVyEHB5PCywdyb5me+r+08
         cRzrxXBYs538WX1vZNU9yDbaOr1dyYNpL2Q+d0RrPQV9L01+qGatjGcIxpmIM8VYL6Nb
         cKiU3qhfNv3HbhiDu7lUEevGaHOcRrbYXAM2VYeXkInYjjouCAnrE/51dkE9PUkz/fcS
         Z24A==
X-Gm-Message-State: AOJu0YygjMEdD4xV9xYkVG0HkXeuXKhZesWXSOP74oHdfy+CfqY9gjxY
        pX6fLuwJ+dpCCjYWFmRIAzib6mRP0IaF/A==
X-Google-Smtp-Source: AGHT+IGS8j3IjpSJimjygO02lvI8vxOAd1pExxvzKvWhnUf2x/31X0MABM5GM8J5YkHScv+ICOfmsw==
X-Received: by 2002:a25:2d1e:0:b0:d9a:4a5f:415d with SMTP id t30-20020a252d1e000000b00d9a4a5f415dmr8844739ybt.0.1699948207828;
        Mon, 13 Nov 2023 23:50:07 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id p13-20020a056902014d00b00d9a43500f1dsm1920128ybh.28.2023.11.13.23.50.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 23:50:07 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a7eef0b931so61437687b3.0;
        Mon, 13 Nov 2023 23:50:06 -0800 (PST)
X-Received: by 2002:a0d:cc10:0:b0:5a7:c1f1:24b with SMTP id
 o16-20020a0dcc10000000b005a7c1f1024bmr10295001ywd.22.1699948206361; Mon, 13
 Nov 2023 23:50:06 -0800 (PST)
MIME-Version: 1.0
References: <20231114075136.3e164b4a@canb.auug.org.au>
In-Reply-To: <20231114075136.3e164b4a@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 14 Nov 2023 08:49:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSD3pXUOKQ_ShDLgDb=YCz26Ot3TzF3hrxjdrax2inJQ@mail.gmail.com>
Message-ID: <CAMuHMdXSD3pXUOKQ_ShDLgDb=YCz26Ot3TzF3hrxjdrax2inJQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the renesas tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, Nov 13, 2023 at 9:51 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Commits
>
>   e443f05dfa8f ("arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support")
>   ce2e1b36450e ("arm64: dts: renesas: rzg2l-smarc-som: Enable 4-bit tx support")
>
> are missing a Signed-off-by from their committer.

Thanks for reporting, please consider it fixed.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
