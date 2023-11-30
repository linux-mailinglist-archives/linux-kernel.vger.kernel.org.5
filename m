Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358767FFB6C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376484AbjK3Tef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:34:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376422AbjK3Ted (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:34:33 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEFE93
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:34:40 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5D7EC40E025A;
        Thu, 30 Nov 2023 19:34:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id e6XQCArdnUgx; Thu, 30 Nov 2023 19:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701372876; bh=pOu9Ts9/NH6WGFGQ/MyCryal0Gt+vGg24iT6I25Vx2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENwOg5bsTZDhEIWBYoIB1BgerPLB82HsC8TQwpJHRfvFOTJXh46IYqihGwHqHMBWI
         fa/faA2EADlxfa5Se7N/vEeaVavTFo8WZ0G8RMCWq3lwsignlV0YxjDRlbydqqPRnp
         m2fSTN2ACd+QpmX0mwl8cwYcQT17BzgkXBwSxEtm2fwUtkgt5unBBV5pauctCKnKdv
         ZI6kb/bDw7xFQBKB9S7D028hh9rqqT1oVmsuolhFH/LmMnJ1YA1dDG4rtKE38KjxZp
         Wr/CtgNqfi1MOVrHV9SvKCGyB5VWmRJ3JRhVCdgBwLoL1M9fcD+mYvhaZy/yjR8ztd
         m+Nn0PgQaQ8y9+UAsW7uidQ7NSSsrgEa46pPnXaeYubvfWn30LqhguU5htFRfK/t0r
         fdbTfpWhxUIn8YmQ6hvI1iAsYh7KjnpddCDJCnycVH1ZOZK5JFoC4u032VktPMJ5/M
         HTRf2atk3dr57AnP+GuQEisNkaDqUXfXDRnapTHWUZVwgKfFQajWZNUDhdmJkAmKQJ
         PQegIJgNmJkYNIs3DnlQV2gVh+FjOqdfzxhTSb0/5dmTgPmp08134hbaY4Eowh7p9Y
         2fmLABP/o8dzZj8CIXwNR7URcklHH9A90eb7Gp5Hyp8jubX+ZGrQ/vVKp8a/G9lb2e
         K688+xBN7LuMS+W2J6GHmJt0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2947E40E0239;
        Thu, 30 Nov 2023 19:34:33 +0000 (UTC)
Date:   Thu, 30 Nov 2023 20:34:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/Kconfig: Disable KASLR on debug builds
Message-ID: <20231130193428.GNZWjjxKJ38Ruh7puz@fat_crate.local>
References: <20231130120552.6735-1-bp@alien8.de>
 <20231130181051.GA3357088@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130181051.GA3357088@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 11:10:51AM -0700, Nathan Chancellor wrote:
> I know Peter pointed out that there is a runtime switch for this, which
> should make this patch obsolete but in case there is more reasons needed
> for why this might be a bad idea,

Bad idea? Why?

Because they'd have EXPERT enabled and thus disable KASLR by accident
this way?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
