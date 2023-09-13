Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5692979EB7B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbjIMOq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241412AbjIMOq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:46:27 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5899891
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:46:23 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 48D1940E01A2;
        Wed, 13 Sep 2023 14:46:21 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
        reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kSqtKosVwqsu; Wed, 13 Sep 2023 14:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694616378; bh=mFifg/MtbgKHH9sRTf162NPA8eGUlQaXOGCGhH4Cm8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYqQtiz3V1LAL013lk5nR8aU6b9NYvVc/CTfDuUiJPGj9it7eW0YRCyL4qVS7xQHz
         qjA+RbxuR/1j2geDEgF/bB6+YpkPfBxOH0/Qlv6t5LiZA7l5qJUngkF3RyeJPGHpbJ
         KFGk6oiYOWcjXB2QkrDAblYWWEXskR7ygkO8R0aTGYKfiKKO0iiEGo6R+mD06g/kfY
         B1i2SdL5SeESgw3c72VkDl6mhB4BjjFFyCp9uj4YOXVQBweQz7q95aI4NuOwS28fGB
         lsg0i2XsfzMcZbzeMN+NCoJA3WGpdZ6t1Mi/nFCCZmGT4d1g5w1qMDiT1dv4a85ePU
         H67gLLDyz3ps82pzX7JULcTc0eVIs2AWpVF4ne7V84wtwczOz3FuzIDPx/8krmS7gn
         lGUR6kWi/dA9wiFhAgc4FGQGkmowxVBpKFKpmmcoO/2SjDXzE/2qn8vH7avv3BcJjt
         Fz3woDTELe2LJ+EvAFdOvWaw7iRw4+isuu7umqFEqTZgW1phGEOwSVNZVk8wEzk3gb
         RlawM6kIqY13ghq7WaKZnPk1sLWcVzblEheqYHuwQP2izGgY0Db19i/Qp1GyogOpfw
         kssQiy2HCDR2+d+1uwN5VvOZ4wpLetS1gN8z2LArbCWWe2/XbOp0gCe+UIiqrZsbE+
         oOOCkPvSQoy/hiSxbQAo+fVw=
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44B6C40E0198;
        Wed, 13 Sep 2023 14:46:08 +0000 (UTC)
Date:   Wed, 13 Sep 2023 16:46:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] x86/srso: Rename srso_alias_*() to srso_fam19_*()
Message-ID: <20230913144623.GCZQHLPw2OC2gnzeri@fat_crate.local>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-2-andrew.cooper3@citrix.com>
 <20230913134618.GAZQG9KrdVjjpYpBqe@fat_crate.local>
 <8331673e-ce7d-8509-4ccc-f5eaaafd2d94@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8331673e-ce7d-8509-4ccc-f5eaaafd2d94@citrix.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 03:27:00PM +0100, Andrew Cooper wrote:
> I know you may like $FOO and $FOO_alias, but an alias infix on one of a
> pair implies they're related when in fact they are not.=C2=A0 It takes =
a the
> already-insanely-complicated logic and makes even harder to follow.

Maybe, but adding the family into the function name doesn't make it more
clear. After all, the family is just a number.

I'm open to other suggestions which make this logic easier to follow
- although this is as confusing as it gets already and I doubt that
calling it whatever would make it more clear...

In any case, the family number ain't the right one.

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
