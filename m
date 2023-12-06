Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D25806B9E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377532AbjLFKO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377558AbjLFKOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:14:16 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217ED170E;
        Wed,  6 Dec 2023 02:14:04 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E092040E00C7;
        Wed,  6 Dec 2023 10:14:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a-TvTrffaLX1; Wed,  6 Dec 2023 10:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701857640; bh=DpJAkZjYSjqYx12wMmVH/VG2/8sUA0v7dT9LxGl01OY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIbN3DP5pAaYCScTVJkKzv/SM3UAAvwj+wynkVjU3ONyoNn1Mx3T9zMi9eBlSawee
         wh0s7/PIihrAylZdJ3MYU8ncxqeLqZKNv3WbNtTZY50Z0VkkG4MiZi9QT2oHkwIkGK
         Q4tEtHsmlMXGqaI/CXO8+Jo9dGFOI988Yqx1B0Litwj7wqdK5WPSE0s3LY8BTlXa7O
         RZ17ROiBOTrJkfdbfGzJolFdwbQPzlLuJk1+8m2IApDyquNeUuBG7W/WMBzu7rbOex
         rQ6PdJwIW0Q4COKKLk6ttumXfRpSTDHUTbUWjB1Sf37dTNaDc6/OZcfiDFUWrJ2Q4b
         r0oTOkgejxb1oKxYywGZX6+5KQxinxqPXkYp+mO2VP7TqjVwNBhMZx2Cg4maoZOWdP
         CXc469/bwizLFCRbbCVhweIWM4AxJ5ElTBftw+pUsCKGE5aQfAwgI9VumFi2L2DyVq
         eSs1yGA2Hw2zRIbVAWxgzKwiU2Bmc65y3hPr9MGJLrkLiGjKiCMSlw2EenuGAy7Cg9
         QVfOZDTfzoHBVVOLMEvv1pLfWSRY5ddE2+khOdk6J8vLrsvXAi4KdhhJ5C7ZMV1i2s
         vMXdEACVsjhd4j1kM6PtZvv+Hrc2u1o7TEMdh5F9WXAKvd9s4P4jWbbWuVvU8ataQT
         HmSsthlf/sDE2CXjB1JrX7BM=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E6EFA40E00C6;
        Wed,  6 Dec 2023 10:13:47 +0000 (UTC)
Date:   Wed, 6 Dec 2023 11:13:42 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sohil Mehta <sohil.mehta@intel.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Update references to the Intel SDM
Message-ID: <20231206101342.GAZXBJVh+3tZuBAyX+@fat_crate.local>
References: <20231206013846.1859347-1-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206013846.1859347-1-sohil.mehta@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 01:38:46AM +0000, Sohil Mehta wrote:
> I am open to suggestions, is there a better way to do this?

Yes, drop the references and make the comments self-contained. What
point would there even be to refer to a document which can change:

* the chapter number, name, etc
* text
* ...

And I mean that about all technical documents. They do change so either
we can freeze them - upload the exact version to kernel bugzilla and
refer to it - or simply look at the code, try to understand what it
does, see if the comment makes sense or not and if so, explain what it
is commenting properly, without the need to refer to an external doc.

If the comment is outdated, drop it and also explain why you're dropping
it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
