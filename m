Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D27F0131
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjKRQni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 11:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKRQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 11:43:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA0DE5;
        Sat, 18 Nov 2023 08:43:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 145A31F45E;
        Sat, 18 Nov 2023 16:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1700325812; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlbJbB5h6moL2eoLGsN3b6JGgLCOxAl5/1Rn1Oo2CUQ=;
        b=yYql8ujwgFRsAIsnB3SH3U8o2goXVkVtgc0Wg2fkaAjY+CtNCP/BM2u2FXWlz0kKI5XIi7
        CHEhqKdFqhYDyjLWCcajxLK1T90Cv1mQ9peiSboxe4an47p3KEpcUxRK2zd33msQSoLQoW
        +MA+yD7rNA/8KHzuUcVn16QtbQnCC04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1700325812;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jlbJbB5h6moL2eoLGsN3b6JGgLCOxAl5/1Rn1Oo2CUQ=;
        b=q8f5jFnhEY2yo1wYoGUPtE5+FOoIm5hiaH5Tn+HHuYgdvxFN6ZXc0S9DtQOilqiRBW4OPB
        8+3JGosvrLvY6SCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11024138EF;
        Sat, 18 Nov 2023 16:43:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id b/WgM7LpWGW2IAAAMHmgww
        (envelope-from <colyli@suse.de>); Sat, 18 Nov 2023 16:43:30 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Re: [PATCH 0/2] Two small closures patches
From:   Coly Li <colyli@suse.de>
In-Reply-To: <20231031162454.3761482-1-kent.overstreet@linux.dev>
Date:   Sun, 19 Nov 2023 00:43:18 +0800
Cc:     Bcache Linux <linux-bcache@vger.kernel.org>,
        linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <79FE1457-FC6D-46A9-A7F9-55ADCCBE42DF@suse.de>
References: <20231031162454.3761482-1-kent.overstreet@linux.dev>
To:     Kent Overstreet <kent.overstreet@linux.dev>
X-Mailer: Apple Mail (2.3774.200.91.1.1)
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.27
X-Spamd-Result: default: False [-2.27 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-1.55)[92.04%];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         MV_CASE(0.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         TO_DN_SOME(0.00)[];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-0.13)[-0.637];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B411=E6=9C=881=E6=97=A5 00:24=EF=BC=8CKent Overstreet =
<kent.overstreet@linux.dev> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> I'll be sending these to Linus in my next pull request, sending them =
to
> linux-bcache so Coly gets a chance to see them.
>=20
> Kent Overstreet (2):
>  closures: Better memory barriers
>  closures: Fix race in closure_sync()
>=20
> fs/bcachefs/fs-io-direct.c |  1 +
> include/linux/closure.h    | 12 +++++++++---
> lib/closure.c              |  9 +++++++--
> 3 files changed, 17 insertions(+), 5 deletions(-)

The whole series got tested with current bcache code, it works fine.

Acked-by: Coly Li <colyli@suse.de <mailto:colyli@suse.de>>

Thanks.

Coly Li

