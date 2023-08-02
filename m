Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610C976D51A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjHBR0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjHBR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:26:27 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EABE46
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:26:26 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CF251EC00F8;
        Wed,  2 Aug 2023 19:26:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690997184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8tJgz8TX/PxaQwaopmKdDCz6t/wM5DSDqnMNByWWbjY=;
        b=StZvKVQeSe9Idx5yr2kSni+csZMkKzvHe7a+SWd/V9O+2TofXgqWfcqXpAdkc1EIjNucDQ
        yXYwQQyPRByFrmoDNBV9JlYthdczZdVGNDxT5OSNN4NOfs2KRKkKmaVT46IUPF3acqwU8v
        4mt0bLupMXqZcyeFDo0sV6goGUQfnbg=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LfCkf42t8xWT; Wed,  2 Aug 2023 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690997181; bh=8tJgz8TX/PxaQwaopmKdDCz6t/wM5DSDqnMNByWWbjY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VGDEfDuqoQwWajFtZyXt8BiPST996QJLjaATons7cC5wfjR7ndvIic+GQ7QKtAbKp
         9T5NCvSXWk5C2h0sReuZw9bb8NfeGk1SN+jPLWiC+N/4V3CFo1nOV8/KHKu5PsIcNW
         GB/tsz2gtCEtgezsYS3Jnvtp0s5yKdqQ5OntauHKNDWPj0ac1sK6d2twstqSbwRmnK
         zIGfeQxpV7qrMJkxhYUm7c4bB3yNNeJJJMOkDDweRYywz7xNH6Ad/FS1ISObOW4C3s
         4mc4vAAWrtJUTsUGpX1myrFBjohpZp0C0zg4foZzuvCyKYM275cwLkj+7vkkeBS+Nn
         sVmdym9jIYCik6OtZMwCJTpKiKM2LtUQBcTI9r5RcTOvK6jYsTMTuU8zKn9f3lKXd8
         o/MZKgYMngyZFfSC5cIXBV/BVLSpAzuXwC3oTE2jHs99RIfzwvgQybdQe9oKLKPk3R
         OYV8yUbKYUH4yxsF1H9HuCZrEaYmOA6olTXZP1cRwVkyBFe809mkGkqkMv4ChKkD4B
         TWEvAFSwAjfroAHFZnD1dpCDI08jHUYdVuNMgy3Xxc9Ivwnjgtujl9uTmu7eI+8Fms
         OyXbTCf71OmjHtPBXfkEV0anjoH0F9b5VDsRPBLFjrSi7XGeBdh3ePWjQEL0CMRH7V
         7V9q5PV0D5WVDzVElVVSfJps=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BB5AA40E0207;
        Wed,  2 Aug 2023 17:26:13 +0000 (UTC)
Date:   Wed, 2 Aug 2023 19:26:12 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/5] [RESEND] x86: qspinlock-paravirt: fix
 mising-prototype warnings
Message-ID: <20230802172612.GFZMqRtDOGd28DNe03@fat_crate.local>
References: <20230725134837.1534228-1-arnd@kernel.org>
 <20230725134837.1534228-4-arnd@kernel.org>
 <20230801192217.GHZMlbaVMBavu909lb@fat_crate.local>
 <21188533-a56b-484b-8cb7-053f38a4155c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <21188533-a56b-484b-8cb7-053f38a4155c@app.fastmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 10:26:36PM +0200, Arnd Bergmann wrote:
> The variant below would avoid adding more #ifdefs, by moving
> the declaration into asm/paravirt.h to ensure that it's
> declared even if there is no caller.
> 
> Does this look better to you?

Yes, thanks. I don't mind empty stubs in the header which the compiler
discards/ignores.

Now lemme look at the rest.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
