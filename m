Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11130776BA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbjHIWBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232677AbjHIWBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:01:12 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D711FEF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:01:10 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6D8C440E0140;
        Wed,  9 Aug 2023 22:01:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BHHPYaUi1Wv9; Wed,  9 Aug 2023 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691618465; bh=mOw3UfmxLUqlp+srChQDc8V8SYdBxD9Ow2uHxM9ENJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cCEMxIw/WWsXmbRt0CDMxQA3XJkHvw3cjBY85N4KoXjy/d2K1URmcQcZnL42vaxNE
         cPnmgT4B40hympVtpJHEYBoCYV1Wyu3OfK10+vfrji5CxsQOALN7iCd/s6ZLqYvV6s
         kM9A+DiSmLMKPiJuiTjadpy/j5pXSBj2HeuyR5YMB06xWmgY67Fn3Z6VdNKsvUZ6Qw
         2xYpolcK7Q47Ub8sc+0d18JERRD3F/RGZO8q3sjHnU7gcNRUkd21AwTlRTNHuxkGap
         C+A6/3eyhgXsITPEkQ9wXqbF9K+WGNb+ClWOSUL7IRArCTc18YRVsTff+3B6likWo3
         QiwQo72O0gyf/P1aVkNkg/IGw212kYFBZXro3V/1Zr0+QczRIH0vLCfUev2kczAuF7
         vIHcqcAcXfZv1x2uLUAllCfWvo0WtQ9yOKG+8IV/Tjdfj+SNo+w28XQosqyjea2p8n
         0iXheraw4bDHuA/7iS7Byd8Cvcn9Rca7WL/iBFRTWC2o0s7H3aBvjd4MYYERqEF/SM
         BO8G9xfGYhUobjVQBXK82Aw4c8zp66MXCegQOX0jIeXO//V8b2j+cpnGdoH9xp8Hqn
         j8dSgvAxJDh9lDoMFQrUg34+MSDPRltd/zc+DnlhIw8/enV2x6k+w7wXpasqa8/RFd
         Wmfhwo/ZCDYm4UwGytgn1osM=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C34FC40E01A0;
        Wed,  9 Aug 2023 22:01:00 +0000 (UTC)
Date:   Thu, 10 Aug 2023 00:01:00 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     X86 ML <x86@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/3] driver core: cpu: Unify redundant silly stubs
Message-ID: <20230809220100.GRZNQMnEGKuOcZ4lb6@fat_crate.local>
References: <20230809102700.29449-1-bp@alien8.de>
 <20230809102700.29449-3-bp@alien8.de>
 <20230809214741.n4k5rmnw7an4dfdr@desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230809214741.n4k5rmnw7an4dfdr@desk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 02:47:41PM -0700, Pawan Gupta wrote:
> Do you want me to send a separate patch for this?

No need - I'll fix it up.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
