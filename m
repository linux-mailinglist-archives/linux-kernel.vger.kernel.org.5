Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D077D24D0
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Oct 2023 19:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjJVRG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 13:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjJVRGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 13:06:38 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CE188
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697994388;
        bh=95BWdYpieA1jfCJkLTVcMtXh8VjD0uWsXDor/VLum28=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WhAKF1ptXoD72GDjWu2I1FTDZf0aTtXIFWCtaRVTBDP7HkrX0TNo5rMRWZuoCV/BJ
         BaLexMVi/+YlEhEFiKSczBmXMRBbUaU3io18uwFPJRpDKJbRI7MscLBr0oYAYbiK2m
         rAMyltdvI52z08nKTqCrJUR73Sxxyx27g7n+0zIQ=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id AE3D51285D91;
        Sun, 22 Oct 2023 13:06:28 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id GqSHSIh7KOph; Sun, 22 Oct 2023 13:06:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697994388;
        bh=95BWdYpieA1jfCJkLTVcMtXh8VjD0uWsXDor/VLum28=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=WhAKF1ptXoD72GDjWu2I1FTDZf0aTtXIFWCtaRVTBDP7HkrX0TNo5rMRWZuoCV/BJ
         BaLexMVi/+YlEhEFiKSczBmXMRBbUaU3io18uwFPJRpDKJbRI7MscLBr0oYAYbiK2m
         rAMyltdvI52z08nKTqCrJUR73Sxxyx27g7n+0zIQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B70021280FB4;
        Sun, 22 Oct 2023 13:06:27 -0400 (EDT)
Message-ID: <b4ebea2eeb63aaa7ba0877cee0c9ca966af9eae0.camel@HansenPartnership.com>
Subject: Re: Oops with v6.6-rc6+
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Borislav Petkov <bp@alien8.de>, Julian Wollrath <jwollrath@web.de>,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Sun, 22 Oct 2023 13:06:25 -0400
In-Reply-To: <20231022161847.GAZTVLZ74T8B79v87p@fat_crate.local>
References: <20231022172700.48c515cf@mayene>
         <20231022161847.GAZTVLZ74T8B79v87p@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-10-22 at 18:18 +0200, Borislav Petkov wrote:
> + linux-scsi
> 
> On Sun, Oct 22, 2023 at 05:27:00PM +0200, Julian Wollrath wrote:
> > Dear maintainers,
> > 
> > on v6.6-rc6+ (git commit hash 1acfd2bd3f0d) I got the following
> > oops:

How to reproduce would be helpful.  Was this a cat of /proc/scsi/scsi?

Regards,

James

