Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2CD770548
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbjHDPwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjHDPwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:52:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F121849D7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8178C6209F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 15:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50B5C433CA;
        Fri,  4 Aug 2023 15:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691164354;
        bh=LOq7RS20TqfH4Hdkn/iEhzGYnzzqU4MxbtyZDje5DTM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=db/QpyGWZiGv+hOkDcQmId64EfLtCECXdj6SVN9iqNnUz87wDzhSDSDKkPqhesxXc
         XkYO8574UAfmZclBZdnsGi8VAqj7rHu/+xeRD5KvG+ijc7xo9ROK2jfD8yKTKqRCsq
         zX7BT0Uug6JnRWvDTte1vdDZs+zBhkIs/jjQPHMmwIvSG5BIkp48BbFKST0uVCujlZ
         cjAylaRSCFsl6gdna/65Ckv7KfS6T+R/op7i0mliGSpS53yTpBcmy7X+2F4JyUZyFj
         GtkGEVfoBBfJpXmPTUq+8Kd9wNfncXOGt2deJxPXuSrP9bccesOId7cwFMM5+Q17UG
         R0JgvLmb+aF9g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso35377221fa.0;
        Fri, 04 Aug 2023 08:52:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YwqQwElZ+9EW5E8jDLO+uma3SHv/xdX+z8dcOj3ad9CUYgwuOPY
        Qezacz6yOc2vvZJLp6AO/yw0rB+E2HANBn2XmQ==
X-Google-Smtp-Source: AGHT+IGTRbQZ164zyFuRSDnd5vaQ7H79WmuECLzjpyyzN1RdAra6RmdexIM3oHlL3swhcI2UIbnez1POXc8rZk7AbpE=
X-Received: by 2002:a2e:9d5a:0:b0:2b9:53bd:47a7 with SMTP id
 y26-20020a2e9d5a000000b002b953bd47a7mr1705190ljj.30.1691164352899; Fri, 04
 Aug 2023 08:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
In-Reply-To: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Aug 2023 09:52:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
Message-ID: <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev
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

On Fri, Aug 4, 2023 at 9:27=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> wro=
te:
>
> Hi,
>
> With recent kernels (5.18 and newer) the ethernet is all wonky on my
> ZCU104 board.
>
> There is some behaviour inconsistency between kernel versions identified
> during bisection, so maybe there is more than one issue with the ethernet=
?
>
>   6.5-rc4: after 10 seconds, the following message is printed:
>
>     [   10.761808] platform ff0e0000.ethernet: deferred probe pending
>
>   but the network device seemingly never appears (I waited about a minute=
).
>
>   6.1 and 6.4: after 10 seconds, the device suddenly appears and starts
>   working (but this is way too late).

10 sec is probably the deferred probe timeout. You can set this to
less time on the kernel command line.

>   5.18: the device never appears and no unusual messages are printed
>   (I waited ten minutes).
>
> With 5.17 and earlier versions, the eth0 device appears without any delay=
.
>
> Unfortunately, as bisection closed on the problematic section, all the
> built kernels became untestable as they appear to crash during early
> boot.  Nevertheless, I manually selected a commit that sounded relevant:
>
>   commit e461bd6f43f4e568f7436a8b6bc21c4ce6914c36
>   Author: Robert Hancock <robert.hancock@calian.com>
>   Date:   Thu Jan 27 10:37:36 2022 -0600
>
>       arm64: dts: zynqmp: Added GEM reset definitions
>
> Reverting this fixes the problem on 5.18.  Reverting this fixes the
> problem on 6.1.  Reverting this fixes the problem on 6.4.  In all of
> these versions, with this change reverted, the network device appears
> without delay.

With the above change, the kernel is going to be waiting for the reset
driver which either didn't exist or wasn't enabled in your config
(maybe kconfig needs to be tweaked to enable it automatically).

There's not really a better solution than the probe timeout when the
DT was incomplete and new dependencies get added.

> Unfortunately, it seems this is not sufficient to correct the problem on
> 6.5-rc4 -- there is no apparent change in behaviour, so maybe there is
> a new, different problem?

Probably. You might check what changed with fw_devlink in that period.
(Offhand, I don't recall many changes)

> I guess I can kick off another bisection to find out when this revert
> stops fixing things...

That always helps.

Rob
