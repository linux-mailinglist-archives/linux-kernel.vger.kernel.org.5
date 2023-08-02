Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386B476D548
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjHBR3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbjHBR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:28:03 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC783AA8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:27:37 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3AC951EC00F8;
        Wed,  2 Aug 2023 19:27:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1690997246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g9gwIYUzANuxTabtR/Loj/Hr4orqvzr9rs21NbfLDgg=;
        b=dF4tG+bjoL3mvTonBj+DbYvwAEZkjud9QHlskEGbuioc7mIQUyTMtPnnI62JfeLV5ftnUJ
        S9zx0vYlpVeO8kR2R5EhFed+3PYbuwtHdD6k8Sne7fWP17tjbDANSxVTUG6Zr1IJWhsroG
        tUSxSPY6vVhLYgGNUsrLSy6tOMUHhLY=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Pwpl7KHOICPl; Wed,  2 Aug 2023 17:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1690997243; bh=g9gwIYUzANuxTabtR/Loj/Hr4orqvzr9rs21NbfLDgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W3XXfON473ZWV3+f58R1ze+EETpyImKuRoQ1LXcJ8CTMRnl1dzsQpQzZaJzUWTXDf
         h/rzWHDRweMFabb/IjnspmCcaRjRcQHC3G3ycbjLTumoogX6sksI2jOMNZ5bkCG5gs
         T4z1N40xPh+W5VGqT8L3ABntlNXyU09Ja48eNqLMsPt5qTHp5cmKTS9YzU0JZx5mOe
         KyyuNQaL3ky141Exp+T7QtYq66h8gD9ZOuJpLoF7aBQMsUXGPXOifwuKgGD8fRnbBG
         NiAs93u1X1F2KvWgIoJDmKq5UNgteT4PnN+wA2kX+GgMIrAOzxCb6jUFQYhyPdewNF
         XCf/uookjEbByHT928pgiSsepqlsPI6khmW9K1ssmig4gDQe+htJJSx9hCjfTHqG0i
         pp96/5V/Te9B5Diwlfw0m2FTLlemfe0SQx3domllzquAyqe6NQKqHNBBPoS/vXka/B
         ixxB6ZkTmn8Z6Ek7rAFGhc2DBJ8FuvDWhVMFXJr7MgjS6uTXuWBDtOCsQIya/e+xPR
         DPWgqBp3zCCEnkCgLuVKWF9lqJcx3qalY0RzkT7YNwvlrKzRIlT13yJ5wULH+yXaEq
         TRM/Io+AgujJFsKFnP/CXvWykAEBbDT0/Vpj3AmiTKHui9aMCV0x9x0IC4pnoZk+KH
         GwWiDKwfXwWllprZ+5BToq1g=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D132D40E0205;
        Wed,  2 Aug 2023 17:27:15 +0000 (UTC)
Date:   Wed, 2 Aug 2023 19:27:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 3/5] [RESEND] x86: qspinlock-paravirt: fix
 mising-prototype warnings
Message-ID: <20230802172715.GGZMqR8ypFBDve9q/r@fat_crate.local>
References: <20230725134837.1534228-1-arnd@kernel.org>
 <20230725134837.1534228-4-arnd@kernel.org>
 <20230801192217.GHZMlbaVMBavu909lb@fat_crate.local>
 <21188533-a56b-484b-8cb7-053f38a4155c@app.fastmail.com>
 <20230802172612.GFZMqRtDOGd28DNe03@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230802172612.GFZMqRtDOGd28DNe03@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 07:26:12PM +0200, Borislav Petkov wrote:
> Now lemme look at the rest.

Yap, they look good. I'll queue your next version.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
