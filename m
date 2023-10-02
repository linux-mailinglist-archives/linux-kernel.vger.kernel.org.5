Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C627B54FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbjJBOUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbjJBOUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:20:09 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39080A4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:20:05 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RzjlP2DF8z9sTR;
        Mon,  2 Oct 2023 16:20:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1696256401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cn6tOEOxdtKRvC53Ii7MWskHfS4eUSQaxlG7bIUWUis=;
        b=GbWRPlvxrf+nuu97U9qthoo5aXNNoldMkrPDVdu0g1uHl9tJnT9U8OQ8f6BEVWDgaE8Hy6
        qJhUNpVEaX6BWB620oO8CpVFMQ0w9erQHOGktvCbArySygt/IKR0y4uIJW6suGU9SF740B
        f5nkZOG3wpnsoH+Haa/cvsxvVZkJuTRBuXZCUv4dqAep3ZF1Opw4bmUikzeY21rgx6/0RF
        A1IJYkJXeBPL4olXe4FHDE5mMUAGij74qJfTk8BC/lPtgVz6tIZBEptsHPYC6XtxqpKt7+
        KVS4zo+cFdK9PfgnrTlT3v0LFvuKULmBNC6p0ehVYFhqZ6Gfq0cJ/BxFqzdTYw==
Message-ID: <c8b55d7c-e5e3-db83-3b3d-4db0ca636c7b@mailbox.org>
Date:   Mon, 2 Oct 2023 16:19:56 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] Revert "drm/amd/display: Check all enabled planes in
 dm_check_crtc_cursor"
Content-Language: en-CA
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     Stylon Wang <stylon.wang@amd.com>, Ivan Lipski <ivlipski@amd.com>,
        Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Alex Hung <alex.hung@amd.com>,
        =?UTF-8?Q?Michel_D=c3=a4nzer?= <mdaenzer@redhat.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, amd-gfx@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <20230929204120.120795-1-hamza.mahfooz@amd.com>
 <2a8ebf1a-0d74-e068-6d68-de0ecae9bdf1@mailbox.org>
 <39342931-1716-bf53-62d7-613b1191f60a@mailbox.org>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <39342931-1716-bf53-62d7-613b1191f60a@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: fc988c79e82e16c7df7
X-MBO-RS-META: 8kkgszj8cx6m9h1ctpw95a6117q4df6d
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/23 12:48, Michel Dänzer wrote:
> On 10/2/23 12:05, Michel Dänzer wrote:
>> On 9/29/23 22:41, Hamza Mahfooz wrote:
>>> From: Ivan Lipski <ivlipski@amd.com>
>>>
>>> This reverts commit 45e1ade04b4d60fe5df859076005779f27c4c9be.
>>>
>>> Since, it causes the following IGT tests to fail:
>>> kms_cursor_legacy@cursor-vs-flip.*
>>> kms_cursor_legacy@flip-vs-cursor.*
>>
>> Any information about how those tests fail? Maybe they accidentally rely on the broken behaviour?
> 
> I was able to reproduce, that doesn't seem to be the case. They just rely on multiple legacy cursor ioctl calls being able to complete between consecutive flips, which I suppose is broken by always pulling in non-cursor plane state with any cursor plane state changes.
> 
> I'll see if I can find a better solution. Meanwhile,
> 
> Acked-by: Michel Dänzer <mdaenzer@redhat.com>
> 
> for the revert.

Alternatively, here's an incremental fix:

https://patchwork.freedesktop.org/series/124527/


-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

