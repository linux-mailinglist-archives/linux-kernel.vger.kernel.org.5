Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242947744DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbjHHSaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbjHHS3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:29:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1596AE1E3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:47:11 -0700 (PDT)
Received: from [185.238.219.21] (helo=[192.168.44.45]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qTFvd-00072q-6h; Tue, 08 Aug 2023 08:10:49 +0200
Message-ID: <661fcece-a83c-cb24-1b37-5d8693b1fb94@leemhuis.info>
Date:   Tue, 8 Aug 2023 08:10:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Regression fix not progressing towards mainline/stable
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     sound-open-firmware@alsa-project.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Alsa-devel <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691516832;e30d876d;
X-HE-SMSGID: 1qTFvd-00072q-6h
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone, I noticed a regression fix that afaics lingers in the
thesofproject's git repo instead of progressing towards the stable trees
and wondered what's up here.

I'm talking about about the fix "ASoC: SOF: intel: hda: Clean up link
DMA for IPC3 during stop" for this ticket:
https://github.com/thesofproject/linux/issues/4455

Two more tickets about it:
https://github.com/thesofproject/linux/issues/4482
https://bugzilla.kernel.org/show_bug.cgi?id=217673

It seems the fix is ready and reviewed for two weeks now, but not even
in -next by now. That's not how it should be for regression fixes, as
per https://docs.kernel.org/process/handling-regressions.html it ideally
should be in -stable soon or already. Is this a mistake, am I missing
something, or is there a good reason for this?

Ciao, Thorsten
