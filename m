Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6362E762849
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGZBob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjGZBo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:44:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCC126A5;
        Tue, 25 Jul 2023 18:44:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ADEB61454;
        Wed, 26 Jul 2023 01:44:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF1BC433C7;
        Wed, 26 Jul 2023 01:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690335867;
        bh=LBEGyWUuDk8taOlI+/DUHwmzAVtgRIEuDlE5OeddHlg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iy7LdoOLZLD7w0AoBF/XnKlIAHKZiLxtQyDjkXEywbWpjC7xb3/HyxXRKWXWWzGCU
         SgK9FOVu6l+pJiizsnWgok11vHPqFSKyEpN/HHXhnCiCizC1rTw8uWBQZTrM7Ru8iH
         wpOlLjHxRleYjIGFZkiqGduTRIT8xVzT/HfrSEOxLdTYQepW4eeHmO5xbFRmDM9zrj
         FVDTpan5odvlb2wnMoZR2o0+KepgBDiiSn+cidSzCTKf2E6ZnagVhnI4EavjKFaiqc
         5ROgiejuTpax7O4EMbzHPeX7XlBo8s2I1/ZBj1Mmx14vnpNB99OuygdMni/O6Bhd2j
         T2cLQY4Spnxeg==
Date:   Wed, 26 Jul 2023 10:44:24 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] tracing/probes: Fixes for v6.5-rc2
Message-Id: <20230726104424.37124ea07d8cd9f41666f043@kernel.org>
In-Reply-To: <20230724224017.76d5b0e9@rorschach.local.home>
References: <169024903018.395371.1006584451160707296.stgit@devnote2>
        <20230724224017.76d5b0e9@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jul 2023 22:40:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 25 Jul 2023 10:37:10 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > These two patches are probe-events fixes for v6.5-rc2.
> > One is to fix btf_type_by_id() return value check and the other is fixing
> > selftest.
> > 
> > Thank you,
> > 
> > ---
> > 
> > Masami Hiramatsu (Google) (2):
> >       tracing/probes: Fix to add NULL check for BTF APIs
> >       selftests/ftrace: Fix to check fprobe event eneblement
> 
> For both patches:
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks!

> 
> -- Steve
> 
> > 
> > 
> >  kernel/trace/trace_probe.c                         |    8 ++++----
> >  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |    2 +-
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
