Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB2A7F52F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 23:06:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbjKVWGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 17:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKVWGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 17:06:44 -0500
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A26F1A5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 14:06:41 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id 6646016C0057;
        Thu, 23 Nov 2023 00:06:39 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Apnt0kEcJIAU; Thu, 23 Nov 2023 00:05:47 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1700690747; bh=XiylAXhBpVr+an3yZa/AAXuHv5sQqB2KqKPuMEr8uF8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Mnd4tWt3tHqZWLBIqfDpU3FEeIDS0A+ywNEmkOFMyfZgH7XMUVAdHN8QAPpTXpzg7
         GD8sMgxSwgcPJ6rzkUtZNrXSKu2ejX3doIrUeQv3sEzsGTOz/bzDt3cw6tTnrYD84H
         qWgFZpobQn/RnKtH0YN7CMrP2B2bAsfHtyYGIj1k=
To:     syed saba kareem <ssabakar@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops
 support for acp pci driver"
In-Reply-To: <6085d2e3-f28e-4d1d-9863-8275931430e6@amd.com>
References: <87a5v8szhc.fsf@mutex.one> <ZUQssoD2rUHSYQ2v@debian.me>
 <610d562f-0bbc-485c-ad63-9534fa4ba937@amd.com>
 <d002ad6f-d908-4cf6-afcf-bf0989418e72@leemhuis.info>
 <6085d2e3-f28e-4d1d-9863-8275931430e6@amd.com>
Date:   Wed, 22 Nov 2023 23:55:24 +0200
Message-ID: <87fs0x4fn7.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syed saba kareem <ssabakar@amd.com> writes:

>
> Hi , We have up streamed the patch it is in review.
>
> Please find the below link for the patch details.
>
> https://patchwork.kernel.org/project/alsa-devel/patch/20231113123345.2196504-2-Syed.SabaKareem@amd.com/
>

Sorry maybe I'm not understanding here something, when you are saying
that the patch is in review, where is this review being done?

As far as I can tell Mark Brown only pulled the first patch from your
series:

>
> Applied to
>
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
>
> Thanks!
>
> [1/2] ASoC: amd: acp: add Kconfig options for acp7.0 based platform driver
>       commit: d3534684ada99ef8c0899eb28c62b4462483ee19
> [2/2] ASoC: amd: acp: add pm ops support for renoir platform
>       (no commit info)
>

I don't see the second patch in for-next.
