Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209F77EE24C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjKPOEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjKPOER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:04:17 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C644BD4B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:03:59 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5A9CD20503;
        Thu, 16 Nov 2023 14:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700143438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOEAf/SMh1A5FpgIQzn+MGI9C2/IuJvYpW+XFINPXC8=;
        b=xKUDKp2s8c6SvnRq0WiAYnRTpFZjGlqM04Kvi1v937jnUZtx90YJrkAgqtjwsXuifMiRIb
        L9EgW6DCOMQ7e+UtW9zuK1BgRoEVHYSlRcJyINGKMLzBygLowiQAzzVXr9ErI+H21D3TMp
        sw2M5fKyUH0z7h2kXGOs3TzIceKKGIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700143438;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NOEAf/SMh1A5FpgIQzn+MGI9C2/IuJvYpW+XFINPXC8=;
        b=o2GvLAMcDaM46vb6HYsL23yLPQZzJT5PI9kJfurM0Hx7vFs3X+B6yC4k39TDhDoQ9EVmaU
        X33owFCZTVjUpgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BB98139C4;
        Thu, 16 Nov 2023 14:03:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /BIPCU4hVmUJJQAAMHmgww
        (envelope-from <jdelvare@suse.de>); Thu, 16 Nov 2023 14:03:58 +0000
Date:   Thu, 16 Nov 2023 15:03:57 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     "Gabriel L. Somlo" <gsomlo@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH] drivers/soc/litex: drop obsolete dependency on
 COMPILE_TEST
Message-ID: <20231116150357.6a2fa8f9@endymion.delvare>
In-Reply-To: <Y4DKYqgecIlGTxQK@errol.ini.cmu.edu>
References: <20221124161618.34ca07b3@endymion.delvare>
        <Y4DKYqgecIlGTxQK@errol.ini.cmu.edu>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         RCPT_COUNT_FIVE(0.00)[5];
         HAS_ORG_HEADER(0.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         TO_DN_ALL(0.00)[];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         FREEMAIL_TO(0.00)[gmail.com];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[22.41%]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gabriel,

On Fri, 25 Nov 2022 09:00:02 -0500, Gabriel L. Somlo wrote:
> On Thu, Nov 24, 2022 at 04:16:18PM +0100, Jean Delvare wrote:
> > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> > is possible to test-build any driver which depends on OF on any
> > architecture by explicitly selecting OF. Therefore depending on
> > COMPILE_TEST as an alternative is no longer needed.
> > 
> > It is actually better to always build such drivers with OF enabled,
> > so that the test builds are closer to how each driver will actually be
> > built on its intended target. Building them without OF may not test
> > much as the compiler will optimize out potentially large parts of the
> > code. In the worst case, this could even pop false positive warnings.
> > Dropping COMPILE_TEST here improves the quality of our testing and
> > avoids wasting time on non-existent issues.
> > 
> > As a minor optimization, this also lets us drop of_match_ptr() and
> > ifdef-guarding, as we now know what they will resolve to, we might as
> > well save cpp some work.  
> 
> Acked-by: Gabriel Somlo <gsomlo@gmail.com>

Despite your ack, this patch was never committed. Was it forgotten
somehow? Should I resubmit?

Thanks,
-- 
Jean Delvare
SUSE L3 Support
