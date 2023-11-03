Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C957DFD96
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 01:38:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjKCAdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 20:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjKCAdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 20:33:45 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F4D136;
        Thu,  2 Nov 2023 17:33:39 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id DAF07C01B; Fri,  3 Nov 2023 01:33:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698971616; bh=/MJZ9C7RKPB/RlBz8fZGhhwSSkmv7eGeKoqSA++bXEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Laxif8cFeFoIrghfcmNngzBUeK6QJUuQhgt2QM93ipCUQ9A/UbpcW4I9CmxvOdBYs
         Gya7Ss24GZ5nkH++UWsO7YLxy6TH9WK2pXpecu1CaSRlL+GM+AS5V2x7V3bQNl9R0v
         PJL8Lii3uYEGRv7EeFtl0Fy64no4juaU3Net7orCkYS2XdGQocUtBuX/f5lYauBy8b
         sAFM/YXmjXki1sUZrKvjg5/UcO5YqKPEb6hjUVpN6jgCVZ4scz27ufWnLleulCtX2U
         NKbtfIRRxgf8+J0SridlURcSLAdXlyNrjLg15J4SeD7ToGJGBgO4E4MmpIqpjN9YA2
         HiHOSN+4lki5g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 931D5C009;
        Fri,  3 Nov 2023 01:33:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698971606; bh=/MJZ9C7RKPB/RlBz8fZGhhwSSkmv7eGeKoqSA++bXEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ziSwTLqpvBCbkOG3YevGUd55nv9mPIke4sHuKV6L7JwohCulWYyuCw3ir3VfbJF58
         v/ICuKfWpeP/voHtHU4BmyTjm2uFjbUwI+SVmRqDDni++8ETVjTWqgAp5LEZSGbRgF
         1eurIDg2X7llo8YLtvYxY+KqW61CKiN/5SxHWEAFQ6+2NDVnVq18eI7EQv/Uk3KFdG
         dUMDx33hAP5eG5V0mdb3aSDBwJxhzRRwj/Ghl/o8adK9emfbHGWc8e13LFZWy1WLID
         qlYOf9i6I1QP2/Y76CNi0uiKeRD5i/Z82W5MDCOiRmsQPKu/XKbx4T7EYm6LAdWIG+
         pq1SAyOxZyF3Q==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id c8812187;
        Fri, 3 Nov 2023 00:33:21 +0000 (UTC)
Date:   Fri, 3 Nov 2023 09:33:06 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Dominique Martinet <dominique.martinet@atmark-techno.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Alex Fetters <Alex.Fetters@garmin.com>
Subject: Re: [PATCH] mmc: truncate quirks' oemid to 8 bits
Message-ID: <ZUQ_wm22gO7lLZ3N@codewreck.org>
References: <20231026075230.414685-1-dominique.martinet@atmark-techno.com>
 <CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwhW2u9K2oUtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPDyKFqkKibcXnwjnhc3+W1iJBHLeqQ9BpcZrSwhW2u9K2oUtg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ulf Hansson wrote on Thu, Nov 02, 2023 at 02:25:09PM +0100:
> > Fixes: 84ee19bffc93 ("mmc: core: Capture correct oemid-bits for eMMC cards")
> 
> [...]
> 
> It looks to me that the offending commit (84ee19bffc93) should be
> reverted instead of trying to introduce some weird parsing of the card
> quirks.

I agree that's better -- that's what I did on our stable tree until the
dust settles down, I probably should have sent that instead.

As Avri pointed out the offending commit was picked up to stable, but
the revert should apply cleanly so if we send Greg a mail after Linus
picked it up it can be reverted on all stable branches quickly.

There's little value in me resending this as a revert, but process-wise
I guess it's easier if someone sends it as a mail so I'll whip up a
commit message and send that now.

> In fact, up until v5.1 it seems not to be a problem to use 16-bits for
> the OID, as the CBX and the reserved bits are probably just given some
> fixed values by the vendors, right?

Right, it's possible that using 8 bits here would apply the quirks to
more devices than what was intended if the other 8 bits made a
difference... Unfortunately that's something only vendors would know.

> Beyond v5.1A, we may have a problem as the BIN may actually be used
> for something valuable. Maybe Avri knows more here?
> 
> That said, if the offending commit is really needed to fix a problem,
> we need to figure out exactly what that problem is. The EXT_CSD_REV
> doesn't provide us with the exact version that the card is supporting,
> but at least we know if v5.1 and onwards is supported, so perhaps that
> can be used to fixup/improve the OID/CBX/BIN parsing.

Keep filling the full 16 bits unless rev is higher, in which case we
read half?
At this point (mmc_decode_cid) we can use card's ext_csd.rev so if v5.1A
bumped it then it's a possibility; I don't have access to the jedec
standard to check right now.

-- 
Dominique Martinet | Asmadeus
