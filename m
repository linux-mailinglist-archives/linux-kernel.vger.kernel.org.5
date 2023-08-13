Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664EF77A614
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjHMLD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHMLDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:03:25 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDC21BD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 04:03:28 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AC51F40E0185;
        Sun, 13 Aug 2023 11:03:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5C8xwSiMocF3; Sun, 13 Aug 2023 11:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691924603; bh=NElFY/m1+ArvR7Gho78vQn1P8OB5nFajoABT/fHSVYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MRlyieZkkSnHX2qmgUCdPajG3wE+LhKL9EsOB5ghL6RcBk7UjCyxuTsq54EXTR82A
         lf9MoTnC2aO9NLeAktosNGdKOdbzw8mILDzR76SatBUFdFULvrxWMI38b1ObZL4N92
         yYnINJkF2fNHWIA8UCNzh7FW/TNhpFDX3Ri0m0hq8l36VOm4Q/VPfWAgNe0tTN7jCY
         MDTYvlC6o97swoJ0GkuP2zQV+SJO86xRDHUTeJMUPSlWJqQfPPzicavmrxl4ZqlWih
         /Z+nbuMxVqUH/LZ1Ao4WzaKbVstz+bzCnhQzXr8g1IeX5cWqMKMZ2ec+AYzmaIckJ/
         MnzW/w3ZNECsSqzEFPyYZX+AZGlfv/R69CHqs/KH0cSI+wP8QLBTTSHjRUGNd6Lr9t
         lFh1aqt1gLVWpwjTBlPEXEQon4Hd7/B0GW6uHk0ga6UUW+F7NJibcEm4K8Y5STsD/z
         f+eMkUXc9zmL1radgTCguaJY9+Yv3bDYq24QcnMixrdrnM+e/rXWYNYVdTlKt+SjXM
         noGRqPmEOcIJHzYFD/LV2VrMSrQuMqUwQXFJ1qiHMklqz37BwSGHLZ6MgX3QcY5A2w
         3w7xDqv05uSIbUskK7k6MBVlYdmmeT/b7xhmnypBZwnkwta0R3hZxu2+vn9ievDLuI
         weBr1CoqeYEuDDIBgiPug//Y=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3F03740E00B0;
        Sun, 13 Aug 2023 11:02:59 +0000 (UTC)
Date:   Sun, 13 Aug 2023 13:02:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        clang-built-linux <llvm@lists.linux.dev>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Daniel Kolesa <daniel@octaforge.org>, x86@kernel.org
Subject: Re: [PATCH 6.1 000/127] 6.1.45-rc1 review
Message-ID: <20230813110254.GDZNi4XhHjY4xlNdBJ@fat_crate.local>
References: <20230809103636.615294317@linuxfoundation.org>
 <CA+G9fYvQdQqTqCgbS4sit_Y2AtKtDiWMOkGZjoeSEFhc=M_jKw@mail.gmail.com>
 <078d6e3d-9572-a624-2c5a-e2d58473e6d0@roeck-us.net>
 <20230811041339.GA193223@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811041339.GA193223@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 09:13:39PM -0700, Nathan Chancellor wrote:
> 1911 is still being investigated (some additional eyes on it would not
> hurt).

I'm hoping that we can take this one:

https://lore.kernel.org/r/20230809072200.543939260@infradead.org

which should resolve this issue, right?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
