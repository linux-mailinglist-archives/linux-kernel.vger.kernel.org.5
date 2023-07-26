Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53B47639A6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjGZOzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjGZOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:54:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E8026BC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3k28+zvPVrQmllp4Y1yDLUbb9Odau4PMyGcZXH9Q2X0=; b=J1IA4J8sAda/QvW3cxq0oyestk
        jSlACYqE9Ya3NsypgUKmoh4kr5NL0B/RZt96Dc+0vx18U9paJ7brvNDvczndFWdf3CFkz9TbGu08P
        GiE37cN9ZjhvFhHOnIpcRlp0qUg6c3/M5b6WIITLuSh/6PwTEG+UJAUBpJPI3N2qlMlHmzPPZq2oS
        xRhlRGRBt7AAdmcdqmgpKI/yqegcLbJUX49daFtTje6IQZ6DGyqqcmzJX0OecJNu22ODemfuhw2Ga
        n7hjETchULoXb9gyAe5xAJQx2wygg6GqcAJFDrynw3Sn0xZLY6mFFfEnwXaDZLWTy3DQXil0Evt2T
        hxsrzRSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOfuc-006aFm-5k; Wed, 26 Jul 2023 14:54:50 +0000
Date:   Wed, 26 Jul 2023 15:54:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: two reports about NULL pointer dereferences in mm subsystem
 since 5.18(?) with qbittorrent on XFS
Message-ID: <ZMEzuqTOdT1EDApa@casper.infradead.org>
References: <2e453cab-9049-98e5-1d96-2305fbb751ee@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e453cab-9049-98e5-1d96-2305fbb751ee@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 02:43:24PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi everyone! There are two regression reports with somewhat similar
> symptoms in bugzilla.kernel.org that seem to not get the attention they
> IMHO deserve.

I'm sorry you think this regression hasn't received the attention that
it deserves.  I've spent weeks thinking about this problem and trying to
track it down, with no success so far.

I'm not used to being matrix managed.  Perhaps you can schedule a 1:1
with my actual boss who pays me money.
