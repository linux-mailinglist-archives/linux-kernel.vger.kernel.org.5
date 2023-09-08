Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52763798110
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 05:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbjIHD7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 23:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbjIHD7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 23:59:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F21BD5;
        Thu,  7 Sep 2023 20:59:08 -0700 (PDT)
Received: from nazgul.tnic (unknown [93.123.97.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33ECC1EC0645;
        Fri,  8 Sep 2023 05:59:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1694145546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TguoLw/M+pg5pof3m7M+GZki4L6QFruFleEnIMG45oc=;
        b=bQ3kHLjkA3IUe4Dp1awZwI3rjciES9TcnBC66CMvRUmAImo+cb+2bNVZLI3dCEh0qZpvfz
        c7e0LeG0boRzRoKOsTo6egC0n9JGdug1i9KJisqtsEXFFQps2NGXfXye5GCLXWbpSB1tYD
        UnFMbkfLN3+hNmI2FUGR5XaKv0YHgjs=
Date:   Fri, 8 Sep 2023 05:59:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Elliott Mitchell <ehem+xen@m5p.com>
Cc:     smita.koralahallichannabasappa@amd.com, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, yazen.ghannam@amd.com
Subject: Re: [PATCH] Revert "EDAC/mce_amd: Do not load edac_mce_amd module on
 guests"
Message-ID: <20230908035911.GAZPqcD/EjfKZ0ISrZ@fat_crate.local>
References: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
 <ZPqQEHXgmak1LMNh@mattapan.m5p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPqQEHXgmak1LMNh@mattapan.m5p.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 08:08:00PM -0700, Elliott Mitchell wrote:
> This reverts commit 767f4b620edadac579c9b8b6660761d4285fa6f9.
> 
> There are at least 3 valid reasons why a VM may see MCE events/registers.

Hmm, so they all read like a bunch of handwaving to me, with those
probable hypothetical "may" formulations.

How about we cut to the chase and you explain what exactly is the
concrete issue you're encountering and trying to solve?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
