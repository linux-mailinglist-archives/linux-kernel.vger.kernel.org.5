Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA4C808682
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378944AbjLGLPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378884AbjLGLPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:15:16 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC4011F;
        Thu,  7 Dec 2023 03:15:22 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E84B940E00C7;
        Thu,  7 Dec 2023 11:15:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zA3FcBYuDKzQ; Thu,  7 Dec 2023 11:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701947719; bh=q/aOTK0ooA0NK+qsWb3wyUsPFtr16T+u4TTr3X/f35g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gDp40T9RvusesPyiIKCAlH4uapzEgwCDQl4ctT4Z4WmSvHNVikoMLSVj7r3Ae5j/4
         eVBfuqUVBHzln+anqJZViKAOXdijlxsGry9mloyFQuWW0/UbGtBpFDaKZvmBQeVJkC
         FLj3iE1/RVlqafPE/qop5wwWHJJTksBRIPHN6BTk9yfsOaqJFeNRVH00UuV1H3pbg9
         NYsgxhpVwyNsAnlUcrGWdlXkd2QFWL6roalHcjb1DUeOSvrEScd1nlGgqVdEhPE3ze
         Vm2bXFbvpfyVzJJUF5GaeahOcEvolA9vbu1qtfVRGkwED745Wc7WhsFUX4v4n+LngU
         AKwjDw+C89pTPOOMgRS/Neoe5aSC6gYoz0eHjGf7kmO6ScZk2DHKnAjPP44URE3sfi
         eS7ylFOQ+0zfueQ79ptGocWonJp7Zi1LIdg21TBe0XxoxUcr8aCd5zYLXeTEgmgK97
         FBX7N3BB08h3iW5MuneIvbprI8e91/yfOJxzMsbhWNoLfD1/CoJb7fJCaDhZI1oJcm
         tLk+7gGTABLIOn2iOwqTdjAfgfo3hQP8Qui7RIYLm96cSJGn4sOuvwHRgVvxWELqN0
         OAjgr4iB37iwRdFFF32i/YxECbXFcbg5Wr5nRimoyOawkYnjOLFEDykaJIG0oJtxlZ
         icO8DeXM53D6ozeI6gAZlR34=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1ADAD40E00C5;
        Thu,  7 Dec 2023 11:15:14 +0000 (UTC)
Date:   Thu, 7 Dec 2023 12:15:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org
Subject: Re: [tip: x86/percpu] x86/callthunks: Mark apply_relocation() as
 __init_or_module
Message-ID: <20231207111509.GAZXGpPVEuWO/gNfvY@fat_crate.local>
References: <20231105213731.1878100-3-ubizjak@gmail.com>
 <170137899106.398.14613676631297252898.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170137899106.398.14613676631297252898.tip-bot2@tip-bot2>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:16:31PM -0000, tip-bot2 for Ingo Molnar wrote:
> -void apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
> +void __init_or_module apply_relocation(u8 *buf, size_t len, u8 *dest, u8 *src, size_t src_len)
>  {
>  	int prev, target = 0;

Can't do that for a CONFIG_MODULES=n build:

WARNING: modpost: vmlinux: section mismatch in reference: patch_dest+0x61 (section: .text) -> apply_relocation (section: .init.text)
ERROR: modpost: Section mismatches detected.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
