Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0EA680ACDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574649AbjLHTXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbjLHTXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:23:00 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B1B1700
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:23:06 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EB81740E00C9;
        Fri,  8 Dec 2023 19:23:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lJoqhLpwHWWM; Fri,  8 Dec 2023 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1702063383; bh=YrdoyyjOauHIuJ9S3ymT89tgVgbZ0WPJEgR2O/39Cn4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lOeWRb6Eq2BEKx1M4bPUB8ZLqVh8roTFgKP7yHcKdPK07Id/KtCPM/sc4HBlsKAL3
         p951j7SMe8nxYviDLJRI3A6m3BPyQoIldDK+a1DthghppJVPGYdhDSB/GNDgWm/l4M
         4EvUCyndL502qODOv9AMlzpCOtK3t333tD7pnx1Zi2fy6h0Hi5Wj9vmsyv4PtMo6ZZ
         iuW0ZvN91hWMt1Xw0AnqNhVWfceK7VZUykzEPZB4ONXs1G5uOaMDlL8NMt3IFGD0R0
         dOMoj+p4OXLr41WfoG0nqN/7z6xHJXIGUgmPnziDPB+MAAUCEqqDXlC7oAqzbiuj8s
         wukJBaLzPmtjw9HhGxp5YqkNhv8ZXYwAjO2iK/aSqh6Gz7873obNAyv/4qRPGtyNNA
         czsU17CnM8bHgYukWRAQw/hqnO709vinYu6V8/Kn8wBKMxwHxzPViOBZlEidrq91mr
         s8xOGM2QUzxVc57el9426jwdYxzye6T1x1gFM7wiJpwi6uqO+ClgNJ7HUQzOnhUCpn
         uOh33epCRH2s5mIAa5Ua/HufePVFZwFyAmKwC1tWzB7YXpdsOkZu7m9fkQc2qOk2MQ
         GnLELhQ6XFBgooUzh0BwEImGYkAvKDyVOP7SGRLK0+rt/Ss6rv/GQrViy1tcLPm3Ar
         9pv4oWbiCjdpVgZnRmx7nM+A=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 369DA40E00A9;
        Fri,  8 Dec 2023 19:23:00 +0000 (UTC)
Date:   Fri, 8 Dec 2023 20:22:54 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v2] x86/ia32: State that IA32 emulation is disabled
Message-ID: <20231208192254.GCZXNtDjT73Z4L06h/@fat_crate.local>
References: <20231130155213.1407-1-bp@alien8.de>
 <20231130160903.GJZWizn+dPaaViFVKN@fat_crate.local>
 <20231206172022.GCZXCtVoZtt4t2TLpe@fat_crate.local>
 <4f232dfb-a112-4271-8f43-f85a02c4abeb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f232dfb-a112-4271-8f43-f85a02c4abeb@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 08:42:29PM +0200, Nikolay Borisov wrote:
> > +static inline bool ia32_enabled_verbose(void)
> > +{
> > +	bool enabled = ia32_enabled();
> > +
> > +	if (IS_ENABLED(CONFIG_IA32_EMULATION) && !enabled)
> 
> nit: But why check config_ia32_emulation explicitly, its state should
> already be accounted for in ia32_enabled's value? So this check can simply
> be 'if (!enabled)'
> 
> > +		pr_notice_once("32-bit emulation disabled. You can reenable with ia32_emulation=on\n");
				^^^^^^^^^^

If CONFIG_IA32_EMULATION is disabled, is there any 32-bit emulation to
be enabled, at all?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
