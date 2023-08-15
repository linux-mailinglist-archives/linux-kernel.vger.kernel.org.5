Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1077C95B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235673AbjHOI0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235629AbjHOI0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:26:15 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535C8B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:26:11 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C7C4A40E0197;
        Tue, 15 Aug 2023 08:26:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oC7Aen0r7e2r; Tue, 15 Aug 2023 08:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1692087964; bh=SLjMpJVf4Lp7hv2TydLocpzoAwt5EI3fFCwqsC3/CBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtExnofD1O9WOuvajglriYuZbcV8ASLIaEVBKeWl43tqIszAgqhwRPh6Y9JJsUWtJ
         JUyZ/OLkj+BmhFgg0SW4wXr2At2FAYGfLNWRMLSabvR8EI0DrWGRW8dYpaGFJt01lc
         /mr5d2uDMcUcuN4m1cTzQdbv7xS84d/3hW2RDVi/sl8oT/ha5wE+1ZtGziPVk2MghK
         CxTT91qEC3juv1iXWtbzrmH5hwfvXfTWPba/TrfP/bBRHwgwJfbtVT5FDBtYN7g3TY
         uYtdov/h9ldyQGORBlXMP9L71XiO+fhaZfVBOfWXuA7WA+W6DBslT/gOBzebGBgDZ1
         z7w0oEOUQDBTyVFZBJkdld72sp+hOP0ePO/NrRKXutuYgy7aMytamL/QiUY2R7EyTk
         ZTlyyANWWHrHPTJXtVEja+Iys0I+VdN2YpjIqxfVsF9s+IfxyHccQKKtAsLHfuN0jj
         AJcgGJONFOtd8tZDVyt3/9Wiwr0gqw1tihG67f/iPmNhyjwqlcflQdAj9RNBOoBp8x
         5su7Bn/HrgQ9ukIIc+TJPM4g/sowUenX4Wci6UDyqHWKgJTNBECOU0t/EokLarVACt
         16iFR/rHvqntp0AR1lKD+xb9G0ljhfak99jBQAKyk/e0t9AAuWiD0soqseEoQG5wLF
         B/aTyqFLKxtQzkguq7FxsUoQ=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5A0EB40E0196;
        Tue, 15 Aug 2023 08:25:57 +0000 (UTC)
Date:   Tue, 15 Aug 2023 10:25:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [patch V2 02/37] x86/microcode: Hide the config knob
Message-ID: <20230815082551.GAZNs2j/fUUOuahpx9@fat_crate.local>
References: <20230812194003.682298127@linutronix.de>
 <20230812195727.660453052@linutronix.de>
 <ZNqWD2CKFfa0nSqS@localhost>
 <20230814211912.GMZNqaUD6FriYo1wOo@fat_crate.local>
 <ZNq/agLqraP0IYwR@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNq/agLqraP0IYwR@localhost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 04:57:30PM -0700, Josh Triplett wrote:
> Multiple reasons. First, because "a couple more KBs" (concretely, 4637
> bytes in this case) add up across the kernel.

Sure, if it were not really core. But this is core code. This is used on
practically every baremetal x86 machine out there. You have other core
code which is not used on virt either but that doesn't mean we'll axe it
off on virt with a Kconfig option just to save a couple of KBs.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
