Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6915475BFF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 09:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjGUHjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 03:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjGUHjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 03:39:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A871E19A1;
        Fri, 21 Jul 2023 00:38:58 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E21B51EC0BE2;
        Fri, 21 Jul 2023 09:38:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1689925126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KAUU/mdQhd4wg4dt+1FcBtRhDhZZCh+Oqx1GNFQ2HqQ=;
        b=H/YFvoh8XMZfoEqGM7qZkRTLrfhZlT2DvBWpfIPFpqaa4T5a8BMeph7Fd4RGUf9xf1GIXo
        5/yTVgh4Qb4lkxo44i9ccQBU8kxHs3PinwyMjSgsIqnmZnKV6Pvl2xICqRPasDlX6HbHCJ
        lfPomGrUvas3A8MwDSJAM7SaZRxS8rc=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4S9mVmsDxJuN; Fri, 21 Jul 2023 07:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1689925124; bh=KAUU/mdQhd4wg4dt+1FcBtRhDhZZCh+Oqx1GNFQ2HqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuOMpjP/mk2PCS4QCTX2fuHKJo+7+r4eIuRcoSQcBIyjmuC3y4bxKHunGcD0/XLdY
         H4How9uU9jt8gHRf6vBeZIauU0TJakr+0iE+fIxykB+vBgERhnNVaWUOjKzGwnPUZd
         T0q8Ivn9wIWrU42CXkSd66Pl9rVoGteD8NklIEfELBQl2uvS2ypzxY3J3YL3r/6+iJ
         kI40S++QVHjhcrPav3tt2ptWkRg9q9DSOYGmS/B/AiabBxmh9iluJq5KOZsYQbQb2q
         XqziAtVPUuG8zYAQxvMIwpsFEPKtVbTlgEJbWqgKDXvQf+aNqGaWaYOP9u2KvDIRiY
         tRGwwmYlvjpdzTmlifXm3Bpdvvolx4ay054vY86h/G6ECpz+5TEXsTlAFdLVWb70rT
         E8kvYxzXyErY6bgde4NCC5suKMbdi8zI/aczK4a+hGF2BLzKYUP+RM3CMybq8hgNuJ
         puxeELmkdOudKtaiHCjbP1Nh0e1v6+cQt1HHGhkMDYMIn4m5bXnAUbIA1yZxlgB3/1
         Bns1/GVAgHMRhtM3L42BPvH58e28MaAr9VcmjaxDsBK6oawOl6Y2YyWEov0R3FAbVy
         /QZh0PS8pLnA+Cp+aItu2LpnDIEsFOwJckhD/I753KTRKX1Z0YenzsmtOFCol1nnwu
         pociFFbVljCb4hT6E6yXimRU=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0838E40E0034;
        Fri, 21 Jul 2023 07:38:35 +0000 (UTC)
Date:   Fri, 21 Jul 2023 09:38:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     John Allen <john.allen@amd.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Message-ID: <20230721073830.GAZLo19vwzyEWESHum@fat_crate.local>
References: <20230720202813.3269888-1-john.allen@amd.com>
 <748e8be1-d7e6-c0a3-b83b-a8475873cc4c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <748e8be1-d7e6-c0a3-b83b-a8475873cc4c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:47:39AM +0200, Jiri Slaby wrote:
> is now 32M instead of 12M. That is a complete waste on my _one_ node system.
> Can we make amd_ucode_patch dynamic first, depending on num_online_nodes()?

I have a small set which gets rid of all those arrays - I just need to
finish it.

:-(

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
