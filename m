Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA647C4F10
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjJKJel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjJKJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:34:39 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED26A91
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 02:34:37 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 43FB440E01A5;
        Wed, 11 Oct 2023 09:34:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zYrS_lfx2XWo; Wed, 11 Oct 2023 09:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697016874; bh=wlVHCRniVFaiJL/44jNYT0InX+M6DG5c0AFa+WZS7gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqpVIkUuVh0xCDZpqdC/D3R/PtHYWiIAp0bf5eVOhgbcOrJFi8mGvNm/K4NASnCRM
         jv+rGflBCEiYnXMAof+o9Hu6RqeoV2oToQttHreQQ3aTMFVx8QojkZ72CVNgUbHpid
         pdj7QdOoziklmkY2ekXoYh48+jrveQA366PEHze3isygNLyxIuf/GohKWFfGeWh/IX
         GfCSOV54BmNBJgc92coM1aTvBZBGm5H/OcOm91TzdQTFyYajVdCP5FvaRdSKnH9XQ1
         m/cRQTd8PSKecytsaM8zN1x8A62UFQYz8nBvr4S9u3LUgyxTiC0J1BSCLLMyOQdLq1
         fsj7IctbD57l5tFJCAxLASt66wWVcxR5H8pn5RUtTt8X0llTwMPfJB6uUSjss3sZj6
         FTL6uU695WLPDQ0DsQjuRW5MRXG6ZaI+7Fus6b6UQTEhCWcQAJ4n6f+Pa9ZORdi69S
         ZEUbOmV0apkXW8gAW/yRY9/o3AUMDjncnlGcAbMxbM7PmACyn2VXBaoWt8liT7xO3B
         xzvRjqEkeQjmEtYE4Y/jK0b/fjxVUInfeSGt9lL8I7bFhqvOkZehXZiebA2eEyQgxe
         9g+nCfLD6acoDFN+n4lv+osUUT2PboTvKCrESrXTSEZNoo7waXtHI+QoAjevEh/Rnx
         6dBPmTW1sHj3OKjgn+a7R1ME=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8D2FE40E01AA;
        Wed, 11 Oct 2023 09:34:28 +0000 (UTC)
Date:   Wed, 11 Oct 2023 11:34:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        David Kaplan <david.kaplan@amd.com>, x86@kernel.org,
        luto@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "x86/retpoline: Remove
 .text..__x86.return_thunk section"
Message-ID: <20231011093422.GBZSZsHumBjU6c68Zb@fat_crate.local>
References: <20231010171020.462211-1-david.kaplan@amd.com>
 <20231010171020.462211-2-david.kaplan@amd.com>
 <20231010174833.GG14330@noisy.programming.kicks-ass.net>
 <20231010195721.p5pb273kevg7ydxz@treble>
 <20231010200429.GIZSWuTWSUM9aId7a6@fat_crate.local>
 <20231010201912.7pjksbparssqu34k@treble>
 <20231010212254.ypk2wdogno55shit@treble>
 <20231011074142.GK14330@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011074142.GK14330@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 09:41:42AM +0200, Peter Zijlstra wrote:
> *urgh*... I mean, yes, that obviously works, but should we not also have
> the retpoline thingy for consistency? That case makes less sense though
> :/
> 
> Perhaps warn about this instead of fixing it? Forcing people to play the
> section game?

I like the conservative aspect of that: keep the separate sections and
warn if the return thunk is in the same section.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
