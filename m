Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A436C808B7A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 16:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjLGPLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjLGPLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:11:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319C4E9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:11:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C20AFC433C9;
        Thu,  7 Dec 2023 15:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701961898;
        bh=3mIbHVyQYh29uJuAMGbzFAE0OIGSXCm8+OVelPkKgC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B4qgp41uCCiI4YBd+DOBvvHc7MuCVaT34hxVK4FCrwSHiPuErk2TzTNDaYKazUNta
         KiUxf+afNkOjYl0j22oczMElIK57ocgMOf/+9e7aI9+IS3ueUqeJW86mB0x0PSJKjo
         dmhb42vu3sxl3hfW9bzKzWNg613VvnYpEyUfBOcwpeURa7RKl0hHZpY09ZB4b1LY0H
         zyvT3NxnW8e3r4jP5R9qg4kYyOx9a4EfKGLWmX0PLvS/x9Krjo6+MUedYYImHQ+0qq
         Wv/HKUwNK1HgANn07B6smn9DTBkNldUtmumFchMHvi1cwTaMCnvGwPYwY2eRrrhnPp
         oGlrnHyP8oFvw==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50bdec453c8so988736e87.3;
        Thu, 07 Dec 2023 07:11:38 -0800 (PST)
X-Gm-Message-State: AOJu0YzIwqljkPWjkYHB4ivEtQ6kXBIpgI3LEiKSJMLGeTettH8A0D8t
        qu5iKryM/UkaCmP3mk96kfzNmrcGXy362Fqhzg==
X-Google-Smtp-Source: AGHT+IEDUE3Dkxw+tzRzMgfvhX4FgqD5y9gpeZ/cqurOkrW+43qs1KpchHVDvADVBE4q03ymgHWalBCT2F8NDwPc6OE=
X-Received: by 2002:a19:8c42:0:b0:50b:fa2e:4bce with SMTP id
 i2-20020a198c42000000b0050bfa2e4bcemr1548695lfj.9.1701961896987; Thu, 07 Dec
 2023 07:11:36 -0800 (PST)
MIME-Version: 1.0
References: <20231207125737.5e7553e3@canb.auug.org.au>
In-Reply-To: <20231207125737.5e7553e3@canb.auug.org.au>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Dec 2023 09:11:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXo+Cr=9s=dt1kCQeMadJ_cnuSpm06zmvK8yd-vd2X3g@mail.gmail.com>
Message-ID: <CAL_JsqKXo+Cr=9s=dt1kCQeMadJ_cnuSpm06zmvK8yd-vd2X3g@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the devicetree tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 7:57=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> After merging the devicetree tree, today's linux-next build (x86_64
> allmodconfig) failed like this:

Not too surprised...

> drivers/auxdisplay/img-ascii-lcd.c: In function 'img_ascii_lcd_probe':

This is fixed in the auxdisplay tree. There are other trees with
dependencies as well, so I guess they happen to get merged before the
DT tree?

> drivers/firmware/microchip/mpfs-auto-update.c:439:42: warning: 'struct pl=
atform_device' declared inside parameter list will not be visible outside o=
f this definition or declaration
> drivers/gpu/drm/bridge/aux-hpd-bridge.c:27:9: error: implicit declaration=
 of function 'of_node_put' [-Werror=3Dimplicit-function-declaration]

These look like new drivers since I last tested.

> drivers/tty/serial/esp32_acm.c:367:37: warning: 'struct platform_device' =
declared inside parameter list will not be visible outside of this definiti=
on or declaration
> drivers/tty/serial/esp32_uart.c:678:36: warning: 'struct platform_device'=
 declared inside parameter list will not be visible outside of this definit=
ion or declaration

This one I just missed...

I'm sending out fixes for all these. I want to get the final patch
("of: Stop circularly including of_device.h and of_platform.h") for
all this in next to get some better build coverage and catch any new
drivers added. But if it is dropped for every new driver that breaks,
I'll never get it in. Can you fix these up or just leave them broken?
I can keep the fixes in my tree until they get applied by the
corresponding subsystem.

Rob
