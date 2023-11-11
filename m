Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2607E8D26
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 23:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjKKWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 17:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKWgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 17:36:07 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEAED8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 14:36:04 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 354AD40E018F;
        Sat, 11 Nov 2023 22:36:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qK2TaQqZPyfQ; Sat, 11 Nov 2023 22:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699742158; bh=OzpHat8gl6GM/lll5lsFrRpwrAFV28c7ZVp9i2lyeyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iqcup+2/ExOwtUXb2HHhkumK+PI1LXbsxmsbEr3tgSW5/ji2yCwpMznyCx1Hj/qzZ
         Dzm1FS736pzbo3Dh4qlmncRGVt3wRarlyftURpzCqpCZC9L2J/NLfw9rZcRn04Nsrr
         3mkvXdy2+VK7I6YLV2CJdWwEyotp+ADiPbfJdMiOXkbZzuj4Cmgch6qNkz6TpGUliB
         UBZLByWXZKjfE1SU9kT3DacaH6mweo0GAZaHAWETqEx6ufCItk5cqq/4P8jk93fBwG
         e6vhIdNxBxZMa/WpQfYEzSTNTRys+z+0y8nHXlWR74o8VZLo5ww7CLKuGbViFFeHiR
         k6UZjpgYrBakBBQcnq1YR4VvZhdqBqntTBs39sJSaw3ebLafcmUtihGXFaTqQsQAMM
         hW56LbYWVYmJvFMlWGAjoX2AUYOfV64dhIaIq7NVdy5zGkeqXThEt7pJ/9um/i36On
         HO1OJsKsZiQimD0Dqcnxp0BKYb8c8t2ChDLwXK0/+NPVH7Lzk17IlpOLkmzE8GfS6R
         o9ynNJoLz8OOgGrDEpqmyisL3rCAk198FpcJOCogP5LendnISEPZkV13etfCDKVUGW
         R4vIt0eiss2rff5d223GZ39BuHiax72fblEk8SYG69Mz6vp13qNLhzwLGCrmf6YVld
         DNW25ES66ZdXjitlvaf8JXNk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9F3A40E0171;
        Sat, 11 Nov 2023 22:35:54 +0000 (UTC)
Date:   Sat, 11 Nov 2023 23:35:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/microcode for 6.7
Message-ID: <20231111223549.GBZVABxWKgkuGNhEqe@fat_crate.local>
References: <20231103110600.GAZUTUGFjhoLm1KZzE@fat_crate.local>
 <CAHk-=wg=+8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wg=+8rceshMkB4VnKxmRccVLtBLPBawnewZuuqyx5U=3A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 02:19:00PM -0800, Linus Torvalds wrote:
> Can we please stop doing this insanity? It's not helpful.

Yeah, it is on the todo list. I'll take a look next week.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
