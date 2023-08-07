Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE4771D24
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 11:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjHGJcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 05:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjHGJcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 05:32:20 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872AFE76;
        Mon,  7 Aug 2023 02:32:18 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0B8B240E0194;
        Mon,  7 Aug 2023 09:32:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PP9vhy3VGXTt; Mon,  7 Aug 2023 09:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691400733; bh=jdzfSbcLTyLOfAPBSqaYmOQ5LXgQftjhemRqqNArAm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cG61Kq/HbzwTSv4C+HJX9sZh2Jdoq/xcqD90mvG5ZhD0vgXGUGVimP8hRjfLpqx65
         7+KEVKRLT+yQksNgYAxWncrlNer59MTM1xu1ZV1EiNYmk11MMKLCZa9jpMJUAFCoSM
         nmoG2KMNSA+PkTSjiRneiT9vKiOfbAfICQ6PU0sDBcyRutTWwR5VZLg+YjSg5zpeAP
         0CRE77w0gIov8MrQayVHhwPlZI3zKOjK4ZhNIRmAkkwGSp8MwBCTcxU/bEyliQbyFK
         trB9QYQfBrPayv9p/5t9E6i/APtuWvV6jM2U0p0n+4eg/Ukmu/PvFnkdNa6SMl98VR
         4G/DvmqHnLw139IiR4v6dssIC08Q49Ienj052KFONZ5V3tqpUG8fo1XRu9bLcpK5o9
         1XMZXVXW9U1A2HoA/CbYiPUifyejWhEnA60KUm+5kRcvqubT5Co/Kga4rsNzz3gzVO
         LHA/ZrJXwgZJd7O7fsYj3ClxIFcWhQK7HD94clwQ167t/Y3h2UJoKsH+sMgWSxAydP
         8QYiBbwRlHr9SJdOcAbJdWLURzYzw0MDFrxpK9YvV039bvBMqMDosYG0GAokrs/PsC
         MkWBwy+G0JOB9wYeYDQXOnK9XFGKnpYnwk/DqsGkKFUpTqlKI3Uvl3umjdfeV/Hnvv
         CBxBFXgkfEE8GJ0q1NHU/I48=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6260040E00B0;
        Mon,  7 Aug 2023 09:32:07 +0000 (UTC)
Date:   Mon, 7 Aug 2023 11:32:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shravan Kumar Ramani <shravankr@nvidia.com>
Cc:     James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 RESEND] EDAC/bluefield_edac: Add SMC support
Message-ID: <20230807093203.GEZNC6E88ALSqduipK@fat_crate.local>
References: <0512fa0c173f446b62e8503e0f308359b64aa679.1690537719.git.shravankr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0512fa0c173f446b62e8503e0f308359b64aa679.1690537719.git.shravankr@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 05:53:47AM -0400, Shravan Kumar Ramani wrote:
> Add secure read/write calls to bluefield_edac. The ACPI

What are "secure" calls and why does this driver need them?

This commit message is too laconic.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
