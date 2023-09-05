Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9BD792E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 21:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjIETAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 15:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237143AbjIETAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 15:00:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547E6F9;
        Tue,  5 Sep 2023 12:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CD19B81263;
        Tue,  5 Sep 2023 16:40:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FC7C433C7;
        Tue,  5 Sep 2023 16:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693932038;
        bh=C37WiDCkvf3N122KTeenfNUS30D1yxbe+PTilg5G4Bo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kNuaLg+YwHFC8m9+gJ9x09xFpcR4KYu0OMMRGsrubK/vrG6WWHmevzM1EPxV/CFJw
         ufv2HdG+s9PC3b/bc3UP0xu+T+PUvmQHcS0GJfaXKfK1gZsaEsxJDlFuEnh2xQw5Wm
         xcmmTBPJTgqxrPEUe881vDMxWCD3OMdab1U5M4kbhxy73Lu/Ic0nGrreCrR2h4LDR1
         EyTKQtXK5DpTt0PGlFMmQyIzOx6ZEyjBgxdDdDpZyTPDoWRD0Ioq24+DcHZ0Fyem0W
         rq6MRZCYtoDY8g3vLERonmIQkg09zAwcEuu59o70q57nNFc95OQDc5q8YviyEENSfu
         ocgen5c+DOWYw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 27CB540722; Tue,  5 Sep 2023 13:40:36 -0300 (-03)
Date:   Tue, 5 Sep 2023 13:40:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the perf-current tree
Message-ID: <ZPdaBAWxzUpr0cdu@kernel.org>
References: <20230905074350.6a9c81f2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905074350.6a9c81f2@canb.auug.org.au>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 05, 2023 at 07:43:50AM +1000, Stephen Rothwell escreveu:
> Hi all,
> 
> The following commits are also in Linus Torvalds' tree as different
> commits (but the same patches):
> 
>   10da1b8ed79f ("perf tests mmap-basic: Adapt for riscv")
>   159a8bb06f7b ("libperf: Implement riscv mmap support")
> 
> These are commits
> 
>   26ba042414a3 ("perf: tests: Adapt mmap-basic.c for riscv")
>   60bd50116484 ("tools: lib: perf: Implement riscv mmap support")
> 
> in Linus' tree.

Yeah, I had cherry picked those perf patches at some point, I'll make a
note when submitting to Linus.

Thanks for the report!

- Arnaldo
