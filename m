Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8747667FF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234679AbjG1I77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233289AbjG1I75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:59:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55126B6;
        Fri, 28 Jul 2023 01:59:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 13BD3219B8;
        Fri, 28 Jul 2023 08:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690534795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1yAQj2+drdxOg7W1xMMihj39vdtsCy+k9dgFHWRk9A=;
        b=N0rVU+qUJPLE+5c9Fe2qfiQ4QbEZQ7uOazDWiF4qTaPR4NpWdkKkS8jI1Ck9Zwe6bae+mr
        im99wL/jnP6faUX3Uo+ijZIgeoz6KKw7xaNAQ915XLzDNdTC3uQAKTpq9JFAvSll8YZiD7
        G2jza5/bdosUUSWdRG9M5kbJdc7MUAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690534795;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+1yAQj2+drdxOg7W1xMMihj39vdtsCy+k9dgFHWRk9A=;
        b=XmNFzsCzeT8aHQNyOZo67JTXE5Qr3GO1uEDjLw+BvbWChknTYmwEHmuilIIvi327JDHha2
        NIeacs1hzD+6y8AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04B0D133F7;
        Fri, 28 Jul 2023 08:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3oH3AIuDw2SleQAAMHmgww
        (envelope-from <dwagner@suse.de>); Fri, 28 Jul 2023 08:59:55 +0000
Date:   Fri, 28 Jul 2023 10:59:54 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH blktests v1 00/11] Switch to allowed_host
Message-ID: <ldlkosfmplhb4cqunws5nknpxrgcenbgytlabszl547vygxtbh@xsd7pzil6nk4>
References: <20230726124644.12619-1-dwagner@suse.de>
 <hqi4yxhc3jc7v7ywf5qvy3u2th676irollqngbsh62rrlitkyy@rhl6axqsve5s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hqi4yxhc3jc7v7ywf5qvy3u2th676irollqngbsh62rrlitkyy@rhl6axqsve5s>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 08:20:55AM +0000, Shinichiro Kawasaki wrote:
> > Except the last two patches are just refactoring patches. So if we decide to use
> > common target setup/cleanup helpers, I think we could add them before the last
> > two patches, which would make the last patch way smaller.
> 
> I ran 'make check' and saw shellecheck complaints below. I added 'export' to the
> variables then they disappeared.
> 
> tests/nvme/rc:19:1: warning: def_subsysnqn appears unused. Verify use (or export if used externally). [SC2034]
> tests/nvme/rc:20:1: warning: def_file_path appears unused. Verify use (or export if used externally). [SC2034]
> tests/nvme/rc:21:1: warning: def_file_path appears unused. Verify use (or export if used externally). [SC2034]

These variables are not used in nvme/rc at the point I introduce them. Only in
the tests. I could add the nvmet setup/cleanup helpers with the variables which
would make those warnings go away. But these helpers would then add the end of
the series. Also not really good. I don't what is best here.

> I also ran nvme tests with the export fixes and saw no regression. Looks good
> from test run point of view.

Thanks!

BTW, I am off next week, so I don't think I send soon an update.
