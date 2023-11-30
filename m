Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A297FF453
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjK3QDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjK3QDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:03:51 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2713E197
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:03:58 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 813A340E025A;
        Thu, 30 Nov 2023 16:03:56 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2e0zgs5U6h8a; Thu, 30 Nov 2023 16:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701360234; bh=2BsSVf4eGWEC06wZdpV5ipTj3BRs/boclnjYyNphgB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dJfHtQnn6DiOWmoT9Y9g3//NqAKoORiPwjUOvZykcqvIMwBKoGiMgoqbJFNIb65M4
         QCeFSI995IdYu23z8xIXoeQxHFou9tcTk5+z7r4NJXHxfal1OiA3bt3V84DOEGvZHl
         csBFOXxlhTkjUngHIXr7mOKlxM6dQFJvVCFOd/svoo0Ed8VxuK/3g568a8MCjZKoX9
         PkmaRsT9F4hiLworOoaRsANSBXN0ZLtgvuyxZo87egrDEoSAGcozCSLrXJUw1hmKzW
         qg6WVPnW9DvuIQdENawAFc+uEl/BBNW4M4hZ6L4k3xurWqQBvuVhRqTq71z30MK9y6
         OyAYDiIKTWQO1X3gn/KD3P/5Sf2PMj/dKBtccZPJoi5/Z2gD3WkdMaT16oFVK6Vhdh
         u8tN5L//qrq8cblR9X2k5rW8NiXMBcQz7MsMnqLsE7pgk3oq2dBGuWCXhVQ4Ga0lXV
         qhDgKZRkjaQquni/qE5n7ZznIr+xYozNNJtbV7nC9ptYrzWgI5OVqwkzW7AkvGJb/T
         awvAkUd92Tl4bTGCbSa/yh6SS3yZf1PHaxHCrN2bMkXy0jY7DWEkbGeji91EIJQ8rz
         0wzQx1hA5x+EzF95c57hP4U8zJVRL2EXCtrFGOMbVNi348jDzP4GGHvC/GI+BSvEIE
         TFzwZ956ULRx2DPlFjuKWWFc=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B1D740E01AD;
        Thu, 30 Nov 2023 16:03:51 +0000 (UTC)
Date:   Thu, 30 Nov 2023 17:03:50 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nikolay Borisov <nik.borisov@suse.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/ia32: State that IA32 emulation is disabled
Message-ID: <20231130160350.GIZWiyZqNQvZZIOUWo@fat_crate.local>
References: <20231130155213.1407-1-bp@alien8.de>
 <e485409f-150d-4138-a030-c19041f0fc8f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e485409f-150d-4138-a030-c19041f0fc8f@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 06:00:16PM +0200, Nikolay Borisov wrote:
> Hang on, this is wrong, it should be CONFIG_IA32_EMULATION_DEFAULT_DISABLED

Slow down pls and think: what happens if I boot with ia32_emulation=off
and CONFIG_IA32_EMULATION_DEFAULT_DISABLED is not set?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
