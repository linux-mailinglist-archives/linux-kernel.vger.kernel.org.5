Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE68807279
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378881AbjLFOdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 09:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378823AbjLFOdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:33:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B16D40;
        Wed,  6 Dec 2023 06:33:28 -0800 (PST)
Date:   Wed, 6 Dec 2023 15:33:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701873207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zezMrylqGdb36QvkU2zBAFlIvARn8RpkFnyn/ed2Rnk=;
        b=MeZmA6gikd4FGvWaJR5qR+4hZjtxgZ8P9pUjTh9kDlKh28o2DXrKsiMJy3/5K+oG7xRdHO
        ek3k5WPuplKAFJ3E8gS6mS8zpLEkLgKznFfkwy/FpkrW8Ed6hoJN+zLBy+CyxiI7kZPHvi
        bP+wVy39EvjaeJF9s67gQrKAK298571q+7NjJmY4n9sxKyG9CHxXg/Es9F+xg8rx/NrqA8
        tZDXsuKACPxGuclZPAByWIsEbbhijbrUgsAbOBUUY9T2NPmXAB6J9EaNW84jtZZ3CD4Zcp
        iwZfYgPtwisjRFyA2N607phCtJdEDxGxtWA+fqWuDlUV+0KtyDvoPXg/i6w1Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701873207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zezMrylqGdb36QvkU2zBAFlIvARn8RpkFnyn/ed2Rnk=;
        b=D6OiCCqqCCK70Ml7/H5hv0hyU08GdNctiY+5JgFAZHDp7tOzazsdwpOHlCpJXCKBzbfn5H
        NsAd+8yporlJAzBQ==
From:   Nam Cao <namcao@linutronix.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel@zonque.org
Subject: Re: [PATCH] Revert "spi: cadence: Add SPI transfer delays"
Message-ID: <20231206153326.028a0706@namcao>
In-Reply-To: <d8eb53dc-5158-4212-8715-052e9e99768b@sirena.org.uk>
References: <20231206134446.69048-1-namcao@linutronix.de>
        <d8eb53dc-5158-4212-8715-052e9e99768b@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 13:55:30 +0000 Mark Brown <broonie@kernel.org> wrote:
> On Wed, Dec 06, 2023 at 02:44:46PM +0100, Nam Cao wrote:
> > This reverts commit 855a40cd8cccfbf5597adfa77f55cdc8c44b6e42.  
> 
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.

Okay, will send a v2 shortly. Sorry for the inconvenience.

Best regards,
Nam
