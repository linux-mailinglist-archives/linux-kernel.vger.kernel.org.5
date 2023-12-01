Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C51480137D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 20:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379505AbjLATPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 14:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379514AbjLATPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 14:15:43 -0500
X-Greylist: delayed 593 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 11:15:49 PST
Received: from mxout3.routing.net (mxout3.routing.net [IPv6:2a03:2900:1:a::8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72932B0;
        Fri,  1 Dec 2023 11:15:49 -0800 (PST)
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
        by mxout3.routing.net (Postfix) with ESMTP id 20FA860476;
        Fri,  1 Dec 2023 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1701457554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k1KGPYRvYIOKuqyRIUAMSTTl/RZtGgGj2cX3gmi3st0=;
        b=BXSOtP87w0sNXDfd1BKrhZ0Hu9DzSraAdttZSa5r69wfWBSQ48L8FmzDdyDP0q5WEf5aMr
        pOjLdc294/cw8DeKNBTR8HyXMgta9srVE0airsEOGrvlSoQfTaq7xS3+lwM8cgdcVB/qEv
        vTgM1OQ8HETN66b+cDRF/HmxMU/0Fx4=
Received: from [192.168.178.75] (dynamic-095-116-189-134.95.116.pool.telefonica.de [95.116.189.134])
        by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 4AF95360200;
        Fri,  1 Dec 2023 19:05:53 +0000 (UTC)
Subject: Re: Fwd: Thinkpad X13 AMD: Problems with external monitor wake up
 after suspend
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux AMDGPU <amd-gfx@lists.freedesktop.org>
Cc:     Wayne Lin <wayne.lin@amd.com>, Stylon Wang <stylon.wang@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <8da256ea-b069-44f0-9cc2-93482c2f5eec@gmail.com>
 <da0efb19-c883-40c8-b284-7eb7f4d3640b@leemhuis.info>
From:   Oliver Schmidt <oliver@luced.de>
Message-ID: <12db0c2e-a1b7-f8f9-278e-8aefe5619c1f@luced.de>
Date:   Fri, 1 Dec 2023 20:05:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <da0efb19-c883-40c8-b284-7eb7f4d3640b@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Mail-ID: 20b245b1-f3ff-4754-a7e8-c1632906f36e
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.12.23 12:37, Thorsten Leemhuis wrote:
> Maybe one of the developers among the recipients has a idea. Oliver, but
> if none of them replies any time soon, it would be best if you'd check
> if 6.6 (and/or 6.7-rc) is affected as well; and if reverting it there
> fixes it, too.

OK, I checked it: compiled a 6.6.3 kernel and got the same suspend-resume
problem as with the 6.1.57 and 6.1.64 kernels. I also was able to revert the
changes of commit ec5fa9 "drm/amd/display: Adjust the MST resume flow" in the
6.6.3 kernel and the problem was solved as in the 6.1.x kernels (however it
seems that resuming with the 6.6 kernel needs a little more time until the
monitor gets signal).

Best regards,
Oliver


