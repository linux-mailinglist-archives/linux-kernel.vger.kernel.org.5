Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544008038E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 16:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbjLDPc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 10:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbjLDPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 10:32:25 -0500
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE370E6
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 07:32:30 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0028840E0275;
        Mon,  4 Dec 2023 15:32:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id W7tZGXmaD_gW; Mon,  4 Dec 2023 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701703947; bh=sJMPaBTq2W+d+UnYz3q+JxTewGqmmAbRBZQqH1UMueU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hikvEk9hU5gIRNewGnoEp72aSxXz+VEn8myfUufxidLmAeHZqUlvJjg/glDX1/PK6
         i2cl+JrWTp7FPfhV8wBFDZ4wJsQ7fHpO4OlSQWR5OXGDJLuPwkWglI9QdfhgNfzFgR
         niSRpw422dlUJsuwSZUVg1AT5A3N7RnIKZd3OB4WTHIA0YAW8pED7gMRaLLWagore7
         aI6NtCFje70tKFntGjidvj+/piNfT69cCCTNQfXWxv+y2qaS/66jRmrtyOAtuZkFis
         AI2Bj9w5mpiitMp/r/KUoayuIRqqCz6ZkFcJBPX3djwpH6/beXBEVlTbsoXk+HKVQ1
         iYkG1L7Aj+Aa7xzrhLw9XpcRTFritKQQkjbMSLO7xQ7yz2B8u/SBmjq4W4mP0UfnvR
         0ez7l5+Ul9Bc0scjZXN4m1Q808/bgCivlmMtYEc+/4T5lbDVS6UJtxPuxKakjuLsgE
         DRNP6a9PSuGSvhLj3Rhq758nIvWgkXsLD8YCTcwaC/Pea9aCLZUpDtFKS58/Ty49bH
         pGU4aW0rXLG1vmp9O3ANC7QAFTGFH+wPZ3vYSC28cezJViXdjIyvkNoOcDUF1C7ZOp
         2qceu1myQbeDjJo55jbHve4K29/XlP8hEM1Mu+HSgM9EftKKig1be4g8EocR2PwrHq
         0N9ZYxZW2VayWfqlGrTvu7tk=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 156EC40E014B;
        Mon,  4 Dec 2023 15:32:23 +0000 (UTC)
Date:   Mon, 4 Dec 2023 16:32:17 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Brian Gerst <brgerst@gmail.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/CPU/AMD: Add X86_FEATURE_ZEN1
Message-ID: <20231204153217.GBZW3xAbH36zBxPZIM@fat_crate.local>
References: <20231120104152.13740-1-bp@alien8.de>
 <20231120104152.13740-2-bp@alien8.de>
 <dc3835e3-0731-4230-bbb9-336bbe3d042b@amd.com>
 <20231130171316.GLZWjCrHGHl+VVp724@fat_crate.local>
 <16400d3d-8264-4f3f-96ca-168064944462@amd.com>
 <20231130185048.GMZWjZiIjhpjrv4rPf@fat_crate.local>
 <20231202124901.GBZWsnvQct4PxsUsXK@fat_crate.local>
 <255f23c8-5c89-47cd-ad97-7f5f0b07d645@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <255f23c8-5c89-47cd-ad97-7f5f0b07d645@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 08:36:04AM -0600, Tom Lendacky wrote:
> Should this be renamed to init_amd_zen1(), just to avoid confusion?

Done.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
