Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90607890E9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 23:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjHYV5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 17:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjHYV4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 17:56:45 -0400
Received: from mail.mutex.one (mail.mutex.one [62.77.152.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2897B26B0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 14:56:44 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.mutex.one (Postfix) with ESMTP id DD82D16C0048;
        Sat, 26 Aug 2023 00:56:41 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at mail.mutex.one
Received: from mail.mutex.one ([127.0.0.1])
        by localhost (mail.mutex.one [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IfqredlHnEla; Sat, 26 Aug 2023 00:56:40 +0300 (EEST)
From:   Marian Postevca <posteuca@mutex.one>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mutex.one; s=default;
        t=1693000600; bh=nywwSi4JCfTe6/Na+Lb56v+TrIH4XSaDTdinszc8DeY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=db/iGm/PMySZnG5VWcyl/xJe5FF1ny2cihx61eDr//1cHmd679bwrejUy9TZPVi5K
         QmoLPAmxNDwyX7gt9G+40qqq7UHT8WetGRzpt55xyhT5dDV8OiXTDgMj6lNTkoM3Vr
         Tnk5eBkYwWPxb5sWyjdhuNbCBBIIxRrYIvdbDWcY=
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ASoC: es8316: Enable support for S32 LE format
In-Reply-To: <ZOfMo4Cb2zd1Km3H@finisterre.sirena.org.uk>
References: <20230824210135.19303-1-posteuca@mutex.one>
 <20230824210135.19303-2-posteuca@mutex.one>
 <ZOfMo4Cb2zd1Km3H@finisterre.sirena.org.uk>
Date:   Sat, 26 Aug 2023 00:55:21 +0300
Message-ID: <87y1hypz1y.fsf@mutex.one>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

>> To properly support a line of Huawei laptops with AMD CPU and a
>> ES8336 codec connected to the ACP3X module we need to enable
>> the S32 LE format.
>
> What's the issue?  The AMD code looks like it supports plenty of other
> formats in most places.

In previous version of the machine driver I used a different CPU
component than acp-i2s-sp. For that one, I couldn't get it to have
sound unless I specifically requested S32 LE format.

I removed S32_LE from the CODEC to test if it works and it
seems it does work with acp-is2-sp. Format S16_LE is chosen by
both components and sound can be heard. I guess this patch is
not really needed.
