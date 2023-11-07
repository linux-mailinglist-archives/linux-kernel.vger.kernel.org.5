Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9E97E369D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjKGI3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjKGI3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:29:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE82ABD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:29:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B406C207A4;
        Tue,  7 Nov 2023 08:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1699345743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qZDMSBtWVAg504seqHWeihkTrETvOme2JYvTzx0yJ0=;
        b=sQGfc5PT4wIIiM9QDzcassLKWuWC2T86hmPiHklapCk/Eedl+ICIaz6GDrF9EB2lx28vQY
        5Mj2Ps+dGCl9DFDPdW9c5rIMtY/WIR/4sq6wqDOR0NRyLowoKqn7Z/+/peF+XDaQyybfbq
        3P9kIlGHsuNZgLakSSqXxQywXgqxjpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1699345743;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2qZDMSBtWVAg504seqHWeihkTrETvOme2JYvTzx0yJ0=;
        b=onvCTtiIJ5BEEOdSVi5pVtCTC0ITutYkL5emTD58dH+vOhP21GM9qLJiC2uaeksvShoiKU
        Myz5UYvNPiNrG5Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A25DC13907;
        Tue,  7 Nov 2023 08:29:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LYaNJ0/1SWU0UAAAMHmgww
        (envelope-from <dwagner@suse.de>); Tue, 07 Nov 2023 08:29:03 +0000
Date:   Tue, 7 Nov 2023 09:30:48 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v3] nvme: update firmware version after commit
Message-ID: <zwmkbfmmdcdppgjncy4bwhlvwbhrlmiwsdgp3n4bumpq6ramtt@7mplbzszzboo>
References: <20231030160044.20355-1-dwagner@suse.de>
 <ZUEmlRnBVr9LGDnF@kbusch-mbp.dhcp.thefacebook.com>
 <y32ounthrv2uuedtriy73oir5m7k5ryupzytd2x5wn436bcrj7@7xalhdepjyk6>
 <20231103135857.GA1871@lst.de>
 <ZUUCE88vOi6Wj69a@kbusch-mbp.dhcp.thefacebook.com>
 <gwyjg43fnkzhrxmeub7zdoikvwfpatdrmaaoaqggdlfgopnpki@uba2ulvqruk3>
 <ZUkX9z1M3ZxjIp6Z@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUkX9z1M3ZxjIp6Z@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 09:44:39AM -0700, Keith Busch wrote:
> Fixed up inline when applying the original patch. Let me know if you
> have any concerns with the result, currently here:
> 
>   https://git.infradead.org/nvme.git/commitdiff/983a338b96c8a25b81e773b643f80634358e81bc

Looks good. Thanks!
