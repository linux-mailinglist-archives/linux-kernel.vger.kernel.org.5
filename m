Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09D97FD62D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjK2MCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjK2MCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:02:20 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4C310C9;
        Wed, 29 Nov 2023 04:02:25 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B8A621AD1;
        Wed, 29 Nov 2023 12:02:24 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C4761376F;
        Wed, 29 Nov 2023 12:02:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id uAubClAoZ2XfAgAAn2gu4w
        (envelope-from <dsterba@suse.cz>); Wed, 29 Nov 2023 12:02:24 +0000
Date:   Wed, 29 Nov 2023 12:55:11 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, regressions@lists.linux.dev,
        linux-btrfs@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: btrfs: super.c:416:25: error: 'ret' undeclared (first use in
 this function); did you mean 'net'?
Message-ID: <20231129115511.GP18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvbCBUCkt-NdJ7HCETCFrzMWGnjnRBjCsw39Z_aUOaTDQ@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Queue-Id: 4B8A621AD1
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 05:55:51PM +0530, Naresh Kamboju wrote:
> Following x86 and i386 build regressions noticed on Linux next-20231128 tag.
> 
> Build log:
> -----------
> fs/btrfs/super.c: In function 'btrfs_parse_param':
> fs/btrfs/super.c:416:25: error: 'ret' undeclared (first use in this
> function); did you mean 'net'?
>   416 |                         ret = -EINVAL;
>       |                         ^~~
>       |                         net
> fs/btrfs/super.c:416:25: note: each undeclared identifier is reported
> only once for each function it appears in
> fs/btrfs/super.c:417:25: error: label 'out' used but not defined
>   417 |                         goto out;
>       |                         ^~~~
> make[5]: *** [scripts/Makefile.build:243: fs/btrfs/super.o] Error 1

Fixed in today's for-next snapshot, thanks.
