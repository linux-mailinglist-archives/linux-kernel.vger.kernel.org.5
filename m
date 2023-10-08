Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9E97BCF37
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 18:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344849AbjJHQAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 12:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbjJHQAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 12:00:36 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF751C5
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 09:00:34 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 81C4640E01AA;
        Sun,  8 Oct 2023 16:00:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id td4bOXP08P_s; Sun,  8 Oct 2023 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696780830; bh=5n35o/TCXyFSTC6RXXRKggxle8tJKsdLt7OmeGuIaSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LId0FWAzezBwMimVuk2C4BwPqqRP1uy+cp1hc5VoHrTM4iU9Pj1+xIVENZUu/019q
         bFXXaxnxdZKNiYjfZuCOgh68/kP2AYhxdnQhJyYl0weWjLU5wL6W4ZipO/vCq/EnNZ
         UQqVlBlvzneOHGVJ8/G+0PBnTyL9mWoWA0/106Zo6i4nvFD4/5KhDSSsStTGj7I8Xz
         E9S4Qz0Ev6odUBVznCCwrMhV/MtEj5GwEeOnRSKqwEx5ZS+pxXWB0GJY5nSOVKbtXW
         VHeEvqP79C4esstw9sA4J76JspKYvkSmBI48kAyNukWJy4oAGiiRgORzYUOF3XtZja
         dGUvpw3xNmbaAG35Wii8dj6e3dWs6k9vYI24irK6PyPh9g+j+eisBTcPpoRzUFMG/7
         yMQ3OSgu49BRL7+mPKU55Smgt288QhmxAadJfjR79+0WlWksxZlchjRpY+jc3WG7NI
         R7f2B2Ij0GWluyaFOwWqjUyC9Bf8q2nTKWBcfmzCR10caQkMHoo9shiASbV0547j9k
         3MPcnnfOPFobVMsB/gv8p+VajPk/waUPbLCAXqIBCqALlY/Tdxs9/wQyS8cuVArUw5
         vj3bIm/6trRZ6vWDsHA0uxvARAqQIENtMf1N/lqach3Vp9J2pIHn0fW+9Xr0rOx0El
         SvOJEVnkJVn+TaEw3e0e07CA=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AD39140E0177;
        Sun,  8 Oct 2023 16:00:27 +0000 (UTC)
Date:   Sun, 8 Oct 2023 18:00:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] irq/urgent for 6.6-rc5
Message-ID: <20231008160022.GDZSLSFts55BpX6M7F@fat_crate.local>
References: <20231008130634.GBZSKpWoTIzUDQMgs/@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231008130634.GBZSKpWoTIzUDQMgs/@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah,

please do not pull that one yet - reportedly, a commit in there has
a wrong SOB chain which tglx wants to fix first.

Thx.

On Sun, Oct 08, 2023 at 03:06:34PM +0200, Borislav Petkov wrote:
> Hi Linus,
> 
> please pull a couple of irqchip fixes for 6.6.
> 
> Thx.
> 
> ---
> 
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> 
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.6_rc5
> 
> for you to fetch changes up to 9cd847ee4d64c10b52f26f18d19eb6462ba7d2fe:
> 
>   Merge tag 'irqchip-fixes-6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent (2023-09-28 23:04:13 +0200)
> 
> ----------------------------------------------------------------
> Irqchip fixes by way of Marc Zyngier <maz@kernel.org>
> 
> - Fix QC PDC v3.2 support by working around broken firmware tables
> 
> - Fix rzg2l-irqc missing #interrupt-cells description in the DT binding
> 
> - Fix rzg2l-irqc interrupt masking
> 
> Link: https://lore.kernel.org/lkml/20230924094105.2361754-1-maz@kernel.org
> 
> ----------------------------------------------------------------
> Biju Das (1):
>       irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source
> 
> Dmitry Baryshkov (1):
>       arm64: dts: qcom: sm8150: extend the size of the PDC resource
> 
> Lad Prabhakar (1):
>       dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update description for '#interrupt-cells' property
> 
> Neil Armstrong (1):
>       irqchip/qcom-pdc: Add support for v3.2 HW
> 
> Thomas Gleixner (1):
>       Merge tag 'irqchip-fixes-6.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent
> 
>  .../interrupt-controller/renesas,rzg2l-irqc.yaml   |  5 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi               |  2 +-
>  drivers/irqchip/irq-renesas-rzg2l.c                |  2 +-
>  drivers/irqchip/qcom-pdc.c                         | 69 ++++++++++++++++------
>  4 files changed, 56 insertions(+), 22 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
