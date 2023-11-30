Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 768227FFA06
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbjK3SvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjK3Su7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:50:59 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB6C194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:51:02 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7BC6340E0239;
        Thu, 30 Nov 2023 18:51:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id luf6zEsWk3BT; Thu, 30 Nov 2023 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701370258; bh=rapiwZDlWnBbpAMEhaygRwuZfjLV0wnHZQnxjAZcvyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DtdsvPVH9edVoTCu5TBnMiqyxE8V2ApUzZy8w704bA96VMy/uwxzRQieu4nrFVi9i
         vNVzCzgJtBhIHL/hOX+n9+XU1btpZRg1LYQ+EAmDUjz+ds2fqWYBZcp9zUlgqtCgPT
         Z6juqksP3haowTR5MSHhOUMV4+tzYtSXpwHYiGCuWLXzHDhmtxCnqVFSALHKrDpFcx
         pv0aP6CtW5oee/iXzXaFS2hh9F4Qy7PLybaqs/23LWGos556msiaiL5GwZC2rPXKpU
         8MSei9xb+rbOxj2hFg3PkBxJbPjOhSCmP0DZUn/BPT8luKson3EEkd+/1dAXY5bvEw
         A9j0FWuIasmqG1Svt5TTbO/HYCaU383zq+GEnF9P+f+EpnL8VKP5XGCCetopCd1pLO
         tXKqPtyYg3vf4sAv2ocvAvG2zCOoRFW2rJrc0awSotuTRL2eQi6z4oCqd/n+hMqQt5
         zilqDxCWWxWZ4H+poJpmRf4nZ4sTMf1i7DPq5ESiH3eczh4sFltX0yLvm5Lwx2HYFi
         xU8P2PRjnc91GzOl+HiSXgPkD5+XSuDc3wogESuR8qHXj/JDmIr3cYENGKnXXDCjz6
         M5I1ehUKvAnv6Xx2CHWMyqkdju9D8cUlXTCDp3nhWj88Ceii7zddNmBsVGEHPjY+ur
         1Fo8YgCIISPjOXbWJcFVrH/0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2E70D40E01AD;
        Thu, 30 Nov 2023 18:50:54 +0000 (UTC)
Date:   Thu, 30 Nov 2023 19:50:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brian Gerst <brgerst@gmail.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/13] x86/CPU/AMD: Add ZenX generations flags
Message-ID: <20231130185048.GMZWjZiIjhpjrv4rPf@fat_crate.local>
References: <20231120104152.13740-1-bp@alien8.de>
 <20231120104152.13740-2-bp@alien8.de>
 <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
 <20231130171316.GLZWjCrHGHl+VVp724@fat_crate.local>
 <16400d3d-8264-4f3f-96ca-168064944462@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <16400d3d-8264-4f3f-96ca-168064944462@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:17:02PM -0600, Tom Lendacky wrote:
> There are references to X86_FEATURE_ZEN in arch/x86/kernel/process.c and
> drivers/acpi/resource.c that should probably be vetted.
> 
> Maybe having X86_FEATURE_ZEN mean all ZEN (and set for anything family 17h
> or higher) and a separate per generation, e.g. X86_FEATURE_ZEN1, when you
> need to be specific, would work.

Yap, looks like it. Those process.c and resource.c things mean all Zen
- and perhaps that really should mean that - Zen and newer. This all
falls nicely into place anyway since Zen stopped using a family number
per generation so that's a natural cutoff point where we're going to
start using those synthetic feature flags for the generations and one
for all Zens.

And yap, the Zen1 stuff should probably be behind X86_FEATURE_ZEN1.

Yap, sounds good. Lemme cook up a patch tomorrow.

Thx to you and Brian for the suggestions.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
