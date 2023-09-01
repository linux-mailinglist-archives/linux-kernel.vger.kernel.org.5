Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C162578F932
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 09:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347332AbjIAHi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 03:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjIAHi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 03:38:28 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9E10D5;
        Fri,  1 Sep 2023 00:38:25 -0700 (PDT)
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4CD7F1EC0865;
        Fri,  1 Sep 2023 09:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1693553903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=I10jJ3rPf4KMJhMJjkVN7N9K6siOjGMTic8ViSZ8/Og=;
        b=or2k1rLSpwCzu/kvcAFXP1JXZoLg7s8ibqeG/Eze0rJ9CvJq9Lltq9ofSk5PTwEOubjXWw
        ySB8VoQA6MhvslmwSK5GOQq4xomnEDsr5cKGX4Ap2FgcRNwbSINdN8SUPLXj7PMBI6IikE
        hHVyaVImY6a4budvol94JC/EEL4l+WA=
Date:   Fri, 1 Sep 2023 09:38:23 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shravan Ramani <shravankr@nvidia.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] EDAC/bluefield_edac: Use ARM SMC for EMI access
Message-ID: <20230901073823.GAZPGU75L6YEPGopLb@fat_crate.local>
References: <7a67e5fd25664f4c2277283e15b438e826b3c163.1693392576.git.shravankr@nvidia.com>
 <20230830113421.GBZO8pPUILVoBUVlki@fat_crate.local>
 <DM4PR12MB5136B7483D9E76625B2BDCA1C0E5A@DM4PR12MB5136.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5136B7483D9E76625B2BDCA1C0E5A@DM4PR12MB5136.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 04:31:23AM +0000, Shravan Ramani wrote:
> SMC is needed by the driver to access certain HW blocks/registers which
> can be accessed only from secure state. Whether a certain block requires
> these secure calls or not is encoded in the ACPI table entry and passed
> on to the driver.

This sounds like a good start towards explaining why this patch is
needed. Here's an example commit message structure:

1. Prepare the context for the explanation briefly.

2. Explain the problem at hand.

3. "It happens because of <...>"

4. "Fix it by doing X"

5. "(Potentially do Y)."

For more detailed info, see
Documentation/process/submitting-patches.rst, Section "2) Describe your
changes".

Do not talk about what your patch does - that should (hopefully) be
visible from the diff itself. Rather, talk about *why* you're doing what
you're doing.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
