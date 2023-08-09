Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCB57761FF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjHIOEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjHIOET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:04:19 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ABC137
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:04:15 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qTjnE-00010I-D5; Wed, 09 Aug 2023 16:04:08 +0200
Message-ID: <60ef0646-b0ab-b4e0-9eaa-a2c431c5d682@leemhuis.info>
Date:   Wed, 9 Aug 2023 16:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 2b5d1c29f6c4 ("drm/nouveau/disp: PIOR DP uses GPIO for HPD, not
 PMGR AUX interrupts")
Content-Language: en-US, de-DE
To:     Takashi Iwai <tiwai@suse.de>, Karol Herbst <kherbst@redhat.com>
Cc:     nouveau@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, Borislav Petkov <bp@alien8.de>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20230806213107.GFZNARG6moWpFuSJ9W@fat_crate.local>
 <CACO55tvZD5U4J8DawFTRVnV-dLYLngfhuqO29_sWNEGofKfnBg@mail.gmail.com>
 <20230807150521.GGZNEIMQ9rsyCmkpoA@fat_crate.local>
 <CACO55tvWuSdwdirj7S3Dk-r4NAw8jC8g5RHKFd62WXi43iQP-w@mail.gmail.com>
 <87fs4sfu54.wl-tiwai@suse.de>
 <CACO55tszwFEgt=8xn4auAE7KJVs3ybGG68OzL9HJt19XGVhhHQ@mail.gmail.com>
 <874jl8fngo.wl-tiwai@suse.de>
 <CACO55ts9YWF7nLi3Zs4xKySpdHyUFgf4r566cKx3FwNTCaz0Sg@mail.gmail.com>
 <87wmy4e4uk.wl-tiwai@suse.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <87wmy4e4uk.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691589856;a95f3b79;
X-HE-SMSGID: 1qTjnE-00010I-D5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.08.23 15:13, Takashi Iwai wrote:
> 
> If this can't be fixed quickly, I suppose it's safer to revert it from
> 6.4.y for now.  6.5 is still being cooked, but 6.4.x is already in
> wide deployment, hence the regression has to be addressed quickly.

Good luck with that. To quote
https://docs.kernel.org/process/handling-regressions.html :

```
Regarding stable and longterm kernels:

[...]

* Whenever you want to swiftly resolve a regression that recently also
made it into a proper mainline, stable, or longterm release, fix it
quickly in mainline; when appropriate thus involve Linus to fast-track
the fix (see above). That's because the stable team normally does
neither revert nor fix any changes that cause the same problems in mainline.
```

Note the "normally" in there, so there is a chance.

Ciao, Thorsten
