Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A97F1FFB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbjKTWIj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 17:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:08:38 -0500
Received: from vps.thesusis.net (vps.thesusis.net [IPv6:2600:1f18:60b9:2f00:6f85:14c6:952:bad3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B6FC3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:08:34 -0800 (PST)
Received: by vps.thesusis.net (Postfix, from userid 1000)
        id 02882149C52; Mon, 20 Nov 2023 17:08:32 -0500 (EST)
From:   Phillip Susi <phill@thesusis.net>
To:     Christian =?utf-8?Q?K=C3=B6nig?= 
        <ckoenig.leichtzumerken@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Luben Tuikov <luben.tuikov@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>
Subject: Re: Radeon regression in 6.6 kernel
In-Reply-To: <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
References: <87edgv4x3i.fsf@vps.thesusis.net>
 <559d0fa5-953a-4a97-b03b-5eb1287c83d8@leemhuis.info>
 <CAPM=9tw-8pQWFso0zuLqpsqd5BSHWtc4As9ttdjY-DDr70EMqQ@mail.gmail.com>
 <bdb238b6-60c7-4f26-81d0-9e62cd5dd326@gmail.com>
Date:   Mon, 20 Nov 2023 17:08:32 -0500
Message-ID: <87o7fojcwv.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian König <ckoenig.leichtzumerken@gmail.com> writes:

> Well none of the commits mentioned can affect radeon in any way. Radeon 
> simply doesn't use the scheduler.
>
> My suspicion is that the user is actually using amdgpu instead of 
> radeon. The switch potentially occurred accidentally, for example by 
> compiling amdgpu support for SI/CIK.

Indeed, the lspci I originally posted does indicate amdgpu.  What is the
difference and should I switch it?  If so, how?

> Those amdgpu problems for older ASIC have already been worked on and 
> should be fixed by now.

I just pulled v6.7-rc2 and it's still broken.  I'll see if I can revert
those 3 patches.
