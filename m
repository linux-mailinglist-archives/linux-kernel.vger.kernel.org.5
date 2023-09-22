Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90DD7AB55B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 18:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbjIVQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIVQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:00:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A7E99
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 09:00:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C434C433CC;
        Fri, 22 Sep 2023 16:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695398452;
        bh=xhaA32OBzVOM6nAoPy+gaX1FXQZKalbztmjU2PzXFPQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ggzP0E0DGs0mibxseVl52HMOQX0aJ/KNk9DKc7+M5mWQt6G8GwUN+N8OLddQSnP00
         mikR3nt6qzuamVj4tB1KHTzXqXbEsUT/Nz515Nxo3qSeT7fKjiTlGV+kk0HNmJFUtn
         h+W4eEBKX5fqYVPKRizLnCPkmHHPyQtJQ6xKkd3wWuC0bCTDOy3b6JN+vOBXl9CaNg
         2YV/3iwkjSnGvmL+BVVAwuWLJK5K/irp+IYCF9eS/5Y5q1UI8irQKKjxh5S5z6MQ0k
         MYor0XI3CmqlTXmq/gGMHA+94sJ8DMPEG3JOhP7KuaKERhhij7Qm1mRu96NSNFR2EC
         Q1uK6f7ijoBtw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50307acd445so3792965e87.0;
        Fri, 22 Sep 2023 09:00:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzd8T+BXNFU7FQRkwSSJl3XLaSo+3irguQppBcxi/Cz5Z8Jfpml
        iEt23VPL9kN9jJ55LW0tV2J0OuK2GWmns5hmjQ==
X-Google-Smtp-Source: AGHT+IEEE/JvcGeQD4KCzLIPPO9coF/0Kd1GNltvU5JvL5xNpex4YSVmnWqzCk9JmegTSZU7ZxtuJs2nrUqxTkVlYi8=
X-Received: by 2002:ac2:5041:0:b0:503:2623:7cfc with SMTP id
 a1-20020ac25041000000b0050326237cfcmr6407321lfm.34.1695398450443; Fri, 22 Sep
 2023 09:00:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
In-Reply-To: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 22 Sep 2023 11:00:38 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
Message-ID: <CAL_Jsq+WuYDU+yY98opTHr1PT-J9mFYJQBjVMnk+FSWLDUO33w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 1:45=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Binman[1] is a tool for creating firmware images. It allows you to
> combine various binaries and place them in an output file.
>
> Binman uses a DT schema to describe an image, in enough detail that
> it can be automatically built from component parts, disassembled,
> replaced, listed, etc.
>
> Images are typically stored in flash, which is why this binding is
> targeted at mtd. Previous discussion is at [2] [3].
>
> [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.=
org/
> [3] https://www.spinics.net/lists/devicetree/msg626149.html

You missed:

https://github.com/devicetree-org/dt-schema/pull/110

where I said: We certainly shouldn't duplicate the existing partitions
bindings. What's missing from them (I assume we're mostly talking
about "fixed-partitions" which has been around forever I think (before
me))?

To repeat, unless there is some reason binman partitions conflict with
fixed-partitions, you need to start there and extend it. From what's
posted here, it neither conflicts nor needs extending.

I did a bit more research. "fixed-partitions" as a compatible has
"only" been around since 2015. Prior to that, it was implicit with
just partition nodes with addresses (i.e. reg) and that dates back to
2007. Looks like u-boot only supports the newer form and since 2021.

Rob
