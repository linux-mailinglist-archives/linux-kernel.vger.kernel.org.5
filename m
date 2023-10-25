Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060967D73E5
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjJYTIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjJYTIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:08:34 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BA210E;
        Wed, 25 Oct 2023 12:08:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F0B9F40E0199;
        Wed, 25 Oct 2023 19:08:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SOVZmwGQ6OgV; Wed, 25 Oct 2023 19:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698260909; bh=mQQA/bbEDjLExBZKacbMFCHC1vLWWr3iuoGA/egFOng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emkvT+AdkNalocsrZFCdULM19AFpg65rn9Dtjv5bW9LgI5qnkE1ffFtlRPTfCZp6u
         WMPI0AnTxDAyT9yiNLie2YMSMiKr9/YljO0wlx4BxuowcD8TPTb2JrCGj5HBR2ovLf
         wX9TDzuijH791Pm/ab6dTGVUO8rVBKwvJG4qXLKbZ+qIv9VBGfPrw8Yq7z3BWAZ4oU
         uWfjkMit0fgN+4Ly/A64vj/jgk5lQbamk1WVZzSa56gScJCi3jYZPJR/jxYKBO/Kkb
         JfAo0j1yQPP8qNpB6v7iV/jRBdFQyabYZI6/BIcqEIWawP1R2IkfoHuqdA7lWxH+Xd
         Prq6Dworj49E7S6nStI6CIXDHdw0+FF8yBcbSrixu/6u4AEhduGtK9STLToLGfOkrv
         by7jkMIbJgPIBw6RDKbxwtKexJHoDSbe6EXeKNBaHrPlSGTntGm/XJ2t3eqyNY5SwA
         WfVWWVliaypp3FJevBFq9Qs4AJQ3/oL17CI+A+Gs8ro1DZfVOramW9EhpvYRd4WBiP
         RXFxrEfpgnrTR3pyvlhSLw8VHN68zidUlXsLV3YQdWiy//NU/0xB/RT/HV7iee3LKe
         brjPmZtUoKACJJStlUtGPvE8xgZ9dbW6RB9laNvsDwzQygIqWEWJLtFcrB/QnppBTB
         CMNR0DwQ/7uD0XecejF1gz+I=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3557240E014B;
        Wed, 25 Oct 2023 19:08:23 +0000 (UTC)
Date:   Wed, 25 Oct 2023 21:08:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v2 1/4] EDAC/mce_amd: Remove SMCA Extended Error code
 descriptions
Message-ID: <20231025190818.GDZTlnomnaT8zxnbxX@fat_crate.local>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-2-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025051455.101424-2-muralimk@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:14:52AM +0000, Muralidhara M K wrote:
> The SMCA error decoding already exists in rasdaemon and future bank decoding
> is supported from below patches merged in rasdaemon.
> https://github.com/mchehab/rasdaemon/commit/1f74a59ee33b7448b00d7ba13d5ecd4918b9853c rasdaemon: Add new MA_LLC, USR_DP, and USR_CP bank types
> https://github.com/mchehab/rasdaemon/commit/2d15882a0cbfce0b905039bebc811ac8311cd739 rasdaemon: Handle reassigned bit definitions for UMC bank
> 

I'm still missing here the exact steps a user needs to do in order to
decode such an error.

Please inject an error, catch the error message and show me how one is
supposed to decode it with rasdaemon in case the daemon is not running
while the error happens or the error is fatal and the machine doesn't
even get to run userspace.

If that is not possible with rasdaemon yet, then this patch should not
remove the error descriptions but limit them only to the families for
which they're valid.

Bottom line is, I don't want to have the situation mcelog is in where
decoding errors with it is a total disaster.

IOW, I'd like error decoding on AMD to always work and be trivially easy
to do.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
