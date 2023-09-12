Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EFF79C264
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjILCJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239492AbjILCDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:03:15 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806F9CBFB1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:34:46 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c1ff5b741cso46389115ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694482486; x=1695087286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emSwqr+1xErKYh7O3K2A83PvnYfgpw6yJfaUgEcoSa4=;
        b=n/fqJv/XJ31vbaygZ+evBPKZSkjl3u1VxMWm49OAmly+hOLWk+hT6LkAJdnLTfe056
         UCzDVV+1PAItc1BcNML03+VANGrZ+ZzqZpyJy7yMnhfpP0OndstxX7iWkaVzLtS3/9gV
         bZutPRktcQgW5i1en84ktqU0KJWEbXAanS7N+kTusJvgcBi+hZ+7KxvkBgaN/VyGstKP
         xQlEvzbmbQJt4sZ/YtfIkZKFJshMXLjm4gfzAcL7CQACT1jYPlmghRsrXlP8Qg2VX15X
         3FEXQ+OsNvgH5pxehdqSVsGWytKWMSwtFmKtmwEbtA773EqJDTjhqJqCB1diTp4iT737
         soJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694482486; x=1695087286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emSwqr+1xErKYh7O3K2A83PvnYfgpw6yJfaUgEcoSa4=;
        b=f9VnBHEupL4FNc35ihfxdbkZY3iV5mRS4hg50NA0ogS/nKs7vj5PYsAiQPhRjx2YGe
         an5UfAHNy+1uH7OxsjlAEess7pToPGAMrbZO4pYYzHrr+qJ5Rqmta+7S3tMBbxeoHW6G
         wSawdwaK7VbhL5LhFxfkJVwf79zavaNWLOa/+hwefE5hmQAgWUz2aOhaM0rmbG3pLCki
         ozFF3FIDRw1WCfoCEXN3iky+nZEAbOx98dxYWEcm0EUeH28psckxR++NixwJCQxHGtwZ
         ushVTC3GAZJl64kB0X5ColbocTRICQhyek62eTYWXTWCWV9Lk/mO/gFYgWXmfkKeKxz8
         Sb1g==
X-Gm-Message-State: AOJu0YyE50bGhESPPUzmmVfkPb8SRgGyg3KQkyEB45u81LwaW5q5berX
        oyhI86yOgK5Gwj90z+waUxg=
X-Google-Smtp-Source: AGHT+IEH7O26gZQqAU5DXvjl/pZ88rf0WJY2byLIfXgwGd5rVvEH6RB8Z6ZRTRGBzoqvuhlZelcApA==
X-Received: by 2002:a17:902:db11:b0:1bc:61d6:5fcc with SMTP id m17-20020a170902db1100b001bc61d65fccmr14252548plx.51.1694482485802;
        Mon, 11 Sep 2023 18:34:45 -0700 (PDT)
Received: from [192.168.0.106] ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id a7-20020a170902ecc700b001b890b3bbb1sm7074337plh.211.2023.09.11.18.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 18:34:45 -0700 (PDT)
Message-ID: <3721e97b-365c-d6da-b8b8-1a963e569e3c@gmail.com>
Date:   Tue, 12 Sep 2023 08:34:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ASoC: dwc: fix typo in comment
To:     =?UTF-8?B?6rmA66qF7Jqx?= <mwkim@gaonchips.com>,
        alsa-devel@alsa-project.org
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-kernel@vger.kernel.org
References: <gab64ffbd7bdbafc@gaonchips.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <gab64ffbd7bdbafc@gaonchips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 08:23, 김명욱 wrote:
> ISR_RXFO means "Status of Data Overrun interrupt for the RX channel" according to the datasheet.
> 
> So, the comment should be RX, not TX
> 
=

OK, but next time don't reply like:

> A: http://en.wikipedia.org/wiki/Top_post
> Q: Were do I find info about this thing called top-posting?
> A: Because it messes up the order in which people normally read text.
> Q: Why is top-posting such a bad thing?
> A: Top-posting.
> Q: What is the most annoying thing in e-mail?
> 
> A: No.
> Q: Should I include quotations after my reply?
> 
> http://daringfireball.net/2007/07/on_top

because I can't see the context you're replying to.

And don't send HTML emails as mailing lists hate and
block them.

Regardless, send v2 with reviews (especially on patch description like this)
addressed.

Thanks!

-- 
An old man doll... just what I always wanted! - Clara

