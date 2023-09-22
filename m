Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2673B7ABAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjIVUvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIVUvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:51:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E961A3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:51:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C33C433C8;
        Fri, 22 Sep 2023 20:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695415898;
        bh=GYskKyjo0FmpusJcMMZmSC6zPPr6TtDi/xqUdv7Hd9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/RjwNzWltM4aAsJn610JUMps6FyrMDPCJyZ72S/JOAKqgXdB9fgpRSarV3VFJFhQ
         S3qqIpr5wfIRAvx5Bu1cPr5faImWsAHeznwtfUP8UgTDuvsVeulHTQxcp+nKTwrhSY
         q5oXhZ1Th3+SOV5pWpYbTfjpGkQn9ibo7slndunaHwHH/twXYGXyZsu+odl9B1ti5+
         8NWa1OCoZwcS+5zdTf7r+aMqF5M8uyxG+MLyymx1/qOg2l7IdWevK+CiPra6fw0d1c
         R6HCqiy4qZA8RrmRWdO9QbqvEZVyHRqpd4EcYIdPgEbjQKSVSKSGU79iSS8MgytYP1
         snB1Ls5C3HFlw==
Received: (nullmailer pid 3557889 invoked by uid 1000);
        Fri, 22 Sep 2023 20:51:34 -0000
Date:   Fri, 22 Sep 2023 15:51:34 -0500
From:   Rob Herring <robh@kernel.org>
To:     wangweidong.a@awinic.com
Cc:     13916275206@139.com, rf@opensource.cirrus.com, liweilei@awinic.com,
        lgirdwood@gmail.com, povik+lin@cutebit.org, ryans.lee@analog.com,
        perex@perex.cz, tiwai@suse.com, linus.walleij@linaro.org,
        yijiangtao@awinic.com, colin.i.king@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, arnd@arndb.de,
        harshit.m.mogalapalli@oracle.com, yang.lee@linux.alibaba.com,
        ckeepax@opensource.cirrus.com, broonie@kernel.org,
        herve.codina@bootlin.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, trix@redhat.com, shumingf@realtek.com
Subject: Re: [PATCH V4 1/7] ASoC: dt-bindings: awinic,aw88395: Add properties
 for multiple PA support
Message-ID: <169541589406.3557849.14317344918884630444.robh@kernel.org>
References: <20230919105724.105624-1-wangweidong.a@awinic.com>
 <20230919105724.105624-2-wangweidong.a@awinic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919105724.105624-2-wangweidong.a@awinic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 19 Sep 2023 18:57:18 +0800, wangweidong.a@awinic.com wrote:
> From: Weidong Wang <wangweidong.a@awinic.com>
> 
> Add two properties, the "awinic,audio-channel" property and the
> "awinic,sync-flag". The "awinic,audio-channel" is used to make
> different PA load different configurations, the "awinic,sync-flag"
> is used to synchronize the phases of multiple PA. These two properties
> will be read by the corresponding driver, allowing multi-PA to
> achieve better playback effect.
> 
> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
> ---
>  .../bindings/sound/awinic,aw88395.yaml           | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

