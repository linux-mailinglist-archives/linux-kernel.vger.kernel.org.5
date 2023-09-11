Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C6B79AF51
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245731AbjIKVLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236223AbjIKJ76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:59:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC18E67
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:59:51 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 5b1f17b1804b1-40037db2fe7so45283665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694426389; x=1695031189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W8DwGOouAfeTC9dQWWUPc8inKmfQnl7752/OQxdRR2w=;
        b=Y2T52zsbgvt8bDHUPbR5E4I+pgisqT7+bYwG34zmOffRDQ68L5c3MfzQQ3xHRF14LE
         OINlt2YoJ81/rT1xZLtvPxrsB/bcQqZ/xQeyb5f2/AyzSanHQm/VOt4z6nvxgqPii6jo
         ybtsKZZQU+nng63gi1MZ5wI6OcpBeYHPisNoVQM4j7c8/DdRkC2QN+s3Pk+/1qQxy4zh
         rdKn6TdN23Wd5hos6Iszx/n6BWdjEsUUSaK7+wuWSuBGCbASJbsv8EwGymEvWOJFERlQ
         s+nLqzoJbSf8v3wJAaI5S0Fg1aLPPs0OfQ8Mu4Oc3blPmauE9mDmhl82w6oM/hwRy4jg
         n3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694426389; x=1695031189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8DwGOouAfeTC9dQWWUPc8inKmfQnl7752/OQxdRR2w=;
        b=WlynwzEKTd/RrL9hBiNepDKEsBr8cS5B7ZTXSW8jRWgh4Hzgd/fqoWupIH0/AsE9e/
         Hu5b/LmelCuuDG4ndsiimhv6IIjiRvaSZX8zntLLJpFsOUdLvnTn+Fn40bbfwFxI3ag0
         JHkDOrGL1xOC/o/TJqKgTRmoT4SU8FzIupYjY1yKQydqbejbe4jxRGDc90wjWjbgaTpj
         monaL9ugZ0mw5K8dSzSXQCDgWOB297hXYuuljcIf456Dys8j5cpwYFFmKjK16kbH3LN1
         v1+hNjEZ1Ciiz3ohBodKJD2VsbRiFS/AWr2bbQ5j0LlQWEay0zBk+Sg3UROUEpoW7A54
         J2Kw==
X-Gm-Message-State: AOJu0YzuIgBCMAqcoAWzUyLwoW9gNbG91FD+sNA6+2X6pv5pP5FcZzmV
        36cG+86v3Do2K1P3AGMEi08=
X-Google-Smtp-Source: AGHT+IFBUY7gHK1mAZy8nG0AfLjBC8XLEJvInpL0oTLiQQfgZnP7fUu+Eo0jMt8J4B/7vYrmK/mfrQ==
X-Received: by 2002:a05:600c:452:b0:402:cc5c:c98 with SMTP id s18-20020a05600c045200b00402cc5c0c98mr7693933wmb.13.1694426389291;
        Mon, 11 Sep 2023 02:59:49 -0700 (PDT)
Received: from ubuntu ([2a02:810d:1640:10d8:ac22:c335:c227:5398])
        by smtp.gmail.com with ESMTPSA id fa14-20020a05600c518e00b00402fa98abe3sm8936300wmb.46.2023.09.11.02.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 02:59:48 -0700 (PDT)
Date:   Mon, 11 Sep 2023 13:59:46 +0200
From:   Joerg Schambacher <joerg.hifiberry@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     a-krasser@ti.com, joerg@hifiberry.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Zhang Qilong <zhangqilong3@huawei.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] ASoC: Adds support for TAS575x to the pcm512x driver
Message-ID: <ZP8BMkDeZakUyACL@ubuntu>
References: <20230907161207.14426-1-joerg.hifiberry@gmail.com>
 <a9c3d43a-af26-44a0-9352-4666107f9f56@sirena.org.uk>
 <ZPn4nsypsSXdB3J7@ubuntu>
 <bb3e5ccf-6eb5-4a36-9af0-b33f2db68445@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb3e5ccf-6eb5-4a36-9af0-b33f2db68445@sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.09.2023 um 17:28 hat Mark Brown geschrieben:
> On Thu, Sep 07, 2023 at 06:21:50PM +0200, Joerg Schambacher wrote:
> 
> > And yes, we cannot be sure that future devices may require different
> > settings, but I can hardly imagine anything completely different than
> > this approach with the usual audio MCLK frequencies.
> 
> They may for example be restricted and just not the the incoming MCLK
> divider, or require a higher frequency for some fancy processing.  In
> any case tas_device is just an obviously bad name here - there should be
> a flag per quirk, not a flag per entire class of devices.
> 
Ok, I see your point and completely agree. I tend for now to leave that
part out of the patch. This leaves the PLL divider programmings
completely 'untouched'. Nevertheless, I'll continue with testing here
on the hardware.
> > > This is probably a separate quirk?  I'm a bit concerned about what's
> > > turning the PLL off here...
> 
> > The PLL should not be used in this specific case where all divisions are
> > just divide-by-2's. Your original code does reflect that and turns the
> > PLL off. It improves jitter and finally audio performance.
> 
> > But in the case of the TAS-devices we even then need the PLL to
> > drive the AMP clocks.
> 
> That's definitely a separate quirk, and does sound like it should be
> driven from the bias management or DAPM more than hw_params.

Then it makes sense to use a DT-param 'force_pll_on' and even
remove the compatible string fixes from the patch series.
Still, I think, this is the best part of the code to act on the PLL.
Simply instead of checking 'do we need it or not' just let it run.
What do you think?


-- 


