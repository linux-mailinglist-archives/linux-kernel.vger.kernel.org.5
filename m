Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C05B07BF0B2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 04:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441800AbjJJCMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 22:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjJJCMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 22:12:22 -0400
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470999
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 19:12:20 -0700 (PDT)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4S4KD11W8pz4xVby;
        Tue, 10 Oct 2023 10:12:17 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
        by mse-fl1.zte.com.cn with SMTP id 39A2CCDP008536;
        Tue, 10 Oct 2023 10:12:12 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp06[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 10 Oct 2023 10:12:13 +0800 (CST)
Date:   Tue, 10 Oct 2023 10:12:13 +0800 (CST)
X-Zmail-TransId: 2b086524b2fdffffffff9f1-637db
X-Mailer: Zmail v1.0
Message-ID: <202310101012133445522@zte.com.cn>
In-Reply-To: <CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com>
References: ZSPayGSz6HQBp+3W@gmail.com,202310092030430136422@zte.com.cn,ZSP3cuEsgwWcIKRw@gmail.com,CAJuCfpFabCn8gcuLV322RKC=xzVm0C+64HQP+CkFNJZ4VO42ZA@mail.gmail.com
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <surenb@google.com>
Cc:     <mingo@kernel.org>, <peterz@infradead.org>, <hannes@cmpxchg.org>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <juri.lelli@redhat.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCBsaW51eC1uZXh0IDIvM10gc2NoZWQvcHNpOiBBdm9pZCB1cGRhdGUgdHJpZ2dlcnMgYW5kIHJ0cG9sbF90b3RhbCB3aGVuIGl0IGlzIHVubmVjZXNzYXJ5?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 39A2CCDP008536
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6524B301.001/4S4KD11W8pz4xVby
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think that the second part could have been done in the first patch
> to place the "group->rtpoll_next_update = now +
> group->rtpoll_min_period" line at the right place from the beginning.

Thanks for your advice, if we strict follow "one conceptual change per patch"
rule, I think "group->rtpoll_next_update = ..." should be in another patch.

> Also when posting the next version please add the version number to
> all the patch titles in the patchset, not only to the cover letter.
> That helps with finding the latest version.
> Thanks!

Get it, thanks to your reminder. I treat the split-up patches  as new patches
previously, so didn't add the version number. I will add version number in
follow-up patches.

> One small comment above and when you post the V2 please include
> peterz@infradead.org. Peter is hosting PSI in his tree, so he is the
> maintainer you absolutely need :)

I get the maintainer information from get_maintainer.pl, it said Peter is
a reviewer, maybe get_maintainer.pl should update ?
Johannes Weiner <hannes@cmpxchg.org> (maintainer:PRESSURE STALL INFORMATION (PSI))
Suren Baghdasaryan <surenb@google.com> (maintainer:PRESSURE STALL INFORMATION (PSI))
Peter Ziljstra <peterz@infradead.org> (reviewer:PRESSURE STALL INFORMATION (PSI))
