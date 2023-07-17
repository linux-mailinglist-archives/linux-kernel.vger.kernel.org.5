Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FAF756816
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGQPgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGQPgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:36:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2917A8F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 08:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B45D661124
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25544C433C8;
        Mon, 17 Jul 2023 15:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689608162;
        bh=Mdqvlz2keSwYuvECBis4KPcAaQ93p7bxYYFBxWPAsIE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dhBU1w3oHrojzxYUleKVC7Hl3F7XD2hETEsvqdpSYsr7SqnLNeIMoEE7kByTffbM0
         hQcSQyDwk/KpDWz3i/yzN+yIwzG+3U5KvBfd+MMf0z+gdBuEFjUyvRzO0ds1xKP4KC
         TAT7jz75BedRgH/BYi6Z8Qn5xj3V1iDh9+B0SlwonuGhcqjw/iEbdkaiUE95AMcNrr
         F+gkwBzfOOZQp5mTsQGp/0IeSp4nT472aDdsCG+WzDX9m+B/nhSSSCuo99sqq/wu7o
         EigJppGLg7J56MQ+Q6yBA6E2THTIgLSUEIKJGp2dokcu29iGq7fzE9FSH224SOFnmR
         H2uI9lDMaSVlA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B3E89CE03F1; Mon, 17 Jul 2023 08:36:01 -0700 (PDT)
Date:   Mon, 17 Jul 2023 08:36:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org, jgross@suse.com, vschneid@redhat.com,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, imran.f.khan@oracle.com
Subject: Re: [PATCH csd-lock] Decrease console output from CSD-lock timeouts
Message-ID: <76dfc04b-e683-4ad7-a5ac-8f73b6985a4a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3ee27fe5-cbea-46b6-adb0-48c4dde92b4f@paulmck-laptop>
 <b0b2e3fe-2872-48c1-978f-9c2cd0ae7cd8@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0b2e3fe-2872-48c1-978f-9c2cd0ae7cd8@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 25, 2023 at 08:42:17AM -0700, Paul E. McKenney wrote:
> On Mon, Jun 12, 2023 at 01:49:40PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > This series contains a couple of patches that reduce the console output
> > produced by CSD-lock timeouts.
> > 
> > 1.	Reduce logging due to dump_stack of CSD waiters, courtesy of
> > 	Imran Khan.
> > 
> > 2.	Reduce NMI traffic from CSD waiters to CSD destination, courtesy
> > 	of Imran Khan.
> 
> Hearing no objections, I plan to send Linus a pull request for these at
> this end of this coming week.

OK, best-laid plans and all that.  Sigh.  Next merge window...

						Thanx, Paul
