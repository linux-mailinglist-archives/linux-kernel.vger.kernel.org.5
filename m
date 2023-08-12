Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99111779FE9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjHLMMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 08:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHLMMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:12:21 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8593
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 05:12:25 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 94D5B40E0185;
        Sat, 12 Aug 2023 12:12:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PExWd0DORjF1; Sat, 12 Aug 2023 12:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691842341; bh=3moOiqEl3hGq/6UWN+rrx3A7BsYlaxHuKUOU5H8UEHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwLVsMXxmMVQqbBhY3y+3JElMOpVn2R3m7abhzbivz23RRPX2w0JfdAO6J+DMsC22
         yUsAkmVMuouSFEJuYexx+d75SMP+IPYqMAQ6rIly9TpaVyS79urrbcN3SMy2/pq/3v
         ZgOohsBUr0nLmDYgTFv6RUBlpskHrObx1Q09p++z9LghLDjhvJA0jTkDjP1YJEZksq
         O/H7dptQXudPlNQhjooD5zzDr99r8hseKYwaR+Jy82XCJzC/UHjMh12Ba7x3eNHZq1
         6o/IjgWCs2O/+psLlAlbNgokB2/ECqknDUqQRxTJ4Mc5ZiwoyfH2NmlDTOl2ybqrWF
         LS0EkNIplKs5T9CyJheB61O30ghczQ0mrCjtApEsMKuwRMO2r3CQFw6YK57lSJmJqI
         4YBw31OdZcZKkNUUJlzZULyzCrqTwI0/jIThblDplxfWHd2ZAYu6/eBP9M5MdbbHQz
         TuIGsVjAynucaBVTgbJXNBWViQxtMNI26JV0Qtu1EpBhqY5o+I1qjdLc8Zpif0dB0x
         qpiSexnoaKvM192g3ihrbRcAGvjBoAGjg5uDchpIMekli6Q+9+7oOeJ82YHzYxd4vg
         HhO/PzZ4KQd6VbzTfZCReFD1k5yAPgrEUhCJaLhkotRLHlGoWksm2pbMvyAYVfEwx+
         R74SimM6gVkEaTX6fAh7RbRo=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F52E40E018F;
        Sat, 12 Aug 2023 12:12:14 +0000 (UTC)
Date:   Sat, 12 Aug 2023 14:12:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org
Subject: Re: [RFC][PATCH 06/17] x86/cpu: Add SRSO untrain to retbleed=
Message-ID: <20230812121213.GEZNd3HQxbYI42mDtr@fat_crate.local>
References: <20230809071218.000335006@infradead.org>
 <20230809072200.850338672@infradead.org>
 <20230810154404.GOZNUFxHxLIMth6j9s@fat_crate.local>
 <20230810161003.i65d37ozlt3d5xse@treble>
 <20230811102748.GEZNYNJEeDxTqcOLvj@fat_crate.local>
 <20230812113256.GC749618@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230812113256.GC749618@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 01:32:56PM +0200, Peter Zijlstra wrote:
> So I really hate that .Kconfig explosion, that's the very last thing we
> need :-( More random options that can cause build time trouble.
> 
> I might see value in one knob that kills all speculation nonsense at
> build time, but not one per mitigation, that's maddness.

Yap, I hate them too. Linus wanted them last time and you added them.

And now we have a subset of mitigations with Kconfig options and
a subset without.

;-\

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
