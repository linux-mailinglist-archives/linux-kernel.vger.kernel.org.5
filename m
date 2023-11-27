Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B747FA82D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjK0RgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjK0RgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:36:22 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A101E198;
        Mon, 27 Nov 2023 09:36:28 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CE00340E024E;
        Mon, 27 Nov 2023 17:36:26 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UVu3Syl5LlkR; Mon, 27 Nov 2023 17:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701106584; bh=fXeNq8uj+nYXQQwj1hJlpkSJlDEw/i6llRh8605Z9QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSVuDUXnx15IPUzU1CHgYrL2rbzydK5udJF5wy4RepcKg55kRqtGMh+3GXTKw4XDR
         I96/ngHpf1cDvsaoDSbp4Dv+VBoSQMjdIxh6z4wJzuMnAmD2tniFsR1iDDG2Y41H8P
         DgVQxRKDEevJ9dRREdXzXhM7i2+P9ReVusEI5S+MIVFHNdRO97m7BugZfWnIgL4CCG
         iIOl/JmXhlOJ5BkhRIYInKPm2y+W1JN6V8dXiAkGjUH4Elo+xqUodo7rQmoXxt+eo7
         6i3873rWhXG/nKYQKdwFWkmw9HOe/LQtkg+E0+amMeapYlYbTnKtnHjMTvZgs0py2z
         sHyAHchMjYbDZPhROWanqtVrQzciWFsJf4jbDgvJOrDz0g32MlsYpzgGtC4cvg1Cer
         /OI2efemu8pq8jqrGlUNJ1iI4aFvt0D4D5XJmLYJahZQc+/OrUNbrXkK2DU+ZELdXE
         X1SsiJeDPhkRiRn6ZJUBvrjEQnQuXbfdJbIBFErOkS2yfgwY7MY786PJuOsMHsmtfb
         NBATAOzVirxmLu5rnMDv3Pu6fzZWitqNM8D75QU8/WwUzZl3IcZjmRoqODDaIoTt2G
         WfUkbB6zjj3y+Ym8tMBcnQyIniEozTL/UiiHuP7o6YHf3tOuJTzLT4BT2vI+adx3Z2
         /aLV0ydJ88B1UY3FEwOP+Y+A=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9406840E01B1;
        Mon, 27 Nov 2023 17:36:16 +0000 (UTC)
Date:   Mon, 27 Nov 2023 18:36:10 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Jan Luebbe <jlu@pengutronix.de>, Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EDAC: armada_xp: Explicitly include correct DT includes
Message-ID: <20231127173610.GDZWTTigD7tzi3jVJk@fat_crate.local>
References: <20231013190342.246973-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231013190342.246973-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:03:42PM -0500, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/edac/armada_xp_edac.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
