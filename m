Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F5078DE83
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237977AbjH3TEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243707AbjH3LeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:34:18 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B498132;
        Wed, 30 Aug 2023 04:34:16 -0700 (PDT)
Received: from nazgul.tnic (unknown [78.130.214.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D4D81EC08F9;
        Wed, 30 Aug 2023 13:34:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693395254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kyrJuOePM6iTnqDG/fqXmuj6BgFDXnc1OpummGdqoKk=;
        b=Rv5vok3kkjHpodzGz6dXlJ08m3i9Xxymtas3l8jZ+cnHwNA7rBknQfHyQA8I1G2ZBVSw1n
        3WeBwD7f19u4zN6vw8Te1ShmYUlNvJ/BpHRkKrqvMHO7oTGGBanvzdZ9WeIq1aoTRSA2jf
        ZDaTb1N7DYuqzLqBhvCeufB9+Ju4h5I=
Date:   Wed, 30 Aug 2023 13:34:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shravan Kumar Ramani <shravankr@nvidia.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] EDAC/bluefield_edac: Use ARM SMC for EMI access
Message-ID: <20230830113421.GBZO8pPUILVoBUVlki@fat_crate.local>
References: <7a67e5fd25664f4c2277283e15b438e826b3c163.1693392576.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7a67e5fd25664f4c2277283e15b438e826b3c163.1693392576.git.shravankr@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 06:56:14AM -0400, Shravan Kumar Ramani wrote:
> Add secure read/write calls (arm_smccc_smc) to bluefield_edac.
> The ACPI table entry decides whether SMC is need for accessing

SMC? Self-Modifying Code?

> the registers in the External Memory Interface block. If not,
> the registers may be mapped and accessed directly.

I'm sure there's a human readable explanation for the above.

> v0 -> v1
> Updated commit message

I still have no clue what those secure calls are.

I'm sure there's some ARM documentation which you use in order to
explain why those are needed.

> +static int edac_readl(void __iomem *addr, uint32_t *result,

No "edac_" previxes to driver-local functions. They belong to the EDAC
subsystem.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
