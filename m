Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0046A771519
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 14:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjHFMqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjHFMqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 08:46:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE9C19A9;
        Sun,  6 Aug 2023 05:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EE39610D5;
        Sun,  6 Aug 2023 12:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E8FC433C9;
        Sun,  6 Aug 2023 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691325968;
        bh=6TIGYL50jTt3RrR8Xa/GJs4fTWIOeNqCJEHk92mA1bs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s+hobwR4AYXqD/rq1kG364h+zd5zrvcO8GUlfPLH2Gd1f1HhDQdZ8R6O/3744EBu3
         CvhGrRDecb6YsIPyo6ZhkP+j/GSsmeK6nsG+ztpfV7xErN7BNhPDo4p6cy3cLPITRU
         CDzDn7Q9yXu3fMGJODbn5eNqHfIcUUuvXYwATTWKj6EEuTP1kQ2zTiRX7MbPY8fAme
         4PPowr/Tf3dQde8jj3aP2QZ8g+2w5OHF5bfZOtJZZw4A6KcD2UZBO5c+MRFvE3D7GY
         s7MWxkelro5OiHnzvoNScYHqjE3AbWENjHwYTYAGIqNnMzsp7wEYTBiOhH3/EgRyt6
         pqtfQiX2HM8qQ==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-56c711a88e8so2358980eaf.2;
        Sun, 06 Aug 2023 05:46:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+kJszd7Uz2ObZdIHeVlESTMn6EtWC8nuUR0+fzte4Y2WS8us3
        s1Kr67WbUwxn7Vz4nbQZijW9OmJWiO/aXFBxlSg=
X-Google-Smtp-Source: AGHT+IEyMoB0Ew6vqKlPnKkZmJiaVsE8EEInCUUd1A2P50FmKcHZdfnK4qioSyV1ri3JPM++aUFBhZ8VlO7KIT0jUHg=
X-Received: by 2002:a4a:3406:0:b0:56c:a273:7d99 with SMTP id
 b6-20020a4a3406000000b0056ca2737d99mr5827609ooa.5.1691325967305; Sun, 06 Aug
 2023 05:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230801174922.333700-1-bmasney@redhat.com> <20230801174922.333700-3-bmasney@redhat.com>
 <CAK7LNAQ-nhy1_xFYiwuvOKvfUVSjvnEb4ZnJ8EMWo7uJun89Zg@mail.gmail.com> <ZMt+DGRQIZ52miGF@brian-x1>
In-Reply-To: <ZMt+DGRQIZ52miGF@brian-x1>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Aug 2023 21:45:31 +0900
X-Gmail-Original-Message-ID: <CAK7LNARauVPQPt5SGZ9=i=RcY2eOnhdMOqpW_+s0hfooG37SrA@mail.gmail.com>
Message-ID: <CAK7LNARauVPQPt5SGZ9=i=RcY2eOnhdMOqpW_+s0hfooG37SrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] scripts: add kconfig lookup script
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 7:14=E2=80=AFPM Brian Masney <bmasney@redhat.com> wr=
ote:
>
> On Thu, Aug 03, 2023 at 03:23:16PM +0900, Masahiro Yamada wrote:
> > Everyone tends to have their own utility scripts
> > on their machines.
> >
> > I think this patch set falls into that category
> > as "create a wrapper script of grep" is what everyone
> > does to reduce typing.
> >
> >
> >
> >
> > FWIW, I have the following scripts in my ~/bin directory.
> >
> >
> >
> > $ cat ~/bin/kgrep
> > #!/bin/sh
> >
> > exec find . -name .repo -prune -o -name .git -prune -o -type f \
> > \( -name 'Kconfig*' -o -name 'Config.in' \) \
> > -print0 | xargs -0 grep --color -n "$@"
> >
> >
> > $ cat ~/bin/mgrep
> > #!/bin/sh
> >
> > exec find . -name .repo -prune -o -name .git -prune -o -type f \
> > \( -name 'Makefile*' -o -name 'Kbuild*' -o -name "*.mk" \) \
> > -print0 | xargs -0 grep --color -n "$@"
> >
> >
> >
> >
> > masahiro@zoe:~/ref/linux(master)$ kgrep -A5 TSL2772
> > ./drivers/iio/light/Kconfig:564:config TSL2772
> > ./drivers/iio/light/Kconfig-565- tristate "TAOS TSL/TMD2x71 and
> > TSL/TMD2x72 Family of light and proximity sensors"
> > ./drivers/iio/light/Kconfig-566- depends on I2C
> > ./drivers/iio/light/Kconfig-567- help
> > ./drivers/iio/light/Kconfig-568-   Support for: tsl2571, tsl2671,
> > tmd2671, tsl2771, tmd2771, tsl2572, tsl2672,
> > ./drivers/iio/light/Kconfig-569-   tmd2672, tsl2772, tmd2772 devices.
> >
> > masahiro@zoe:~/ref/linux(master)$ mgrep efivarfs.o
> > ./fs/efivarfs/Makefile:6:obj-$(CONFIG_EFIVAR_FS) +=3D efivarfs.o
> > ./fs/efivarfs/Makefile:8:efivarfs-objs :=3D inode.o file.o super.o vars=
.o
> >
> >
> >
> > That's my local way to satisfy my demand.
> > I do not intend to force my way or merge it in the upstream.
>
> OK, fair enough.
>
> Those are useful little utilities and simpler than what I posted. If
> something like these had been in the scripts/ directory, then I
> wouldn't have spent the time to write yet another script that does
> basically the same thing. I get what you are saying, however having
> a script to lookup a Kconfig by name or module will be useful to other
> people.
>
> Brian
>

I do not want to fill the scripts/ directory
with random trivial scripts.

I need to draw a line between
"the time cost for writing the code by myself" vs
"the time cost for searching for a similar script".

I'd rather write the code by myself
if it is a script of a few lines.




--=20
Best Regards
Masahiro Yamada
