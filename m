Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6678A7B17D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjI1JrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjI1Jq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:46:58 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91491122
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:46:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 080072188C;
        Thu, 28 Sep 2023 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695894416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1m5a3QBPquEtABFzJZnp0P/n4AzBqVnoHBwO07SKZA=;
        b=w4KjglXY59PT3pqFYhHgL9hFgBd2fxznPl7Ws5hk8sMIvsuNFrvVgpncF0GwdLX2wOHbJF
        56khlr8224wJNWGUTkRnJuUwOfHLk8AHLMGGhuHYhxPjkivDROM8e+ws2b+/UalRJgEm7C
        bk/kkKOMztwYnR5ONmMB2OVp/QmcPhQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695894416;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u1m5a3QBPquEtABFzJZnp0P/n4AzBqVnoHBwO07SKZA=;
        b=JPU2dVMxHiNoXVQZQg3EDYaY6G6Mb742RLXGuG3phX0QBs1/dkrlRvVJixUs8uxmJLVir8
        i0lspZrPBqw+OiDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DA0B413581;
        Thu, 28 Sep 2023 09:46:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aY7PM49LFWXMeAAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 28 Sep 2023 09:46:55 +0000
Date:   Thu, 28 Sep 2023 11:48:31 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     liming.wu@jaguarmicro.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/debugfs: Fix a typo of irq debugfs
Message-ID: <20230928094831.GD7895@alberich>
References: <20230927022925.751-1-liming.wu@jaguarmicro.com>
 <875y3ufxa2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <875y3ufxa2.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:43:33AM +0200, Thomas Gleixner wrote:
> On Wed, Sep 27 2023 at 10:29, liming wu wrote:
> > From: Liming Wu <liming.wu@jaguarmicro.com>
> >
> > Correct the spelling of effective.
> 
> That spelling is on purpose to have tabular output, which you break with
> that change.

Hi Thomas,

I've received this email twice.

There seem to be many duplicate emails today (LKML, maybe other vger
lists as well).
Not sure what is causing this.

Do others observe this as well?


-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)
