Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF25805BE8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbjLERXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345778AbjLERXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:23:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72B1AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:23:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEEB9C433C7;
        Tue,  5 Dec 2023 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701796989;
        bh=pU9M00dkHKU1TS7CBL1inocdlITXmGP7gY/XTaLHoyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpMPJv4XEKXQyQYQR6FkqXiXv1mDf/eSYeILTXcboW3xOS8bPLZL+N2huZtkLCQEL
         0OtFsxwzAd6kdDSsD7WpB6tttxUtHcP0gxlldD7BJAy6XYXjMH4NSuRVOLFiD8ViIy
         rWHgLBD2A0HITc0L8KBBIrpwPPqNjiN6VBG8xMYo0PWwMyIboOHek+V2R7b3GUSmdV
         autTFncMlnDQxky1Dx0r5f3dzmt4BusJ8adkxkZBjU60FQGxSve3/r7MfAq/fQFb18
         eYlvLHBXmriqKTncHF0mpyF1m4N3EZQG6v7p8F46z0Eip5rHX+UGN6gOo/6LwvQAcW
         Zv1JAF3oYGeZw==
From:   SeongJae Park <sj@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] mm/damon: export DAMON symbols and add sample loadable modules
Date:   Tue,  5 Dec 2023 17:23:07 +0000
Message-Id: <20231205172307.2310-1-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZW6xTyyl0qvcqi3O@infradead.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On 2023-12-04T21:12:47-08:00 Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Dec 05, 2023 at 02:28:55AM +0000, SeongJae Park wrote:
> > DAMON cannot be used from loadable modules since it is not exporting its
> > symbols.
> 
> And that is a good thing.  We should absolutely not allow random modules
> probing MM internals.

I agree.

> What you posted here is basically just adding hooks without even real
> in-kernel users.

I was thinking someone might be able to think even the sample module as real
usage since there was actually some questions about it from real users.  That
said, those were more like questions than strong requests, so I still think
this change is somewhat better to be made for at least some folks, but I also
agree that this wouldn't be not really essential for everyone, and could be
only long term maintenance threat.

I personally don't have strong opinion, and thank you for raising your concern.
I will hold this patchset unless someone request this change again with good
rationale.

Btw, I know there were many concerns about unnecessarily exporting symbols, but
do we have a formal guideline or documentation about the requirements for
exporting symbols in sepcific subsystem?  I was hoping to have such one so that
I could provide better answer to DAMON's loadable module support questions, but
I was unable to find such one with my poor searching skill.  This reply could
be used for the purpose meanwhile, though, so appreciate again. :)


Thanks,
SJ
