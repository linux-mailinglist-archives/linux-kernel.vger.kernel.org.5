Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA8C763AE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbjGZPXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235087AbjGZPXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:23:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CA71FDD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 08:23:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B96761B3B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 15:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51687C433C8;
        Wed, 26 Jul 2023 15:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690384993;
        bh=oC0eTTq4WytvUZB2KcVKqBozq5IBKTLRL8iBHm0r3F4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OuXJb/EgmZaLAAaej2KcRStR7pVRlBD2dcRGeXpXjMz4oeNvpYhqMGqe5+26AJTyf
         8khmLayEaQSud57scWhtQeLKtj16EAsw8hfh8NQtPyGONuf0XjPqnvU1ygWJH+lJET
         fHpheeTlUxbntNn9qGMN/S272GtyQQBc9XIoL9GbwQAEqptoGCOBrtDInYSM1+64SH
         GKjbhiEnsUryPr72fsMBPO+5zxWZgEWAvvYMmoLDXITeNyBzCiN7vwY2rLEo+QGkfB
         IDbc9OLrOZc+z+GQlZ4TagMDoZ/UZeuou7dcIEomODgnuZotOWfNjJIt3Q0v1xzLXH
         5XK7LEWizP/xA==
Date:   Wed, 26 Jul 2023 08:23:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     syzbot <syzbot+14736e249bce46091c18@syzkaller.appspotmail.com>,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
        song@kernel.org, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        Gal Pressman <gal@nvidia.com>
Subject: Re: [syzbot] [bpf?] WARNING: ODEBUG bug in tcx_uninstall
Message-ID: <20230726082312.1600053e@kernel.org>
In-Reply-To: <20230726071254.GA1380402@unreal>
References: <000000000000ee69e80600ec7cc7@google.com>
        <91396dc0-23e4-6c81-f8d8-f6427eaa52b0@iogearbox.net>
        <20230726071254.GA1380402@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jul 2023 10:12:54 +0300 Leon Romanovsky wrote:
> > Thanks, I'll take a look this evening.  
> 
> Did anybody post a fix for that?
> 
> We are experiencing the following kernel panic in netdev commit
> b57e0d48b300 (net-next/main) Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue

Not that I know, looks like this is with Daniel's previous fix already
present, and syzbot is hitting it, too :(
