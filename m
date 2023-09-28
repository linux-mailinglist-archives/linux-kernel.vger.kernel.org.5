Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 448107B181A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjI1KM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 06:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjI1KMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 06:12:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0724126
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 03:12:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7B81821854;
        Thu, 28 Sep 2023 10:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695895939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngZmuXVMIJumoo5UQfITL7xAzm5EwAlIH18PHZinZyI=;
        b=I6VHgxPS5Qc1hS695pAxPWn55GxmIOTFveDFSpexfLM+K1CPqUgBlXwmMsTt9pq4AzvB3D
        zJc4+6/fItR/c6NmGGmFuYBPK/4LODnmlbxk/3UiN3TDMozz7O0cpVHCheU7NfGRIrItGs
        lNjenHO/Zutp+pYnHrwrqzCUWvuGi90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695895939;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngZmuXVMIJumoo5UQfITL7xAzm5EwAlIH18PHZinZyI=;
        b=VOx91Edrx+i7zfKSMk/jT2lE3yXfxyDgfDrEaNUeM26ChK/cnloCc9F5KLhKxAg7XJvno+
        nf2oP3h4bOT37sAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5AF3513581;
        Thu, 28 Sep 2023 10:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jYzME4NRFWWjBwAAMHmgww
        (envelope-from <aherrmann@suse.de>); Thu, 28 Sep 2023 10:12:19 +0000
Date:   Thu, 28 Sep 2023 12:13:54 +0200
From:   Andreas Herrmann <aherrmann@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     liming.wu@jaguarmicro.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/debugfs: Fix a typo of irq debugfs
Message-ID: <20230928101354.GA10436@alberich>
References: <20230927022925.751-1-liming.wu@jaguarmicro.com>
 <875y3ufxa2.ffs@tglx>
 <20230928094831.GD7895@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928094831.GD7895@alberich>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:48:32AM +0200, Andreas Herrmann wrote:
> On Thu, Sep 28, 2023 at 11:43:33AM +0200, Thomas Gleixner wrote:
> > On Wed, Sep 27 2023 at 10:29, liming wu wrote:
> > > From: Liming Wu <liming.wu@jaguarmicro.com>
> > >
> > > Correct the spelling of effective.
> > 
> > That spelling is on purpose to have tabular output, which you break with
> > that change.
> 
> Hi Thomas,
> 
> I've received this email twice.
> 
> There seem to be many duplicate emails today (LKML, maybe other vger
> lists as well).
> Not sure what is causing this.
> 
> Do others observe this as well?

Never mind. It seems to be on my end -- somehow.
Don't care at the moment.

Examples:

fetchmail:
2023-09-28T12:02:34: reading message aherrmann@mutt@imap.suse.de:1 of 2 (15900 header octets) (2222 body octets) flushed
2023-09-28T12:02:34: reading message aherrmann@mutt@imap.suse.de:1 of 2 (15900 header octets) (2222 body octets) flushed
mutt:
23339     Sep 28 Miguel Luis     (2.1K) │   └─>
23340     Sep 28 Miguel Luis     (2.1K) │     └=>

fetchmail:
2023-09-28T12:02:35: reading message aherrmann@mutt@imap.suse.de:2 of 2 (6029 header octets) (9197 body octets) flushed
2023-09-28T12:02:35: reading message aherrmann@mutt@imap.suse.de:2 of 2 (6029 header octets) (0 body octets) flushed
mutt:
25751 N ! Sep 28 AngeloGioacchin (8.7K) └─>Re: [PATCH v10 5/9] drm/mediatek: Add connector dynamic selection capability
25752 N ! Sep 28 AngeloGioacchin (  0K)   └=>
{the 2nd mail has empty body}

The first duplicate email from LKML seems to be
Sep 11 Casey Schaufler (8.4K) &─&=>Re: [PATCH v14 04/11] LSM: syscalls for current process attributes
Date: Mon, 11 Sep 2023 15:08:48 -0700

Odd.

-- 
Regards,
Andreas

SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nürnberg, Germany
GF: Ivo Totev, Andrew McDonald, Werner Knoblich
(HRB 36809, AG Nürnberg)
