Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324337D9B72
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346030AbjJ0ObF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345952AbjJ0ObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:31:03 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E922BD7;
        Fri, 27 Oct 2023 07:31:01 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A55A40E018F;
        Fri, 27 Oct 2023 14:31:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Ik-TNpFeKp8Q; Fri, 27 Oct 2023 14:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698417057; bh=Ugyndk500bk2O/AcAl8/rPk58PUdfX9vTxuY/2R6tow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TvCTTVo8QoeI6GgQ57VRn7MDli7slUsfpiGrI2fQ4mrG6XcrkHp5MXLbYoMuLINIq
         c5KXEeNjuxtE90ZbEdXt9fQVvZvBvRqBQ18A1pcVLAzc1OqLMUzflcweyAlosxaKeO
         c7C+G0dRlNiFWxIrD53Dgvz4O6DkptBiUq8S85nrQYOOPZJ97dtpJgMQwouiCuVf5j
         qV7MMLXhfn8qzDHccAX9FQNwVF7O/4M8nCzzZdkHzB/s9FIJbVE1hSorPhxMHqRoNq
         9T8aaFf+RQDLiifQ4DDx32EBAsj7ATKzdD5DslQ1IBYc4L++kGTVNWAgw1weQOpBrG
         1Ybfunjj+dZNaAKz5NRrMeNP0uBXgDgWROcwfOqx9PMk3lJyb0vOVJyCui4s1QUFso
         KepSkxzzwZ4lgxr+sLKaX26agDYafTRkog0ROwVS5iPmnI3fC5SnOH67+wWpWCn9QV
         owOjHfbzmIg4erjKaqXoMe8F/SnqEGWW5MUY3NAp2Dlbd6dxlSwrNkQ+7bKs4Yn0h1
         7OYzJGkv2MLXwnPNTDxone9DhDdq9d7qkDxTZ0HHG4Rc7C4Gmh1syFML7DoGKC6hFh
         MR/qUzfj099beCZCfb7nkr9qHT/5dpRTtK2FiAtTFTDDaggipEpWN8lGmj6KQzN4NC
         GVOZQAYo+tmquK9Z2Za06hSY=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ED1AA40E0173;
        Fri, 27 Oct 2023 14:30:51 +0000 (UTC)
Date:   Fri, 27 Oct 2023 16:30:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH v2 3/4] EDAC/mc: Add new HBM3 memory type
Message-ID: <20231027143050.GFZTvJmvrrgh0CyF4j@fat_crate.local>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-4-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025051455.101424-4-muralimk@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:14:54AM +0000, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> AMD MI300A models use HBM3 (High Bandwidth Memory Gen 3) memory.
> HBM is a high-speed computer memory interface for 3D-stacked synchronous
> dynamic random-access memory (SDRAM).
> So support new memory type by adding a new entry to 'enum mem_type'.

"Add support for this memory type."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
