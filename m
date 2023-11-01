Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1717DDC34
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 06:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346844AbjKAEh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 00:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbjKAEhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 00:37:54 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969B0103
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 21:37:47 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id EC2A3C01B; Wed,  1 Nov 2023 05:37:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698813465; bh=j+mg0+uxBvTuBRWF4ptxdU82Fb+1k2fxHgCCXiVcZQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4awi9G+mg0+EAiKXCXRJdb+1a8p9CfMbHvFn3a8oVq2cYQBKM4nvx0VzA178oTRK
         SXk05BcSid5LR2bq/i9X9cd3Q8ZgF8EYBaR5urwNi0EYcJPGhvBta9zE13cQSHWbe6
         cA8TeBCKOmLoaQUoaeHn5/aFcpebdLAu7EoswMS5xk2PgLQfYpKV+WkX8zPkEbExv1
         mmJmqULWawJScFdD87a3dLdcCAF05KJ+8Yse8wzLnBVUgHtikf7fMtsp9zE/qEihHm
         ZVieNDqTiq6BNdFg7k61V5k6kJlBVh1pTUqr+51bFeAxH2PCsCmHUyy3pic9xTTbQC
         Q/DfyEnCEUaFQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id AC94BC009;
        Wed,  1 Nov 2023 05:37:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698813455; bh=j+mg0+uxBvTuBRWF4ptxdU82Fb+1k2fxHgCCXiVcZQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrYPsiWrkRCUcn9s2MkFLg31xqxTmwQ1Tm4if+GBYb8fG34lFc7Iztqp6C1KKbclx
         T6gcJFZrjEYqGzP2dK+HhKxVK/hvZUQFEP5xVQLBRQPli2Ekd23oC70xH0OsEMtIF+
         yE/i3PX6sgdgnjTga6oZVr9k4AO1o5cFlevbYUcq03sVYSX6dyv6mP2q2uNmYsTz3g
         dxejHEfnu/Gu60nGzWQjRg32VvKIP40RYvx/ad6UoeuD1lmTWXlKvHacFqt7XI6lcA
         ihpRJqLOxHAaQ73XCwDcX0oI+gOvO0d01ZUSZyJ1OIF+SR5T+zMlcp5MVWNXoDoCem
         2m4ptISHOVnNQ==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 532b5c2b;
        Wed, 1 Nov 2023 04:37:30 +0000 (UTC)
Date:   Wed, 1 Nov 2023 13:37:15 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Dominique Martinet <dominique.martinet@atmark-techno.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alex Fetters <Alex.Fetters@garmin.com>
Subject: Re: [PATCH] mmc: truncate quirks' oemid to 8 bits
Message-ID: <ZUHV-wduEf12M86U@codewreck.org>
References: <20231026075230.414685-1-dominique.martinet@atmark-techno.com>
 <DM6PR04MB657596E19EF3D7976197660EFCDDA@DM6PR04MB6575.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM6PR04MB657596E19EF3D7976197660EFCDDA@DM6PR04MB6575.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avri Altman wrote on Thu, Oct 26, 2023 at 10:16:53AM +0000:
> Reviewed-by: Avri Altman <avri.altman@wdc.com>

Thanks for the review!

> > ---
> > Notes:
> >  - mmc_fixup_device() was rewritten in 5.17, so older stable kernels
> >    will need a separate patch... I suppose I can send it to stable
> >    after this is merged if we go this way
> >  - struct mmc_cid's and mmc_fixup's oemid fields are unsigned shorts,
> >    we probably just want to make them unsigned char instead in which
> >    case we don't need that check anymore?
> >    But it's kind of nice to have a wider type so CID_OEMID_ANY can never
> >    be a match.... Which unfortunately my patch makes moot as
> >    ((unsigned short)-1) & 0xff will be 0xff which can match anything...
> >  - this could also be worked around in the _FIXUP_EXT macro that builds
> >    the fixup structs, but we're getting ugly here... Or we can just go
> >    for the big boom and try to fix all MMC_FIXUP() users in tree and
> >    call it a day, but that'll also be fun to backport.
> To me, your fix is clean, elegant and does the job.
> I would let the quirk owners to fix that hard-coded bogus oemid - should they choose to.
> I guess Sandisk would need to do that as well.

Yes, this was exactly my intention - leave the workaround in place for a
while while owners fix their quirks then eventually fix types and remove
this when it is no longer needed.

Meanwhile, all stable kernels including the newly released 6.6 have many
broken quirks and at the very least the MMC I have here would
periodically hang when issuing a flush, so as a selfish user I'd
appreciate if this (or something equivalent) could be making its way
towards Linus' tree.
Ulf, would you have a bit of time to move this forward, or should I ask
Greg to temporarily revert Avri's "mmc: core: Capture correct oemid-bits
for eMMC cards" commit in stable trees until the way forward is decided?

Thanks!
-- 
Dominique Martinet | Asmadeus
