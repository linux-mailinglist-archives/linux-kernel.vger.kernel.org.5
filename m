Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27D0279E9FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjIMNqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjIMNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:46:34 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC21419B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 06:46:30 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A1EDC40E0198;
        Wed, 13 Sep 2023 13:46:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4i79b8CUzaMu; Wed, 13 Sep 2023 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1694612786; bh=FzVnaJjidBaj6o42/mTOYdxXB8ha+LbWEPF5ZYYhqGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OxOZkE3TYh+ocDmg3NW7HzJNjN1Jwfx1KhrW4oVLBjn0If57UO5iSqgJOSKG8z3oh
         I3q655dEujlgEiI3M+hgorW6N5WSiMvF6fFzpJX8F4qGHE73g+gj09GY6N1JZ/k2v/
         kePZ5+7H9lOXomgUqFFE8D1mUtPXk8EXrGoifxVV7tjt1S0Yl+iuGQfbH1HJ++cZdU
         hEwMo388Po1REF8ArOEcBvq/J9K3mibMJy3Q482Ti3jmLcFm2veh2aAoJacHvMHUY2
         eusDvXvKu6tYbR2RsxETlwfleT+0fYXBqe05kxmzOUNnsO0IJwWUYtnE+PF3bZ17AC
         K4LlD3Tk/ZqthTkv2nbPvctILv3Jz8C5Rt5rWxqx/CgQVHNls2Q+/scb330BNwP/Qy
         h7yLHRSdE61mMEL4G5tQKgDWrwfpyeqc+UV2IHPgjWuU2mXt7lVp0sgLRo5feEEGDj
         ezcktD51mXIcfy2nzWjFLKK5p9gz09Qp0+Oz8OhfiUWiOZtCRtLRrR2ewvY9bzK759
         YdDZoEwqebKsDQ3Ds06shre6twezIF8VlJOlK0DZm7azLr6K2swirhQyCW+80lS/ES
         FD1JPiHcJQu27cESfCMBdpSrnm2NlnQY97O0VaIdZi3QyqFTCjK4prBor3ul6LQTgv
         5UTnL5syq74yXT6dGOPcqYGA=
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D13A640E01A2;
        Wed, 13 Sep 2023 13:46:15 +0000 (UTC)
Date:   Wed, 13 Sep 2023 15:46:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/4] x86/srso: Rename srso_alias_*() to srso_fam19_*()
Message-ID: <20230913134618.GAZQG9KrdVjjpYpBqe@fat_crate.local>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-2-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821112723.3995187-2-andrew.cooper3@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:27:20PM +0100, Andrew Cooper wrote:
> The 'alias' name name is an internal detail of how the logic works.  Rename it
> to state which microarchitecture is is applicable to.

Sorry, no. Hardcoding the family into some function is a backwards. The
moment you need to apply this to some other family, it becomes wrong.

And I prefer much more "srso" and "srso_alias".

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
