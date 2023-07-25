Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC3760C03
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbjGYHf6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Jul 2023 03:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGYHeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:34:15 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B261FF5;
        Tue, 25 Jul 2023 00:34:07 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-577ddda6ab1so77060567b3.0;
        Tue, 25 Jul 2023 00:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690270447; x=1690875247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0qL9IZYgpO3GCH2h6qtSZKecTbJOQZsWeaP2pk98kY=;
        b=HMayid02j2VOY7byYGkgJr1TCrYuNo3jvY9vEfE2NMcozg6xWYlRG0qwD5as3KheMk
         QDwfEM2mpriIqzGndaFnO+yIDj+LxMbRf0ifz1ot4oLZMmRxTfx2vuzFhEsWvt3dXIJ6
         nL8AvljVncnNxhT7kY5Sw8pka9Gil/B7Uoy7jZFX6R5e6X04A+PfJ9k6QPjsNPglujPF
         ngzSoX+eRyj58QqDm/Uhw2hffmLgmm5vXXwS4plCmHeVEF4lr1XY3YQ1yzkcHJz+z0Nc
         Xk4oKz9dN+fR+qxuAnaaj/ZU0WC17iP2VGYQTGpJZCpa+rSq0iss50wduFN9ReO71BhW
         ofTQ==
X-Gm-Message-State: ABy/qLb419yb6yWaWPkmOXU8TBa4qsO13FMp+lwI3MyvLtiTT5u7bGht
        WJuv+P8xpErCbx9tUtfA/6fIe9hMdo1yjA==
X-Google-Smtp-Source: APBJJlFlAGoRaosh5iZDK3DZ9eQN1ijqTENzra5syEOOY8reEQGVOI54toXgjXUJFjYSH8A2zyJYgw==
X-Received: by 2002:a81:6d88:0:b0:583:821b:603a with SMTP id i130-20020a816d88000000b00583821b603amr1624421ywc.20.1690270446837;
        Tue, 25 Jul 2023 00:34:06 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id d205-20020a8168d6000000b00577269ba9e9sm3394641ywc.86.2023.07.25.00.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 00:34:06 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-d13e0bfbbcfso1926945276.0;
        Tue, 25 Jul 2023 00:34:06 -0700 (PDT)
X-Received: by 2002:a25:ac5b:0:b0:d0d:f4c0:ddb3 with SMTP id
 r27-20020a25ac5b000000b00d0df4c0ddb3mr1443938ybd.6.1690270446138; Tue, 25 Jul
 2023 00:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230721062617.9810-1-boon.khai.ng@intel.com> <20230721062617.9810-2-boon.khai.ng@intel.com>
 <e552cea3-abbb-93e3-4167-aebe979aac6b@kernel.org> <DM8PR11MB5751EAB220E28AECF6153522C13FA@DM8PR11MB5751.namprd11.prod.outlook.com>
 <8e2f9c5f-6249-4325-58b2-a14549eb105d@kernel.org> <20230721185557.199fb5b8@kernel.org>
 <c690776ce6fd247c2b2aeb805744d5779b6293ab.camel@perches.com>
 <20230724180428.783866cc@kernel.org> <213f5d2b13225f9ed4bdadda3c492ffc79940b13.camel@perches.com>
In-Reply-To: <213f5d2b13225f9ed4bdadda3c492ffc79940b13.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Jul 2023 09:33:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX0DpNSDRSJ7D85NGV2ri2kFHjTtXJE5aOaTD3jNoyc-w@mail.gmail.com>
Message-ID: <CAMuHMdX0DpNSDRSJ7D85NGV2ri2kFHjTtXJE5aOaTD3jNoyc-w@mail.gmail.com>
Subject: Re: [Enable Designware XGMAC VLAN Stripping Feature 1/2] dt-bindings:
 net: snps,dwmac: Add description for rx-vlan-offload
To:     Joe Perches <joe@perches.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        workflows@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        MarioLimonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Jul 25, 2023 at 6:22 AM Joe Perches <joe@perches.com> wrote:
> I do suggest you instead write wrapper scripts to get
> the output you want rather than updating the defaults
> for the script and update the process documentation
> to let other people know what do to as well.
>
> Something akin to Mario Limonciello's suggestion back in 2022:
>
> https://lore.kernel.org/lkml/20220617183215.25917-1-mario.limonciello@amd.com/

FTR, this is more or less what I am using to generate a script
to send out patches:

    OUT=...
    echo git send-email \\ > $OUT
    # Add -cc
    # Wrap comment inside $(: ...)
    # Replace (...) in comment by [...]
    # Replace ] at EOL by ) again
    # Add continuation to EOL
    scripts/get_maintainer.pl $* | \
    tr -d \" | \
    sed -e 's/^/--cc "/' \
        -e 's/ (/" $(: /' \
        -e 's/ (/ [/' -e 's/)/]/' \
        -e 's/]$/)/' \
        -e 's/$/ \\/' | \
    tee -a $OUT
    echo "*[0-9][0-9][0-9][0-9]-*.*" >> $OUT

After generation, I edit the script to
  - Replace some --cc by --to,
  - Add/remove some people,
and run "source $OUT" to send the patches...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
