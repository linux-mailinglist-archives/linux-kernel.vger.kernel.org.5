Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ADF7DFC1B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 22:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377429AbjKBVyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKBVyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 17:54:20 -0400
X-Greylist: delayed 1335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 14:54:14 PDT
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844E5138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 14:54:14 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id C716016C0059;
        Thu,  2 Nov 2023 23:31:56 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QGFwVGpa-qcb; Thu,  2 Nov 2023 23:31:51 +0200 (EET)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1698960711; bh=Q6RAt9WDoMmKifTz8osglDccZBx2+JeWzwRjjrF32hE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fjJx7RCRxmL0vI4FsOD0Ut7IzvWscnPYs4ITJjcb1+QVmI7C/v8FgQjInLbQPGOy0
         kKzqNo2xwygkacxKxwuEEYsLBwpiXOzbqrKMYncfWtpdgMelM/OrdMtG2GMJ6uVJsb
         5S2KpcbnOGPnYKjNqz4DaOWp/n+WW8PEuDlOCt68=
To:     syed saba kareem <ssabakar@amd.com>
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org,
        Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-kernel@vger.kernel.org
Subject: Re: Regression apparently caused by commit
 088a40980efbc2c449b72f0f2c7ebd82f71d08e2 "ASoC: amd: acp: add pm ops
 support for acp pci driver"
In-Reply-To: <fcb8f03e-bad1-966c-d454-b7ef7cb62454@amd.com>
References: <87a5v8szhc.fsf@mutex.one>
 <fcb8f03e-bad1-966c-d454-b7ef7cb62454@amd.com>
Date:   Thu, 02 Nov 2023 23:30:16 +0200
Message-ID: <878r7f4zdj.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syed saba kareem <ssabakar@amd.com> writes:

> We haven't up streamed pm ops for Renoir platform.
>
> That is the cause for the issue.
>
> Will upstream them in a week.

Did you manage to upstream the pm ops for Renoir platform?
I have checked the latest commit on the for-next branch
( ed2232d49187cebc007ecf4e6374069b11ab3219 ) and the issue is still
there.
I still have to revert commit
088a40980efbc2c449b72f0f2c7ebd82f71d08e2 to have my driver function
properly.
